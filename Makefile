LEXICON ?= new
COMMONLEX=$(shell ls lexicon/*.lexc)
ROOTLEX=$(COMMONLEX) $(shell ls lexicon/$(LEXICON)/*.lexc)
CPP=gcc -E -traditional -P -w -x c
TARGETS=trmorph.fst segment.fst stem.fst guess.fst hyphenate.fst

%.cpp.lexc: %.lexc
	$(CPP) -o $@ $^

%.cpp.xfst: %.xfst
	$(CPP) -o $@ $^

analyzer: trmorph.fst

all: analyzer segmenter stemmer guesser

trmorph.fst: analyzer.cpp.xfst morph.cpp.lexc morph-phon.cpp.xfst
	foma -f analyzer.cpp.xfst

#
# a simple segmenter
#
segmenter: segment.fst
segment.fst: segment.cpp.xfst morph.cpp.lexc morph-phon.cpp.xfst
	foma -f segment.cpp.xfst

#
# stemmer 
#
stemmer: stem.fst 

stem.fst: stemmer.cpp.xfst trmorph.fst
	foma -f stemmer.cpp.xfst

#
# unknown word guesser
#
guesser: guess.fst

guess.fst: guesser.cpp.lexc guesser.cpp.xfst morph-phon.cpp.xfst
	foma -f guesser.cpp.xfst

hyphenate: hyphenate.fst

hyphenate.fst: hyphenate.cpp.xfst
	foma -f hyphenate.cpp.xfst
#
# housekeeping goes below
#
clean:
	rm -f $(TARGETS) *.cpp.*
