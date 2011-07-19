DISTNAME=trmorph-`cat VERSION`
FSTC ?= hfst
ifeq ($(FSTC),sfst)
%.a: %.fst
	fst-compiler-utf8 $< $@
else
%.a: %.fst
	hfst-calculate -w -v -i $< -o $@
endif
