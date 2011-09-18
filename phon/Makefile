FSTFILES = 010-exception_deye-i.fst 012-exception_deye-passive.fst 020-compn.fst \
		   040-exception_ben.fst 050-exception_su.fst 050-exception_su-gen.fst \
		   060-xception_del_bS.fst 060-xception_del_bS-gen.fst\
		   070-exception_del_buff.fst 080-vowel_epenth.fst 090-duplication.fst\
		   100-fs_devoicing.fst 110-v_assimilation.fst 120-passive_ln.fst\
		   130-exception_yor.fst 140-v_harmony.fst 015-exception_obs.fst\
		   017-exception_i.fst del-analysis-syms.fst\
		   del-analysis-syms-bm.fst 055-del_BoW.fst
FSAFILES=$(FSTFILES:.fst=.a)
SOURCES = $(LEXFILES) $(FSTFILES)

include ../Makefile.inc

.PHONY: all

all: phon.a phon-gen.a phon-bm.a

phon.a: $(FSAFILES) phon.fst ../symbols.fst
phon-gen.a: $(FSAFILES) phon-gen.fst ../symbols.fst

clean:
	-rm -f *.a *~ Makefile.bak 

#Makefile: *.fst
#	-makedepend -Y -o.a $(SOURCES) 2>/dev/null 

# DO NOT DELETE

010-exception_deye.a: ../symbols.fst
015-exception_obs.a: ../symbols.fst
017-exception_i.a: ../symbols.fst
020-compn.a: ../symbols.fst
040-exception_ben.a: ../symbols.fst
050-exception_su.a: ../symbols.fst
060-xception_del_bS.a: ../symbols.fst
070-exception_del_buff.a: ../symbols.fst
080-vowel_epenth.a: ../symbols.fst
090-duplication.a: ../symbols.fst
100-fs_devoicing.a: ../symbols.fst
110-v_assimilation.a: ../symbols.fst
120-passive_ln.a: ../symbols.fst
130-exception_yor.a: ../symbols.fst
140-v_harmony.a: ../symbols.fst
phon.a: ../symbols.fst
