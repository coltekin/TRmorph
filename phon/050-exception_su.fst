%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xcptn_su$: Handling of exception words ending with `su'
% buffer `n' and `s' are realized as `y' after words ending with `su'.
%     suyu (his/her water) not susu or su-yu (water-acc) not su-nu
%
% we also handle insertion of `y' as in su-yum
%
%
% affects analysis symbol <bN>, has to be before $Del$.
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> \
           <bN>:y <bS>:y 

$b-y$ = (s u [#pos##subcat##BM##infl_feat#]*) [<bN><bS>] <=> y

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> \
           <>:y
$insy$ = (s u [#pos##subcat##BM##infl_feat#]*) <> <=> y (<bI>)

$b-y$ || $insy$
