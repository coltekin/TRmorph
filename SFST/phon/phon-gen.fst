% phon-gen.fst
%
% This is the same as the phon.fst, except some rules with generation
% ambiguities are not included (or alternative unambiguous versions
% are included). This is used in trmorph-gen.fst, for
% building an automaton that generates a unique string for each
% analysis symbol. 
%
% Currently (2011-08-18) this file differs from phon.fst in 
%
%       - 012-exception_deye-passive.fst
%       - 050-exception_su-gen.a
%       - 060-xception_del_bS.fst
%

#include "../symbols.fst"


$PHON$ = "<010-exception_deye-i.a>" \
        || "<015-exception_obs.a>" \
        || "<017-exception_i.a>" \
        || "<020-compn.a>" \
        || "<040-exception_ben.a>" \
        || "<050-exception_su-gen.a>" \
        || "<055-del_BoW.a>" \
        || "<060-xception_del_bS-gen.a>" \
        || "<070-exception_del_buff.a>" \
        || "<080-vowel_epenth.a>" \
        || "<090-duplication.a>" \
        || "<100-fs_devoicing.a>" \
        || "<110-v_assimilation.a>" \
        || "<120-passive_ln.a>" \
        || "<130-exception_yor.a>" \
        || "<140-v_harmony.a>" \
        || "<del-analysis-syms.a>"

$PHON$
