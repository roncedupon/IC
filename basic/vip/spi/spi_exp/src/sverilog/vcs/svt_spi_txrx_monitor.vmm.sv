
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV

typedef class svt_spi_txrx_monitor_callback;
typedef class svt_spi_txrx_monitor_cb_exec;

// =============================================================================
/**
 * Temporary class definition used to enable VMM based compilation of the layer.
 */
class svt_spi_txrx_monitor extends svt_xactor;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the SPI Transaction is first initiated (TX) or recognized (RX). */
  int EVENT_TRANSACTION_STARTED;

  /** Event triggered when the SPI Transaction is completed. */
  int EVENT_TRANSACTION_ENDED;
/** @endcond */

  /** Event triggered when the SPI Transaction is first initiated (TX) */
  int EVENT_TRANSACTION_STARTED_TX;

  /** Event triggered when the SPI Transaction is completed at TX */
  int EVENT_TRANSACTION_ENDED_TX;

  /** Event triggered when the SPI Transaction is first recognized (RX) */
  int EVENT_TRANSACTION_STARTED_RX;

  /** Event triggered when the SPI Transaction is completed at RX */
  int EVENT_TRANSACTION_ENDED_RX;

  /** Event triggered when one beat has been Sampled/Transmitted at SPI Interface */
  int EVENT_BEAT_ENDED;

  /** Event triggered when the POWER UP Sequence is completed . */
  int EVENT_POWER_UP_SEQUENCE_COMPLETED;

  /** Event triggered when the POWER DOWN Sequence is completed . */
  int EVENT_POWER_DOWN_SEQUENCE_COMPLETED;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  int EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */
  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Handle to an abstract common class. This class is extended in two different 
   *  classes to implement shared functions between the driver and monitor (in active mode) 
   *  or monitor only functions (in passive mode). The containing agent class will construct 
   *  the correct extended common class and assign that to this monitor.
   **/
  svt_spi_txrx_common common;

  /** Technology independent support for the Transmit-Receive features. */
  svt_spi_txrx_monitor_cb_exec cb_exec;
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

`protected
ZYQP.JKICJTN^DK1=.K[9(_4#XO+O]#b(gG,)1gELdd1/9]P/S&e&)]4GYbW:KbM
D)Xf[PcWbV2[LQN>M?MG?N<A-Y^XS2/d8Af>QOWcSNPadgf4TV)69YR@N)G7Q>OW
/[L--MK>CWGKPZPB-V@NSa846(a86X)_1O;^A&&)S];BYS3\,]2U(<FE(IUSD4Ia
(49@(S6,7IOb(:VJDXXTFH=D7+FZ4EI06JO6EOSKcO9c=6Df_3Z/]<Y&12W+TeK7
UD]/=SLY(O6fI\R0NFe;gVQ85:g-)SQb7HYN_\5fCN@FKI]e1OUeKXCP<bTN&\\R
;W/VEC<PFMKB05-?eN0H26LH;I&&fOg(0)P>_V))6Y@]Y=D+^aA)GOW-1KG]:B&:
98R\6M:3\SAVT>O=7@R<=L:E,6fUffZ21+2I\_TWSJ_XDG?Dceb6EcA#:Ia+TYIa
2EY99Og70d[T\SL.cfa^D_W2)YWa(T#J0R9.,3QZ:#951(f2bg#UeE:VY^FJa8a8
J-_E91>M9Ngca.WJSJaQ0.7>BX0F+0[41,Z^>8N7c4U03-;J#37-8;cPLVJg5Y=S
HEg1\bYC+]cT)g([3>Da+Q+([.MEFER^dbY^=JJD)SBdL;RSf7E5Vc1Y?TS:[T@O
W.T-1ZQU:Yfa&4[G\3PVDC7FPR9/6WYAO/XUQ6JWB@Z_/Ag&dEQ#_QE/9Sc>>dgC
/-PdDeM\<@7(:7\#6N19.7?.3].16NG6>(U.4]b5[4[ZU+b0(c#?FI0LQ<ZB9aDYW$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_observed_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_observed_cov(svt_spi_transaction xact);

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_observed_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_observed_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * This method issues the <i>transaction_observed_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_observed_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX..
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX..
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

/** @endcond */

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
.KU;<V\BObFI(WNH-4IRQLcTK8d,KaL#9-=[V[_T\@[A;P[(cZ__))Z_9Oe?^9I9
1[&6U-f+=UeZA)87b32#WKNa<SdJJYJJ=&;OCR-)BIbUAa:]eedAGZdcLYcBg/gC
14M2-.3],+Q(2>dYPJVZHV0A@,^=P91X9(b<ANa^KLdJW>,^,;>,a\:.:O[Pa/5#
cTYR)\0@AgBL7E3BGZK#1(R5J7)CR.#-N,8CeH>GC@b/-,_G<@HHL:=-<&Q:X[FOQ$
`endprotected


