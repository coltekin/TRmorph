TESTFILES=$(shell ls *.test)
EXPECTFILES=$(TESTFILES:.test=.expect)

all: test

%.expect: %.test
	./make-expect.sh $< > $@

test: tests.expect.all
	expect tests.expect.all 

tests.expect.all: $(EXPECTFILES)
	cat $^ > $@
