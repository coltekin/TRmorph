WEBDIR=$(HOME)/public_html/trmorph/demo
URL=./index

all: index.php sym-table.html ../trmorph.a

index.php: index-template.php
	sed "s,__URL__,$(URL)," index-template.php > index.php

sym-table.html: 
	(cd ../doc; ./syms-doc.sh html) > sym-table.html

../trmorph.a:
	$(MAKE) -C ..

install:
	cp -a index.php sym-table.html ../trmorph.a $(WEBDIR)

clean:
	-rm -f index.php sym-table.html
