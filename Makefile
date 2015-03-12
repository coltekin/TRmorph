LEXICON ?= new
COMMONLEX=$(shell ls lexicon/*.lexc)
ROOTLEX=$(COMMONLEX) $(shell ls lexicon/$(LEXICON)/*.lexc)
CPP=gcc -E -traditional -P -w -x c
MAKEDEP=gcc -MD
MAKEDEP=./makedepend.sh
TARGETS=trmorph.fst segment.fst stem.fst guess.fst hyphenate.fst
LEXCSRC=analyzer.lexc guesser.lexc morph.lexc number.lexc exceptions.lexc
XFSTSRC=analyzer.xfst guesser.xfst hyphenate.xfst morph-phon.xfst segment.xfst stemmer.xfst g2p.xfst
DEPDIR=.dep

%.cpp.lexc: %.lexc $(DEPDIR)/%.lexc.P
	$(CPP) -o $@ $<

%.cpp.xfst: %.xfst $(DEPDIR)/%.xfst.P
	$(CPP) -o $@ $<

$(DEPDIR)/%.lexc.P: %.lexc
	mkdir -p $(DEPDIR)
	$(MAKEDEP) $< $@

$(DEPDIR)/%.xfst.P: %.xfst
	mkdir -p $(DEPDIR)
	$(MAKEDEP) $< $@


analyzer: trmorph.fst

all: analyzer segmenter stemmer guesser

trmorph.fst: analyzer.cpp.xfst analyzer.cpp.lexc morph-phon.cpp.xfst
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
guesser: guess.fst analyze_guess.fst

guess.fst: guesser.cpp.lexc guesser.cpp.xfst morph-phon.cpp.xfst
	foma -f guesser.cpp.xfst

analyze_guess.fst: analyze_guess.xfst guess.fst trmorph.fst
	foma -f analyze_guess.xfst

hyphenate: hyphenate.fst

hyphenate.fst: hyphenate.cpp.xfst
	foma -f hyphenate.cpp.xfst

#
# g2p - grapheme to phoneme conversion
#
g2p: g2p.fst 

g2p.fst: morph-phon.cpp.xfst g2p.cpp.xfst
	foma -f g2p.cpp.xfst


#
# housekeeping goes below
#
clean:
	rm -rf $(TARGETS) *.cpp.* .dep

-include $(LEXCSRC:%.lexc=$(DEPDIR)/%.lexc.P) $(XFSTSRC:%.xfst=$(DEPDIR)/%.xfst.P)
