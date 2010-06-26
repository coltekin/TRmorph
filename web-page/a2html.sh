#!/bin/bash


input=$1

IFS='
'
for line in `cat $input`;do
    
    if echo "$line" |grep  '^%--' >/dev/null 2>&1 ; then
        w=`echo "$line"  |cut -c4- | cut -d\| -f1 `
        wp=`echo "$line" |cut -c4- | cut -d\| -sf2 `
        echo '<tr><th colspan=3 class=th3>'
        if [[ -n "$wp" ]]; then
            echo "    <a href=http://en.wikipedia.org/wiki/$wp>$w</a>"
        else
            echo "    $w"
        fi
    elif echo "$line" | grep  '^%-' >/dev/null 2>&1; then
        w=`echo "$line"  |cut -c3- | cut -d\| -f1 `
        wp=`echo "$line" |cut -c3- | cut -d\| -sf2 `
        echo '<tr><th colspan=3 class=th2>' 
        if [[ -n "$wp" ]]; then
            echo "    <a href=http://en.wikipedia.org/wiki/$wp>$w</a>"
        else
            echo "    $w"
        fi
    elif echo "$line" | grep  '^<' >/dev/null 2>&1 ;then
        sym=`echo "$line" | sed 's/^<\([^>]*\)>.*/\1/'`
        gls=`echo "$line" | cut -d- -f2`
        exp=`echo "$line" | grep '\--' | sed 's/.*--\(.*\)/\1/'`
        wp=`echo "$gls" |cut -c2- | cut -d\| -sf2 `
        gls=`echo "$gls"  |cut -c2- | cut -d\| -f1 `

        echo "<tr><td><a name=\"$sym\"><b>$sym</b>"
        if [[ -n "$wp" ]]; then
            echo "    <td><a href=http://en.wikipedia.org/wiki/$wp>$gls</a>"
        else
            echo "    <td>$gls"
        fi
        if [[ -n "$exp" ]]; then
            echo "    <td>$exp"
        else 
            echo "    <td>&nbsp;"
        fi

    else
        continue;
    fi
done
