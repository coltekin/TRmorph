%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $Dup$: Duplication of some root final consonants (gemination)
%         hak -> hakkı
#include "../symbols.fst"

% First correct but slow version:
%
ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup>


#=D# = #C#<C><D><K><c><p><t><k><g><LN>
$D$ = {[#=D#]}:{[#=D#][#=D#]}

$Dup$ = $D$ ^-> (<dup> __ [#pos##BM##infl_feat#]* [#V#<A><I>])

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup>:<>

$Dup$ || .*
