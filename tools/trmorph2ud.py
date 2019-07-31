#!/usr/bin/python3
""" Converter from trmorph tagset to UG.
"""

from logging import debug, info, warning, basicConfig
basicConfig(level="INFO", format='%(asctime)s %(message)s')


pos_map = {
    'Alpha':    'SYM',
    'Adj':      'ADJ',
    'Adv':      'ADV',
    'Cnj':      'CCONJ',
    'Det':      'DET',
    'Ij':       'INTJ',
    'N':        'NOUN',
    'Num':      'NUM',
    'Postp':    'ADP',
    'Pron':     'PRON',
    'Punc':     'PUNCT',
    'Sym':      'SYM',
    'Q':        'AUX',
    'V':        'VERB',
    'AUX':      'AUX',
}

# straightforward mapping only
tag_map = {
    'pl': ('Number=Plur',),
    'sg': ('Number=Sing',),
    'p1s': ('Number[psor]=Sing','Person[psor]=1',),
    'p2s': ('Number[psor]=Sing','Person[psor]=2',),
    'p3s': ('Number[psor]=Sing','Person[psor]=3',),
    'p1p': ('Number[psor]=Plur','Person[psor]=1',),
    'p2p': ('Number[psor]=Plur','Person[psor]=2',),
    'p3p': ('Number[psor]=Plur','Person[psor]=3',),
    'nom': ('Case=Nom',),
    'acc': ('Case=Acc',),
    'dat': ('Case=Dat',),
    'abl': ('Case=Abl',),
    'loc': ('Case=Loc',),
    'gen': ('Case=Gen',),
    'ins': ('Case=Ins',),
    'ce': ('Case=Equ',),    #TODO: not really
    'dist': ('NumType=Dist',),
    'ord': ('NumType=Ord',),
    #TODO: other case-like suffixes -siz, -li, -lik
    'rfl': ('Voice=Rfl',),
    'rcp': ('Voice=Rcp',),
    'caus': ('Voice=Cau',),
    'pass': ('Voice=Pass',),
    'abil': ('Mood=Pot',),    #TODO: this is also Permissive/Abilitive
    'ayaz': ('Aspect=Prosp',),
    'iver': ('Aspect=Rapid',),  #TODO: not in UD v2
    'adur': ('Aspect=Iter',),
    'agel': ('Aspect=Iter',),
    'akal': ('Aspect=Iter',),
    'agor': ('Aspect=Iter',),   #TODO: durative ?
    'neg': ('Polarity=Neg',),
    'imp': ('Mood=Imp',),
    # oteher TAME markers are complex, treated below
    '1s': ('Person=1','Number=Sing'),
    '2s': ('Person=2','Number=Sing'),
    '3s': ('Person=3','Number=Sing'),
    '1p': ('Person=1','Number=Plur'),
    '2p': ('Person=2','Number=Plur'),
    '3p': ('Person=3','Number=Plur'),
    'dir': ('Mood=Gen',),
    'vn.me': ('VerbForm=Vnoun',),
    'vn.mek': ('VerbForm=Vnoun',),
    'vn.yis': ('VerbForm=Vnoun',),
    'part.pres': ('VerbForm=Part','Tense=Pres'),
    'part.past': ('VerbForm=Part','Tense=Past'),
    'part.fut': ('VerbForm=Part','Tense=Fut'),
    'part.esi': ('VerbForm=Part','Tense=Pres'),
    'part.ici': ('VerbForm=Part','Tense=Pres'),
    'cv.cesine': ('VerbForm=Conv',),
    'cv.ken': ('VerbForm=Conv',),
    'cv.dikce': ('VerbForm=Conv',),
    'cv.eli': ('VerbForm=Conv',),
    'cv.erek': ('VerbForm=Conv',),
    'cv.esiye': ('VerbForm=Conv',),
    'cv.inceye': ('VerbForm=Conv',),
    'cv.ince': ('VerbForm=Conv',),
    'cv.ip': ('VerbForm=Conv',),
    'cv.meden': ('VerbForm=Conv',),
    'cv.meksizin': ('VerbForm=Conv',),
    'cv.ye': ('VerbForm=Conv',),
    #
    'def': ('Definite=Def',),
    'indef': ('Definite=Ind',),
    #
    'abbr': ('Abbr=Yes',),
}

tags_ignore = { # tags that are not (explicitly) converted
    'p0x',
    'apos',
    'rom',  # Roman numerals
    'ara',  # Arabic numerals
    'coo',  # CCONJ is default
}

tame_markers = {
    'aor',
    'cond',
    'evid',
    'fut',
    'obl',
    'opt',
    'past',
    'prog.yor',
    'prog.mekte'
}

