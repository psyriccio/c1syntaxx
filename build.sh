#!/bin/bash
echo "Started building c1syntax..."
./clean.sh
./fix.sh
./unpack.sh
./mk-index.sh
./fix-links.sh
./pack.sh
./clean.sh
echo "Bulding done!"
ls -lsah ./c1syntax.tar.gz
