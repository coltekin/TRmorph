LATEX=xelatex -shell-escape #-interaction=batchmode
MAIN=trmorph-manual
SOURCES=$(MAIN).tex 
FIGURES=
BIBSRC=/data/lib/cc.bib
INDEXES=$(MAIN)

all: $(MAIN).pdf

$(MAIN).pdf: $(SOURCES) $(FIGURES) $(MAIN).bib
	$(LATEX) $(MAIN)
	biber $(MAIN)
	for i in $(INDEXES);do  test -f $${i}.idx && makeindex $$i; done
	test -f $(MAIN).makefile && (sed -i 's/\^\^I/\t/g' $(MAIN).makefile ; make -j 2 -f $(MAIN).makefile)
	$(LATEX) $(MAIN)
	$(LATEX) $(MAIN)

$(MAIN).aux:
	$(LATEX) $(MAIN)

$(MAIN).bib: $(BIBSRC) $(MAIN).aux
	test -r $(BIBSRC) && \
		(bibtool -q -i $(BIBSRC) \
   		$$(grep '@cite{' $(MAIN).aux |sed 's/.*@cite{/ -X /;s/}.*//'|sort|uniq) \
       	> $(MAIN).bib) || echo "No $(BIBSRC)."

$(BIBSRC):
	echo "We do not have $(BIBSRC) but this should be OK."

view:
	okular $(MAIN).pdf >/dev/null 2>&1 &

clean:
	rm -f *~ $(MAIN).aux $(MAIN).bbl $(MAIN).blg $(MAIN).log\
		$(MAIN).pdf $(MAIN).snm $(MAIN).toc $(MAIN).nav $(MAIN).out \
	 	$(MAIN).bcf missfont.log $(MAIN).run.xml   \
	 	$(MAIN).idx $(MAIN).ind $(MAIN).ilg

