MAKEDEP=./makedepend.sh
DEPDIR=.dep
SUBDIRS=lexicon
LEXCSRC=$(shell ls *.lexc)
XFSTSRC=$(shell ls *.xfst)
TARGETS=$(LEXCSRC:%.lexc=%.a) $(XFSTSRC:%.xfst=%.a)
#FOMA=./hfst-compile.sh
FOMA=./foma-compile.sh

%.a: %.lexc
	$(FOMA) $<

%.a: %.xfst
	$(FOMA) $<

.PHONY: subdirs depend

.SECONDARY:

all: analyzer

depend:
	mkdir -p $(DEPDIR)
	@for f in $(XFSTSRC) $(LEXCSRC); do \
		$(MAKEDEP) $$f $(DEPDIR)/$$f.P ; done

subdirs:
	+for dir in $(SUBDIRS); do $(MAKE) -C $$dir;  done

analyzer: subdirs trmorph.a
	make depend

clean:
	rm -fr $(TARGETS)

hfst: analyzer.hfst generator.hfst analyzer-b.hfst generator-b.hfst

trmorph-boundary.a: trmorph.a
	-ls $@

analyzer.hfst: trmorph.a 
	gzip -cd < $< | hfst-invert --input=- --output=- | hfst-fst2fst --input=- --output=$@ -O

generator.hfst: trmorph.a 
	gzip -cd < $< | hfst-fst2fst --input=- --output=$@ -O

analyzer-b.hfst: trmorph-boundary.a 
	gzip -cd < $< | hfst-invert --input=- --output=- | hfst-fst2fst --input=- --output=$@ -O

generator-b.hfst: trmorph-boundary.a 
	gzip -cd < $< | hfst-fst2fst --input=- --output=$@ -O

-include $(LEXCSRC:%.lexc=$(DEPDIR)/%.lexc.P) \
		 $(XFSTSRC:%.xfst=$(DEPDIR)/%.xfst.P)

