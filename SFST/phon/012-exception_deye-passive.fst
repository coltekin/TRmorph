%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $exception_deye$: 
% 
% this file handles the optional 'n' before passive morpheme after
% some stems
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
           <BoW> <>:n

% as well as de and ye, a few other verbs get an extra optional `n'
% after root if followed by passive.
%
$denyen$ = (<BoW> (de|ye|yaşa|kapa|boya) [#infl_feat#]* <v><RB>) <> => n (<bI><LN>)

$denyen$
