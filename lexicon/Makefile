LEXCSRC=$(shell ls *.lexc)

%.a: %.lexc
	foma -qre "read lexc $<"  -e 'save stack $@' -s

all: $(LEXCSRC:%.lexc=%.a)
