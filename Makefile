LEXICON ?= new
ROOTLEX=$(shell ls lexicon/$(LEXICON)/*.lexc)

all: trmorph.fst

segment: segment.fst

trmorph.lexc: morph.lexc $(ROOTLEX)
		cat $^ > $@

trmorph.fst: trmorph.xfst trmorph.lexc morph-phon.xfst
	foma -f trmorph.xfst


segment.fst: segment.xfst trmorph.lexc morph-phon.xfst
	foma -f segment.xfst

clean:
	rm -f trmorph.fst trmorph.lexc
