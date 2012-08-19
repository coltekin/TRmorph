% phon.fst
%
% This file combines the default collection of the morpho-phonological
% rules using composition, and deletes the symbols not needed on the
% surface strings.
%

#include "../symbols.fst"

$PHON$ = "<010-exception_deye-i.a>" \
        || "<012-exception_deye-passive.a>" \
        || "<015-exception_obs.a>" \
        || "<017-exception_i.a>" \
        || "<020-compn.a>" \
        || "<040-exception_ben.a>" \
        || "<050-exception_su.a>" \
        || "<055-del_BoW.a>" \
        || "<060-xception_del_bS.a>" \
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
