%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% The following is list of relatively unproductive derivational
%% morphemes. Normally, lexicon should contain the forms derived using
%% these morphems. Uncomment for cases where these derivations may be
%% useful. 
%%
%% These are (mostly) from Goksel & Kerslake (2005)
%%
%% Not throughly tested: wach out for mistakes!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

% -A: V->N: süre, yara, V->A: geçe, kala
%

$Dv_na_A$ = <D_A>:{<A>}
$DVN$ = $DVN$ | $Dv_na_A$ 
$DVA$ = $DVA$ | $Dv_na_A$ 

% -(A)C: V->N: süreç, kaldıraç, bağlaç
%
$Dv_n_AC$ = <D_AC>:{<bA><c>}
$DVN$ = $DVN$ | $Dv_n_AC$ 

% -(A)cAn: V->J: sevecen, afacan??
%
$Dv_j_AcAn$ = <D_AcAn>:{<bA>c<A>n}

$DVJ$ = $DVJ$ | $Dv_j_AcAn$ 

% -AgAn/-AğAn: V->J: olağan, durağan, gezegen

$Dv_j_AgAn$ = (<D_AgAn>:{<A>g<A>n} | <D_AgAn>:{<A>ğ<A>n})
$DVN$ = $DVN$ | $Dv_j_AgAn$ 

% -(A)K: V->N: durak elek adak kayak 
%        V->J: ürkek korkak dönek
$Dv_nj_AK$ = <D_AK>:{<bA><k>}

$DVN$ = $DVN$ | $Dv_nj_AK$ 
$DVJ$ = $DVJ$ | $Dv_nj_AK$ 

% -(A)l: V->N: okul kural
%        V->J: sanal
$Dv_nj_Al$ = <D_Al>:{<bA>l}

$DVN$ = $DVN$ | $Dv_nj_Al$ 
$DVJ$ = $DVJ$ | $Dv_nj_Al$ 

% -(A)m: V->N: kuram dönem anlam
$Dv_nj_Am$ = <D_Am>:{<bA>m}

$DVN$ = $DVN$ | $Dv_nj_Am$ 
$DVJ$ = $DVJ$ | $Dv_nj_Am$ 

% -(A)mAK: V->N: basamak kaçamak

$Dv_n_AmAK$ = <D_AmAK>:{<bA>m<A><k>}
$DVN$ = $DVN$ | $Dv_n_AmAK$ 

% -(A)nAK: V->N: tutanak ödenek görenek

$Dv_n_AnAK$ = <D_AnAK>:{<bA>n<A><k>}
$DVN$ = $DVN$ | $Dv_n_AnAK$ 

% -(A/I)r V->N: keser yarar gelir
%         V->J: çalar okuryazar
%    also V->A: görülebilir (but this is handled by allowing aorist to
%                            form converbs)
$Dv_nj_AIr$ = (<D_AIr>:{<bA>r} | <D_AIr>:{<bI>r})

$DVN$ = $DVN$ | $Dv_nj_AIr$ 
$DVJ$ = $DVJ$ | $Dv_nj_AIr$ 

% -(A)v: V->N: sınav görev türev
%
$Dv_n_Av$ = <D_Av>:{<bA>v}

$DVN$ = $DVN$ | $Dv_n_Av$ 

% -(A)y: V->N: olay deney 
%        V->J: yapay düşey
$Dv_nj_Ay$ = <D_Ay>:{<bA>y}

$DVN$ = $DVN$ | $Dv_nj_Ay$ 
$DVJ$ = $DVJ$ | $Dv_nj_Ay$ 

% -Inç/ç: V->N: direnç basınç
%         V->J: iğrenç gülünç
% TODO: the form of the suffix is predictable -<c> is adeded to verbs
%       ending with -n only.
%
$Dv_nj_InC$ = (<D_InC>:{<bI>nç} | <D_InC>:{<c>})

$DVN$ = $DVN$ | $Dv_nj_InC$ 
$DVJ$ = $DVJ$ | $Dv_nj_InC$ 

% -DI: V->N: uydu çıktı
%
$Dv_n_DI$ = <D_DI>:{<D><I>}
$DVN$ = $DVN$ | $Dv_n_DI$ 

% -DIK: V->N/J: tanıdık bildik
%
$Dv_nj_DIK$ = <D_DIK>:{<D><I><k>}
$DVN$ = $DVN$ | $Dv_nj_DIK$ 
$DVJ$ = $DVJ$ | $Dv_nj_DIK$ 

