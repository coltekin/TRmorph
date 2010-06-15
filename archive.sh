#!/bin/sh

dirname=$1

mkdir -p /tmp/archive-tmp-$$/$dirname

make
rsync --exclude-from=dist-exclude -avH . /tmp/archive-tmp-$$/$dirname
rsync trmorph.a /tmp/archive-tmp-$$/$dirname/$dirname.a

cd /tmp/archive-tmp-$$

tar czvf $dirname.tar.gz $dirname

cd -
mv /tmp/archive-tmp-$$/$dirname.tar.gz .

rm -fr /tmp/archive-tmp-$$
