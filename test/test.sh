#!/bin/bash

MOR="fst-mor ../trmorph.a "

mkdir -p tmp
rm -f tmp/*

fail=0
pass=0
test=0

for i in input/[0-9][0-9]_*;do 
    f=`echo $i|cut -d/ -f2`
    sed '/^#/d' input/$f | $MOR input/$f > tmp/$f
    if diff output/$f tmp/$f > /dev/null 2>&1 ;then 
        echo $f .. OK
        rm -f tmp/$f
        let pass=pass+1
    else 
        echo $f .. FAILED
        let fail=fail+1
    fi
done

echo tested $test, passed $pass, failed $fail

if [[ $fail -eq 0 ]]; then
    exit 0
else
    exit 1
fi
