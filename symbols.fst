#C# = bcçdfgğhjklmnpqrsştvwxyzBCÇDFGĞHJKLMNPQRSŞTVWXYZ
#C_v# =  bdcgvzjfğlmnrwyBDCGVZJFĞLMNRWY
#C_uv# = ptçkfsşhPTÇKFSŞH
#C_Buff# = <bY><bS><bSS><bN>
#C_xx# = <c><p><t><k><g><K><D><C>
#C_all# = #C##C_xx##C_Buff#

#V# = aeıioöuüAEIİOÖUÜ
#V_f# = eiöüEİÖÜ
#V_b# = aıouAIOU
#V_h# = iüıuİÜIU
#V_l# = eöaoEÖAO
#V_br# = ouOU
#V_fr# = öüÖÜ
#V_bu# = aıAI
#V_fu# = eiEİ
#V_Buff# = <bI><bA>
#V_Pal# = <pA><pI><pO><pU>
#V_xx# = <A><I><e>
#V_all# = #V##V_xx##V_Pal##V_Buff#

% POS tags
%#pos# = <Adj><Adv><Noun><Prop><Pron><Postp><Interj><Conj><Verb><Num><Punct>
#pos# = <adj><adv><n><np><prn><postp><ij><cnjcoo><cnjsub><cnjadv><v><vaux><num><det><pnct><exist><nexist><not><q>
#subcat# = <persp><demp><locp><qp>
#BM#  = <RB><MB>    % Boundary markers

% other intermediate symbols (this should probalby contain
% <K><D><C><A><I>, we assume they may appear in lexicon for some
% reason)

#TMP# = <LN><BoW><EoW>

#Digit# = 0123456789
#Perc# = \%
#Nsep# = \.\, 
#Apos# = \'
#Punct# = \.\?\!\:\,\;

#Spc# = \ \

% types of cuasative markers, some of them are lexicalzed
%
% note that the lexical markers for reflexive and reciprocal is
% different than the corresponding analysis symbols.
%
#caus_types# = <caus_dir><caus_t><caus_it><caus_ir><caus_ar><caus_art><caus_irreg>
#aor_types# = <aor_ir><aor_ar>
#refl# = <rfl>
#recp# = <rcp>

#infl_feat# = #caus_types##aor_types##refl##recp#


% all possible character in the lexicon (??)
#lex_char# = #C##V##V_Pal#

% analysis symbols for derivational suffixes

#deriv# = <D_AcIK><D_CA><D_CAK><D_CAgIz><D_CI><D_CIK><D_IcIK>\
          <D_IncI><D_ca><D_cil><D_gil><D_lA><D_lAn><D_lAs><D_lI>\
          <D_lIK><D_mA><D_mAdIK><D_sAl><D_sAr><D_sa><D_siz><D_yIS>\
          <Dan_0><Djn_0><Dmn_0><Dnn_siz><Dvn_yIcI>

% analysis symbols for inflectional suffixes
#infl# = <ref><rec><caus><pass>\
         <abil><iver><adur><agel><agor><akal><akoy><ayaz>\
         <neg> \
         <t_narr><t_past><t_fut><t_cont><t_aor>\
         <t_imp><t_makta><t_obl><t_opt><t_cond>\
         <cpl_di><cpl_mis><cpl_sa><cpl_ken>\
         <1s><2s><2sf><3s><1p><2p><3p>\
         <vn_dik><vn_acak><vn_ma><vn_mak><vn_yis>\
         <part_dik><part_acak><part_yan>\
         <cv>\
         <dir>\
         <pl>\
         <p1s><p2s><p3s><p1p><p2p><p3p>\
         <loc><gen><acc><abl><dat><ins>\
         <ki>\
         <ca>\
         <apos>

%%%%% some character classes that are helpful

% surface symbols
#Ssym# = #C##V##Digit##Punct##Perc##Nsep##Apos##Spc#

% special symbols that mark exceptions in the lexicon
% By default, LEsymS are the symbols that are removed from the analyses. 
% The others are replaced with the corresponding surface symbol.

#LEsymS# = #infl_feat#<compn><del><dels><dup><yn>
#LEsym# = #LEsymS##C_xx##V_xx##V_Pal##Spc#

% All lexical symbos:

#Lsym# = #Ssym##LEsym##subcat# 

%
% Only the symbols that appear in analysis strings. (this excludes
% the intermediate symbols like morpheme boundaries,)
%

#Asym# = #Ssym##pos##subcat##deriv##infl#

%
% All analysis symbols, including the intermediate ones.
%

#AAsym# = #Asym##BM##TMP#

