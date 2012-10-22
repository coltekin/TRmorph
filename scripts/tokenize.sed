#!/bin/sed -rf
s/([^ \t])([-+“‘”"/()*?!;.:,])/\1 \2/g # insert space before
s/([-+/“‘”"()*?!;.,:])([^ \t])/\1 \2/g # and after
s/([0-9]) +([.,:]) +([0-9])/\1\2\3/g # undo if these are inbetween numbers
s/([ \t])([`'])([^ \t])/\1\2 \3/g    # tokenize these at the beginning of word
s/([^ \t])(['’])([ \t])/\1 \2\3/g    # tokenize these at the end of word
s/[ \t]+/ /g                         # squash space
s/[ \t]/\n/g                         # insert the token boundary
