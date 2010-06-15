%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $AI_yor$: the suffix -yor changes the vowel attached to preceeding
% morpheme (or causes it to drop, we model as change here). e.g. 
% ara -> arıyor, açıkla -> açıklıyor ...
% 
% TODO: this may make MAMI rule above unnecessary
%
% affected analysis sym: 'a', 'e', <A>, rewritten (possibly) as <I>
% interacts with: should be after $Del$ and before $VH$
% 
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##infl_feat#] [#BM#]\
           <A> <I> [#V_Pal#] \
           a:<I> e:<I> <A>:<I>

[ae<A>] <=> <I> ([#pos##infl_feat#]* [#BM#]+ yor)

