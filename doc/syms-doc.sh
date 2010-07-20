#!/bin/bash

out_type=${1:-txt}
gr_file=symbols/groups

g1="POS Nominal Verbal"

print_sym_html()
{
    sym=$1
    dsc=$2
    wp=$3
    notes=$4
    exmpl=$5

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

print_sym_txt()
{
    sym=$1
    dsc=$2
    wp=$3
    notes=$4
    exmpl=$5

    echo "      <$sym> $dsc"
    [[ -n "$notes" ]] && echo "$notes "|fmt -w 65|sed 's/^/          /'
    [[ -n "$exmpl" ]] && echo "Exmple: $exmpl "|fmt -w 65|sed 's/^/          /'
}

print_head_html()
{
    dsc=$1
    wp=$2
    level=$3
    echo "<tr><th colspan=3 class=th$level>"
    if [[ -n "$wp" ]]; then
        echo "    <a href=http://en.wikipedia.org/wiki/$wp>$dsc</a>"
    else
        echo "    $dsc"
    fi
}

print_head_txt()
{
    dsc=$1
    level=$2
    if [[ $level -eq 2 ]]; then
        echo;echo
        echo -n '*' 
    else
        echo
        echo -n "    - " 
    fi
    echo $dsc
}

print_sym()
{
    file=symbols/$1
    sym=$1
    output=$2
    dsc=`head -1 $file`
    wp=`grep ^WP: $file |cut -d: -f2-`
    notes=`grep ^NOTE: $file |cut -d: -f2-`
    exmpl=`grep ^EX: $file |cut -d: -f2-`
    case $output in
        html) print_sym_html "$sym" "$dsc" "$wp" "$notes" "$exmpl"
        ;;
        txt)  print_sym_txt  "$sym" "$dsc" "$wp" "$notes" "$exmpl"
        ;;
    esac
}

print_head()
{
    gr=$1
    level=$2
    output=$3
    dsc=`grep ^$gr: $gr_file |cut -d: -f2`
    wp=`grep ^$gr: $gr_file |cut -d: -f3`
    case $output in
        html) print_head_html "$dsc" "$wp" "$level"
        ;;
        txt)  print_head_txt "$dsc" "$level"
        ;;
    esac
}

for g in $g1; do
    g2=`cut -d: -f1 $gr_file |grep ^${g}/`
    syms=`grep -l ^Type:$g'$' symbols/* |sed 's/^symbols\///'`
    print_head $g 2 $out_type
    if [ -n "$syms" ]; then 
        for s in $syms; do
            print_sym $s $out_type
        done
    fi
    for gg in $g2; do 
        print_head $gg 3 $out_type
        syms=`grep -l ^Type:$gg'$' symbols/* |sed 's/^symbols\///'`
            for s in $syms; do
                print_sym $s $out_type
            done
    done
done
