LEXICON ?= new
COMMONLEX=$(shell ls lexicon/*.lexc)
ROOTLEX=$(COMMONLEX) $(shell ls lexicon/$(LEXICON)/*.lexc)
CPP=gcc -E -traditional -P -w -x c

%.cpp.lexc: %.lexc
	$(CPP) -o $@ $^

%.cpp.xfst: %.xfst
	$(CPP) -o $@ $^

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

analyzer: trmorph.fst

all: trmorph.fst segment.fst stemmer.fst guesser.fst

trmorph.fst: trmorph.xfst trmorph.lexc morph-phon.xfst
	foma -f trmorph.xfst

trmorph.lexc: morph.lexc $(ROOTLEX)
		./options.sh $^ > $@

trmorph.xfst: analyzer.xfst
	./options.sh $^ > $@

#
# a simple segmenter
#
segment.fst: segment.xfst trmorph.lexc morph-phon.xfst
	foma -f segment.xfst

#
# stemmer 
#

stemmer: stemmer.fst 

stemmer.fst: stemmer.xfst trmorph.fst
	foma -f stemmer.xfst

#
# unknown word guesser
#
guesser.fst: guesser.cpp.lexc guesser.cpp.xfst morph-phon.cpp.xfst
	foma -f guesser.cpp.xfst

#
# housekeeping goes below
#
clean:
	rm -f trmorph.xfst trmorph.fst trmorph.lexc
