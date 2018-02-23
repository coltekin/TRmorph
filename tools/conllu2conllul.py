#!/usr/bin/env python3

import sys
from trmorph import Trmorph
from conllu import conllu_sentences

trmorph = Trmorph()

for sent in conllu_sentences(sys.argv[1]):
    offset=0
    for tok in sent.tokens():
        analyses = trmorph.analyze(tok)
        conllul = trmorph.to_conll_ul(tok, analyses=analyses,
                begin=offset)
        print(conllul, end="")
        offset = conllul.end
    print()
