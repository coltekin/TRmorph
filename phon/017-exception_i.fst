%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% the bound root(?) i- seems to omit the buffer y as in 
%   i-dir (not i-ydir)
% 
#include "../symbols.fst"


ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW>:<> <bY>:<>

(<BoW>:<> i [<Verb><RB><MB><>]*) <bY> <=> <> 
