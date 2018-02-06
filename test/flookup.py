#!/usr/bin/python3

import os
from subprocess import Popen,PIPE

class Fst:
    def_cmd = os.environ['HOME'] + "/bin/flookup -b -x "
    def_fst = os.environ['HOME'] + "/trmorph/trmorph.fst"

    def __init__(self, cmd=def_cmd, fst=def_fst, inverse=False):
        if inverse:
            inverse_flag = " -i "
        else:
            inverse_flag = ""

        command = cmd + inverse_flag + fst

        try:
            self.p = Popen(command, shell=True, bufsize=1,
                      stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=False)
        except:
            print("Cannot start flookup with `trmorph.fst'", file=sys.stderr)
            sys.exit(-1)

    def close(self, p):
        self.p.stdin.close()
        self.p.stdout.close()
        self.p.stderr.close()

    def analyze(self, word):
        alist = []
        self.p.stdin.write(bytes(word + "\n", 'utf-8'))
        self.p.stdin.flush()
        for astring in self.p.stdout:
            a = astring.decode('utf-8').strip()
            if a:
                if a == '+?': continue 
                alist.append(a)
            else:
                break
        return alist
