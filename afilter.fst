#include "symbols.fst"

%
% filter/rearrange symbols in the analysis layer 
%


ALPHABET = [#Ssym##deriv##infl#] \
           <>:[#LEsymS#] \
           ç:<c> p:<p> t:<t> k:<k> g:<g> k:<K> t:<D> ç:<C> \
           <A><I> e:<e> \
           a:<pA> ı:<pI> o:<pO> u:<pU> \
           <>:[#TMP#] <>:<RB> <>:<MB>

$deltempsym$ = .

ALPHABET = [#pos##subcat#]

#=SC# = #subcat#
#=C# = #pos#
$swap$ = ({[#=C#][#=SC#]}:{[#=SC#][#=C#]} | [#pos#])


($deltempsym$  | $swap$)*
