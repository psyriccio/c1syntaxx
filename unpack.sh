#!/bin/bash
echo "Unpacking zip archives..."
cd ./zip
for i in $( ls *.zip); do
  echo "   "$i
  unzip -q -n $i -d ./../root
done
cd ..
