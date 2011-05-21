%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xcptn_ben$: Handling of exception two very particular exceptions 
%   if pronuns `ben' and `sen' gets dative case directly the root
%   changes
%   ben -> ban-a, sen -> san-a
%
% another exceptions with this words are with instrumental "case",
% where they require possessive suffixed 'im/in' before. for now, we
% ignore that, as 'benle' and 'senle' seems to be also common.
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
           <e>:a <e>:e

<e> <=> a (n [#pos##subcat#<>#BM##infl_feat#]* <bY><A> <MB>)
