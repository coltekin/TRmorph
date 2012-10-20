LEXICON ?= new
ROOTLEX=$(shell ls lexicon/$(LEXICON)/*.lexc)

#
# Options
#
# Some behavior of the analyzer can be controlled with the options
# below.

#
#  Require apostrophe after proper names and numbers.
#
#  yes:   apostrophe is obligatory.
#  maybe: apostrophe is optional.
#
#  NOTE: currently,  TRmorph's apostrophe insertion does not 
#        follow  the official spelling rules.

APOSTROPHE=maybe

#
# End of options
#

all: trmorph.fst

segment: segment.fst

trmorph.lexc: morph.lexc $(ROOTLEX)
		cat $^ > $@

trmorph.fst: trmorph.xfst trmorph.lexc morph-phon.xfst
	foma -f trmorph.xfst

trmorph.xfst: analyzer.xfst
	cat $^ | sed 's/^!!!APOSTROPHE_$(APOSTROPHE)//;/^!!!APOSTROPHE/d' \
	> $@

segment.fst: segment.xfst trmorph.lexc morph-phon.xfst
	foma -f segment.xfst

clean:
	rm -f trmorph.xfst trmorph.fst trmorph.lexc
