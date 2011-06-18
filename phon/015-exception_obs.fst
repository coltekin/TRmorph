%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $xcptn_obs$: 'o' 'bu' and 'şu' get an `n' before nominal suffixes
%               o-n-lar o-n-u     
% 
% note the dirty hack is to save the buffer y in copular markers and
% -DIr
%             not o-du, but  o-y-du
% TODO: there should be acleaner way
%
#include "../symbols.fst"


ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW> <tmpBuf>


$N$ = {<RB>}:{<tmpBuf><RB>}

$obs1$ = $N$ ^-> (<BoW> (o|bu|şu) [#pos##subcat#]*) __ 

%$obs1$>>"obs_test1.a"

% the following might have been a cleaner solution, but SFST does not
% like insertion with two-level rules
%$obs1$ = (<BoW> (o|bu|şu) [#pos##infl_feat#]*) <> <=> <tmpBuf> (<RB>[^<EoW>])

ALPHABET = [#Ssym#] [#pos##subcat##BM##infl_feat#]\
           <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup><del><dels>\
           [#V_Buff#] <bY> <bS> <bSS> <bN> <bN>\
           <e> <caus> <EoW>\
           <compn> \
           <BoW> <tmpBuf>:n <tmpBuf>:<>

$obs2$ = <tmpBuf> <=> <> (<RB> ([<MB><>]* (<EoW> |\
                                                  ( (<D><I>r)\
                                                   |(<bY><D><I>)\
                                                   |(<bY>m<I>ş)\
                                                   |(<bY>s<A>)\
                                                   |(<bY>ken)\
                                                  )\
                                           )\
                               )\
                         )

%$obs2$>>"obs_test2.a"

$obs1$ || $obs2$
