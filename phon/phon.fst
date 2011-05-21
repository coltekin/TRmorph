#include "../symbols.fst"

% This leaves boundary markers untouched, useful for obtaining
% surface segmentations.
% ALPHABET = [#C##V##Digit##Ssym#] [#pos##subcat##infl_feat#]:<> <RB><MB>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Delete analysis only symbols from the surface string
%

ALPHABET = [#Ssym#] [#BM##pos##subcat##infl_feat#]:<> 
$delete-pos$ = .*


$PHON$ =  "<010-exception_deye.a>" \
        || "<015-exception_obs.a>" \
        || "<017-exception_i.a>" \
        || "<020-compn.a>" \
        || "<040-exception_ben.a>" \
        || "<050-exception_su.a>" \
        || "<060-xception_del_bS.a>" \
        || "<070-exception_del_buff.a>" \
        || "<080-vowel_epenth.a>" \
        || "<090-duplication.a>" \
        || "<100-fs_devoicing.a>" \
        || "<110-v_assimilation.a>" \
        || "<120-passive_ln.a>" \
        || "<130-exception_yor.a>" \
        || "<140-v_harmony.a>" \
        || $delete-pos$

$PHON$
