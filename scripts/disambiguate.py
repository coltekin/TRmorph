#!/usr/bin/python3
""" This script analyzes and disambiguates the tokens from its
    standard input. 

    Note that the disambiguation method used here does not depend 
    on the context. Each word/analysis is evaluated on its own.

    To use this script you need a 'model file'. One can be obtained 
    at www.let.rug.nl/~coltekin/trmorph/1M.m2.

    More information on disambiguation, how to train and use other
    (including context aware) models will follow (hopefully) soon.
"""

import json,os,sys,fcntl,re,getopt,io
from subprocess import Popen,PIPE
from math import log

input_stream = io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8')
output_stream = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def score_m2(model, astring):
    """ We try to estimate the joint probability of the 
        root (r) and the analysis (a). We factor the joint 
        probability as, p(r, a) = p(r|a) p(a).
        the input model contains counts of r|a, and a. 
        For unobserved quantities, we use add-one smoothing.

                          tokenC(r|a) + 1
                p(r|a) = ---------------------
                          tokenC(x|a) + typeC(x|a)

       for all roots x with analysis a. If both r and a are unknown,
       we estimate the probability from the number of times a new root
       was assigned to any analysis in the training data.

                           tokenC(a)
                p(a) = ------------------------------
                         tokenC(words) + typeC(words)
    """

    global a_re
    try:
        m = re.match(a_re, astring)
        r = m.group(1)
        a = m.group(2)
    except:
        print("no match astring: _{}_".format(astring))
        sys.exit(-1)
    ntokens = model["##tokens"]
    ntypes = len(model)

    if a in model:
        rdict = model[a]
        tokC_a = rdict['##tokens']
        typC_a = len(rdict)

        if r in rdict:
            tokC_ra = rdict[r]
        else:
            tokC_ra = 0
        p_a = (tokC_a + 1) / (ntokens + ntypes)
        p_ra = (tokC_ra + 1 ) / (tokC_a + typC_a)
        score = log(p_a) + log(p_ra)
    else:
        p_a = -log(ntokens + ntypes) #log(1 / (ntokens + ntypes))
        p_ra = log(model['##ratypes'] / ntokens)
        score = p_a + p_ra

    return score


def score_astrings(model, alist, word=None):
    slist = []
    for a in alist:
        score = score_m2(model[1], a)
        head, tail = [] , []
        for i in range(0, len(slist)):
            (sc, tmp) = slist[i]
            if sc < score:
                tail = slist[i:]
                break 
            else:
                head.append((sc,tmp))
        slist = head + [(score, a)] + tail
    return slist


def flookup_open(cmd=None):
    if cmd is None:
        cmd=flookup_cmd
    try:
        p = Popen(cmd, shell=True, bufsize=1,
                  stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=False)
    except:
        print("Cannot start flookup with `trmorph.fst'", file=sys.stderr)
        sys.exit(-1)
    return p

def flookup_close(handle):
    handle.stdin.close()
    handle.stdout.close()
    handle.stderr.close()

def get_analyses(handle, word):
    alist = []
    handle.stdin.write(bytes(word + "\n", 'utf-8'))
    handle.stdin.flush()
    for astring in handle.stdout:
        a = astring.decode('utf-8').strip()
        if a:
            if a == '+?': continue 
            alist.append(a)
        else:
            break
    return alist

def usage():
    print("""Usage {} [options]
        This script takes tokens from the standard input, 
        analyzes each token with TRmorph (using flookup),
        scores them and prints the result to standard output

        Options:
        -h, --help          Print this help text, and exit.
        -1, --best-parse    Only print the best analysis.
        -s, --no-score      Do not print the scores, only print the ordered
                            list of analyses.
        -w, --no-word       Do not print the surface word. Useful if
                            you only analyze a single word. Can be
                            confusing if multiple words are analyzed.
        -f, --flookup-cmd   Command to run for obtaining alternative
                            analses. default="flookup -b -x ./trmorph.fst"
        -m, --model-file    The file with the trained model. default='1M.m2'
        """.format(sys.argv[0]))

#-- main --


opts, args = getopt.getopt(sys.argv[1:],"h1nsf:m:",["help","best-parse","no-word", "no-score",'flookup-cmd', 'model-file'])

onlybest = False
model_file = '1M.m2'
print_score = True
print_word = True
flookup_cmd="flookup -b -x ./trmorph.fst"
for opt, arg in opts:
    if opt in ("-1", "--best-parse"):
        onlybest = True
    elif opt in ("-s", "--no-score"):
        print_score = False
    elif opt in ("-n", "--no-word"):
        print_word = False
    elif opt in ("-f", "--flookup-cmd"):
        flookup_cmd=arg
    elif opt in ("-m", "--model-file"):
        model_file=arg
    else:
        usage()
        sys.exit(-1)

a_re = re.compile(r'([^<]+)(<.*)')

try:
    mfile = open(model_file, 'r', encoding='utf-8')
except:
    print("Cannot open the model file.")
    print("Run `{} --help' for help.".format(sys.argv[0]))
    sys.exit(-1)
model = json.load(mfile, encoding='utf-8')
mfile.close()

trmorph = flookup_open(flookup_cmd)

for line in input_stream:
    w = line.strip()
    alist = get_analyses(trmorph, w)

    if len(alist) == 0:
        slist = [(-1, '???')]
    else:
        slist = score_astrings(model, alist)

    last = len(slist)
    if onlybest:
        last = 1
    for i in range(0, last):
        (sc, a) = slist[i]
        if print_word:
            ww = w + " "
        else:
            ww = ""
        if print_score:
            print('{:.2f}: {}{}'.format(sc, ww, a), file=output_stream)
        else:
            print('{}{}'.format(ww, a), file=output_stream)
    print(file=output_stream)
