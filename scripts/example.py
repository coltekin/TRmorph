#!/usr/bin/python3

import os,sys,fcntl
from subprocess import Popen,PIPE

flookup="/usr/local/bin/flookup -b -x ../trmorph.fst"

try:
    p = Popen(flookup, shell=True, bufsize=1,
              stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=False)
except:
    print("Cannot start flookup with ../trmorph.fst\n")
    sys.exit(-1)

for line in sys.stdin:
    p.stdin.write(bytes(line, 'utf-8'))
    p.stdin.flush()

    n = 0
    for astring in p.stdout:
        n = n + 1
        a = astring.decode('utf-8').strip()
        if a:
            print('{}: {}'.format(n, a))
        else:
            break
