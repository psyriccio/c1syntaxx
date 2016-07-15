#!/bin/bash
echo "Packing web-root archive..."
mv ./root ./c1syntax
tar -caf ./c1syntax.tar.gz ./c1syntax
rm -rf ./c1syntax
