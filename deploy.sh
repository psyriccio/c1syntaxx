#!/bin/bash
echo "Deploing to js1..."
scp ./c1syntax.tar.gz root@js1:/srv/www/
ssh root@js1 << EOF
  cd /srv/www
  rm -rf ./c1syntax
  tar -xf ./c1syntax.tar.gz
  rm ./c1syntax.tar.gz
EOF
