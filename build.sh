#!/bin/bash

PATTERN="*_all.ipk"
CURRENT=`pwd`
TEMP=$(mktemp -d)

rm -f $CURRENT/$PATTERN # remove old ipk if exists

cp -a $CURRENT/. $TEMP

cd $TEMP

cd po
./updateallpo-multiOS.sh
cd ..

cd meta

# extract package name from control
package=$(grep Package ./control/control|cut -d " " -f 2)
echo "Package: $package"
# extract version from control
version=$(grep Version ./control/control|cut -d " " -f 2)
echo "Version: $version"
# extract plugin name from Version.py
plugin=$(grep PLUGIN ../src/Version.py|cut -d '"' -f 2)
echo "Plugin: $plugin"

mkdir -p usr/lib/enigma2/python/Plugins/Extensions/$plugin
cp -ra ../src/. ./usr/lib/enigma2/python/Plugins/Extensions/$plugin
tar -cvzf data.tar.gz usr

cd control
tar -cvzf control.tar.gz ./*
cd ..
mv ./control/control.tar.gz .

ar -r ../${package}_${version}_all.ipk debian-binary control.tar.gz data.tar.gz

cd $CURRENT

cp $TEMP/$PATTERN $CURRENT

# rm -rf $TEMP # clean up
