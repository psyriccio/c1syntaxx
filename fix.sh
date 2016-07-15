#!/bin/bash
echo "Fixing zip archives..."
cd ./hbk
for i in $( ls *.hbk ); do
  echo "   "$i
  export FIXFILE="../zip/"$( echo $i | sed -e 's/\.hbk/\.zip/g' )
  zip -FF $i --out $FIXFILE > /dev/null
done
cd ..
