#!/bin/bash
export SNM="./ubuild.sh"
cat ./clean.sh > $SNM
cat ./fix.sh >> $SNM
cat ./unpack.sh >> $SNM
cat ./mk-index.sh >> $SNM
cat ./fix-links.sh >> $SNM
cat ./pack.sh >> $SNM
cat ./deploy.sh >> $SNM
sed -i -e 's/#!\/bin\/bash//g' $SNM
sed -i -e '1 s/^/#!\/bin\/bash\n/;' $SNM
chmod +x ./ubuild.sh
