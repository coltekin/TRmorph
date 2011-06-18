
all: test

test: tests.expect
	expect tests.expect

tests.expect: 00_deye 01_obs 02_i 03_ben 04_su 05_camii 06_bufdel \
			  07_vepenth 08_dup 09_devoic 10_voicassim 11_passiveln \
			  12_yor 13_vh 14_orda_burda 15_punct \
			  20_nominals \
			  99_misc
	./make-expect.sh > tests.expect
