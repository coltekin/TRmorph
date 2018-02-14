#!/usr/bin/env python3
""" A simple FSA-based tokenizer and sentence spliter.
    
    This tokenizer makes use of TRmorph to tokenize Turkish.
    But it is easy to adapt it to another finite-state morphological
    analyzer or electronic lexicon.
    
    The main idea is as follows:

    - Read a simple initial token, analyze it using TRmorph.
      The initial token is typically a token separated by spaces.
    - If the token can be analyzed, we assume that it is a valid token
      (this allows known words with punctuation characters, e.g., in
      abbreviations, words with apostrophe ...). There is a possiblity
      of false positives here.
    - If the token cannot be analyzed
        - if it contains only alphanumeric symbols it is assumed to be
          a token (an unknown/foreign word)
        - if it contains symbols or punctuation, we split the token
          after the last punctuation symbol.
            - if first part is a valid token, we admit both tokens
            - if the first part is not a valid token, we admit the
              last part as a token, split the final symbol as a new
              token, and repeat the same process for the remaining
              (initial) part.
    - After every token (in sequence) we determine whether it is a
      sentence initial token based on the following heuristics:
        - If preceding token is a sentence-final punctuation mark, we
          admit a sentence boundary unless current word starts with an
          unlikely stentence starter, such as
            - a (closing) quotation mark
            - another sentence-final punctuation mark, or a comma
        - If the preceding token ends with a dot (it is an
          abbreviation) and the current token is a capitalized word
          which is not another abbreviation or a proper noun, we 
          admit a sentence boundary
        - Otherwise the token boundary is not a sentence boundary
"""

import sys,re
email_re = re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[a-zA-Z]{2,10}')

# consecutive occurrences of these tokens are collapsed
collapse = {'*', '.', '?', '!', "'", "`"}

# these are potential sentence final tokens
sent_final = {'.', '!', '?', '...', '..'}

punct_chr = r'([][,;:!?&/\'‘’""“”«»()‹›„‟‚‛>=<`….%+±*_—–-])'
non_punct_str = r'([^][,;:!?&/\'‘’""“”«»()‹›„‟‚‛>=<`….%±+*_—–-]+)'
punct_re_start = re.compile(punct_chr + r'(.*?)$')
punct_re_end = re.compile(r'(.*?)' + punct_chr + r'$')
punct_re_both = re.compile(punct_chr + r'(.*?)' + punct_chr + '$')
punct_re_mid = re.compile(non_punct_str + punct_chr + r'(.*?)$')

str_sym = r'[#$%&*+£©€₺/\\^-]'
str_leftb = r'«|‹|<|\[|“|‛|"|\'|\'\'|"|\(|\{|„|‚|‘|`|``|„'
str_rightb =  r'»|›|>|\]|”|’|"|\'|\'\'|"|\)|\}|‟|’'
str_punct = r'\.\.\.|\.\.|\.|!|;|,|‚|—|–|-|:|\?|…'
re_all_punct_sym = re.compile(r"(" + str_sym + r"|" + \
                                     str_rightb + r"|" + \
                                     str_leftb + r"|" + \
                                     str_punct + r")+$")
re_brackets = re.compile(r"(?P<l>" + str_leftb + ")" + \
                         r"(?P<m>.*)" + \
                         r"(?P<r>" + str_rightb + ")$")

re_trailing_punct = re.compile(r"(?P<l>.*?)" + \
                               r"(?P<r>" + str_rightb + "|" \
                                         + str_punct  + "|" \
                                         + str_sym  + ")$")
re_preceding_punct = re.compile(r"(?P<l>" + str_leftb + "|" \
                                          + str_sym  + ")" + \
                                r"(?P<r>.*)$")
re_mid_punct = re.compile(r"(?P<l>.*?)" + \
                         r"(?P<m>" + str_punct + "|" \
                                   + str_sym + ")" + \
                         r"(?P<r>.*)")

re_mid_punct2 = re.compile(r"(?P<l>.*?)" + \
                           r"(?P<m>[(=<>%+*×/-])" + \
                           r"(?P<r>.*)")
re_no_sent_start = re.compile(r"(" + str_rightb + r"|,|\.|;).*")


def initial_tokens(s):
    for tok in s.strip().split():
        yield tok

def is_abbreviation(tok):
    if tok[0] is None or len(tok[0]) == 0:
        return False
    if tok[0][-1] not in sent_final or \
            (tok[1] is None or len(tok[1]) == 0):
        return False
    for t in tok[1]:
        if '⟨abbr⟩' in t:
            return True
    return False

def is_proper_noun(tok):
    if tok[1] is None or len(tok[1]) == 0:
        # assume unanalyzed capitalized tokens are proper names
        if tok[0][0].isupper(): 
            return True
        else:
            return Fasle
    for t in tok[1]:
        if '⟨prop⟩' in t:
            return True
    return False

