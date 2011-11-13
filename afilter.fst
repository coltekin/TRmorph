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

% TODO: this is a q&d hack that allows only a 
%       limited number of (three) subcategories 
#=SC# = #subcat#
#=SC2# = #subcat#
#=SC3# = #subcat#
#=C# = #pos#
$swap1$ = {[#=C#][#=SC#]}:{[#=SC#][#=C#]}
$swap2$ = {[#=C#][#=SC#][#=SC2#]}:{[#=SC#][#=SC2#][#=C#]}
$swap3$ = {[#=C#][#=SC#][#=SC2#][#=SC3#]}:{[#=SC#][#=SC2#][#=SC3#][#=C#]}

$swap$ = $swap1$ | $swap2$ | $swap3$ | [#pos#][#subcat#]*

($deltempsym$  | $swap$)*
