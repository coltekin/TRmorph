%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Del$: Buffer vowel/consonant deletion rules
% 
% affected analysis symbols: <bY> <bS> <bSS> <bN> <bI>, (<I> may be produced)
% interacts with: $xception_su$ (has to be after), $VH$ (has to be before)
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del>\
           <bY>:y <bY>:<> <bS>:s <bSS>:ş <bN>:n  <bS>:<> <bSS>:<> <bN>:<> \
           <bI>:<I> <bI>:<> <bA>:<A> <bA>:<>


$Del_BC$ = ([#C##C_xx#<LN>] [#pos##Apos##BM##infl_feat#]*) [#C_Buff#] <=> <>
$Del_BV$ =  ([#V#<I><A>] [#pos##Apos##BM##infl_feat#]*) [#V_Buff#] <=> <>

$Del_BC$ & $Del_BV$