//vcs_lic_vip_protect
`protected
Y8bJcOXD2N,-ASHd,@#JaTCa3I)d<Z1V;PXRKf)2A8Gg>01JG=FS3(HW17_P(YK,
0<:<Y/OS&cR^QC_ac4+J;TgN#P)2WPV;bb[L\C5\5<<E)?Zb,YAa2Q\Q<-[8&fPR
RB3_Q/0@B4R/JGg7_&3U;b))JfN3T_]4\([K3<HC1e-R\#H3EYcGW2B6UgZHWVYH
V5e7(,?G-9@Q@RLS#G/eSP]+&e6B[EDcDY)P^2TfReER\d4I:;[/-VYW/gJ;?=f1
ZJEOgOKE@HBG+I?JF;68K5X<\;_)#C(.:SP.D2QUH:(N8\NJK(-,;cML&[LNgR0@
,MWW\O>](+P&^TTDQRZ[Y(g<H)#NA1=C0?+;HJ;b:K;W3^7aW?5OB_c4Y1CW4-FT
3G;(.?J?(+Q<>6)<I:5&L80C\-L(9Fd4EWc9D\5UdCS9.^102/U67T^e;1,O9OYD
MLV23Y?1d=aN;P?W_cT7I\CSd(_cP):c,O9.U=fTWc8+<&8QX^1fQ:_IGZ#eC[c&
F(CgAeW:,RX/&+W(CeKM>;/]-\2\#CMV]11b@8PO,NLdc@1DMC_NKI6Cf\=8&G0]
X/I[a9^<)R0fQdAWgJ2<1#>d2\]6OI\C]]NbF.>\+\LD,S@6\,YGI^>c(1d-[XB-
E?13M/<\=&L;?)S0F<WR/<.)<<=BV_#=-H2S[/N(BZ-YS1AMGJAN&bVJ[P>5VG#R
=,LY()XM:#=eQGH@T<aJ/#GL(KM7QR.La&A6)7C0I:Qeg_?eI47ZL^R4[&]4N.(M
>75/,c.KLeV@IGUVZPbWN>@KA:1TU]9IQfe;L0RP:J98FT#P^\20b\H<601=@Jf9
UgVO:Wa5<&@C;Lb60]#X+Y44^N)E3TID,MJ,QO_C8^)__\;aH;7.gd<IIBY9bF>R
G^I\A@f?,E_H9]:@&CSTDL/8+@E0]6SLDJ(M>Q>2>Z<R\7<I8WdcZRO,12=]3LSa
]adSfbfaK:E]?dS8U#<GAL1;DT7K5FR_f5J^7,A1VA8X6^P(WFO=Hc5S,+JXAcX?
4&;NBWcf?GGBX]_2_[A;VAU9R2dZIA5ZVV;ZdcSOBfbATGBO?ML7MIcE.4X\S;IL
](?MbM?g6;L@d:?TQf-,Z+M0\40)[?de8TGbFJ&K3SaK(?_;KdL+LF8BdeBVO)(=
U#<CILJYSNV1SLKAD.0+ELQE-2K6XQIJ7;>UP7[4LX:]:,X\X2@+R[#I&J<J9X[I
>;26NKM4_./EWBNe,Q,_?6OA<gB(^#?<J6[DIZ\Y\G?>gdU8Z[SAU&fDC/S&3bY\
CU\^B-\A.1gYS_5&<A(#HZ-0W:A2Z,eP>])c@XR\.&8GN=+UTZCGfb[2[^.)A-Ef
cU1HW+ce9^_CF0N2Xc-P7R)/<R+K-<)P/\+>Q<FVH+SBH3?)^04K,^^BB6/Y<#:)
gA+5]b1Y;ZOJE=?FND)Rd[HR(A9U_Ie]g6WO(TaR,L6\2FOFXUO[1:,+,JJ91.FT
0F#/6E9D0,#-I<I6&E3f/(Td0VUff2@M+1XCKCKYHFD.I40,1;4N1VF,(O-I\7:g
;FVCP6AT0/+b_+DS#.AR?NIY4d\e53=\=;5VGgJ>V-JK<Y4JdFaf:K(,dENG<;4g
Y]QW\67Q^.b6AH>fEJJ(7P7H-0&5RX#[?B8=cYK6CGPICL8E&L:6T/TE[,LZUA&W
UQUY9:4HG6&3IJ,0YQZ(DENMU_76WI&1N)TXa<KeeARB53XU4?-AdbN1HKNUESMH
XNgGKG._E,b&e)Q+\a+_QLfB[?F)SA-IT)=Z9P<.^9W=gN3OFHd2=W1c0#I^Z=-b
1T45G2?G/A7X&.f@K#L5D#CT,\3E=e@<MU&/bWcI>T<45Z.ca#3DbE7&I1;P&X)C
LIHXbGK]F@7-O]cI.B1V(5R2.R@Y/KFUP6+J#=S3gB\LT77AR2TT??2V1GYK1LZW
HFS7X>Ge\VbOE4aUc3g7&&EW&IG=f3NVFXf^IKL;41JMF73?2@#Hb-Ad-df??a^@
#874CFP^M>DWbC/3\,Xeeg)TK)@Pe,>WBZ)P9-cDPH\^d,(.C(ACQX]b9,#TZN=e
1UVOdU3-UU50c>g<W]2H+S6Ng\_Vd#RgGbFCMe_ETDfg/?.T=,]2ZLGZA[-L9\BT
fcI#Xb54L.=Y1^:Fb0V)&U-,@]>a@ADacSH:C+]=.O[.@SJcHSL.5:PQ7(M+W#OO
N3<#M2a,f,?:;^90@b;PgfG)O95MRg2S>?[;eeA-IA;,:PDH0fKR]cUELB3MGG4Y
;K?M[Wb@T0cITc_YH:/WIX-@PRM(<O/A:-\T<Q_MeIf)[]/5^X@eAQa=5-O[YdgS
^KO_-8g.TZ0JGgNT:L-UI]#dMX@)4BEPe3Z7\^Q2(CZ\WdKa2IP/\/8_NVT#Y@89
JZV077cVgRHY1NG<1S-4[F&[e+5DSC+-QB0\M;9BLS/8&Y+KRE/2K1Eb)YRa6)[9
+7@@;Lda#?886TJ3+UafPPU]IUJLX&+:Kd<>B/47]-,gH85T,6aAD&X>bY<:J:SN
9E[N<5DBI-V&I<?I22MYF/f5gR7?b(D@+;e+^7Q301<M)ZMdf@]^f)OL>JIMTc=C
1aL4-TU(3-3R^[NK-gc-N2/c)Fg7+[Z<^/NdI5;5?RacT47IY]F15SY.IbC5U@-7
S\L;M2C>3?AVLH7cK)3JO(<ALX6;OeY0^JJeZ;dLGa_P.?CCYL5IWQO&^GO.e@HW
&/E/RZ:EM5gA)-&c;33,EbX@S;XRM0^7aM+;-W25OXWF1S3B);gP#>aU<<L23B;#
?N-+@8DXHV5B>.E[NGb=a&EVg^be014A5GcMJb.0&5aV;.8^ZOI0a(L<VdAJ(G,V
JDN+b4a>2-S2L#S4X@f2Nd>Wb=d6W^)+\;I?<DP@@>WS5A^f+FP(A<9W#XI<>8OT
V>gLgfb2QLTVECPUZ),\A316)db89JZYNHL&48YD1=(I_b)SG/.eR&fG<J-PLLUP
N5;&.c&.7.O82(6(^Q4ML7Mb3]::0P+KAK3CLUT+BH_?)P:@M/FZTe7af4V+1LN+
Aa.aU02F;G2/Z1H;8\A+ZER&#]:ScV4),Og#5B,J7PAbG;KRHRB,(0K>1Z_b::X?
Bd425BXSGdTOV)-\V;O@9-NgB8M&?bX><ffT4\)Z3bY[.gW;X>S0X@.^2[,P/MW,
CNPQ(4NgO&&@CB<X^UZ;RfX])4(REV=FK6+LO(RHeDMB9G8S(&KZ_6B7GMP14d,W
\6bd[IFP8&#McJCfbY1c<eZK(b[b)J1L5Q=)4@QI)_Ie,9M<TGF[ZUO@)4ge&4_R
f8Q4G;OSKM#5D@[&&Be^V2_7FY)3T=:?QAP_b]W8<7Q8b><N(BHH6-_M@B[X8+UC
5>#E-]Z,9P_^T=>>@?:\Fe-ee0-g_JE<Y7J0E<K7Hd275/NMV&:W/Q9e)a9Q03),
=LTG8YF\Y[AN&QMHdP4\\2G[9G5WEY_R1+5]Q^=M;aLYe5D[L^</7VG]KS0=+/6&
^E7)W63]\6=/DedbEPG_IP^b3N@g,+8&@104BQ\W_e1)OCX7@G>I+#-W[\30GKb0
C\&beC+7.:OSN+PX?5[02VRaO_E=TYHR_<fc&/)N+OS-+,?9:Q8Y9;:>-ZgJ)7_f
X[1E9.X/M(89I]AQQCC0?9U?ebCaJHGGFPgbgC<BR<e3_f/);DX]M2-T]/XQDfGZ
_-&c/2?]@Z@UQS=N54_4V)<VD/9\4YCEGL[UKKIa8U2f^7G#Ce^X@7B<NTe,beDC
dcH#f1KT^X(&C_OWZ6]TXAc0EDG;J<9b33V-BFgcAV-E7RSB^PZ_\:d][>M28N_/
#-O1/C#M[D?)d<DA;=(Ag.O8J6eZYU2>/1F.B>\KW]^MW&eD6&6]4VQX-/M.>/(;
c:#SFSf7C0TFeP]Y6IG32:cQBFS;d3Ub6d;A7.4?VC7TG(2+T.8;,,IFbQY]G4>U
S4H6LH10N<Zb0A5)8;]=c7bXC2],^@Xc(EO:g/=8\V1:A.YX==B4Y=IG16PX5d]d
>^5Abgb94>C(R)NC(A0a/g/0H.1D]XVd/FGdGP?KbFH<8b=Vg\MG^b7_76+QY_?Q
18RGa2K/^S^2H:X/.@;(:]=;Cd=b,IG_Ka&=UU,-R,:#[[Y.7O,SZSH2#A6b:^D1
C5RQ]6+JS;\Re,I<BWI\]A)&D1M;NF6&5-^\-b9HO:g&YCHWK1/a(V.b\[4PS0PH
J[cgQ:G<e.OR?KTST^Hb.7YPVZFM(+1DQZEU__-A5&RbKX+8_+W)Z;AJ9M6G.-bD
f:.HPWPeY\FQ--4646(KJ#XX-+@)Af^]LURd;e++W6]3749T=d\>G\G9#<YGVDWN
^UB)2:)A8](-RVQbY&_A]YTP/P]YFd,6<J@dBFZdUH9;#A0W;SX+(N+Y/U:MTT.K
;Z@SV]+0H10J)+-.@41AK450cB2g?(T3;:bIH94YF^?&K4ED?Baf0DQG0gJ^>0aJ
(.<O2C[K^#.eD6e]@:fcde5G\D5)GFL^TUg=f9#4ZgfNC/CV=9DWF&<:A;97fO5e
L^QN5M/GJT8FFUPK30#MC\D]?,1J,<K?VQ\PU.7a_349&\8JJbdf_MCYR,gIO-^4
OgA]S7GOEP(=@Y-:Eb.PI6LP/a3\#TTbf+B)@DI8O6-BW]@;d((>JE&e162M\,:@
6O\ZfGI(Z=eLK1(_4ICY_f[;HZ3JM>MX);R<DAWdZ3)Wf]g.L_D,4WH]EgA,YfIS
MFFI@@T5^)3932(Wc=c;6G_1=LP5;6[\CO6FGHLVW?#_&P?Q8DD8FZDb:<PDP3]1
6_F=_8EZ?ba88Kf/F?<IR]4_ee\<Ub.IeMNTDW^8J2,f)Hc[/MGW?FObZ(VgOJ1S
]OJf3OAf)</^TIZ6bVF#\H[.dc^+(_T1RU[:-Ce;2_+6a8W)AVJgAN,CF5IT4E84
4Q^VL]+14>_DdC71cf3\\Se=&]HCBO)-d+EB;/W.,HU(SS,4V@8U_&E11JLa:]Z;
M^W09Y.ONBR)GS2^J;_\=TG#Oe(OV4Y/bV4<AK)BU55P1/7^G\9]8EL[BZWB+,@D
fEF3GZe1XNB##c.A3dU/<2VWUAEI?+1P4IE[-/ZbZeV1W[UB\bY:JJ:?JRDQ;3W8
RHMG/)@16HMdAe/04Ec6E^L[SI-MCQI/7M5Y:e,ZI@QSW_Z.8.OI\-E-[0OQ+3I_
+U\5&HKD[:LH]+BI8];P<Y5=##JL\_7g21R6?g@5R-_94SSG(7T0M-^)dHZ\c]K]
^eE@2N0ZC4C8MXa48#+519[[6:Y9-R<g/@AL@6]dYP58#O0I]5,_8DS2^_gcf3KO
&YMB?SSOc6A,e&]P)J\RUSKdRV3AYS<@CPEQ41-2RG)g;f=O81^RMXd)MQ[M3165
BZ4/1<7UHU4QL3JJO2(8bC<Vd&]@N6IP2:O-5;g5AG=803&=[C9a:N2[+-XOJD-4
W^IJ++gbd]Tf>S0f1(<IIR:;F@&aZ#Nbb:>E,=J<:IA#69bO8WT,Q&gVS#a^ac8e
ZBX&Q0.cg=gH[ZL^SKEf,0M3N8^]A5W-@+b:6/+4K,8+]DCV^K-f.5L1DKULCbd1
38ST8_K[GN+/V&)4Q[9V=XN-82I0K>4QK0b]&?,)/YB;Da,](9(ATY<1Q(CH6]GI
g^/UM&T1GSSIIR@=<:R/I,5F:3IP+\g&N?D2a2IU=9cZ84K;=&;D]TT)\6)#):S<
EO_RP3c8e\4-bWFTdP0&B)9RL629PWT4\7Z5cf]V3K19;2JJ>B9QRM7<Ya=O;.[X
]HIOV4<a1JGF:gV@E>C0FgYKM42GLP<YY9f#37)W5K-5b[A>.Qg2_S2<QB^C-8db
aZ6Pf;BJ[D__T<9V]J(M<<3F(4PL@:PZLZa2/2QZ=L>;1^.=eA6e\7<=Z?8?_KVC
5.Ca?^@dA>g+7bC@RgM\+7OIDNY1aI<[ULAfO,.UW3YS76:K7aM?0;2[)_b?LNVV
5JLNN/CKN.BG?e2F8P5&Se//ede\BM_>:;>a/I#M77:/b8_\_K-E:eOJH\1aPF/D
0SUK_-Z2V<.6)cc6)OD>?+R-7fT]UZ-#=IB5+&I_aLW17bc7ICSM#IG)ac\d-_;Q
K(]1K^743G2)^:dF#<#e700?&dH9[:3cB?I9YIPPX((71<>@_aE3Q6NQ>X51-Q?9
Pe19/@;P(g]gNaY)7GL=cB,4V@ES71,/Rc\bUL,\Hb#bVTX:d@O6b30(Q8156SZ;
6OUO3[[&(7Ug0$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV

