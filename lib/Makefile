MAKEDEP=./makedepend.sh
XFSTSRC=$(shell ls *.xfst)
DEPDIR=.dep
TARGETS=$(XFSTSRC:.xfst=.fst)

.PRECIOUS: $(DEPDIR)/%.xfst.P
.PHONY: all clean

DEPFIlES=$(DEPDIR)/$(XFSTSRC:.xfst=.xfst.P)

%.fst: %.xfst $(DEPDIR)/%.xfst.P
	foma -q -e "source $<" -e "save stack $(@:.xfst=.fst)" -e "exit" |grep 'error:' && exit 1 || exit 0


$(DEPDIR)/%.xfst.P: %.xfst
	mkdir -p $(DEPDIR)
	$(MAKEDEP) $< $@

all: $(TARGETS)
	make depend

clean:
	rm -fr $(TARGETS)

depend: $(DEPFILES)

-include $(XFSTSRC:%.xfst=$(DEPDIR)/%.xfst.P)

