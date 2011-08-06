% trmorph.fst
% 
% Actual morphotactics is described in this file.
%
%

#include "symbols.fst"
#include "vinfl.fst"
#include "ninfl.fst"
#include "particles.fst"

%%% The stems from the lexicon (possibly with derivation)
%
%
$NSTEM$ = "<noun.a>" | "<pron.a>"
$PNSTEM$ = "<prop.a>"
$ASTEM$ = "<adv.a>" 
$JSTEM$ = "<adj.a>" 
$VSTEM$ = "<verb.a>"
$CSTEM$ = "<conj.a>"
%$RSTEM$ = "<pron.a>"
$XSTEM$ = "<interj.a>"
$PSTEM$ = "<postp.a>"
$PISTEM$ = <"postpi.a>"
$MSTEM$ = "<number.a>"
$DSTEM$ = "<det.a>"

% these following contains exceptional cases fully analyzed in the
% lexicon.
$MISC$ = "<misc.a>"



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                      FST for nominal morphotactics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The individual inflections are declared in vinfl.fst, which 
% is included above.
%
% noun.fst deals with complex stem forms, including derivation.
%
%


%%%%% summary variables
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


$NOUN$ = $NSTEM$ $NINFL$? | \
         $PNSTEM$ | \
         $PNSTEM$ $apos$ $NINFL$

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%          Adverbs and adjectives do not get inflectional suffixes.
%
%          The nominal suffixes they get is handeled by deriving
%          nouns out of them with a zero morpheme.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% TODO: (1) check if we need to go around -ki
%       (2) if this can be attached to plural directly
$ADVERB$ = $NSTEM$ ($PLU$ | $POSS$)? $nca$

$ADVERB$ = $ADVERB$ | $ASTEM$
$ADJECTIVE$ = $JSTEM$

%%%%%%%%%%%%%%%%%%%%%%%% End of nominal Morphotactics %%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                      FST for verbal morphotactics
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This part deals with complex stems including derivation on root 
% forms.  The forms we get out of "verb.a" can be complex forms.
%
% We deal with reflexive and reciprocal in deriv.fst
%
% The individual inflections (for the broad definition of inflection)
% are declared in vinfl.fst, which is included above.
%



%%%%%%%  Causative and aorist irregularities on root (or lexical stem) forms.
%
% we split the verbal stems from the lexicon into categories based on 
% their behaviour with causative and aorist suffixes
%
%