% -GA/(A)lgA: V->N: dizge süpürge çizelge
%
% NOTE: this requires another symbol <G>
$Dv_n_GA$ = (<D_GA>:{<G><I><k>}|<D_GA>:{<bA>lg<I><k>})

$DVN$ = $DVN$ | $Dv_n_GA$ 

% -GI: V->N: silgi sevgi sürgü bilgi görgü
%
$Dv_n_GI$ = <D_GI>:{<G><I>}

$DVN$ = $DVN$ | $Dv_n_GI$ 

% -(n)GIC: V->N: dalgıç başlangıç
%
$Dv_n_nGIC$ = <D_nGIC>:{<bN><G><I><c>}

$DVN$ = $DVN$ | $Dv_n_nGIC$ 

% -I: V->N: yazı güldürü batı
%     V->J: dolu duru
%
$Dv_nj_I$ = <D_I>:{<I>}

$DVN$ = $DVN$ | $Dv_nj_I$ 
$DVJ$ = $DVJ$ | $Dv_nj_I$ 

% -(I)K: V->N: konuk kayık
%        V->J: kırık soluk
%
$Dv_nj_IK$ = <D_IK>:{<I><k>}

$DVN$ = $DVN$ | $Dv_nj_IK$ 
$DVJ$ = $DVJ$ | $Dv_nj_IK$ 

% -(I)lI: V->J: yazılı sarılı
%
$Dv_j_IlI$ = <D_IlI>:{<bI>l<I>}

$DVJ$ = $DVJ$ | $Dv_j_IlI$ 

% -(I)m/(y)Im: V->N: bölüm seçim deneyim gerilim devinim
%
$Dv_n_yIm$ = (<D_yIm>:{<by><I>m}|<D_yIm>:{<bI>m})

$DVN$ = $DVN$ | $Dv_n_yIm$ 

% -(I)n: V->N: basın yayın yığın
%
$Dv_n_In$ = <D_In>:{<I>n}

$DVN$ = $DVN$ | $Dv_n_In$ 

% -(I)ntI: V->N: söylenti girinti alıntı
%
$Dv_n_IntI$ = <D_IntI>:{<I>nt<I>}

$DVN$ = $DVN$ | $Dv_n_IntI$ 

% -(I)t: V->N: geçit, yazıt, anıt, umut
%
$Dv_n_It$ = <D_It>:{<I>t}

$DVN$ = $DVN$ | $Dv_n_It$ 

% -mA
% V->N ödeme, arama, kıyma, kesme
% V->J kıyma, kesme, dökme, bunama
%
% NOTE: this one is included in the default list
$Dv_nj_mA$ = <D_mA>:{m<A>}

$DVN$ = $DVN$ | $Dv_nj_mA$
$DVJ$ = $DVJ$ | $Dv_nj_mA$

% -mAC: V->N: bulamaç yırtmaç
%
$Dv_n_mAC$ = <D_mAC>:{m<A><c>}

$DVN$ = $DVN$ | $Dv_n_mAC$ 

% -mACA: V->N: çekmece koşmaca bulmaca
%
$Dv_n_mACA$ = <D_mACA>:{m<A><c><A>}

$DVN$ = $DVN$ | $Dv_n_mACA$ 

% -mAdIK: V->J: kırmadık görmedik görülmedik 
%
% NOTE: this is in fact very productive, except some obviously
% lexicalized forms, it coincides with verbal noun constructions, and
% otherwise this derivation is not  very useful.
$Dv_j_mAdIK$ = <D_mAdIK>:{m<A>d<I><k>}

$DVN$ = $DVN$ | $Dv_n_mAdIk$ 

% -mAdIK: V->J: 
%
$Dv_j_mAdIK$ = <D_mAdIK>:{m<A>d<I><k>}

$DVN$ = $DVN$ | $Dv_n_mAdIk$ 

% -mAK: V->N: ekmek(?) çakmak yemek 
%
$Dv_n_mAK$ = <D_mAK>:{m<A><k>}

$DVN$ = $DVN$ | $Dv_n_mAK$ 

% -mAn
% V->N: öğretmen danışman eleştirmen
% V->J: şişman
% 
$Dv_nj_mAn$ = <D_mA>:{m<A>n}

