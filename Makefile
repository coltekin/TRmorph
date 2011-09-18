LEXFILES = lexicon/adjectives lexicon/adverbs lexicon/cnjcoo\
	       lexicon/cnjadv lexicon/cnjsub\
			lexicon/interjections lexicon/nouns lexicon/postpositions\
			lexicon/proper_nouns lexicon/verbs lexicon/misc
FSTFILES = trmorph.fst ninfl.fst vinfl.fst num.fst symbols.fst particles.fst morph.fst afilter.fst
SOURCES = $(LEXFILES) $(FSTFILES)
SUBDIRS=phon

include Makefile.inc

.PHONY: all subdirs trmorph $(SUBDIRS)

all: subdirs trmorph

ifeq ($(FSTC),hfst)
trmorph: tr-mor.ol tr-gen.ol
else
trmorph: trmorph.a trmorph-gen.a trmorph-bm.a
endif

trmorph.a: trmorph.fst symbols.fst vinfl.fst ninfl.fst deriv.a phon/phon.a
deriv.a: num.a symbols.fst $(LEXFILES)  phon/phon.a

subdirs: 
	for dir in $(SUBDIRS); do  $(MAKE) -C $$dir;  done

archive:
	./archive.sh $(DISTNAME)

testset: ../data/data
	awk '{print $$2}' ../data/data |sort |uniq > tests.all

clean:
	-rm -f *.a *~ Makefile.bak tests.all version.fst
	-for dir in $(SUBDIRS); do  $(MAKE) -C $$dir clean; done

#Makefile: *.fst
#	-makedepend -Y -o.a $(SOURCES) 2>/dev/null 

test:
	fst-mor trmorph.a  < testset.1 |tee /tmp/trfst-testset1.out|less; \
		(echo -n `date`" "; grep 'no result' </tmp/trfst-testset1.out|wc -l) >> .testset1-results

# DO NOT DELETE

trmorph.a: symbols.fst vinfl.fst ninfl.fst particles.fst version.a morph.a afilter.a
trmorph-gen.a: trmorph.a
ninfl.a: symbols.fst
num.a: symbols.fst
deriv.a: symbols.fst ninfl.fst

tr-mor.ol: trmorph.a
	hfst-invert -i trmorph.a | hfst-fst2fst -O -o $@

tr-gen.ol: trmorph-gen.a
	hfst-fst2fst -O -i trmorph-gen.a -o $@

version.fst: $(SOURCES) phon/*.fst
	./version.sh > version.fst
