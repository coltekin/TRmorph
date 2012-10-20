%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Del_BS$: 
%
% this is unambiguous version of 060-xception_del_bS.fst. It only
% deletes the lexical exception symbol <dels>
%

#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del>\
           [#V_Buff#] <bY> <bS> <bSS> <bN>\
           <dels>:<>

.*
