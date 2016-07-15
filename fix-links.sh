#!/bin/bash
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