$DVN$ = $DVN$ | $Dv_nj_mAn$
$DVJ$ = $DVJ$ | $Dv_nj_mAn$

% -mAz
% V->N: açmaz tükenmez 
% V->J: bitmez analşılmaz
% V->A: görülmez -- this one is identical with aorist/CV construction
% 
$Dv_nja_mAn$ = <D_mAz>:{m<A>z}

$DVN$ = $DVN$ | $Dv_nja_mAz$
$DVJ$ = $DVJ$ | $Dv_nja_mAz$
$DVA$ = $DVA$ | $Dv_nja_mAz$

% -mIK: V->N: kıymık kusmuk
%
$Dv_n_mIK$ = <D_mIK>:{m<I><k>}

$DVN$ = $DVN$ | $Dv_n_mIK$ 

% -mIş: V->N: geçmiş dolmuş ermiş
%
$Dv_n_mIS$ = <D_mIS>:{m<I>ş}

$DVN$ = $DVN$ | $Dv_n_mIS$ 

% -sAK: V->N: tutsak
%
$Dv_n_sAK$ = <D_sAK>:{s<A>k}

$DVN$ = $DVN$ | $Dv_n_sAK$ 

% -sAl: V->J: görsel işitsel
%
$Dv_j_sAl$ = <D_sAl>:{s<A>l}

$DVN$ = $DVN$ | $Dv_j_sAl$ 

% -sI: V->N: yatsı tütsü giysi
%
$Dv_n_sI$ = <D_sI>:{s<I>}

$DVN$ = $DVN$ | $Dv_n_sI$ 

% -tay: V->N: danıştay çalıştay
%
$Dv_n_tay$ = <D_tay>:{tay}

$DVN$ = $DVN$ | $Dv_n_tay$ 

% -tI: V->N: doğrultu bağırtı morartı
% 
% --- this may be relatively productive
$Dv_n_tI$ = <D_tI>:{t<I>}

$DVN$ = $DVN$ | $Dv_n_tI$ 

% -(y)AcAK: V->N: yiyecek içecek giyecek
% 
% NOTE: this also forms adjectiv(al)s which is handeled alreadyi in trmorph
$Dv_n_yAcAK$ = <D_yAcAK>:{<bY><A>c<A><k>}

$DVN$ = $DVN$ | $Dv_n_yAcAK$ 

% -(y)An: V->N: bakan sıçan
% 
$Dv_n_yAn$ = <D_yAn>:{<bY><A>n}

$DVN$ = $DVN$ | $Dv_n_yAn$ 

% -(y)AsI: V->J: gelesi gidesi kahrolası
% 
% --- this is quite productive 
$Dv_j_yAsI$ = <D_yAsI>:{<bY><A>s<I>}

$DVJ$ = $DVJ$ | $Dv_j_yAsI$ 

% -(y)AsIcA: V->J: 
% 
%  similar to above
$Dv_j_yAsIcA$ = <D_yAsIcA>:{<bY><A>s<I>c<A>}

$DVJ$ = $DVJ$ | $Dv_j_yAsIcA$ 

% -(y)AsIyA: V->J: 
%            V->A: 
% 
%  similar to above
$Dv_ja_yAsIyA$ = <D_yAsIyA>:{<bY><A>s<I>y<A>}

$DVJ$ = $DVJ$ | $Dv_ja_yAsIyA$ 
$DVA$ = $DVA$ | $Dv_ja_yAsIyA$ 


%%%%% Nest two are quite productive, and already in deriv.fst
% -CI
% N->N şekerci, N->J gerici, ?? J->J mavici
% V->N öğrenci FIXME: this happens only after `n' otherwise -yIcI, ?? V->J 
$D_ci$ = <D_CI>:{<C><I>}


$DNN$ = $DNN$ | $D_ci$
$DNJ$ = $DNJ$ | $D_ci$
$DVN$ = $D_ci$

% -(y)ICI
% V->N öğrenci (but all of these should be lexicalized)
% V->J bulaşıcı, yapıcı, kesici ...
$D_yIcI$ = <Dvn_yIcI>:{<bY><I>c<I>}

% $DVN$ = $DVN$ | $D_yIcI$
$DVJ$ = $D_yIcI$

% -(y)IS: V->N: direniş giriş yürüyüş
% 
$Dv_n_yIS$ = <D_yIS>:{<bY><I>ş}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  End of unproductive derivational morpheme list.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
