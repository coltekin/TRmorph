%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Delete analysis only symbols, EXCEPT the boundary markers, 
%   from the surface string
%

#include "../symbols.fst"


ALPHABET = [#Ssym##BM#] [#pos##subcat##infl_feat#]:<> 

.*
