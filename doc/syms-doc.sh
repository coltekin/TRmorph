#!/bin/bash

input=$1

g1="POS Nominal Verbal"

print_sym_html()
{
    file=symbols/$1
    sym=$1
    dsc=`head -1 $file`
    wp=`grep ^WP: $file |cut -d: -f2-`
    notes=`grep ^NOTE: $file |cut -d: -f2-`
    exmpl=`grep ^EX: $file |cut -d: -f2-`

    echo "<tr><td><a name=\"$sym\"><b>$sym</b>"
    if [[ -n "$wp" ]]; then
        echo "    <td><a href=http://en.wikipedia.org/wiki/$wp>$dsc</a>"
    else
        echo "    <td>$dsc"
    fi
    if [[ -n "$exmpl" ]]; then
        if [[ -n "$notes" ]]; then
            echo "    <td>$notes<br><i>$exmpl</i>"
        else
            echo "    <td><i>$exmpl</i>"
        fi
    else 
        if [[ -n "$notes" ]]; then
            echo "    <td>$notes"
        else
            echo "    <td>&nbsp;"
        fi
    fi
}

print_head_html()
{
    gr=$1
    level=$2
    dsc=`grep ^$gr: symbol_groups |cut -d: -f2`
    wp=`grep ^$gr: symbol_groups |cut -d: -f3`
    echo "<tr><th colspan=3 class=th$level>"
    if [[ -n "$wp" ]]; then
        echo "    <a href=http://en.wikipedia.org/wiki/$wp>$dsc</a>"
    else
        echo "    $dsc"
    fi
}

for g in $g1; do
    g2=`cut -d: -f1 symbol_groups |grep ^${g}/`
    syms=`grep -l ^Type:$g'$' symbols/* |sed 's/^symbols\///'`
    print_head_html $g 2
    if [ -n "$syms" ]; then 
        for s in $syms; do
            print_sym_html $s
        done
    fi
    for gg in $g2; do 
        print_head_html $gg 3
        syms=`grep -l ^Type:$gg'$' symbols/* |sed 's/^symbols\///'`
            for s in $syms; do
                print_sym_html $s
            done
    done
done

exit


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
