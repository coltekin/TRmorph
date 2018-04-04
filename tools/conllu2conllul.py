#!/usr/bin/env python3
""" Create a CoNLL-UL file from a CoNLL-U formatted treebank.
"""

import sys
from trmorph import Trmorph, del_circumflex, tr_lower
from conllu import conllu_sentences
import argparse
ap = argparse.ArgumentParser()
ap.add_argument("conllu", type=argparse.FileType('r'),
                    help="Input treebank in CoNLL-U format")
ap.add_argument("--mark-goldid", "-g", action='store_true',
                    help="Try to mark CoNLL-UL 'goldId'")
ap.add_argument("--output-file", "-o",
                    help="Output file. stdout if not specified")
opt = ap.parse_args()

if opt.output_file:
    outfp = open(opt.output_file, 'w')
else:
    outfp = sys.stdout

trmorph = Trmorph()

for sent in conllu_sentences(opt.conllu):
    offset=0
    multi_end = None
    print('\n'.join(sent.comment), file=outfp)
    for i, node in enumerate(sent.nodes[1:]):
        if node.index in sent.multi:
            tok = sent.multi[node.index].form
            analyses = trmorph.analyze(tok)
            if not analyses and tok.isupper():
                analyses = trmorph.analyze(tok[0] + tr_lower(tok[1:]))
            conllul = trmorph.to_conll_ul(tok, analyses=analyses,
                    begin=offset)
            offset = conllul.end
            multi_end = sent.multi[node.index].multi
        elif multi_end:
            if multi_end == node.index:
                multi_end = None
        else:
            tok = node.form
            analyses = trmorph.analyze(tok)
            if not analyses and tok.isupper():
                analyses = trmorph.analyze(tok[0] + tr_lower(tok[1:]))
            conllul = trmorph.to_conll_ul(tok, analyses=analyses,
                    begin=offset)
            offset = conllul.end

        gold_set = set()
        for arc in conllul.arcs:
            #FIXME: treebank has unspecified lemmas (first cond. below)
            is_gold = False
            if node.lemma is None \
                    or del_circumflex(arc.lemma) == del_circumflex(node.lemma):
                arc.lemma = node.lemma
            if arc.lemma in {'ki', 'li', 'siz'} and arc.upos == 'ADJ':
                arc.upos = 'ADP'
                arc.feat = None
            if (arc.lemma, arc.upos) == (node.lemma, node.upos):
                if arc.feat == node.feats:
                    if node.index not in gold_set:
                        is_gold = True
                        gold_set.add(node.index)
                else:
                    ul_feat = set()
                    u_feat = set()
                    if arc.feat: ul_feat = set(arc.feat.split('|'))
                    if node.feats: u_feat = set(node.feats.split('|'))
                    if node.upos in {'NOUN', 'PROPN', 'PRON', 'ADJ'}:
                        ul_feat.add('Person=3')
                    if 'Voice=Pass' in ul_feat and \
                            'Voice=Cau' in ul_feat:
                        ul_feat.remove('Voice=Pass')
                        ul_feat.remove('Voice=Cau')
                        ul_feat.add('Voice=CauPass')

                    feat_diff = ul_feat ^ u_feat
                    for ff in {'Evident=Fh', 'Evident=Nfh',
                            'Polarity=Pos', 'Number=Sing', 'Case=Nom',
                            'Aspect=Perf', 'Mood=Ind', 'Polite=Infm',
                            'Definite=Def', 'NumType=Card'}:
                        if ff in feat_diff: feat_diff.remove(ff)

                    if not feat_diff:
                        if node.index not in gold_set:
                            is_gold = True
                            gold_set.add(node.index)
                if opt.mark_goldid and is_gold:
                    arc.misc = "goldId={}".format(node.index)
            if arc.upos == 'X':
                    arc.misc = "oov=1"
        if multi_end is None: print(str(conllul), end="", file=outfp)
    print(file=outfp)
#        if not have_gold: print("------ No gold", node)

