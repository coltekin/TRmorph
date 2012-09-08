LEXICON ?= new
ROOTLEX=$(shell ls lexicon/$(LEXICON)/*.lexc)

all: trmorph.fst

trmorph.lexc: morph.lexc $(ROOTLEX)
		cat $^ > $@

trmorph.fst: trmorph.xfst trmorph.lexc
	foma -f trmorph.xfst

clean:
	rm -f trmorph.fst trmorph.lexc
