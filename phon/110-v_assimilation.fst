%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $VA$ Voicing assimilation rules
%
% seker-ci 
% sarap-çı
%
% affected analysis sym: <D> (and later <C>)
% interacts with: $FSD$ (needs to be after)
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##infl_feat#] [#BM#]\
           <A> <I> [#V_Pal#] \
           <LN> \
           <D>:d <D>:t <C>:c <C>:ç

$VA_Dt$ = (.:[#C_uv#] .:[#C##Apos##pos##subcat#<>#BM##infl_feat#]*) <D> <=> t
$VA_Cc$ = (.:[#C_uv#] .:[#C##Apos##pos##subcat#<>#BM##infl_feat#]*) <C> <=> ç

$VA_Dt$ & $VA_Cc$

