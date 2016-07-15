#!/bin/bash
rm -rf ./root
rm -rf ./zip
mkdir ./root
mkdir ./zip
cd ./hbk
for i in $( ls *.hbk); do
  export FIXFILE="../zip/"$( echo $i | sed -e 's/\.hbk/\.zip/g' )
  zip -FF $i --out $FIXFILE
done
cd ../zip
for i in $( ls *.zip); do
  unzip -n $i -d ./../root
done
cd ../root
mv ./0 ./ind0
for i in $( find [0-9]*); do cat $i >> index.txt; rm $i; done
echo "<hrml><head><title>shcntx_ru.hbk</title></head><body><table>" > ./index.html
cat ./index.txt | sed -e 's/"//g' \
    | awk -F "," '{ print "<tr><td>"$11"</td><td><a href=\"."$25"\">"$20"</a></td></tr>" }' \
    | sed -e 's/}//g' >> ./index.html
echo "</table></body></html>" >> ./index.html
rm ./index.txt
cd ../root
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/v8help:\/\/SyntaxHelperContext\//\/c1syntax\//g'
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/v8help:\/\/SyntaxHelperLanguage\//\/c1syntax\//g'
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/\.<HTML>/<HTML>/g'
cd ..
mv ./root ./c1syntax
tar -cvaf ./c1syntax.tar.gz ./c1syntax
rm -rf ./c1syntax
rm -rf ./root
rm -rf ./zip
