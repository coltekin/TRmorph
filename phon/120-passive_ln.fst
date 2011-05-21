%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $LN$: Handling of passive <I>n/<I>l difference
% after a surface `l' <LN> becomes `n', `l' otherwise
%
% affected analysis sym: <LN>
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##infl_feat#] [#BM#]\
           <A> <I> [#V_Pal#] \
           <LN>:n <LN>:l

([l#V#] [#pos##subcat##BM##infl_feat#]* [#V#<I><A>]*) <LN> <=> n
