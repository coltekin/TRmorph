#!/bin/bash


cat << EOF
#!/usr/bin/expect
#

set timeout 2
set CTRLd \004
log_user 0
spawn foma
send ""
expect -re "foma.0.: "
send "load stack ../trmorph.fst\n"
expect -re "foma.1.: "
send "up\n"
expect "apply up> "

EOF



state="analyze"
sstring="apply up"
failstring='\?\?\?'

t=$1
echo 'puts "Testing patterns from '$t' ..."'
echo 'puts ""'
OIFS=$IFS
IFS='
'
for line in `sort $t | sed 's/#.*//;/^$/d'`;do
IFS=$IFS
    AG=`echo $line|cut -d\; -f1`
    AR=`echo $line|cut -d\; -f2`
    SND=`echo $line|cut -d\; -f3`
    EXP=`echo $line|cut -d\; -f4`
    if [[ -z "$EXP" ]]; then
        EXP="$failstring"
        AR="A"
    fi
echo '# [dbg] line: ' $line 
echo '# [dbg] snd: ' $SND 
echo '# [dbg] exp: ' $EXP 

    if [ $state = "analyze" -a $AG = "G" ]; then
        echo 'send $CTRLd'
        echo 'expect -re "foma.1.: "'
        echo 'send "down\n"'
        echo 'expect  "apply down> "'
        echo
        state="generate"
        sstring="apply down"
    elif [ $state = "generate" -a $AG = "A" ]; then
        echo 'send $CTRLd'
        echo 'expect -re "foma.1.: "'
        echo 'send "up\n"'
        echo 'expect "apply up> "'
        echo
        state="analyze"
        sstring="apply up"
    fi

    if [[ $AR == "A" ]]; then 
        if [[ "$EXP" == "$failstring" ]]; then
            echo 'puts -nonewline "'$state' '$SND' reject ... "'
        else
            echo 'puts -nonewline   "'$state' '$SND' accept '$EXP'... "'
        fi
        echo 'set found false'
        echo 'send    "'$SND'\n"'
        echo 'expect {'
        echo '  -re {'$EXP'\r} {puts "OK."; set found true; exp_continue}'
        echo '   timeout {puts "FAILED!"; exit}'
        echo '  "'$sstring'>" {if {!$found} {puts "FAILED!"; exit}}'
        echo '}'
        echo 
    else # reject
        echo 'puts -nonewline "'$state' '$SND' reject '$EXP'... "'
        echo 'send    "'$SND'\n"'
        echo 'expect {'
        echo '  "'$EXP'" {puts          FAILED."; exit}'
        echo '   timeout {puts "FAILED"; exit}'
        echo '  "'$sstring'>" {puts "OK."}'
        echo '}'
        echo 
    fi

done
echo 'puts ""'
echo 'puts ""'
