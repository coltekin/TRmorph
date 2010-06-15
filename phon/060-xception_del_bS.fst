%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Del_BS$: 
%
% this one is for a few lexically marked exceptional cases like camii
% as this seems to be rather an option (as of 2009-10-21 google finds
% more `camisi' than `camii') this deletion is optional
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del>\
           [#V_Buff#] <bY> <bS> <bSS> <bN>\
           <bS>:<> <dels>:<>

(<dels>:<> [#pos##BM##infl_feat#]*) <bS> => <>
