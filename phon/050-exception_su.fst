%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xcptn_su$: Handling of exception words ending with `su' and the word 'ne'
%
% Some stems, particularly `su' and `ne', get a `y' at the end if
% followed by possessive suffixes with a <bI> or <bS> (all possessives
% except p3p) and genitive case marker -(n)In.
%
% In case of `su' this is the only way: 
%  suyum(p1s), suyun(p2s), suyu(p3s), suyumuz(p1p), suyunuz(p2p) and suyun(gen)
% the alternative is not grammatical:
%  sum, sun, susu, sumuz, sunuz and sunun
%
% In case of `ne' and some other words that end with `su' (suchs as akarsu)
% this seems to be optional. With ne, 
%  neyim(p1s), neyin(p2s), neyi(p3s), neyimiz(p1p), neyiniz(p2p) and neyin(gen)
% is the correct/preferred way. However, althogh less preferable, the
% alternative (no y insertion) is also fine
%  nem, nen, nesi, nemiz, neniz and nenin
%
% The stems that require y-insertion should be added to $y-exception$
% below. The stems where the y-insertion is optional should be added
% to $y-optional$.
%
% NOTE: also change 050-exception_su-gen.fst if you change this file
%
% FIXME: everything is duplicated in 050-exception_su-gen.fst.
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

$insy2$ = $insy$ ^->? ((<BoW> $y-optional$ [#pos##subcat##Apos##BM##infl_feat#]*) __ ([<bI><bN><bS>]))

$insy1$ || $insy2$
