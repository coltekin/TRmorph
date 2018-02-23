#!/usr/bin/python3
""" Python interface to TRmorph - http://coltekin.net/cagri/trmorph/
"""

import sys, re, copy
from logging import debug, info, warning, basicConfig
basicConfig(level="INFO", format='%(asctime)s %(message)s')

from flookup import Fst
from trmorph2ud import trmorph_to_ud
from conll_ul import CoNLLUL

import os.path
FST_DIR = os.path.join(os.path.dirname(__file__), "..")

class Trmorph:
    a_re = re.compile('(?P<root>.*?)'
          '(?P<pos>⟨[A-Z][A-Za-z0-9:]*⟩)'
          '(?P<inflections>.*?)'
          '(?P<rest>(⟨[^A-Z][A-Za-z0-9:]*⟩⟨[A-Z][A-Za-z0-9:]*⟩.*)|$)')

    def __init__(self,
                 fst_a=None,
                 fst_g=None,
                 fst_ig=None):
        # defaults
        if fst_a is None:
            fst_a = os.path.join(FST_DIR, 'trmorph.a')
        if fst_g is None:
            fst_g = fst_a
        if (fst_ig is None and 
                os.path.isfile(os.path.join(FST_DIR, 'trmorph-boundary.a'))):
            fst_ig = os.path.join(FST_DIR, 'trmorph-boundary.a')

        assert(os.path.isfile(fst_a))
        self.analyzer = Fst(fst=fst_a)
        self.generator = Fst(fst=fst_g, inverse=True)
        if fst_ig:
            self.generator_ig = Fst(fst=fst_ig, inverse=True)
        else:
            self.generator_ig = None

    def analyze(self, sstring):
        return self.analyzer.analyze(sstring)

    def generate(self, astring):
        return self.generator.analyze(astring)

    def to_igs(self, astring, sstring):
        a_split = []
        m = re.match(self.a_re, astring)
        while m and m.group('root'):
            a_split.append((
                m.group('root'),
                m.group('pos').replace('⟨', '').replace('⟩', ''),
                [x.replace('⟨', '').replace('⟩', '') for x in\
                        m.group('inflections').split('⟩⟨')]
            ))
            m = re.match(self.a_re, m.group('rest'))

        for s in self.generator_ig.analyze(astring):
            s_form = (s.replace('⟪DB⟫', '').replace('⟪RB⟫', '')
                       .replace('⟪MB⟫', '').replace('⟪IGB⟫', ''))
            if astring[0].islower() and \
                    sstring.lower() == s_form.lower():
                break
        s_split = (s.replace('⟪DB⟫', '').replace('⟪RB⟫', '')
                    .split('⟪IGB⟫'))

        assert(len(s_split) == len(a_split))

        igs = [] # tuples of <surface, lemma, pos, inflections>
        for i, (a, s) in enumerate(zip(a_split, s_split)):
            if len(s) == 0: # skip zero morphemes (copula)
                pass
            elif i > 0 and a[0] not in {'⟨ki⟩', '⟨cpl⟩'}:
                prev_ig = igs.pop()
                lemma = prev_ig[0] + s.split('⟪MB⟫')[0]
                igs.append((prev_ig[0] + s.replace('⟪MB⟫', ''),
                    lemma, a[1], a[2]))
            else:
                igs.append((s.replace('⟪MB⟫', ''),
                    a[0].replace('⟨', '').replace('⟩', ''), a[1], a[2]))
        return igs

    def to_ud(self, ig):
        return trmorph_to_ud(ig)

    def igs_to_ud(self, igs):
        ud_igs = []
        for ig in igs:
            ud_igs.append(self.to_ud(ig))
        return(ud_igs)


    def to_conll_ul(self, s, analyses=None, begin=0):
        if not analyses:
            analyses = self.analyze(s)
        if len(analyses) == 0:
            segments = [(0, len(s), s, s, "X", "_")]
            states = [0, len(s)]
        else:
            states = {0}
            segments = []
            for a in analyses:
                igs = self.igs_to_ud(self.to_igs(a, s))
                frm = 0
                w_form = ''
                for form, lemma, pos, feat in igs:
                    to = frm + len(form)
                    w_form += form
                    states.add(to)
                    feat = '|'.join(sorted(feat))
                    if (frm, to, form, lemma, pos, feat) not in segments:
                        segments.append((frm, to, form, lemma, pos, feat))
                    frm = to
        states = sorted(states)
        conllul = CoNLLUL(s, begin=begin)
        for frm, to, form, lemma, pos, feat in segments:
            conllul.add_arc(from_state=states.index(frm),
                            to_state=states.index(to),
                            form=form, lemma=lemma,
                            upos=pos, feat=feat)
        return conllul


if __name__ == "__main__":
    from argparse import ArgumentParser
    ap = ArgumentParser()
    ap.add_argument("--output-format", "-f", dest="out_fmt",
            choices=('trmorph', 'ud', 'conll-ul'), default='trmorph')
    opt = ap.parse_args()

    trmorph = Trmorph()
    for line in sys.stdin:
        s = line.strip()
        analyses = trmorph.analyze(s)
        if 'trmorph' == opt.out_fmt:
            for a in analyses:
                print("{}\t{}".format(s, a))
        elif 'conll-ul' == opt.out_fmt:
            print(trmorph.to_conll_ul(s, analyses=analyses))
        elif 'ud' == opt.out_fmt:
            for a in analyses:
                igs = trmorph.igs_to_ud(trmorph.to_igs(a, s))
                print("{}\t{}".format(s, igs))
