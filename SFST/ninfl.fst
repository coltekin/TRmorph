%
% FSTs for nominal inflections 
%

#include "symbols.fst"

%%%%%%%%%%%% Noun Inflections %%%%%%%%%%%%%%

%%%%% plural
%
$plu$ = <pl>:{l<A>r} <MB>

%%%% possessive markers:
%
%
$p1s$ = <p1s>:{<bI>m} <MB>
$p2s$ = <p2s>:{<bI>n} <MB>
$p3s$ = <p3s>:{<bS><I>} <MB>
$p1p$ = <p1p>:{<bI>m<I>z} <MB>
$p2p$ = <p2p>:{<bI>n<I>z} <MB>
$p3p$ = <p3p>:{l<A>r<I>} <MB>

$poss12$ = $p1s$ | $p2s$ | $p1p$ | $p2p$
$poss3$ =  $p3s$ | $p3p$
$poss$ = $poss12$ | $poss3$

%%%%% case markers
%
%
$loc$ =  <loc>:{<D><A>} <MB>
$loc3$ = <loc>:{<bN>d<A>} <MB>
$gen$ =  <gen>:{<bN><I>n} <MB>
$gen3$ = <gen>:{<bN><I>n} <MB>
$acc$ =  <acc>:{<bY><I>} <MB>
$acc3$ = <acc>:{<bN><I>} <MB>
$abl$ =  <abl>:{<D><A>n} <MB>
$abl3$ = <abl>:{<bN>d<A>n} <MB>
$dat$ =  <dat>:{<bY><A>} <MB>
$dat3$ = <dat>:{<bN><A>} <MB>
$ins$ =  <ins>:{<bY>l<A>} <MB> %| <ins>:{<bY>l<A>n} <MB>
$ins3$ = <ins>:{<bY>l<A>} <MB> %| <ins>:{<bY>l<A>n} <MB>

$case1$ = $loc$ | $gen$
$case1p3$ = $loc3$ | $gen3$

$case2$ = $acc$ | $abl$ | $dat$ | $ins$
$case2p3$ = $acc3$ | $abl3$ | $dat3$ | $ins3$

%%%%% -ki
%
%
$ki$ = <ki>:{ki} <MB>


%%%%% not really an inflection but added after possessive to make
% adverbs:

$nca$ = <ca>:{<bN>c<A>} <MB>

%%%%% summary variables
%
%

$PLU$ = $plu$
$POSS12$ = ($plu$)? $poss12$
$POSS3$ =($plu$)? $poss3$
$POSS$ = $POSS12$ | $POSS3$
$CASE1$ = ($PLU$)? $case1$ | ($POSS12$ $case1$) | ($POSS3$ $case1p3$)
$CASE2$ = ($PLU$)? $case2$ | ($POSS12$ $case2$) | ($POSS3$ $case2p3$)
$CASE$ = $CASE1$ | $CASE2$
 
% all inflectional combinations except case1
$INFL_c1$ = $PLU$ | $POSS$ | $CASE2$

% play around recursive application of ki.
$NINFL$ = (($CASE1$ $ki$)* $INFL_c1$?) | \
           ($CASE1$ ($ki$ $CASE1$)*)

%%% TODO: -(s)<I> as compund marker

%%% Apostrophe in orthograpph

$apos$ = <apos>:' <MB>
