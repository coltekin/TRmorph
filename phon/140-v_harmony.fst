%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $VH$ Vowel harmony rules:
%
% NOTE: palatalized consonants (e.g. as in saat-i, not saat-ı) is
% handeled by lexical <pA> (for palatalized `a', for lack of a better name),
%                     <pI> (does not seem to exist, just for the sake of completeness)
%                     <pO>, <pU>
%
% affected analysis sym: <A> <I> <p[AIOU]>
% interacts with: $Del$ (has to be after)
%
% NOTE: the rules take <I> -> i and <A> -> e as default. this helps
%       with the cases like ye -> y<I> -> yi (-yor).
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##infl_feat#] [#BM#]\
           <A>:a <A>:e <I>:i <I>:ı <I>:u <I>:ü \
           [#V_Pal#]

#Non_V# = #C##pos##Apos##infl_feat#<>#BM#

% $VH_Ii$ = (.:[#V_fu#<pA><pI>] [#Non_V#]*) <I> <=> i
$VH_II$ = (.:[#V_bu#] [#Non_V#]*) <I> <=> ı
$VH_IU$ = (.:[#V_fr#<pO><pU>] [#Non_V#]*) <I> <=> ü
$VH_Iu$ = (.:[#V_br#] [#Non_V#]*) <I> <=> u

$VH_Aa$ = (.:[#V_b#]  [#Non_V#]*) <A> <=> a
%$VH_Ae$ = (.:[#V_f#<pA><pI><pO><pU>]  [#Non_V#]*) <A> <=> e


ALPHABET = [#Ssym#] [#pos##infl_feat#] [#BM#]\
           <pA>:a <pI>:<> <pO>:o <pU>:u

$Del_pV$ = .*

($VH_Aa$ & $VH_II$ & $VH_Iu$ & $VH_IU$) || $Del_pV$

