#!/bin/bash


cat << EOF
#!/usr/bin/expect
#

log_user 0
spawn fst-mor ../trmorph.a
send ""
expect "analyze>"
EOF


state="analyze"
for t in [0-9]*; do
    echo 'puts "Testing patterns from '$t' ..."'
    echo 'puts ""'
    for line in `sort $t | sed 's/#.*//;/^$/d'`;do
        AG=`echo $line|cut -d: -f1`
        AR=`echo $line|cut -d: -f2`
        SND=`echo $line|cut -d: -f3`
        EXP=`echo $line|cut -d: -f4`

        if [ $state = "analyze" -a $AG = "G" ]; then
            echo 'send "\n"'
            echo 'expect "generate>"'
            echo
            state="generate"
        elif [ $state = "generate" -a $AG = "A" ]; then
            echo 'send "\n"'
            echo 'expect "analyze>"'
            echo
            state="analyze"
        fi

        if [[ $AR == "A" ]]; then 
            echo 'puts -nonewline   "'$state' '$SND' accept '$EXP'... "'
            echo 'set found false'
            echo 'send    "'$SND'\n"'
            echo 'expect {'
            echo '  "'$EXP'\r" {puts "OK."; set found true; exp_continue}'
            echo '   timeout {puts "FAILED!"; exit}'
            echo '  "'$state'>" {if {!$found} {puts "FAILED!"; exit}}'
            echo '}'
            echo 
        else # reject
            echo 'puts -nonewline "'$state' '$SND' reject '$EXP'... "'
            echo 'send    "'$SND'\n"'
            echo 'expect {'
            echo '  "'$EXP'" {puts          FAILED."; exit}'
            echo '   timeout {puts "FAILED"; exit}'
            echo '  "'$state'>" {puts "OK."}'
            echo '}'
            echo 
        fi

    done
    echo 'puts ""'
    echo 'puts ""'
done
