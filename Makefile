MAKEDEP=./makedepend.sh
DEPDIR=.dep
SUBDIRS=lexicon
LEXCSRC=$(shell ls *.lexc)
XFSTSRC=$(shell ls *.xfst)
TARGETS=$(LEXCSRC:%.lexc=%.a) $(XFSTSRC:%.xfst=%.a)
FOMA=./foma-compile.sh

%.a: %.lexc
	$(FOMA) $<

%.a: %.xfst
	$(FOMA) $<

.PHONY: subdirs depend

all: analyzer analyzer-boundary

depend:
	mkdir -p $(DEPDIR)
	@for f in $(XFSTSRC) $(LEXCSRC); do \
		$(MAKEDEP) $$f $(DEPDIR)/$$f.P ; done

subdirs:
	+for dir in $(SUBDIRS); do $(MAKE) -C $$dir;  done

analyzer: subdirs trmorph.a
	make depend

analyzer-boundary: subdirs trmorph-boundary.a

clean:
	rm -fr $(TARGETS)

-include $(LEXCSRC:%.lexc=$(DEPDIR)/%.lexc.P) \
		 $(XFSTSRC:%.xfst=$(DEPDIR)/%.xfst.P)

