WEBDIR ?= $(HOME)/public_html/trmorph
URL = ./index.php
DATE = $(shell date +%Y-%m-%d)
FSTINFL = $(shell which fst-infl)

all: index.php sym-table.html ../trmorph.a

index.php: index-template.php
	sed -e "s,__URL__,$(URL)," \
		-e "s,__DATE__,$(DATE)," \
		-e "s,__WEBDIR__,$(WEBDIR)," \
		index-template.php > index.php

sym-table.html: 
	(cd ../doc; ./syms-doc.sh html) > sym-table.html

../trmorph.a:
	$(MAKE) -C ..

install:
	mkdir -p $(WEBDIR)
	cp -a index.php sym-table.html ../trmorph.a ../README $(FSTINFL) $(WEBDIR)

clean:
	-rm -f index.php sym-table.html
