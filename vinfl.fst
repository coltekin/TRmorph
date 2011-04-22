%
% FST for verbal inflections
%

%%%%%%%%%%%%%%%% Voice
%%%
%%% These are reflexive, reciprocal, cauastive and passive.
%%% First two are rather unproductive. we attach them only to the
%%% stems that are lexically marked, and deal with them in deriv.fst.
%%%

%%% Causative 
%
% TODO: handling of (truely?) irregular forms such as gir/sok,
%       kalk/kaldir, gel/getir, git/gotur
%


$caus_dir$ = <caus>:{<D><I>r} <MB>
$caus_t$ = <caus>:{t} <MB>
$caus_It$ = <caus>:{<I>t} <MB>
$caus_Ir$ = <caus>:{<I>r} <MB>
$caus_Ar$ = <caus>:{<A>r} <MB>
$caus_Art$ = <caus>:{<A>rt} <MB>

%%% Passive

% <LN> realized as `n' if preceeding morpheme (almost always the stem 
% ends with `l', otherwise `n'. <bI> is the buffer vowel, which is
% dropped or realized as <I>

$passive$ = <pass>:{<bI><LN>} <MB>

%%%%%%%%%%%%%%%% End of voice suffixes


%%%%%%%%%%%%%%%% -(y)A
%%% this is only t/a/m marker that occurs before negative, and has to
%%% be followed by the negative marker.
%%%
%%% NOTE: if we use the same analysis symbol <able> like the -(y)Abil
%%%       morpheme we will acccept words like `gel-ebil-mez' because
%%%       of the loop back after compound verb suffixes. 
%%%

% $able_ya$ = <able_neg>:{<bY><A>} <MB>
$able_ya$ = <abil>:{<bY><A>} <MB>


%%%%%%%%%%%%%%%% Negation
%%%
%%% we will deal with the -mI form that occurs before -yor by special
%%% symbol <AI> phon.fst replaces <AI> with <I> before 
%%% `yor', otherwise <AI> is replaced with <A>.
%%%

$neg$ = <neg>:{m<A>} <MB>

