#!/bin/bash

source=$1
depfile=$2


DEPS="$(grep '^#include' $source |sed 's/#include[ ]*"\([^"][^"]*\)".*/\1/')"
DEPS="$DEPS $(grep '^read lexc' $source | sed 's/^read lexc[ ]*//')"
if echo $source |grep '\.xfst' > /dev/null 2>&1; then
    DEPS+=" "`grep '^source' $source |sed 's/source[ ]*\([^ 	][^ 	]*\).*/\1/'`
    target=`basename $source .xfst`.cpp.xfst
else 
    target=`basename $source .lexc`.cpp.lexc
fi

if [ -z "$depfile" ]; then
    depfile=${source}.d
fi

echo -n "${target}: " >$depfile
for d in $DEPS;do
    echo -n " $d"  >>$depfile
done
echo>>$depfile;echo>>$depfile

for d in $DEPS;do
    echo "${d}:" >>$depfile
done
