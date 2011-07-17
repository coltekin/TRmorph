%
% FST to handle all derivational process 
%

#include "symbols.fst"
#include "ninfl.fst"   % this is used for derivations involving
                       % possessive suffixes (e.g. abimgil)
%#include "vinfl.fst"   % we handle causative attached to the 
%                       %  irregular root forms here.

%%%%%% These are the lexical roots throughout this file
%   A - Adverb
%   C - Connective
%   J - Adjective
%   M - Number
%   N - Noun
%   PN - Proper Noun
%   P - Postopsition
%   R - Pronoun
%   V - Verb
%   X - Interjection
%

$ASTEM$ =  "lexicon/adverbs" <adv><RB>
$CSTEM$ =  "lexicon/cnjcoo" <cnjcoo><RB>
$CSTEM$ =  $CSTEM$ | "lexicon/cnjsub" <cnjsub><RB>
$CSTEM$ =  $CSTEM$ | "lexicon/cnjadv" <cnjadv><RB>
$JSTEM$ =  "lexicon/adjectives" <adj><RB>
$MSTEM$ =  "<num.a>" <num><RB>
$NSTEM$ =  "lexicon/nouns" <n><RB>
$PNSTEM$ = "lexicon/proper_nouns" <np><RB>
$PNSTEM$ = $PNSTEM | "lexicon/toponyms" <np><top><RB>
$PSTEM$ =  "lexicon/postpositions" <postp><RB>
$RSTEM$ =  "lexicon/pronouns" <prn><RB>
$VSTEM$ =  "lexicon/verbs" <v><RB>
$XSTEM$ =  "lexicon/interjections" <ij><RB>
$DSTEM$ =  "lexicon/det" <det><RB>
$MISC$ =  "lexicon/misc" 


%%%% Even though most treat reflexive and reciprocal verb forms in
%    derivational morphology, we process them here. Current
%    implementation only allows attachment to the root forms which are
%    marked in the lexicon.
%

%%% Reflexive
%
$reflexive$ = <ref>:{<bI>n} <MB>

%%% Reciprocal

$reciprocal$ = <rec>:{<bI>ş} <MB>

