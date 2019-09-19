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

def tr_upper(s):
    return s.replace('i', 'İ').replace('ı', 'I').upper()

def tr_lower(s):
    return s.replace('I', 'ı').replace('İ', 'i').lower()

def del_circumflex(s):
    return (s.replace('â', 'a')
             .replace('û', 'u')
             .replace('î', 'i')
             .replace('Â', 'A')
             .replace('Î', 'İ')
             .replace('Û', 'U'))

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
        m = self.a_re.match(astring)
        while m and m.group('root'):
            a_split.append((
                m.group('root'),
                m.group('pos').replace('⟨', '').replace('⟩', ''),
                [x.replace('⟨', '').replace('⟩', '') for x in\
                        m.group('inflections').split('⟩⟨')] \
                    if m.group('inflections') else []
            ))
            m = re.match(self.a_re, m.group('rest'))

        debug('sstring = {}, astring = {}'.format(sstring, astring))
        match = False
        for s in self.generator_ig.analyze(astring):
            s_form = (s.replace('⟪DB⟫', '').replace('⟪RB⟫', '')
                       .replace('⟪MB⟫', '').replace('⟪IGB⟫', ''))
            s_form_norm = del_circumflex(s_form)
            sstring_norm = del_circumflex(sstring)
            if (( s_form_norm == sstring_norm)
                 or (astring[0].isupper() and
                    sstring_norm[0] + tr_lower(sstring_norm[1:]) 
                        == 
                    s_form_norm[0] + tr_lower(s_form_norm[1:]))
                 or (astring[0].islower() and
                    tr_lower(sstring_norm) == tr_lower(s_form_norm))):
                match = True
                break
            else:
                debug('Ambiguous generation:', sstring, s_form)

        debug('generated = {}'.format(s))

        s_split = (s.replace('⟪DB⟫', '').replace('⟪RB⟫', '')
                    .split('⟪IGB⟫'))

        debug('split = {}'.format(s_split))

        assert(len(s_split) == len(a_split))

        def split_like(sp, s):
            """ Split s similar to the already split same-size string 'sp'
            """
            assert len(''.join(sp)) == len(s), "_{}_ - _{}_".format(sp, s)
            i = 0
            ssp = []
            for seg in sp:
                ssp.append(s[i:i+len(seg)])
                i += len(seg)
            return ssp

        ig_forms = split_like([x.replace('⟪MB⟫', '') for x in s_split], sstring)

        if len(''.join(s_split).replace('⟪MB⟫', '')) != len(sstring):
            print(''.join(s_split).replace('⟪MB⟫', ''), '-',  sstring, file=sys.stderr)

        igs = [] # tuples of <surface, lemma, pos, inflections>
        for i, (a, s) in enumerate(zip(a_split, s_split)):
            ig_lemma, ig_pos, ig_infl = a
            debug('    l = {}, p = {}, infl = {}'.format(ig_lemma, ig_pos, ig_infl))
            ig_surf = ig_forms[i]
            if len(s) == 0: # skip zero morphemes (copula)
                pass
            elif i > 0 and ig_lemma not in {'⟨ki⟩', '⟨cpl⟩', '⟨li⟩', '⟨lik⟩', '⟨siz⟩'}:
                prev_ig = igs.pop()
                ig_morphs = split_like(s.split('⟪MB⟫'), ig_surf)
                ig_lemma = prev_ig[0] + ig_morphs[0]
                if not ig_lemma.islower() and prev_ig[1].islower():
                    ig_lemma = tr_lower(ig_lemma)
                igs.append((prev_ig[0] + ig_surf, ig_lemma, ig_pos, ig_infl))
                debug('-> pf = {}, pl = {}'.format(prev_ig[0], prev_ig[1]))
            else:
                if ig_lemma == '⟨ki⟩': #TODO: use -ki to distinguis from the free morpheme
                    ig_lemma = 'ki'
                elif ig_lemma == '⟨cpl⟩':
                    ig_lemma = 'i'
                elif ig_lemma == '⟨li⟩':
                    ig_lemma = 'li'
                elif ig_lemma == '⟨lik⟩':
                    ig_lemma = 'lik'
                elif ig_lemma == '⟨siz⟩':
                    ig_lemma = 'siz'
                igs.append((ig_surf, ig_lemma, ig_pos, ig_infl))
        debug('returning = {}'.format(igs))
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
            choices=('trmorph', 'ud', 'conll-ul', 'udcs'), default='trmorph')
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
                if len(igs) > 1:
                    print("0-{}\t{}\t_\t_\t_\t_\t_\t_\t_\t_".format(
                        len(igs)-1, s))
                for i, ig in enumerate(igs):
                    print("{}\t{}\t{}\t{}\t_\t{}\t_\t_\t_\t_".format(i,
                        *ig[:3], "|".join(sorted(ig[3]))))
            print()
        elif 'udcs' == opt.out_fmt:
            outstr = [s]
            for a in set(analyses):
                igs = trmorph.igs_to_ud(trmorph.to_igs(a, s))
                a_out = ""
                for i, ig in enumerate(igs):
                    if i == len(igs) - 1:
                        sep = ""
                    else:
                        sep = " -- "
                    feat_val = dict()
                    for ff in ig[3]:
                        f, v  = ff.split('=')
                        feat_val[f] = sorted(feat_val.get(f, []) + [v])
                    feat_val = '|'.join(sorted(['='.join((f, ''.join(v))) for f,v in feat_val.items()]))
                    if not feat_val:
                        feat_val = "_"
                    a_out += "{}+{}+{}{}".format(ig[1], ig[2], feat_val, sep)
                outstr.append(a_out)
            if len(outstr) > 1:
                print('\t'.join([outstr[0]] + list(set(outstr[1:]))))
            else:
                print('{}\tUNKNOWN'.format(outstr[0]))
