SFTSLEX=$(shell ls *.sfstlex)
LEXCLEX=$(SFTSLEX:.sfstlex=.lexc)

%.lexc: %.sfstlex
	./sfstlex2lexc.sh $^ > $@
#$(LEXCLEX)
all: $(LEXCLEX)
