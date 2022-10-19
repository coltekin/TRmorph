#!/usr/bin/python3

import os,sys
from trmorpy import TrMorph


trm = TrMorph(datadir=os.path.join(sys.path[0],".."))
print(sys.argv[1], "...", end=" ")
linenum = 0
with open(sys.argv[1], 'r') as fp:
    for line in fp:
        linenum += 1
        if line[0] in '!#': continue
        line = line.strip()
        if len(line) == 0: continue
        action, result, surface, analysis = line.split(";")
        if action == 'A':
            out = [x for x in trm.analyze_word(surface)
                    if '⟨X⟩' not in x]
            expect = analysis
            inp = surface
        elif action == 'G':
            out = trm.generate(analysis)
            expect = surface
            inp = analysis
        else:
            sys.exit("malformed test file")

        if len(expect) == 0:
            if result == "A" and len(out) == 0:
                sys.exit("{}: Failed to accept: input `{}'.".format(
                    linenum, inp))
            elif result == "R" and len(out) != 0:
                sys.exit("{}: Failed to reject: input `{}'.".format(
                    linenum, inp))
            continue

        found = False
        for a in out:
            if expect == a:
                found = True
                break
        if result == "A" and not found:
            sys.exit("{}: Failed to accept {}: {} -> {}".format(
                linenum, action, inp, expect))
        if result == "R" and found:
            sys.exit("{}: Failed to reject {}: {} -> {}".format(
                linenum, action, inp, expect))

print("OK")
sys.exit(0)
