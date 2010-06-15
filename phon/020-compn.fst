%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $CompN$: add -(s)I if compound noun does not have any suffixes,
% otherwise delete <compn>
%
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
           <compn>:<>

$C$ = {<compn>}:{<bS><I>}
$CompN$ = $C$ ^-> ( __ <Noun><RB><EoW> )


ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus>\
           <EoW>:<>

$DelEoW$ = .*

$CompN$ || $DelEoW$
