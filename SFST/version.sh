#!/bin/sh 

date=`date +%Y%m%d%H%M`

if [ -d .git -a -n "`which git`" ]; then
    branch=`git status |head -1| sed 's/# On branch //'`
    echo "$branch" |grep 'Not currently on any branch' && branch="unknown"
    modified=`git status |grep -E '(new file:|modified:)'>/dev/null 2>&1 && echo modified || echo clean`
    commit=`git log --oneline |head -1|cut -d' ' -f1`
    version=TRmorph.$branch.$commit.$modified.$date
    rversion=`cat VERSION`
    rmodified=`git log --oneline --decorate|head -1|grep $rversion >/dev/null 2>&1\
               && echo clean || echo modified`
    release=TRMorph.$rversion.$rmodified
else
    version=TRmorph.unknown.$date
    release=TRmorph.`cat VERSION`.unknown
fi

echo "{$version}:{version} | {$release}:{release}" | sed 's/[.-]/\\&/g'
