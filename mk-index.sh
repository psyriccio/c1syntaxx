#!/bin/bash
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
cat ./ind0 | grep "^[\{\}][^0-9]" \
  | sed -e 's/{"ru","//g' \
  | sed -e 's/{"en","//g' \
  | sed -e 's/[,"}{]//g'
cd ..
