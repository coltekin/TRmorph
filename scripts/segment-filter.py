#!/usr/bin/python2.7
# vim: set fileencoding=utf-8 :

import sys,os,codecs,random,time
import codecs, sys
sys.stdout = codecs.getwriter('utf8')(sys.stdout)
sys.stdin = codecs.getreader('utf8')(sys.stdin)


for line in sys.stdin:
    if len(line) == 1: 
        continue
#    print "attmpting:", "[", len(line), "]", line
    t = line.rstrip().split("\t");
    if len(t) != 2:
        continue
    word, seg = t
    tmp = seg.replace("-", "")
    if tmp.lower() == word.lower():
        print word,'\t',seg