$VSTEM-rr$ =  $VSTEM$ || \
              [#Lsym#]* <rfl>:<> <rcp>:<> [#caus_types##aor_types#]* <v><RB> 
$VSTEM-rfl$ = $VSTEM$ || \
              [#Lsym#]* <rfl>:<> [#caus_types##aor_types#]* <v><RB>
$VSTEM-rcp$ = $VSTEM$ || \
              [#Lsym#]* <rcp>:<> [#caus_types##aor_types#]* <v><RB>

ALPHABET = [#Lsym#]
$VSTEM-def$ = $VSTEM$ || \
              [^<rfl><rcp>]+ [#caus_types##aor_types#]* <v><RB>

$VSTEM$ = $VSTEM-def$ |\
          $VSTEM-rfl$ $reflexive$? |\
          $VSTEM-rcp$ $reciprocal$?|\
          $VSTEM-rr$ $reflexive$? $reciprocal$?

%%% Productive derivations

% TODO: order (alphabetically?)

%%%%%  -lI 
% N->N atlı, N->J, akıllı, J->J mavili, J->N ??
$D_li$ = <D_lI>:{xxx}

$DNN$ = $D_li$
$DNJ$ = $D_li$
$DJJ$ = $D_li$

%%%%%  -slz 
% N->J insafsız, N->A, arabasız, TODO: non-prod N->N telsiz
$D_siz$ = <Dnn_siz>:{xxx}

$DNJ$ = $DNJ$ | $D_siz$
$DNA$ = $D_siz$

%%%%%  -lIK
% N->N krallık, J->N iyilik, A->N yavaşlık
$D_lik$ = <D_lIK>:{xxx}

$DNN$ = $DNN$ | $D_lik$
$DJN$ = $D_lik$
$DAN$ = $D_lik$

% TODO: we may want to mark dimunitive function
% TODO: currently dimunitives overgenerate


$D_cak$ = <D_CAK>:{xxx}
%%%%% -CIK
% N->N kedicik, adacık
$D_cik$ = <D_CIK>:{xxx}
%%%%% -CAgIz
% N->N çocukcağız -- TODO looks like -cAğIz rather than -CAğIz
$D_cagiz$ = <D_CAgIz>:{xxx}

$DNN$ = $DNN$ | $D_cik$ 
$DNN$ = $DNN$ | $D_cagiz$

%%%%% -AcIK / IcIK
% A->A daracık, hemencecik
% A->A azıcık, TODO: küçücük
$D_acik$ = <D_AcIK>:{xxx}
$D_icik$ = <D_IcIK>:{xxx}

$DAA$ = $D_acik$ | $D_icik$

%%%% -CI
% N->N şekerci, N->J gerici, ?? J->J mavici
% V->N öğrenci FIXME: this happens only after `n' otherwise -yIcI, ?? V->J 
$D_ci$ = <D_CI>:{xxx}


$DNN$ = $DNN$ | $D_ci$
$DNJ$ = $DNJ$ | $D_ci$
$DVN$ = $D_ci$

%%%% -(y)ICI
% V->N öğrenci (but all of these should be lexicalized)
% V->J bulaşıcı, yapıcı, kesici ...
$D_yIcI$ = <Dvn_yIcI>:{xxx}

% $DVN$ = $DVN$ | $D_yIcI$
$DVJ$ = $D_yIcI$

%%%% -CIl
% N->J insancıl, N->N balıkçıl
$D_cil$ = <D_cil>:{xxx}

$DNJ$ = $DNJ$ | $D_cil$
$DNN$ = $DNN$ | $D_cil$

%%%% -gil
%%%% N->N, Ahmetgil, baklagil TODO: can come after inflections: amca-m-gil
$D_gil$ = <D_gil>:{xxx}

$DNN$ = $DNN$ | $D_gil$


%%%% -lA
%%%% N->V tuzla, J->V kurula TODO: gıdakla, ahla
$D_la$ = <D_lA>:{xxx}

$DNV$ = $D_la$
$DJV$ = $D_la$

%%%% -lAn
%%%% N->V avlan, J->V kurulan 
$D_lan$ = <D_lAn>:{xxx}

$DNV$ = $DNV$ | $D_lan$
$DJV$ = $DJV$ | $D_lan$

%%%% -lAş
%%%% N->V mektuplaş, J->V güzelleş
$D_las$ = <D_lAs>:{xxx}

$DNV$ = $DNV$ | $D_las$
$DJV$ = $DJV$ | $D_las$

%%%% -lAş
%%%% N->V mektuplaş, J->V güzelleş
$D_las$ = <D_lAs>:{xxx}

$DNV$ = $DNV$ | $D_las$
$DJV$ = $DJV$ | $D_las$

%%% -mAdIK
% V->J görmedik, TODO: this can come after voice (görülmedik)
$D_madik$ = <D_mAdIK>:{xxx}

$DJV$ = $DJV$ | $D_madik$

%%% -(y)Iş
% V->N duruş, yürüyüş, görüş, dönüş, bakış
$D_yIS$ = <D_yIS>:{xxx}

$DVN$ = $DVN$ | $D_yIS$

%%% -mA
% V->N ödeme, arama, kıyma, kesme
% V->J kıyma, kesme, dökme, bunama
$D_mA$ = <D_mA>:{xxx}

$DVN$ = $DVN$ | $D_mA$
%$DVJ$ = $DVJ$ | $D_mA$

%%% -CA
% N->N çocukça, N->J Almanca, J->J hızlıca 
% TODO: M->J onlarca, -mAcA, NOTE: G&K takes these as two different sufixes
$D_ca$ = <D_CA>:{xxx}

$DNN$ = $DNN$ | $D_ca$
$DNA$ = $DNA$ | $D_ca$
$DNJ$ = $DNJ$ | $D_ca$
$DJJ$ = $DJJ$ | $D_ca$

%%% -sAl
% N->J tarihsel, düşsel
$D_sAl$ = <D_sAl>:{xxx}

$DNJ$ = $DNJ$ | $D_sAl$

% also: $DVA$ = $DVA$ | $D_sAl$, does not seem to  be prductive

%%% -gil
% N->N abimgil, amcasıgil 
$D_gil$ = $poss$? <D_gil>:{xxx}

$DNN$ = $DNN$ | $D_gil$

%%%%%% Numeral Changes
% -(I)ncI: beş -> beşinci
% TODO: (maybe) use differnt numeric types for cardinal ordinal and
%       districutive numerals

$D_IncI$ = <D_IncI>:{<bI>nc<I>}
$D_IncIa$ = <D_IncI>:{'<bI>nc<I>}

$DMJ$ = $D_IncI$ | $D_IncIa$ 

$D_sAr$ = <D_sAr>:{xxx}
$D_sAra$ = <D_sAr>:{xxx}

$DMA$ = $D_sAr$ | $D_sAra$ 

$JSTEM$ = $JSTEM$ | $MSTEM$ $DMJ$ <adj><MB>
$ASTEM$ = $ASTEM$ | $MSTEM$ $DMA$ <adv><MB>


%$ASTEM$>>"test-a.fst"
%%%% Zero derivations to allow J, A, M -> N
%

$DJN0$ = <Djn_0>:<xxx>
$DAN0$ = <Dan_0>:<xxx>
$DMN0$ = <Dmn_0>:<xxx>

$DMNa$ = <apos>:{'}

$DJN$ = $DJN$ | $DJN0$
$DAN$ = $DAN$ | $DAN0$
$DMN$ = $DMN0$ | $DMNa$

% regardless of the derivational option we will type-shift these to
% noun, to simplify the notation below. we modify the N here.

$NSTEM$ = $NSTEM$ |\
          $JSTEM$ ($DJN0$ <n><MB>)|\
          $ASTEM$ ($DAN0$ <n><MB>)|\
          $MSTEM$ ($DMN$ <n><MB>)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Options for combination of derivational morphemes goes below.
% This assumes all combinations are possible, heavily overgenerates.
% It may be fine for analysis that is interested in the derivations
% though. The best option would be checking the possible combinations,
% and ruling out the ones that does not happen.
%
% Options are: 
%     - No derivation   : all derivation should be handeled in the
%                         lexiocn
%     - N derivations   : allow a fixed number of derivational suffixes
%                         to be added
%     - Only productive : use only the productive derivational
%                         morphemes, assume non-productive ones are
%                         handeled in the lexicon
%     - 0/1 non-productive N/unlimited productive (TODO)
%     - Unlimited derivation   (TODO)
%

%%%%%%%% OPTION 1: No derivation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% -- do nothing


%%%%%%%% OPTION 2: Allow only one derivation %%%%%%%%%%%%%%%%%%%%%
%
%

% TODO: appostrophe after PNSTEM
$NSTEM$  = $NSTEM$ ($DNN$  <n><MB>)? \
         |  $PNSTEM$ $DNN$  <n><MB> \ 
         |  $VSTEM$ $DVN$   <n><MB> \
         |  $ASTEM$ $DAN$   <n><MB> \
         |  $JSTEM$ $DJN$   <n><MB>
            
$ASTEM$  = $ASTEM$ ($DAA$ <adv><MB>)? \
         | ($NSTEM$|$PNSTEM$) $DNA$ <adv><MB>
%           $VSTEM$ $DVA$   |\
%           $JSTEM$ $DJA$ 

$JSTEM$  = $JSTEM$ ($DJJ$ <adj><MB>)? \
         | ($NSTEM$|$PNSTEM$) $DNJ$ <adj><MB> \
         |  $VSTEM$ $DVJ$ <adj><MB> \
%        |  $ASTEM$ $DAJ$ 

$VSTEM$  = $VSTEM$ \
         | ($NSTEM$|$PNSTEM$) $DNV$ <v><MB> \
         | $JSTEM$ $DJV$ <v><MB> \ 
%           $ASTEM$ $DAV$   |\
%           $VSTEM$ $DVV$?  |\

%%%%%%%%% OPTION 3: One more (2 so far) %%%%%%%%%%%%%%%%%%%%%
%%
%% The part below be repeated to anlyze logner sequences of
%% derivational morphemes.
%
$NSTEM$  = $NSTEM$ ($DNN$  <n><MB>)? \
         |  $PNSTEM$ $DNN$  <n><MB> \ 
         |  $VSTEM$ $DVN$   <n><MB> \
         |  $ASTEM$ $DAN$   <n><MB> \
         |  $JSTEM$ $DJN$   <n><MB>

$ASTEM$  = $ASTEM$ ($DAA$ <adv><MB>)? \
         | ($NSTEM$|$PNSTEM$) $DNA$ <adv><MB>
%           $VSTEM$ $DVA$   |\
%           $JSTEM$ $DJA$ 


$JSTEM$  = $JSTEM$ ($DJJ$ <adj><MB>)? \
         | ($NSTEM$|$PNSTEM$) $DNJ$ <adj><MB> \
         |  $VSTEM$ $DVJ$ <adj><MB> \
%        |  $ASTEM$ $DAJ$ 

$VSTEM$  = $VSTEM$ \
         | ($NSTEM$|$PNSTEM$) $DNV$ <v><MB> \
         | $JSTEM$ $DJV$ <v><MB> \ 
%           $ASTEM$ $DAV$   |\
%           $VSTEM$ $DVV$?  |\

%%%%%%%% OPTION X: unlimited derivation %%%%%%%%%%%%%%%%%%%%%
%
% The part below be repeated to anlyze logner sequences of
% derivational morphemes.



%%%%%%%%%%%% Causative
%
% Handling causative attached to root forms here to clean up some 
% the mess in trmorph.fst
% 

% first split the verbal stems based on causative types

%$CAUS-reg$ = $VSTEM$ || ($AAsym$* [#V_all##caus_types#] <v>?[<RB><MB>])
%
%$CAUS-t$    = $VSTEM$  || ($AAsym$* <caus_t>:<> <aor_ar>? <v><RB>)
%$CAUS-dir$  = $VSTEM$  || ($AAsym$* <caus_dir>:<> <aor_ar>? <v><RB>)
%$CAUS-it$   = $VSTEM$  || ($AAsym$* <caus_it>:<> <aor_ar>? <v><RB>)
%$CAUS-ir$   = $VSTEM$  || ($AAsym$* <caus_ir>:<> <aor_ar>? <v><RB>)
%$CAUS-ar$   = $VSTEM$  || ($AAsym$* <caus_ar>:<> <aor_ar>? <v><RB>)
%$CAUS-art$  = $VSTEM$  || ($AAsym$* <caus_art>:<> <aor_ar>? <v><RB>)
%$CAUS-none$ = $VSTEM$ || ($AAsym$* <caus_irreg>:<> <aor_ar>? <v><RB>)
%
%
%% now put them together, replicating the irregular forms
%
%$VSTEM$ = $CAUS-reg$ \
%         | $CAUS-dir$ <caus>:{<D><I>r} <MB> \
%         | $CAUS-dir$ <caus-none> \
%         | $CAUS-t$ <caus>:{t} <MB> \
%         | $CAUS-t$ <caus-none> \
%         | $CAUS-it$ <caus>:{<I>t} <MB> \
%         | $CAUS-it$ <caus-none> \
%         | $CAUS-ir$ <caus>:{<I>r} <MB> \
%         | $CAUS-ir$ <caus-none> \
%         | $CAUS-ar$ <caus>:{<A>r} <MB> \
%         | $CAUS-art$ <caus-none> \
%         | $CAUS-art$ <caus>:{<A>rt} <MB> \
%         | $CAUS-art$ <caus-none> \
%         | $CAUS-ir$ <caus-none> \
%         | $CAUS-none$ <caus-none>
%



%%%%%%%%%%%%%%%%%%%%% Write the FSTs
%
%
%
$NSTEM$  >> "noun.a"
$PNSTEM$ >> "prop.a" 
$RSTEM$  >> "pron.a"
$JSTEM$  >> "adj.a"
$ASTEM$  >> "adv.a"
$PSTEM$  >> "postp.a"
$XSTEM$  >> "interj.a"
$CSTEM$  >> "conj.a"
$VSTEM$  >> "verb.a"
$MSTEM$  >> "number.a"
$DSTEM$  >> "det.a"
$MISC$   >> "misc.a"



%%%%
%%% This is for testing. Individual files are already written to
%   correspondign FSA already.
%

<>:<BoW> ($NSTEM$ |\
 $PNSTEM$|\
 $RSTEM$ |\
 $JSTEM$ |\
 $ASTEM$ |\
 $PSTEM$ |\
 $XSTEM$ |\
 $CSTEM$ |\
 $DSTEM$ |\
 $MISC$ |\
 $VSTEM$ |\
 $MSTEM$ ) <>:<EoW> || "<phon/phon.a>"
