#!/bin/bash

source=$1
depfile=$2


DEPS="$(grep '\@\"[^"]*";' $1 | sed 's/.* @"\([^"]*\)";.*/\1/')"

if echo $source |grep '\.xfst' > /dev/null 2>&1; then
    DEPS+=" "`grep '^source' $source |sed 's/source[ ]*\([^ 	][^ 	]*\).*/\1/'`
    target=`basename $source .xfst`.fst
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
