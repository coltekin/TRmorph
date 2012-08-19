#!/bin/bash

infile=$1

pos=$(echo $infile | sed s/.sfstlex//)

echo LEXICON ${pos}Root

OIFS=$IFS
IFS='
'
for line in `grep -v '^[%#=]' $infile \
            | sed 's/<\([t|c|k|p|g]\)>/^\1/g' \
            | sed 's/<e>/e/g' \
            | sed 's/<\(p[A|I|O|U]\)>/^\1/g' \
            | sed 's/<del>\(.\)/\1@DEL@/g;s/<dup>/@DUP@/g;s/<dels>/@DELS@/g'`
do
    IFS=$OIFS

    Cclass=$pos
    if [[ $Cclass == "Verb" ]]; then Cclass="V";fi
    unset astring
    unset reflexive
    unset reciprocal
    unset reciprocal
    unset caus
    unset aor
# echo "! $line"
    case "$line" in
        *\<compn\>*) Cclass="${Cclass}comp"
#echo "! $line: compn"
        ;;
        *\<yn\>*) Cclass="${Cclass}comp"
        ;;
        *\<rfl\>*) reflexive="true"
        ;;&
        *\<rcp\>*) reciprocal="true"
        ;;&
        *\<caus_*\>*) caus=$(echo $line | sed 's/.*<caus_\([^>]*\).*>/\u\1/')
        ;;&
        *\<aor_ar\>*) aor="ar"
        ;;
        *\<pers\>*) Cclass="PersPrn"
        ;;
        *\<dem\>*) Cclass="DemPrn"
        ;;
        *\<qst\>*) Cclass="QPrn"
        ;;
        *\<locp\>*) Cclass="LocPrn"
        ;;
    esac

    line=$(echo $line | sed -E 's/<rfl>//;s/<compn>//;s/<rcp>//;s/<caus_[^>]*>//;s/<aor_ar>//;s/<pers>//;s/<dem>//;s/<qst>//;s/<locp>//;s/s?[iıuü]<yn>//')

    if echo $line | grep ':<>' >/dev/null 2>&1;then
            astring=$(echo $line|sed 's/:<>//g')
            line=$(echo $line|sed 's/.:<>//g')
    fi

# echo "! caus: '$caus'"

    if [[ -n  "$reflexive" ]];then
        Cclass="${Cclass}_Rfl"
    fi
    if [[ -n  "$reciprocal" ]];then
        Cclass="${Cclass}_Rcp"
    fi
    if [[ -n  "$caus" ]];then
        Cclass="${Cclass}_Caus${caus}"
    fi
    if [[ -n  "$aor" ]];then
        Cclass="${Cclass}_AorAr"
    fi

    if [[ -n "$astring" ]];then
        word="$astring:$line"
    else
        word="$line"
    fi

# We ignore a few subcategories for now.
    word=$(echo $word|sed 's/<[^>]*>//g;s/ /%&/g')

    printf "%-30s %s;\n" "$word" $Cclass
done
    
