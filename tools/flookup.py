#!/usr/bin/python3

import os.path
from subprocess import Popen,PIPE
import shutil

class Fst:
    DEF_CMD = shutil.which('flookup')
    DEF_FST = os.path.join(os.path.dirname(__file__),
                                "..", "trmorph.a")

    def __init__(self, cmd=(DEF_CMD + " -b -x "), fst=DEF_FST, inverse=False):
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
