%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $eph$: vowel epenthesis: burun -> burnu
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup>\
           <del>:<> [#V#]:<>

(<del>:<>) [#V#] <=> <> ([#C##C_xx#<LN>] [#pos##subcat##BM##infl_feat#]* [#V#<A><I>]) 
