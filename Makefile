LEXFILES = lexicon/adjectives lexicon/adverbs lexicon/conjunctions\
			lexicon/interjections lexicon/nouns lexicon/postpositions\
			lexicon/proper_nouns lexicon/verbs lexicon/misc
FSTFILES = trmorph.fst ninfl.fst vinfl.fst num.fst symbols.fst
SOURCES = $(LEXFILES) $(FSTFILES)
DISTNAME=trmorph-`cat VERSION`


.PHONY: all

%.a: %.fst
	fst-compiler-utf8 $< $@

%.ca: %.a
	fst-compact $< $@

all: trmorph.a

phon/phon.a: 
	(cd phon && make)

trmorph.a: trmorph.fst symbols.fst vinfl.fst ninfl.fst phon/phon.a deriv.a
deriv.a: num.a symbols.fst $(LEXFILES)


archive:
	./archive.sh $(DISTNAME)

testset: ../data/data
	awk '{print $$2}' ../data/data |sort |uniq > tests.all

clean:
	-rm *.a *~ Makefile.bak tests.all 2>&- > /dev/null

#Makefile: *.fst
#	-makedepend -Y -o.a $(SOURCES) 2>/dev/null 

test:
	fst-mor trmorph.a  < testset.1 |tee /tmp/trfst-testset1.out|less; \
		(echo -n `date`" "; grep 'no result' </tmp/trfst-testset1.out|wc -l) >> .testset1-results

# DO NOT DELETE

trmorph.a: symbols.fst vinfl.fst ninfl.fst
ninfl.a: symbols.fst
num.a: symbols.fst
deriv.a: symbols.fst ninfl.fst
