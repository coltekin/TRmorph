%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% This file duplicates code from 050-exception_su.fst, for
% non-ambiguous generation mode
%
% The only difference is that $insy2$ here is not optional 
%
% FIXME: duplicated code!
%

#include "../symbols.fst"

$y-exception$ = (su|özsu|karasu)
$y-optional$ = (ne|akarsu|Akarsu)

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> \
           <BoW> 

$insy$ = {<RB>}:{<RB> y} | {<MB>}:{<MB>  y}

$insy1$ = $insy$ ^-> ((<BoW> $y-exception$ [#subcat##pos##Apos##BM##infl_feat#]*) __ ([<bI><bN><bS>]))

$insy2$ = $insy$ ^-> ((<BoW> $y-optional$ [#pos##subcat##Apos##BM##infl_feat#]*) __ ([<bI><bN><bS>]))

$insy1$ || $insy2$
