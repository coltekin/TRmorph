#C# = bcçdfgğhjklmnpqrsştvwxyz
#C_v# =  bdcgvzjfğlmnrwy
#C_uv# = ptçkfsşh
#C_Buff# = <bY><bS><bSS><bN>
#C_xx# = <c><p><t><k><g><K><D><C>
#C_all# = #C##C_xx##C_Buff#

#V# = aeıioöuü
#V_f# = eiöü
#V_b# = aıou
#V_h# = iüıu
#V_l# = eöao
#V_br# = ou
#V_fr# = öü
#V_bu# = aı
#V_fu# = ei
#V_Buff# = <bI><bA>
#V_Pal# = <pA><pI><pO><pU>
#V_xx# = <A><I><e>
#V_all# = #V##V_xx##V_Pal##V_Buff#

% POS tags
%#pos# = <Adj><Adv><Noun><Prop><Pron><Postp><Interj><Conj><Verb><Num><Punct>
#pos# = <adj><adv><n><np><prn><postp><ij><cnj><v><vaux><num><pnct>
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
         <t_narr><t_past><t_fut><t_cont><t_aor><t_makta><t_obl><t_opt><t_cond>\
         <cpl_di><cpl_mis><cpl_sa><cpl_ken>\
         <1s><2s><2sf><3s><1p><2p><3p>\
         <VN_dik><VN_acak><VN_ma><VN_mak><VN_yis>\
         <part_dik><part_acak><part_yan>\
         <cv_acak><cv_cesine><cv_dan><cv_dik><cv_ecek><cv_eli>\
         <cv_erek><cv_ince><cv_inceye><cv_ip><cv_ir><cv_iyor>\
         <cv_ken><cv_ma><cv_mak><cv_mis><cv_zdan>\
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
#Ssym# = #C##V##Digit##Punct##Perc##Nsep##Apos#

% special symbols that mark exceptions in the lexicon
% By default, LEsymS are the symbols that are removed from the analyses. 
% The others are replaced with the corresponding surface symbol.

#LEsymS# = #infl_feat#<compn><del><dels><dup><yn>
#LEsym# = #LEsymS##C_xx##V_xx##V_Pal#

% All lexical symbos:

#Lsym# = #Ssym##LEsym#

%
% Only the symbols that appear in analysis strings. (this excludes
% the intermediate symbols like morpheme boundaries,)
%

#Asym# = #Ssym##pos##deriv##infl#

%
% All analysis symbols, including the intermediate ones.
%

#AAsym# = #Asym##BM##TMP#

