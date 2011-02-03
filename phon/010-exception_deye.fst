%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xception_deye$: verbs `de' and  `ye' became `di' and `yi' if they
%                  followed by a 'y'
% 
% second part handles the optional 'n' before passive morpheme
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW> e:i

$diyi$ = (<BoW> [dy]) e <=> i ([#infl_feat#]* [<v><RB><MB><>]* [<RB><MB>] [y<bY>])

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW> <>:n

% as well as de and ye, a few other verbs get an extra optional `n'
% after root if followed by passive.
%
$denyen$ = (<BoW> (de|ye|yaşa|kapa|boya) [#infl_feat#]* <v><RB>) <> => n (<bI><LN>)

$diyi$ || $denyen$
