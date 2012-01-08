%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xception_deye$: verbs `de' and  `ye' became `di' and `yi' if they
%                  followed by a 'y'
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW> e:i

$diyi$ = (<BoW> [dy]) e <=> i ([#infl_feat#]* [#BM#<v><>]* [#BM#] [y<bY>])

$diyi$