% any stem with causative or aorist irregularites
$VSTEM-irreg$ = $VSTEM$ || \
                ([#Lsym#]* [#caus_types#<aor_ar>] [#Lsym#]* <v><RB>)

% this one is the default for all, no marked form in the lexicon:
$VSTEM-reg$ = $VSTEM$ - $VSTEM-irreg$

$VSTEM-irregC$ = $VSTEM-irreg$ || \
                 ([#Lsym#]* [#caus_types#] [#Lsym#]* <v><RB>)
$VSTEM-irregA$ = $VSTEM-irreg$ || \
                 ([#Lsym#]* <aor_ar> [#Lsym#]* <v><RB>)
$VSTEM-regC$ = $VSTEM-irreg$ - $VSTEM-irregC$
$VSTEM-regA$ = $VSTEM-irreg$ - $VSTEM-irregA$

% rC -> regular causative, rA regular aorist
% iC -> irregular causative, iA irregular aorist ...

$VS-rC-rA$ = $VSTEM$ - $VSTEM-irreg$
$VS-rC-iA$ = $VSTEM-regC$
$VS-iC-rA$ = $VSTEM-regA$
$VS-iC-iA$ = $VSTEM-irregA$ & $VSTEM-irregC$ 

$VSTEM-ir-t$   = $VSTEM-reg$ || \
                 ([#AAsym#]* [#V_all#lr] [<rfl><rcp>]* <v>?[<RB><MB>])
$VSTEM-ir-dir$ = $VSTEM-reg$ - $VSTEM-ir-t$

% no causative marker, but aorist -ar
$VSTEM-ar-t$ = $VS-rC-iA$ || \
               ([#AAsym#]* [#V#lr] [<rfl><rcp>]* <aor_ar> <v><RB>)
$VSTEM-ar-dir$ = $VS-rC-iA$ - $VSTEM-ar-t$


% forms with irregular aorist and causative
$VSTEM-ar-X$ = $VS-iC-iA$ || ([#Lsym#]* <caus_irreg> [#Lsym#]* <v><RB>)
$VSTEM-ar-dir$ = $VSTEM-ar-dir$ |\
                ($VS-iC-iA$ || ([#Lsym#]* <caus_dir> [#Lsym#]* <v><RB>))
$VSTEM-ar-t$ = $VSTEM-ar-t$ |\ 
              ($VS-iC-iA$ || ([#Lsym#]* <caus_t> [#Lsym#]* <v><RB>))
$VSTEM-ar-it$ = $VS-iC-iA$ || ([#Lsym#]* <caus_it> [#Lsym#]* <v><RB>)
$VSTEM-ar-ir$ = $VS-iC-iA$ || ([#Lsym#]* <caus_ir> [#Lsym#]* <v><RB>)
$VSTEM-ar-ar$ = $VS-iC-iA$ || ([#Lsym#]* <caus_ar> [#Lsym#]* <v><RB>)
$VSTEM-ar-art$ = $VS-iC-iA$ || ([#Lsym#]* <caus_art> [#Lsym#]* <v><RB>)


% irregular causative with default aorist -ir-
$VSTEM-ir-X$ = $VS-iC-rA$ || ([#Lsym#]* <caus_irreg> <v><RB>)
$VSTEM-ir-dir$ = $VSTEM-ir-dir$ |\
                ($VS-iC-rA$ || ([#Lsym#]* <caus_dir> <v><RB>))
$VSTEM-ir-t$ = $VSTEM-ir-t$ |\ 
              ($VS-iC-rA$ || ([#Lsym#]* <caus_t> <v><RB>))
$VSTEM-ir-it$ = $VS-iC-rA$ || ([#Lsym#]* <caus_it> <v><RB>)
$VSTEM-ir-ir$ = $VS-iC-rA$ || ([#Lsym#]* <caus_ir> <v><RB>)
$VSTEM-ir-ar$ = $VS-iC-rA$ || ([#Lsym#]* <caus_ar> <v><RB>)
$VSTEM-ir-art$ = $VS-iC-rA$ || ([#Lsym#]* <caus_art> <v><RB>)

%some summary variables for convenience

$VSTEM-Aor_ar$ =  $VSTEM-ar-X$ \
                | $VSTEM-ar-dir$ \
                | $VSTEM-ar-t$ \
                | $VSTEM-ar-it$ \
                | $VSTEM-ar-ir$ \
                | $VSTEM-ar-ar$ \
                | $VSTEM-ar-art$
$VSTEM-Aor_ir$ = $VSTEM-ir-X$ \
                | $VSTEM-ir-dir$ \
                | $VSTEM-ir-t$ \
                | $VSTEM-ir-it$ \
                | $VSTEM-ir-ir$ \
                | $VSTEM-ir-ar$ \
                | $VSTEM-ir-art$


%%%%% Causative attached to root forms
% VSTEM-Caus variables are different types of lexical stems (mostly
% roots) that take different causative suffixes.
% 

$VSTEM-Caus_none$ = $VSTEM-ir-X$ | $VSTEM-ar-X$ 
$VSTEM-Caus_dir$ = $VSTEM-ir-dir$ | $VSTEM-ar-dir$ 
$VSTEM-Caus_t$ = $VSTEM-ir-t$ | $VSTEM-ar-t$ 
$VSTEM-Caus_it$ = $VSTEM-ir-it$ | $VSTEM-ar-it$ 
$VSTEM-Caus_ir$ = $VSTEM-ir-ir$ | $VSTEM-ar-ir$ 
$VSTEM-Caus_ar$ = $VSTEM-ir-ar$ | $VSTEM-ar-ar$ 
$VSTEM-Caus_art$ = $VSTEM-ir-art$ | $VSTEM-ar-art$ 

$VSTEM_all$ = $VSTEM-Aor_ar$ | $VSTEM-Aor_ir$

$VSTEM-Caus+dir$ = $VSTEM-Caus_t$ $caus_t$    \
                  | $VSTEM-Caus_it$ $caus_It$  \
                  | $VSTEM-Caus_art$ $caus_Art$


$VSTEM-Caus+t$ = $VSTEM-Caus_dir$ $caus_dir$ \
                | $VSTEM-Caus_ir$ $caus_Ir$  \
                | $VSTEM-Caus_ar$ $caus_Ar$

$T_causdirloop$ = $caus_dir$ ($caus_t$ $caus_dir$)* $caus_t$?
$T_caustloop$ = $caus_t$ ($caus_dir$ $caus_t$)* $caus_dir$?

$CAUS$ = $VSTEM-Caus+t$    $T_caustloop$*   |\
         $VSTEM-Caus+dir$  $T_causdirloop$*


%%%%% Aorist attached to root forms
%  these are simpler than causatives, nevertheless they are irregular
%  and we'll have more fun with negative below.
%

$AOR-Stem$ = $VSTEM-Aor_ir$ $t_aor_ir$ |\
             $VSTEM-Aor_ar$ $t_aor_ar$

% some variables for notational convenience
% 
%

$T_neg$ = (($able_ya$ $neg$)|$neg$)


%%%%%%%%%% copular combinations

$T_cplDI$ = $cpl_di$ $p_g1$ $cpl_sa$?  |\
            $p1_3p$ $cpl_di$ $cpl_sa$? |\
            $cpl_di$ $cpl_sa$ $p1_3p$ 

$T_cplMIS$ = $cpl_mis$ $p_g2$ $cpl_sa$?  |\
             $p1_3p$ $cpl_mis$ $cpl_sa$? |\
             $cpl_mis$ $cpl_sa$ $p1_3p$ 

$T_cplSA$ = $cpl_sa$ $p_g1$ $cpl_di$?  |\
            $p1_3p$ $cpl_sa$ $cpl_di$? |\
            $cpl_sa$ $cpl_di$ $p1_3p$ 

% -(y)ken is a somewhat special case, it only combines with 3rd person
% forms and produces adverbs
$T_cplKEN$ = ($p1_3s$ | $p1_3p$) $cpl_ken$

$T_cpl$ = $T_cplSA$ | $T_cplMIS$ | $T_cplDI$ | $T_cplKEN$

%%%%%%%%% tenses including person markers and possible suffixes that
% come after.

% The tense group1 can be followed by $dir$ or all copular suffixes
$T_tense1$ = $tense_g1$ ( $p_g2$  $dir$? |\
                          $T_cpl$ \
                        )

% past tense can be followed by cond. or past copula. we have
% additional exception that person suffix may preceed the copular
% suffixes.
$T_tenseDI$ = $t_di$ ( $p_g1$ ( $cpl_di$ $cpl_sa$? |\
                                $cpl_sa$ $cpl_di$? \
                              )? |\
                        $T_cplSA$ |\
                        $T_cplDI$ \
                     )
% -sA can be followed by past or evdential copula
$T_tenseSA$ = $t_sa$ ( $p_g1$ |\
                       $T_cplDI$ |\
                       $T_cplMIS$ \
                     )

% optative -yA can be followed by past or evdential copula
$T_tenseYA$ = $t_ya$ ( $p_g3$ |\
                       $T_cplDI$ |\
                       $T_cplMIS$ \
                     )

% imperative do not take any other suffix than person markers
$T_tenseIMP$ = $t_imp$ $p_g4$

$T_tense$ = $T_tense1$ | $T_tenseDI$ | $T_tenseSA$ | $T_tenseYA$ | $T_tenseIMP$

% all stems with possible application of cuasative
$T_CAUS$ = $VSTEM_all$|$CAUS$

% all stems with possible causative and passive 
$T_VOICE$ = ($VSTEM_all$|$CAUS$) $passive$? 

% After a compound verb suffix, we can go back and add voice suffixes.
% as in `yapıverdirdi', or `yapabilindi'.
% The following allows going back to causative. It may be ok to go
% back to verb root as well.
% G&K claims that this is only possible after -Iver, but I see no
% problem with the examples like `yapabilindi' donakalındı.
$T_comploop$ = ($comp$ ($T_causdirloop$* $passive$?  $T_neg$?)?)

% T_compl2 is a replacement that is not active yet. $Tcomploop$ 
% accepts words like "gelebilmez", the one below should fix it, but
% needs careful check at each point where T_comploop is used.
%

% optional series with causative loop, passive and negative
$T_clpn1$ = $T_causdirloop$* $passive$? $T_neg$?
% the same with the restriction that at least one of caus loop or passive
$T_clpn2$ =  $T_causdirloop$+ $passive$? $T_neg$? \
           | $T_causdirloop$* $passive$ $T_neg$?

$T_compl2$ = ($comp-able$ $T_causdirloop$? $passive$? $T_neg$?) |\
             ($able$ ( ($T_causdirloop$ $passive$? $T_neg$?) \
                     | ($T_causdirloop$? $passive$ $T_neg$?) \
                     | ($T_causdirloop$? $passive$?) \
                     )\
             )

% alternative, less readalble (TODO: check the equivalence of these):
%

$T_compl2x$ = ( ($able$ ($T_clpn2$ $able$)* $T_clpn2$)? \
                 $comp-able$ $T_clpn1$ \
              )* \
              (  ($able$ ($T_clpn2$ $able$)* $T_clpn2$)? $comp-able$ \
               | $able$ ($T_clpn2$ $able$)* $T_clpn2$? \
              )?
              

% almost the same loop, except that it is impoosible to read, this
% makes sure that it ends with negative

$T_clp1$ = $T_causdirloop$* $passive$?
$T_clp2$ = ($T_causdirloop$* $passive$ | $T_causdirloop$+) 
$T_clpna$ = $T_clp2$ $T_neg$?  $able$

$T_compl2p$ = ($T_neg$ $able$ $T_clpna$* $T_clp2$ $T_neg$? \
                            $comp-able$ $T_clp1$ \
              |($able$ $T_clpna$* $T_clp2$ $T_neg$?)? $comp-able$ $T_clp1$ \
              )* \
              $T_neg$ ($T_neg$ $able$ $T_clpna$* $T_clp2$ $T_neg$)?

% this time we try to make sure that we do not end with negative
$T_compl2n$ =  ($T_neg$? $comp-able$ $T_clp1$)* $T_neg$? \
              (($able$ $T_clpna$* $T_clp2$?)? $comp-able$ \
               |$able$ $T_clpna$* $T_clp2$?  \
              )

$T_NEG$ = $T_VOICE$ $T_neg$

% if we do not have aorist, we do not care about the stem
% irregularities (causative stem irreg. are covered above).
%
% note: G&K states that -iver cannot combine with -mekte, but the
%       following combines it. combination may generally be semantically odd,
%       but in general i see nothing against, e.g.,  'yapıvermekte'.
% 

%$FIN_V$ = $T_CAUS$ $passive$? $T_neg$? $T_compl2$* $T_tense$

% First line has no causative
% Second and third lines process stems with a causative suffix
$FIN_V$ = ( $VSTEM_all$ \
           | $VSTEM-Caus+t$ $T_caustloop$* \
           | $VSTEM-Caus+dir$ $T_causdirloop$* \
           ) $passive$? $T_neg$? $T_compl2$*  $T_tense$
     
%%%%%  fun with aorist:

% The first one is the simple case, no loop.
% The lines 2--3 try to make sure that the aorist is not attched to
% the stem or the negative suffix
%    first expression has a causative suffix, so what follows is
%    optional as long as we do not have negative, otherwise we make
%    sure that the loop around compounding end with a suffix other
%    than negative.
%    second expression is similar, except it considers cases where we
%    have passive before the possible negative marker or not.

$AOR-pos$ = $AOR-Stem$  |\
            ( $VSTEM_all$ ($passive$ \
                          |$passive$? $T_neg$? $comp$ \
                          ) \
            | ( $VSTEM-Caus+t$ $T_caustloop$* \
              | $VSTEM-Caus+dir$ $T_causdirloop$* \
              ) $passive$?  ($T_neg$? $comp$)? \
            ) $t_aor_ir$  

% the following is a more correct/complete implementation, but needs
% some debugging.
%$AOR-pos$ = $AOR-Stem$  |\
%            ( $VSTEM_all$ |\
%              $VSTEM-Caus+t$ $T_caustloop$* |\
%              $VSTEM-Caus+dir$ $T_causdirloop$* \
%            ) $passive$? $T_compl2p$* $t_aor_ir$  
%

$FIN_V$ = $FIN_V$ | $AOR-pos$ ($p_g2$|$T_cpl$) 

% negative aorist forms:
%
% aorist after negative form is is either a -z, or is not realized at
% all if immediately followed by a 1st person sg or pl marker.
%
$aor_neg_p1$ = $p1_1s$ | $p2_1p$ 
$aor_neg_p23$ =  $p2_2s$ | $p2_3s$ | $p2_2p$ | $p2_3p$

$AOR-neg0$ = $T_VOICE$ ($T_neg$ | ($T_compl2$* $T_neg$)) \
                        $t_aor_null$ 
$AOR-neg1$ = $T_VOICE$ ($T_neg$ | ($T_compl2$* $T_neg$)) \
                        $t_aor_z$ 

% the following is a mor complete implementation, but needs some
% debugging
%$AOR-neg0$ = ( $VSTEM_all$ |\
%               $VSTEM-Caus+t$ $T_caustloop$* |\
%               $VSTEM-Caus+dir$ $T_causdirloop$* \
%             ) $passive$? $T_compl2n$* $t_aor_null$  
%
%$AOR-neg1$ = ( $VSTEM_all$ |\
%               $VSTEM-Caus+t$ $T_caustloop$* |\
%               $VSTEM-Caus+dir$ $T_causdirloop$* \
%             ) $passive$? $T_compl2n$*  $t_aor_z$  

$FIN_V$ = $FIN_V$ |\
          $AOR-neg0$ $aor_neg_p1$ |\
          $AOR-neg1$ ($aor_neg_p23$|$T_cpl$)


% put all aorist forms together. this will be used for a trick to form
% some of the converbials.
$AOR$ =  $AOR-pos$  ($p_g2$|$T_cpl$) \
       | $AOR-neg0$ $aor_neg_p1$ \
       | $AOR-neg1$ ($aor_neg_p23$|$T_cpl$)
        
%%%%%%%%%% end of aorist forms 

$VERB$ = $FIN_V$

%%%%% non-finite verb forms:

% nominal inflections without plural
% FIXME: loop after -ki may include plural
$POSS-plu$ = $poss12$ | $poss3$
$CASE1-plu$ = $case1$ |\
              $poss12$ $case1$ |\
              $poss3$ $case1p3$
$CASE2-plu$ = $case2$ |\
              $poss12$ $case2$ |\
              $poss3$ $case2p3$
$CASE-plu$    = $CASE1-plu$ | $CASE2-plu$
$INFL_c1-plu$ = $POSS-plu$ | $CASE2-plu$
$NINFL-plu$ = (($CASE1-plu$ $ki$)* $INFL_c1-plu$?) | \
           ($CASE1-plu$ ($ki$ $CASE1-plu$)*)


% verbal nouns
% TODO: double check if -mak combines with ki
% TODO: these still require some work, especially if we want to know
%       the POS transitions

$T_vn$ = $vn_dik$ $NINFL-plu$? |\
         $vn_acak$ $NINFL$? |\
         $vn_ma$ $NINFL$? |\
         $vn_yis$ $NINFL$? |\
         $vn_mak$ ( $case1$ $ki$? |\
                    $case2$ \
                  )?

$T_part$ = $part_dik$ $NINFL$? |\
           $part_acak$ $NINFL$? |\
           $part_yan$ $NINFL$?

%%%%%%%%%%% converb formations
%
% these are very selective 
%
%



% -dik and -acak combine only with a limited set of nominal morphemes
% to form converbs
%
% TODO: better analysis for  -<C><A>/-s<I>z/-s<A>
%

$T_cv$ = $cv_dik$ ( ($p3s$ ($loc3$|$abl3$|$acc3$|$dat3$)?) |\
                     $abl$ |\
                     <D_ca>:{<C><A>} <MB>\
                   ) |\
        $cv_acak$ (($p3s$ ($abl3$|$dat3$)?)?)? |\
        $cv_mak$ ( $ins$ |\
                  <D_siz>:{s<I>z} <MB> $gen$ |\
                  $abl$ (<D_sa>:{s<A>})? \
                 )? |\
        $cv_ma$ (($p3s$ ($abl3$|$dat3$)?)?) |\
        $cv_ince$ $dat$? |\
        $cv_erek$ $abl$? |\
        $cv_eli$ |\
        $cv_ecek$ |\
        $cv_mis$ |\
        $cv_iyor$ |\
        $cv_ip$



% these combine with negative only (G&K documents these as combined
% morphemes -mazdan -madan).
$T_cv_neg$ =  $cv_dan$ | $cv_zdan$ 

%this one comes after A/Ir and mIş:
$T_cv_cesine$  = $cv_cesine$

$VN$ = $T_VOICE$ $T_neg$? $T_compl2$* $T_vn$

$PART$ = $T_VOICE$ $T_neg$? $T_compl2$* $T_part$

$CV$ = $T_VOICE$ $T_neg$? $T_compl2$* $T_cv$ |\
       $T_VOICE$ $T_neg$? ($T_compl2$+ $T_neg$)? $T_cv_neg$ |\
       ($AOR-pos$|$AOR-neg1$) $cpl_mis$? $T_cv_cesine$ |\
       $T_VOICE$ $T_neg$? $T_compl2$* $tense_g1$? $cpl_mis$ $cv_cesine$ 

% the converbial marker (I/A)r  behaves exactly same as aorist.
% instead of replicating the whole aorist construction here, we will
% give a free pass for aorist form without further suffixes added to
% become a CV
%

%$CV_IR$  = ($AOR-pos$ | $AOR-neg1$) (<cv>:<> <MB>)
%
%$CV$ = $CV$ | \
%       $CV_IR$

%$CV$ = $CV$ | ($AOR-pos$ | $AOR-neg1$) (<cv>:<> <MB>)



% FIXME: following list (at least so_cv) overgenerates (e.g.  gelmişince)
$NONFIN_V$ = $VN$ | $PART$ | $CV$

%%%%%%%%%%%%%%%%%%%%%%%% End of verbal Morphotactics %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% some postpositions can get nominal inflections, some can't
%%%%%%%%%%%%%%%%%%%%%%%%%%

$PSTEM$ = $PSTEM$
$PISTEM$ = $PISTEM$ $NINFL$

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                      FST for verbal/nominal mix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% nominal predicates 
%
% TODO: check!
$NP$ = ($PSTEM$ | $NOUN$ | $VN$ |$PART$) \
                        ( $p_g2$ $dir$? |\
                         $dir$ $p2_3p$ |\
                         $T_cpl$ |\
                         $cpl_mis$ $p_g2$ $cv_cesine$ )

%$NV$ = $NP$ | ($NOUN$|$VN$) $dir$

% combine them all and apply the phonological rules.
%

% -yIcI (V->J) derivation seems to be common after causative here we
% only allow derivation to adjectives, further derivations may be
% possible (araştır-ıcı-lık) but for these cases the stems are likely
% to be lexicalized. 

$D_yIcI$ = <Dvn_yIcI>:{<bY><I>c<I>}

$ADJECTIVE$ = $ADJECTIVE$  \
              | $CAUS$ $D_yIcI$ <adj><MB>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%            FST for some clitics and the like
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mI does not get the 3p suffix
$p_g2-3p$ = $p2_1s$ | $p2_2s$ | $p2_3s$ | $p2_1p$ | $p2_2p$ 

$MI$ = $mi$ ( $p_g2-3p$ $dir$? |\
               $dir$ $p2_3p$ |\
               $cpl_di$ $p_g1$ |\
               $cpl_mis$ $p_g2$ \
            )
$CLITIC$ = $MI$

% i- is always bound. idi, imis, iken
% TODO: this version may be overgenerating.
$I$ = $I$ $T_cpl$

$CLITIC$ = $CLITIC$ | $I$

% var/yok/degil is treated specially. TODO: there should be a cleaner
% way.
$VYD$ = $vyd$ ( $p_g2$ $dir$? |\
                $dir$ $p2_3p$ |\
                      $T_cpl$ |\
    $cpl_mis$ $p_g2$ $cv_cesine$ )

% TODO: these are not clitics.
$CLITIC$ = $CLITIC$ | $VYD$

%%%% punctuation marks
%
$PUNCT$ = $punct$

$PUNCT$ >> "punct.a"


%%%%%%%%%%%%% done

$WORD$ = $NOUN$      |\
         $NP$        |\
         $VERB$      |\
         $NONFIN_V$  |\
         $ADVERB$    |\
         $ADJECTIVE$ |\
         $CSTEM$     |\
%         $RSTEM$     |\
         $XSTEM$     |\
         $PSTEM$     |\
         $MSTEM$     |\
         $DSTEM$     |\
         $MISC$      |\
         $PUNCT$     |\
         $CLITIC$    |\
         "<version.a>"


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


$afilter$ = ($deltempsym$  | $swap$)*

$afilter$ || <BoW> $WORD$ <EoW> || "<phon/phon.a>"
