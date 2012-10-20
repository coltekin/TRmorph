DISTNAME=trmorph-`cat VERSION`
FSTC ?= sfst
ifeq ($(FSTC),hfst)
%.a: %.fst
	hfst-calculate -w -v -i $< -o $@
else
%.a: %.fst
	fst-compiler-utf8 $< $@
endif
