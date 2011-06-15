%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $CompN$: add -(s)I if compound noun does not have any suffixes,
% otherwise delete <compn>
%
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
           <compn>

$C$ = {<compn>[#V#]}:{}
$CompN$ = $C$ ^-> ( __ [<n><np>]<RB>[^<EoW>] )


ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus>\
           <EoW>:<> <compn>:<>

$DelEoW$ = .*

$CompN$ || $DelEoW$
