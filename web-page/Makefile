WEBDIR=$(HOME)/public_html/trmorph
URL=./index
DATE=$(shell date +%Y-%m-%d)

all: index.php sym-table.html ../trmorph.a

index.php: index-template.php
	sed -e "s,__URL__,$(URL)," \
		-e "s,__DATE__,$(DATE)," \
		index-template.php > index.php

sym-table.html: 
	(cd ../doc; ./syms-doc.sh html) > sym-table.html

../trmorph.a:
	$(MAKE) -C ..

install:
	cp -a index.php sym-table.html ../trmorph.a ../README $(WEBDIR)

clean:
	-rm -f index.php sym-table.html