def is_url_or_email(tok):
    if re.match(email_re, tok):
        return True
#    if urlparse(tok):
    if tok.startswith("http://") or \
            tok.startswith("https://") or\
            tok.startswith("www."):
        return True
    return False



def strip_punct(tok):
    m = re.match(punct_re_both, tok)
    if m:
        return (m.group(1), m.group(2), m.group(3))
    m = re.match(punct_re_start, tok)
    if m:
        return (m.group(1), m.group(2), None)
    m = re.match(punct_re_end, tok)
    if m:
        return (None, m.group(1), m.group(2))
    m = re.match(punct_re_mid, tok)
    if m:
        return (m.group(1), m.group(2), m.group(3))
    return (None, None, None)

def strip_punc_r(tok, analyzer):
    a = analyzer(tok)
    if a:
        return([(tok, a)])
    if re.match(re_all_punct_sym, tok):
        return([(tok, [])])
    m = re.match(re_brackets, tok)
    if m:
        return(strip_punc_r(m.group("l"), analyzer) + \
               strip_punc_r(m.group("m"), analyzer) + \
               strip_punc_r(m.group("r"), analyzer))
    m = re.match(re_trailing_punct, tok)
    if m:
        return(strip_punc_r(m.group("l"), analyzer) + \
               strip_punc_r(m.group("r"), analyzer))
    m = re.match(re_preceding_punct, tok)
    if m:
        return(strip_punc_r(m.group("l"), analyzer) + 
               strip_punc_r(m.group("r"), analyzer))
    m = re.match(re_mid_punct, tok)
    if m:
        return(strip_punc_r(m.group("l") + m.group("m"), analyzer) + \
               strip_punc_r(m.group("r"), analyzer))
    m = re.match(re_mid_punct2, tok)
    if m:
        return(strip_punc_r(m.group("l"), analyzer) + \
               strip_punc_r(m.group("m"), analyzer) + \
               strip_punc_r(m.group("r"), analyzer))
    return([(tok, [])])


def tokenize(s, analyzer=None):
    sentences = []
    sent = []
    prevtoken = None
    for line in s.splitlines():
        linetokens = []
        for tok in initial_tokens(line):
            tokens = []
            if len(tok) > 100:
                tokens.append(tok)
                break
            a = analyzer(tok)
            match = False
            if a:
                tokens.append((tok, a))
                match = True
            elif is_url_or_email(tok):
                tokens.append((tok, []))
                match = True
            else:
                tmp = strip_punc_r(tok, analyzer)
                tokens.extend(tmp)
                match = True

                if not match:
                    tokens.append((tok, analyzer(tok)))

                tokens_collapsed = []
                ctoken = ''
                for (i, t) in enumerate(tokens):
                    if t[0] in collapse:
                        ctoken = ctoken + t[0]
                    else:
                        if len(ctoken):
                            tokens_collapsed.append((ctoken,
                                analyzer(ctoken)))
                            ctoken = ''
                        tokens_collapsed.append(t)
                if len(ctoken):
                    tokens_collapsed.append((ctoken,
                        analyzer(ctoken)))
                tokens = tokens_collapsed

            linetokens.extend(tokens)

        for t in linetokens:
            sent_start = False
            print("...", t[0], end="...")
            if prevtoken is None:
                sent_start = True
                print('bip')
            elif prevtoken[0] in sent_final:
                if not re.match(re_no_sent_start, t[0]):
                    sent_start = True
                    print('bop')
            elif is_abbreviation(prevtoken) and \
                    not is_abbreviation(t) and \
                    t[0][0].isupper() and not is_proper_noun(t):
                sent_start = True
                print('zop')
            else:
                print('top')

            if sent_start:
                if sent: sentences.append(sent)
                sent = []
                sent.append(t[0])
            else:
                sent.append(t[0])
            prevtoken = t
    sentences.append(sent)
    print(sentences)


if __name__ == "__main__":
    from trmorph import Trmorph

    trm = Trmorph()

    s = """Bu bir test. İkinci cumle burada.
        Bu cumle yeni bir satirda başlıyor,
        ama aynı satırda bitmiyor.
        Bu da bir onceki gibi, ama satır sonunda
        virgül yok. Bakalım ne olacak.
        Bu cümlede bir iki rakam olsun: 1 1.3 1,5.
        Birkaç bilinmeyen sözcük: aaaaa bidi Asdkfj.
        Bir de tırnaklayalım: "tırnaklı bu.".
        Bazı insanlar noktalam işaretlerini nereye koyacaklarını
        bilmiyorlar . Bazıları hiç bilmiyor ,daha kötü yani.Daha da
        kötüsü var...
    """
    tokenize(s, analyzer=trm.analyze)
