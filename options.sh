#!/bin/sh

cat $* \
| sed 's/^!!!__PARTWORDS_'"${PARTWORDS}"'__//;/^!!!PARTWORDS/d' \
| sed 's/^!!!APOSTROPHE_'"${APOSTROPHE}"'//;/^!!!APOSTROPHE/d'

return 0