def trmorph_to_ud(ig):
    surface = ig[0]
    lemma = ig[1]
    pos = pos_map[ig[2]]
    t_tags = ig[3]
    ud_tags = []
    tame_tags = []

    # special/exceptional lemmas 
    if lemma in { 'değil' , 'yok'}:
        ud_tags.append('Polarity=Neg')
    if lemma in {'ol', 'i'} and pos == 'VERB':
        pos = 'AUX'

    while t_tags:
        t = t_tags[0]
        if t_tags[0] in tag_map:
            ud_tags.extend(tag_map[t])
        elif t in tame_markers:
            tame_tags.append(t)
        elif t == "sub" and pos == 'CCONJ':
            pos = 'SCONJ'
        elif t == "adv" and pos == 'CCONJ':
            pos = 'ADV'
        elif t == 'prop' and pos == 'NOUN':
            pos = 'PROPN'
        elif t == 'cpl' and pos in {'VERB', 'AUX'}:
            pass
        elif t in tags_ignore:
            pass
        else:
            warning("Tag `{}' is not handled in {}".format(t, ig))

        del t_tags[0]

    # Assign Tense/aspect/modality/evidentiality.
    # The long list is intentional (for documenting
    # different cases)
    #
    # 'aor' ...
    if tame_tags == ['aor']: # okur
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Hab')
        ud_tags.append('Mood=Gen')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['aor', 'evid']:  # okurmuş
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Hab')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['aor', 'past']:  # okurdu
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Hab')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['aor', 'cond']:  # okursa
        # With 'cond' 'aor' seems to lose habitual aspect.
        # To keep the habitual, one needs to use the i- form: 'okur idiyse'
        ud_tags.append('Tense=Pres')    # TODO: Fut ?
        ud_tags.append('Aspect=Imp')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['aor', 'cond', 'evid'] or # okursaymış
          tame_tags == ['aor', 'evid', 'cond']):  # (?)okurmuşsa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Imp')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['aor', 'cond', 'past'] or # (?)okursaydı
          tame_tags == ['aor', 'past', 'cond']):  # (?)okurduysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Imp')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['aor', 'past', 'past']:  # okurduydu
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Hab')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['aor', 'evid', 'evid'] or # okurmuşmuş
          tame_tags == ['aor', 'evid', 'past']):  # (?)okurmuştu
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Hab')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    # 'cond' ...
    elif tame_tags == ['cond']: # okusa
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['cond', 'evid']: # okusaymış
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Perf')   # Impf ?
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['cond', 'past']: # okusaydı
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['cond', 'evid', 'evid']: # okusaymışmış
        ud_tags.append('Tense=Past')    # Pqp ?
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['cond', 'past', 'past']: # (?)okusaydıydı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['cond', 'evid', 'past'] or # (?)okusaymıştı
          tame_tags == ['cond', 'evid', 'past']):  # (??)okusaydıymış
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    # 'evid' ...
    elif tame_tags == ['evid']: # okumuş
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['evid', 'evid'] or # okumuşmuş
          tame_tags == ['evid', 'past']):  # okumuştu
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['evid', 'cond']: # okumuşsa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Perf')   # Impf ?
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['evid', 'cond', 'past'] or # (?)okumuşsaydı
          tame_tags == ['evid', 'cond', 'past'] or # (?)okumuşsaydı
          tame_tags == ['evid', 'past', 'cond'] or # (?)okumuştuysa
          tame_tags == ['evid', 'evid', 'cond']):  # (?)okumuşmuşsa
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['evid', 'evid', 'evid'] or # (?)okumuşmuşmuş
          tame_tags == ['evid', 'evid', 'past'] or # (?)okumuşmuştu
          tame_tags == ['evid', 'past', 'past'] or # (?)okumuştuydu
          tame_tags == ['evid', 'past', 'evid']):  # (?)okumuştuymuş
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    # 'fut' ...
    elif tame_tags == ['fut']:  # okuycak
        ud_tags.append('Tense=Fut')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['fut', 'evid']:  # okuycakmış
        ud_tags.append('Tense=Fut')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['fut', 'past']:  # okuycaktı
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prosp')  # also a subclass of imperfective
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['fut', 'cond']:  # okuycaksa
        ud_tags.append('Tense=Fut')
        ud_tags.append('Aspect=Perf')   # this is prospective too?
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['fut', 'cond', 'past'] or # okuycaksaydı
          tame_tags == ['fut', 'past', 'cond']):  # okuyacaktıysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prosp')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['fut', 'cond', 'evid'] or # okuycaksaymış
          tame_tags == ['fut', 'evid', 'cond']):  # okuyacakmışsa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prosp')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['fut', 'evid', 'evid'] or # okuycakmışmış
          tame_tags == ['fut', 'past', 'evid'] or # (?)okuyacaktıymış
          tame_tags == ['fut', 'evid', 'past']):  # (?)okuycakmıştı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Prosp')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['fut', 'evid', 'evid']:  # okuycakmışmış
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Prosp')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['fut', 'past', 'past']:   # okuycaktıydı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Prosp')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    # 'obl' ...
    elif tame_tags == ['obl']:          # okumalı
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['obl', 'evid']:  # okumalıymış
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['obl', 'past']:  # okumalıydı
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['obl', 'cond']:  # okumalıysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['obl', 'cond', 'past'] or # okumalıysaydı
          tame_tags == ['obl', 'past', 'cond']):  # okumalıydıysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['obl', 'cond', 'evid'] or # okumalıysaymış
          tame_tags == ['obl', 'evid', 'cond']):  # okumalıymışsa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['obl', 'evid', 'evid'] or # okumalıymışymış
          tame_tags == ['obl', 'past', 'evid'] or # (?)okumalıydıymış
          tame_tags == ['obl', 'evid', 'past']):  # (?)okumalıymıştı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['obl', 'past', 'past']: # okumalıydıydı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Nec')
        ud_tags.append('Evident=Fh')
    # 'opt' ...
    elif tame_tags == ['opt']:              # okuya
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Opt')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['opt', 'evid']:      # okuyaymış
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Opt')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['opt', 'past']:      # okuyaydı
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Opt')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['opt', 'past', 'past']: # (?)okuyaydıydı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Opt')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['opt', 'evid', 'evid'] or # okuyaymışmış
          tame_tags == ['opt', 'evid', 'past'] or # (?)okuyaymıştı
          tame_tags == ['opt', 'past', 'evid']):  # (?)okuyaydıymış
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Opt')
        ud_tags.append('Evident=Nfh')
    # 'past' ...
    elif tame_tags == ['past']:             # okudu
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif tame_tags == ['past', 'past']:     # okuduydu
        ud_tags.append('Tense=Ppq')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')  # ?
    elif tame_tags == ['past', 'cond']:     # okuduysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['past', 'cond', 'past'] or   # (?)okuduysaydı
          tame_tags == ['past', 'past', 'cond']):    # (?)okuduyduysa
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['past', 'cond', 'evid'] or   # (?)okuduysaymış
          tame_tags == ['past', 'evid', 'cond']):    # (?)okuduymuşsa
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Impf')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif tame_tags == ['past', 'past', 'past']:     # (?)okuduyduydu
        ud_tags.append('Tense=Ppq')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')  # ?
    elif tame_tags == ['past', 'past', 'evid']:     # (?)okuduyduymuş
        ud_tags.append('Tense=Ppq')
        ud_tags.append('Aspect=Perf')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    # 'prog' ...
    elif (tame_tags == ['prog.yor'] or   # okuyor
          tame_tags == ['prog.mekte']):  # okumakta
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Prog')   # TODO: ambiguous with Hab
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['prog.yor', 'evid'] or   # okuyormuş
          tame_tags == ['prog.mekte', 'evid']):  # okumaktaymış
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['prog.yor', 'past'] or   # okuyordu
          tame_tags == ['prog.mekte', 'past']):  # okumaktaydı
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['prog.yor', 'cond'] or   # okuyorsa
          tame_tags == ['prog.mekte', 'cond']):  # okumaktaysa
        ud_tags.append('Tense=Pres')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['prog.yor', 'cond', 'past'] or   # okuyorsaydı
          tame_tags == ['prog.mekte', 'cond', 'past'] or # (?)okumaktaysaydı
          tame_tags == ['prog.yor', 'past', 'cond'] or   # okuyorduysa
          tame_tags == ['prog.mekte', 'past', 'cond']):  # okumaktaydıysa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Fh')
    elif (tame_tags == ['prog.yor', 'cond', 'evid'] or   # okuyorsaymış
          tame_tags == ['prog.mekte', 'cond', 'evid'] or # okumaktaysaymış
          tame_tags == ['prog.yor', 'evid', 'cond'] or   # okuyormuşsa
          tame_tags == ['prog.mekte', 'evid', 'cond']):  # okumaktaymışsa
        ud_tags.append('Tense=Past')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Cnd')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['prog.yor', 'evid', 'evid'] or   # okuyormuşmuş
          tame_tags == ['prog.mekte', 'evid', 'evid'] or # okumaktaymışmış
          tame_tags == ['prog.yor', 'past', 'evid'] or   # ?okuyorduymuş
          tame_tags == ['prog.mekte', 'past', 'evid'] or # ?okumaktaydıymış
          tame_tags == ['prog.yor', 'evid', 'past'] or   # okuyormuştu
          tame_tags == ['prog.mekte', 'evid', 'past']):  # okumaktaymıştı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Nfh')
    elif (tame_tags == ['prog.yor', 'past', 'past'] or   # okuyorduydu
          tame_tags == ['prog.mekte', 'past', 'past']):  # okumaktaydıydı
        ud_tags.append('Tense=Pqp')
        ud_tags.append('Aspect=Prog')
        ud_tags.append('Mood=Ind')
        ud_tags.append('Evident=Fh')
    elif not tame_tags: # empty list is OK 
        pass
    else:
        warning("Unknown TAME combination: {}".format(tame_tags))

    return surface, lemma, pos, ud_tags

if __name__ == "__main__":
    import pprint
    pp = pprint.PrettyPrinter(indent=4)
    trmorph = Trmorph()
    for line in sys.stdin:
        if not line:
            continue
        if '\t' in line:
            _, a = line.strip().split('\t')
        else:
            a = line.strip()
        igs = trmorph.to_igs(a)
        pp.pprint(igs)
        for ig in igs:
            pp.pprint(trmorph.to_ud(ig))
