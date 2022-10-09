#!/bin/bash
# foma does not return non-zero on error, this hack tries to detct and
# error on the ouput and return a non-zero value. 
#
src=$1
tgt=""
case "$src" in
    *.xfst)
        tgt=${src/.xfst/.a}
        foma -qre "source $src"  -e "save stack $tgt" -s >\
            /tmp/foma-compile.$$ 2>&1
        foma_return=$?
    ;;
    *.lexc)
        tgt=${src/.lexc/.a}
        foma -qre "read lexc $src"  -e "save stack $tgt" -s >\
            /tmp/foma-compile.$$ 2>&1
        foma_return=$?
    ;;
    *)
        exit -1
    ;;
esac

if grep -iE '(^\*\*\*|error|not enough networks)' /tmp/foma-compile.$$;then
    cat /tmp/foma-compile.$$
    rm -f $tgt
    exit -1
else
    exit $foma_return
fi

rm -f /tmp/foma-compile.$$
