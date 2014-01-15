#!/usr/bin/python3
#
#-----------------------------------------------------------------------
# Copyright 2011-2014 Cagri Coltekin <c.coltekin@rug.nl>
#
# This file is part of TRmorph.
#
# TRmorph is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# TRmorph is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser Public License for more details.
#
# You should have received a copy of the GNU Lesser Public License
# along with TRmorph. If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------
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
        
