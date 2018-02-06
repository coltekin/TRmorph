#!/bin/bash
shopt -s extglob

srcfile=$1
depfile=$2


DEPS=$(grep '[^!]*@".*"' $srcfile  | sed 's/.*@"\(.*\)".*/\1/')

target=${srcfile/.+(xfst|lexc)/.a}

if [ -z "$depfile" ]; then
    depfile=${srcfile}.d
fi

echo -n "${target}: " >$depfile
for d in $DEPS;do
    echo -n " $d"  >>$depfile
done
echo>>$depfile;echo>>$depfile

for d in $DEPS;do
    echo "${d}:" >>$depfile
done

