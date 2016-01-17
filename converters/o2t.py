#!/usr/bin/python3
#
#
# Released under the terms of the MIT License
# Copyright (c) 2011-2015 Çağrı Çöltekin <cagri@coltekin.net>
# 
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#

""" Convert a tagged coprus from Oflazer tagset to  TRmorph tagset.
    The input file contains a line per word where the surface form is
    followed by the analysis, separated by tab. Each sentence is divided 
    by a single empty line. The output is the same, except tagsets are
    replaced. 
"""

import os,sys,fcntl,re
from subprocess import Popen,PIPE
from math import log
import locale 

locale.setlocale(locale.LC_CTYPE, "tr_TR.UTF-8")

#verbose = False
verbose = True

convert="/usr/local/bin/flookup -b -x ~/trmorph/converters/o2t.fst"
generate="/usr/local/bin/flookup -i -b -x ~/trmorph/trmorph.fst"

try:
    pc = Popen(convert, shell=True, bufsize=1,
              stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=False)
except:
    print("Command `{}' failed\n".format(convert))
    sys.exit(-1)

try:
    pg = Popen(generate, shell=True, bufsize=1,
              stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=False)
except:
    print("Command `{}' failed\n".format(generate))
    sys.exit(-1)

nsentence = 0
nwords = 0

for line in sys.stdin:
    if len(line) < 2:
        nsentence = nsentence + 1
        print()
        continue 

    (sstring, astringO) = line.strip().split(sep='\t')
    if sstring == "'":
        astringO = "'+Punc"

    pc.stdin.write(bytes(astringO + "\n", 'utf-8'))
    pc.stdin.flush()

    analyses = []
    failstr = "__NO_CONV__" + astringO
    for astringT in pc.stdout:
        a = astringT.decode('utf-8').strip()
        if a:
            failstr = "__NO_GEN__" + astringO + " -> " + a 
# workarounds for a few common exceptonal cases which require 
# both analysis and surface strings
            if sstring.startswith('kendisi') and a.startswith('kendi<'):
                a = a.replace('kendi', 'kendisi', 1)
            elif sstring.startswith('kendileri') and a.startswith('kendi<'):
                a = a.replace('kendi<Prn:refl:3p><p3p>', 'kendileri<Prn:refl:3p>', 1)
            elif sstring.startswith('Prof') and a.startswith('profesör<'):
                a = a.replace('profesör<N>', 'Prof<N:abbr>', 1)
            elif sstring.startswith('Doç') and a.startswith('doçent<'):
                a = a.replace('doçent<N>', 'Doç<N:abbr>', 1)
            elif sstring.startswith('Dr') and a.startswith('doktor<'):
                a = a.replace('doktor<N>', 'Dr<N:abbr>', 1)
            elif sstring.startswith('Org') and a.startswith('orgeneral<'):
                a = a.replace('orgeneral<N>', 'Org<N:abbr>', 1)
            elif (sstring.startswith('Tıp') or sstring.startswith('tıp')) and a.startswith('tıb<'):
                a = a.replace('tıb', 'tıp', 1)

            pg.stdin.write(bytes(a + "\n", 'utf-8'))
            pg.stdin.flush()
            result = False
            for tmp in pg.stdout:
                s = tmp.decode('utf-8').strip()
                if s:
                    if s.replace("I","ı").replace("İ","i").lower() == sstring.replace("I","ı").replace("İ","i").lower():
                        result = True
                else:
                    break
            if result:
                analyses.append(a)
        else:
            break

    print("{}".format(sstring), end="")
    if verbose and not len(analyses):
        print("\t{}".format(failstr), end="")
    for i in range(0, len(analyses)):
        print("\t{}".format(analyses[i]), end="")
    print()
            
    if (len(analyses) > 1):
        sys.stderr.write("Multiple ({}) results for `{}/{} -> {}'\n".format(len(analyses), sstring,astringO, analyses))
        
