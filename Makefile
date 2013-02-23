LEXICON ?= new
ROOTLEX=$(shell ls lexicon/*.lexc lexicon/$(LEXICON)/*.lexc)

#
# Options
#
# Some behavior of the analyzer can be controlled with the options
# below.

#  APOSTROPHE
#
#  Require apostrophe after proper names and numbers.
#
#  yes:   apostrophe is obligatory.
#  maybe: apostrophe is optional.
#
#  NOTE: currently,  TRmorph's apostrophe insertion does not 
#        follow  the official spelling rules.

APOSTROPHE=maybe

#  PARTWORDS
#
#  Compile in lexical units that are part-words, like 'argın' in
#  'yorgun argın', and mark as part of a word. Ideally these words
#  should be tokenized together, but in case it is not, this gives a
#  way for later porcessing to combine the pieces.
#
#  true: compile part words in.
#  any other value disables it.
#

PARTWORDS=true
#
# End of options
#

export APOSTROPHE
export PARTWORDS

all: trmorph.fst

segment: segment.fst

trmorph.lexc: morph.lexc $(ROOTLEX)
		./options.sh $^ > $@

trmorph.fst: trmorph.xfst trmorph.lexc morph-phon.xfst
	foma -f trmorph.xfst

trmorph.xfst: analyzer.xfst
	./options.sh $^ > $@

segment.fst: segment.xfst trmorph.lexc morph-phon.xfst
	foma -f segment.xfst

stemmer: stemmer.fst 

stemmer.fst: stemmer.xfst trmorph.fst
	foma -f stemmer.xfst

clean:
	rm -f trmorph.xfst trmorph.fst trmorph.lexc
