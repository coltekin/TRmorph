%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $FSD$: Final stop devoicing
%
%  p ->  b : şarap -> şarabı 
%  ç ->  c : ağaç -> ağacı
%  k ->  ğ : bebek -> bebeği
% nk -> ng : renk -> rengi
%  t ->  d : tat  -> tadı
%
% affected analysis sym: <p><t><c><k><g>
% interacts with: $VA$ (has to be before)
%
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##infl_feat##BM#]\
           <A> <I> [#V_Pal#] \
           <C><D> \
           <LN> \
           <p>   <t>   <c>   <g>   <k>   \
           <p>:b <t>:d <c>:c <g>:ğ <k>:ğ <k>:g <K>:k <K>:y 
%
% realize root final <p>,<t> as b,d if flooowed by a vowel, p,t otherwise
%% k->ğ, nk -> ng
% realize root/morpheme final `k' as `ğ' if preceeded and followed by
% a vowel.
% `k' realized as `g' if preceeded by `n' and followed by a vowel
% (renk -> renge).
%
% k, marked as <K> after -mak is realized as `y' if followed by a % vowel

$FSD_cc$ =        <c> <=> c ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_gG$ =        <g> <=> ğ ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_KG$ =        <K> <=> y ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_kG$ = ([^n]) <k> <=> ğ ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_kg$ = (n)    <k> <=> g ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_pb$ =        <p> <=> b ([#pos##infl_feat##BM#]* [#V#<A><I>])
$FSD_td$ =        <t> <=> d ([#pos##infl_feat##BM#]* [#V#<A><I>])

$FSD$ = $FSD_cc$ & $FSD_gG$ & $FSD_kG$ & $FSD_KG$ & $FSD_kg$ &\
        $FSD_pb$ & $FSD_td$ 

% this is a trick to make reduplicated copies devoiced (or not)
ALPHABET = [#Ssym#] [#pos##infl_feat##BM#]\
           <A> <I> [#V_Pal#] \
           <C><D> \
           <LN> \
           <p>:p <t>:t <c>:ç <g>:g <k>:k \
           <p>:b <t>:d <c>:c <g>:ğ <k>:ğ <k>:g <K>:k <K>:y 

$FSDd_cc$ =        <c> <=> c (c [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_gG$ =        <g> <=> ğ (ğ [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_KG$ =        <K> <=> y (y [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_kG$ = ([^n]) <k> <=> ğ (ğ [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_kg$ = (n)    <k> <=> g (g [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_pb$ =        <p> <=> b (b [#pos##infl_feat##BM#]* [#V#<A><I>])
$FSDd_td$ =        <t> <=> d (d [#pos##infl_feat##BM#]* [#V#<A><I>])


$FSDd$ = $FSDd_cc$ & $FSDd_gG$ & $FSDd_KG$ & $FSDd_kG$ & $FSDd_kg$ & $FSDd_pb$ & $FSDd_td$ 


$FSD$ || $FSDd$