%%%%%%%%%%%%%%%% Compound verb forms
%%% 
%%% TODO: (1) Currently we ignore the fact that -iver can be followed
%%%       by negative and passive (we may be actually getting back to
%%%       the $STEM$). (e.g. yapıverilmiş, yapıverme, yapıverilmemiş)
%%%       (2) G&K claims that these cannot co-occur. Something like 
%%%       göremeyebiliver sounds like a possibility. maybe some
%%%       plausible/real combinations exist
%%%  
%%% G&K do not include -akoy and -agör (first one looks extremely rare)
%%% and note that -adur, -agel, -ayaz, -akal are unproductive.
%%% probably we only need -abil and -iver for a reasonable coverage.
%%%  
%%%  
%%% METU-Sabanci TB (likely Oflazer's analyzer) calls -iver +Hastily
%%%
%%% We keep the uncommon/unproductive cases as they are
%%% Except ability <able> we use analysis symbols that sound 
%%% similar to the morpheme.
%%% TODO: we need to treat -iver differently than others. 
%%%  -iver one can be followed by passive (recursion again!). and 
%%%   and fine with negation from both sides yapmayıver/yapıverme
%%%

$able$ = <abil>:{<bY><A>bil} <MB>
$iver$ = <iver>:{<bY><I>ver} <MB>
$adur$ = <adur>:{<bY><A>dur} <MB>
$agel$ = <agel>:{<bY><A>gel} <MB>
$agor$ = <agor>:{<bY><A>gör} <MB>
$akal$ = <akal>:{<bY><A>kal} <MB>
$akoy$ = <akoy>:{<bY><A>koy} <MB>
$ayaz$ = <ayaz>:{<bY><A>yaz} <MB>

$comp$ = $able$ | $iver$ | $adur$ |  $agel$ | $ayaz$ | $akal$ | $akoy$ | $agor$ 
$comp-able$ = $iver$ | $adur$ |  $agel$ | $ayaz$ | $akal$ | $akoy$ | $agor$ 

%%%%%%%%%%%%%%%% Tense/Aspect/Modality
%%% 
%%% 
%%% 

$t_di$ = <t_past>:{<D><I>} <MB>         % past tense
$t_mis$ = <t_narr>:{m<I>ş} <MB>         % narrative/evidential past
$t_acak$ = <t_fut>:{<bY><A>c<A><k>} <MB>  % future
$t_sa$ = <t_cond>:{s<A>} <MB>           % conditional
$t_meli$ = <t_obl>:{m<A>l<I>} <MB>      % obligative
$t_makta$ = <t_makta>:{m<A>kt<A>} <MB>  % imperfective (?)
$t_ya$ = <t_opt>:{<bY><A>} <MB>         % optative 1st/2nd person
$t_ya_null$ = <t_opt>:{<>} <MB>         % optative 3rd person
$t_iyor$ = <t_cont>:{<bI>yor} <MB>      % present cont.
$t_imp$ = <t_imp>:{<>} <MB>             % imperative

% aorist attached to stems are more or less irregular
% the type aorist a stem gets is marked in lexicon
%
$t_aor_ar$ = <t_aor>:{<A>r} <MB>   % aorist
$t_aor_ir$ = <t_aor>:{<bI>r} <MB>   % aorist
$aor$ = $t_aor_ar$ | $t_aor_ir$

% aorist after negative form is is either a -z, or is not realized at
% all if immediately followed by a 1st person sg or pl marker.
%
$t_aor_z$ = <t_aor>:{z} <MB> 
$t_aor_null$ = <t_aor>:{<>} <MB> 

%these behave nicely similar with compular suffixes, person markers & -dir
$tense_g1$ = $t_mis$|$t_acak$|$t_meli$|$t_makta$|$t_iyor$


%%%%%%%%%%%%%%%% copula (or second tense/aspect/modality) suffixes
%%% di+di sequence is rather unusual (e.g., yaptıydı), nevertheless
%%% it is accepted.
%%% 
%%% double copula constructions (e.g. yapıyormuşsa) are enumerated
%%% here. most forms are rather odd (e.g. yaparmışsa), on the other
%%% hand, it smells another theoretical possiblity of unlimited
%%% concatinative process (e.g. ?yapıyormuşsaymışsa)
%%% 

$cpl_di$ =  <cpl_di>:{<bY><D><I>} <MB>
$cpl_mis$ = <cpl_mis>:{<bY>m<I>ş} <MB>
$cpl_sa$ =  <cpl_sa>:{<bY>s<A>} <MB>

% though this makes a adjective, it is a copula
$cpl_ken$  = <cpl_ken>:{<bY>ken} <MB>

$cpl$ = $cpl_di$ |  $cpl_mis$ | $cpl_sa$

%%%%%%%%%%%%%%%% person markers
%%% this follows more or less G&K description of different groups
%%% of person markers. 
%%%
%%%
%%%

% These come after most t/a/m markers

$p2_1s$ = <1s>:{<bY><I>m} <MB>
$p2_2s$ = <2s>:{s<I>n} <MB>
$p2_2sf$ = <2sf>:{s<I>n<I>z} <MB>
$p2_3s$ = <3s>:{} <MB>
$p2_1p$ = <1p>:{<bY><I>z} <MB>
$p2_2p$ = <2p>:{s<I>n<I>z} <MB>
$p2_3p$ = <3p>:{l<A>r} <MB>

% note: 2psg formal form is not in
$p_g2$ = $p2_1s$ | $p2_2s$ | $p2_3s$ | $p2_1p$ | $p2_2p$ | $p2_3p$



% These come after <D><I> and s<A>
$p1_1s$ = <1s>:{m} <MB>
$p1_2s$ = <2s>:{n} <MB>
$p1_2sf$ = <2sf>:{n<I>z} <MB>
$p1_3s$ = <3s>:{} <MB>
$p1_1p$ = <1p>:{<k>} <MB>
$p1_2p$ = <2p>:{n<I>z} <MB>
$p1_3p$ = <3p>:{l<A>r} <MB>

% note: 2psg formal form is not in
$p_g1$ = $p1_1s$ | $p1_2s$ | $p1_3s$ | $p1_1p$ | $p1_2p$ | $p1_3p$

% these only work with optative (-(y)A)
% this specification slightly diverges from G&K description
%
$p3_1s$ = <1s>:{y<I>m} <MB>
$p3_2s$ = <2s>:{s<I>n} <MB>
$p3_2sf$ = <2sf>:{s<I>n<I>z} <MB>
$p3_3s$ = <3s>:{} <MB>
$p3_1p$ = <1p>:{l<I>m} <MB>
$p3_2p$ = <2p>:{s<I>n<I>z} <MB>
$p3_3p$ = <3p>:{l<A>r} <MB>

% note: 2psg formal form is not in
$p_g3$ = $p3_1s$ | $p3_2s$ | $p3_3s$ | $p3_1p$ | $p3_2p$ | $p3_3p$


% these only work with imperative
$p4_2s$ = (<2s>:{s<A>n<A>} | <2s>:{<>}) <MB>
$p4_2sf$ = (<2sf>:{<bY><I>n} | <2sf>:{<bY><I>n<I>z} | <2sf>:{s<A>n<I>z<A>}) <MB>
$p4_3s$ = <3s>:{s<I>n} <MB>
$p4_2p$ = (<2p>:{<bY><I>n} | <2p>:{<bY><I>n<I>z} | <2p>:{s<A>n<I>z<A>}) <MB>
$p4_3p$ = <3p>:{s<I>nl<A>r} <MB>

% note: 2psg formal form is not in
$p_g4$ = $p4_2s$ | $p4_3s$ |  $p4_2p$ | $p4_3p$

%%%%%%%%%%% -DIr
%% as in `gidyoruzdur'
%%

$dir$ =  <dir>:{<D><I>r} <MB>


%%%%%%%%%%%%%% Subordinating suffixes
%
% These form non-finite verb forms
%

% verbal nouns

$vn_dik$  = <vn_dik>:{d<I><k>} <MB>                                                                                                  
$vn_acak$ = <vn_acak>:{<bY><A>c<A><k>} <MB>                                                                                          
$vn_ma$   = <vn_ma>:{m<A>} <MB><bY>                                                                                                  
$vn_mak$  = <vn_mak>:{m<A><K>} <MB>                                                                                                  
$vn_yis$  = <vn_yis>:{<bY><I>ş} <MB>                                                                                                 


% participles 
$part_dik$  = <part_dik>:{<D><I><k>} <MB>
$part_acak$ = <part_acak>:{<bY><A>c<A><k>} <MB>
$part_yan$  = <part_yan>:{<bY><A>n} <MB>


% the rest forms converbs
$cv_dik$  = <cv>:{<D><I><k>} <MB>
$cv_acak$ = <cv>:{<bY><A>c<A><k>} <MB>
$cv_ma$   = <cv>:{m<A>} <MB>
$cv_mak$  = <cv>:{m<A><K>} <MB>
% these combine with negative only (G&K documents these as combined
% morphemes -mazdan -madan).
$cv_dan$  = <cv>:{d<A>n} <MB>
$cv_zdan$ = <cv>:{zd<A>n} <MB>

% gelince, gelinceye kadar
$cv_ince$ = <cv>:{<bY><I>nc<A>} <MB>

% calışarak
$cv_erek$ = <cv>:{<bY><A>r<A><k>} <MB>

% geleli
$cv_eli$  = <cv>:{<bY><A>l<I>} <MB>

% gelene kadar
$cv_ene$  = <cv>:{<bY><A>n<A>} <MB>

% the will certainly overgenerate, normally they should be followed by
% 'gibi'

$cv_ir$   = <cv>:{<I>r} <MB>
$cv_ar$   = <cv>:{<A>r} <MB>
$cv_ecek$   = <cv>:{<bY><A>c<A><k>} <MB>
$cv_mis$    = <cv>:{<bY>m<I>ş} <MB>
$cv_iyor$    = <cv>:{<bI>yor} <MB>
% -cesine comes after A/Ir and mIş:
$cv_cesine$ = <cv>:{<C><A>s<I>n<A>} <MB>

$cv_ip$     = <cv>:{<bY><I>p} <MB>
