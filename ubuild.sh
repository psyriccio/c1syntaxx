#!/bin/bash

echo "Cleaning..."
rm ./c1syntax.tar.gz
rm -rf ./root
rm -rf ./zip
mkdir ./root
mkdir ./zip

echo "Fixing zip archives..."
cd ./hbk
for i in $( ls *.hbk ); do
  echo "   "$i
  export FIXFILE="../zip/"$( echo $i | sed -e 's/\.hbk/\.zip/g' )
  zip -FF $i --out $FIXFILE > /dev/null
done
cd ..

echo "Unpacking zip archives..."
cd ./zip
for i in $( ls *.zip); do
  echo "   "$i
  unzip -q -n $i -d ./../root
done
cd ..

cd ./root
echo "Making index.html..."
mv ./0 ./ind0
for i in $( find [0-9]*); do cat $i >> index.txt; rm $i; done
echo "<hrml><head><title>shcntx_ru.hbk</title></head><body><table>" > ./index.html
cat ./index.txt | sed -e 's/"//g' \
    | awk -F "," '{ print "<tr><td>"$11"</td><td><a href=\"."$25"\">"$20"</a></td></tr>" }' \
    | sed -e 's/}//g' >> ./index.html
echo "</table></body></html>" >> ./index.html
rm ./index.txt
cd ..

cd ./root
echo "Fixing links etc..."
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/v8help:\/\/SyntaxHelperContext\//\/c1syntax\//g'
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/v8help:\/\/SyntaxHelperLanguage\//\/c1syntax\//g'
find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/\.<HTML>/<HTML>/g'
find ./ -regex "[\.][/][^\./_]*[_][^\./_]*" -type f -print0 | xargs -I@ -0 echo @ > ./tmp1.txt
for i in $( cat ./tmp1.txt ); do
  echo "   "$i
  export REPL_FROM=$( echo $i | sed -e 's/\.\///g' )
  export REPL_TO=$REPL_FROM".html"
  echo "      "$REPL_FROM" -> "$REPL_TO
  find ./ -name "*" -type f -print0 | xargs -0 sed -i -e 's/${REPL_FROM}/${REPL_TO}/g'
  mv ./$REPL_FROM ./$REPL_TO
done
rm ./tmp1.txt
cd ..

echo "Packing web-root archive..."
mv ./root ./c1syntax
tar -caf ./c1syntax.tar.gz ./c1syntax
rm -rf ./c1syntax

echo "Deploing to js1..."
scp ./c1syntax.tar.gz root@js1:/srv/www/
ssh root@js1 << EOF
  cd /srv/www
  rm -rf ./c1syntax
  tar -xf ./c1syntax.tar.gz
  rm ./c1syntax.tar.gz
EOF
