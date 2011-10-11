
% trmorph.fst
% 

#include "symbols.fst"



$afilter$ = "<afilter.a>" 
$morph$ = "<morph.a>"
$phon$ = "<phon/phon-gen.a>"

$afilter$ || <BoW> $morph$ <EoW> || $phon$
