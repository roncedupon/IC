
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx_monitor;

// =============================================================================
/**
 * SPI TxRx Monitor callback execution class which implements the cb_exec methods supported
 * by the TxRx Monitor component.
 */
class svt_spi_txrx_monitor_cb_exec extends svt_spi_txrx_monitor_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * TxRx monitor which implements the callback methods.
   */
  local svt_spi_txrx_monitor txrx_mon;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx_mon The component supported by this instance.
   */
  extern function new(svt_spi_txrx_monitor txrx_mon);
  
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
   */
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
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
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power UP Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_up_sequence_completed();

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power Down Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_down_sequence_completed();

`protected
5>T2>(/O2HT.H>&1:b+Bbg>gC;M:fOS/_8[A#0cZ8,bAI6)PTKH]+)Oc9cHe(>H<
62^g.H\.Yd:(23)K:eKTFFa(1_Le>CPHN=fO>3@FC0X\.]_?^9SP1f]Xg>A5=V>=
GRB_?g]TJU@_1O9F:S<1]fJGa07>0AJH5F;Id0ZBYOIJ]\:5SJECZK65N\7^G<2R
SOd>;IdaF3+_-$
`endprotected


endclass

/** @endcond */

// =============================================================================

`protected
:93I3^K,PY;>M.X9R_[,dM2FBa_V9[R<aUL\8Sa;eeY\fa/cT3G4/)N\ReEPC)&Z
aENT^1#ZR1,3KcB9XU.,TGGW,A.T8&U=d1g.K^H7/J8.0YdSO]>UEGIQH35R4F&>
Z@L+7F[TWXU?d<QP40N7V:C\OY(c[LNK0gAYU3M6GN1JYbZ__2eDeXT]6@6@K&Nd
@cP2DRf@6K3HBI.J1&/X-C(=P93YYP?AMDd62S_3WSE@,9gQ8K?FUaT]L$
`endprotected


//vcs_lic_vip_protect
`protected
2DR5X5<E;>R]d<-WfO&ceR_VE/76b3e[Ogb7YOc:EAWHR1+[^:fD-(DB\_+ERZU<
Z5@;H4NHA>9GHFLacU?AL_Af[FF&b0;>IP,U;eZM@Pb_]KIV;<PFS6YU23Nc[:NR
0DPX323G&D4G-YJdg/Gg&Zg^X)U=V.)7[eMQK5<Y2=V62^K_VH9S5&LN+)g]FPTT
K<J.0VGB3c2MMY\N=&a_5#5L;VC#IU7#OCJA9DB.8MOdKOE[&GN/-UQ@CY7Je3N/
4>/;-;O#,fTQD2R<dY5^\;8>W7PedK;]GHAF[F/Yg1L7>5eOO28UT/?C.,4(9.CL
L9NOR-?3C=SH-0_U=M)VI1#,FNaQgaSBXH,\5dYR8cZ^&,29;4g-IOB77FQ?BU1Z
K0?M1Za@4VH^#[?>)TI)bI_6N.;L_b&^@\:bZbAUI/4IBH+&HE(H;9]T8]Q3#<Dd
e0-PaM>=9U49)#M,;.1Be^2]/d^35?S;WS#e7=+=-,)UfF@EQX[8.P_Z-5JHcX50
:&dV-c61@:H>g3H/_<S=3R,<_Y(JD?bJ>7gJ,M(_@YdH:I3^0<N3;E5K_-@BELL,
RPQ@6Qb^6X5Z/R]DP4/HKWL)CCLN?R&\NLZN.7S;\[O-E^[<P4AZ#5e=]#2BVeK1
4(a9P:\L)/U=WG>\+/F\1_geHL#Q&6a,;IDfTZ=JED:QK/^TW^OB7&Fe1X0/3_&;
K+._J[)4#2b5[H=B+FZ:)QC=+TMGNSG\1R?@L9O@UX&O2ED-fW1.2NH.Fd/0dHDQ
BG[^]WNZZ/#X^YeOGTF0a2@aD/Sg&U:G=;-K:XB+YUCW9W9Fd&:RC\b?DKUMc@Kf
/>JKdV4&_,b;:=+Q5b7G<.ZaafTHJ<&QQ3<WD<-Q:Q+@IRcQ)R+UD>O8E\Ub^b_E
+XL./Pf:@CF]^11\eB&NXFEe?56>T;>GLgdI,[.aIfdA#Wf;fC:J-L7_?fFZRUD]
JFT6N&IE;eC/L&&1O\MFN9VB&WLVR+=XZ2A5Lg5g]Z6<O28VT,SP,2#\98>Ja_7Q
EVC=]WHPTI5+AXAeVBT,b6?LM[]U5Q6g]K_.0<Bc&Q[b:;M;B3&fYF],PR<@EYG6
R[6OGDc-]7M[9/P[Ma_EgVa1J&#/F2d\+LDN4TR=J24<;^@_J<PY54?NS,:?,_?H
f5Lcd;O#IN3779I)GWbN)//+=Ua\1Fd:ETD_6R)g<WC(-e_\I2&f_ggDQ4R@ee;V
.+#B#b5(^08V/@2\1?H5)?H\_Ce>bQ6,0OEOI7U,KJ.=UYSD590e_03[.a0U/3cY
ZcDL)WgWVWST9MAN-]V4cM?-IE3S#IY.Ie/@4K&\[)I<6:/C.MJV]0XBcbT,4Y&V
+#8G#+7.2F2EW7IAV>U4FBaL#TL)D>PTW>AJF,8>@+a(a.),W;FM2PSMD[?gE1?b
-TD>W-8-bG8b?-02MWGdc^@M5)L&@,#XD8eHVH_-?.#M-1a^/7,?W_\@;C/KKEJF
8PO_6Zffg[[2BcX<8SS];@UQQE7>,4/CO-O]I[c[L-3G\UN&KbcR_@T@7b&+d=fX
I3>VYA82c@1?M^0RB1MLKb1a?P?aa@44++27)G\R[BbR?e6.V/9S>:DS7>Gg:>a,
@BCd..TT9>CCH51BJfTK6W^BS6;N)c.DGU)I>H?K-eT-5:bc:F.G2DSfYJC/#\AU
)cf,EHa5R_N:^J7SMZ+1f<Gaa)=\A#6]M6B\<95M,,E@#KeQ]P0\-3VC-5OBCTDA
]G&.>BY,3-7EUXE60C:e[T4AV[^&e@6FU7@D[1cI62MZLQ(R++HG#?O0+U7]BXR8
/YLP9VBD+abX,a<Y9fRT5;VggOD&XBcCgTa:ZQIQ(:gE;I,ISV=;<ME=?5KeRI;Q
J&b>NORQ@-DD;@M6,P/6UO##&-(S?R;O1-0>B7;_FS5c-ASB=>O,TM6cMH7GPIV#
QQKZ;>&DaFF=_R&.]?ZJ2#ed@V^80T[2\TBaU4K-..IY(,]9,G_g)+1#ZEeCVeg1
Id0^dVPgB-E6O<QIP+EYWW;g5?Y<ffZLe+0,5Q[be,b^#WNEg;Y<b7E.&Se83>(D
gPYE4Xg_).f7a4D@MPWdf3.P>\Y?>H7S5=QA+/UR?K_<(6PWOMOWE4A@]<?DIf]=
.d&3Y__,9XL#],9L4^=2bTTX;9&PWGP[@-9:C<b;YD7K+3,#5[W<_XT_J@XC,#S5
-U2cg2<RHPEf66Nd0<]4+:8FRf?)\PF89QYfZKK)HZ,1e\C(aT_K3PN5<FOGJINM
DFcR->b#^DTQ3(#a5KQb:WZX3bGe5dH<J)M8H/X1c8_\4dIV>@)=?7B[ST-=L[^-
^8<NQC(XcR;._2M)87PZ@aQ6-+C6;-f.5:]dQ8He++L@Z^cG^Y4>0X1UYdfTcFTF
)d@)BTO5H50f6FCY:[W1gWLYJE;TWd98GJVYE8S4)7>&1\[-A6(U1BGA_d=?fLY2
_7Q<2d&7aSdB,R#2LQaT)Q\4=bcL/E\F=ObJ)g/F)/A7d7[-K)]-L5/JPJ\dPC1W
#Q;NYJ\,+2N?aWRd]YH#6)B=17-K3DC<1LUK\B@VWB56AHMR]V@e6b0YZ<N+MK[e
?L_(8GeY5R3[aF[5H2CP&LE]34I0P#&?+9#g;6ffZ[bcRO6PZ&53dBaQ0]RGeS.B
I_d0_W=.aCZJ<R#@W[Z;FCZ-OENRV:^8IJ3QBYX1a,#\0#YPQ-D)CRKNW-_KFZMI
(5cCbg?-4W]>BPIV&0:6)\3fHJ\D3XRBI7F)JBG)[@[)5GS(<d.#f1[Xa4+aaRR<
6[6cVXQOX9+:?BQMC47fU/cJcPYCGYV84J.>fI_TgUdK7[T3K1FOJA,>a4/=#Bbf
fF;P_(D(_-4f<>9L/=1QQ(/N,Ufag)ZNCe#Cc;O0NJYKgSKU;]JLcD13]-;,[YB<
9&>[(X-d2f9bAa2;SMcWTdB9;@ZQf6-e+-f[eQ#_&#,:4+89/G;N#6IBc<R<YA[K
8Dg==NdN/fMef)(..S,La&C>2.7_./gF,BL89W(e5X#5A[5#RDY4QeB:HF.?F1KZ
V_/<;d;bK3<AM+QF=dPTXJ<SA.:3+WX>>=Z6fXf<FYPb^/QY.\_ZKEDM,PaT=P=8
_e14ff8HP>4Y\4>V4T?<L+EfABL4f)]]@4eALaN,2#B=<cQ)R&0UQ.QK9fJKR(98
-7(=@[abT:T?V.E>JSLSXg(:DWP7&TKE\?TE57g[9G?/f/Z6),V?;P1:b=4X19&B
-=(_aI,BTac2.K]ZWY\WXaOb/#7+KQ8&6=E&.fd-X>B#TbD8=b&ZLXFC<-,.H13c
ON@Y:7??VI3^H5E0MJ+H&G#]4;TFHSN^QO9.HG-02R<We;<#<dAVTRH-g?HgAXKL
L)cT-WVCP,47HVbeE.J22?>V0cMN=<L@S>2bU=N5BV4HFYRH,6XI:ON@8AU_gbGb
F3RQ?K9/B6QbeBMZ5>D2@#dLeO6AO6;M?g.[S==D[)V\gD]e<O[-a]AVY,;,b#?,
E<S0J6C[.#T5E3c+)56N,7]:cc@B6f)2=MF3;QS5+5,#0TZ[WQ>+[<F@(P>1-P#A
5[CH]eU(5:NO/ZbGKe(JG+,FKg7D7)GCHB4M5f_AMUYg;\Le.RE0PCBB=V3.,:8:
GgX&48,>Q5&2W3:3?WJ@8(KDAA(^b?(>5(T&/Q,AgbWXV?dX.cb,_4I=+:CF5SbQ
C;0Y2AKK5#b1QUF.U.bA6G-X?Nbf\RTAX0R\(;.0dG_3e9/bBaL@82,O1V./U=&7
)1EO=(P&1+9]96)EBaA2F/N(DB-U8_7AM26,L@?A3Z#aU3T?.5:g#2c&Z,I/B9^4
V[4-Z\>@>fT3(f3ZC@M-4ZRBIfYe?>Z,<\1ZOU-:QbD;?A+^aWTMQa.0&eVN8S>c
@ccd?SZ^SF6<[4X6ESXWf=]g]]]@3S#((Q+cBW8<MYT?dY&&b<U@e7eK+1VZ-7-O
?;LUNAGMdeW#<ePQ>&BWg)V_._1HYV<MPYYJHUHGS6E/;Z\7>]J#=.>R8X?;(g#7
FTg4?NXRBQYT\)>5NCFER?3)YWQ;V6g0YRQF&+L2Yc)52&D@9<ec/a\14&QR7RD;
@:=IXX<H84YLIWNA#KVb-,fC6N;B\K0<W?>6J&YCaSN=CRQ+egK/R4e1DO[_,-f)
f?Y;RTYGPCDAD.X^&9I?)[bM(2,1>a,dG^@aN(NNR\L@WHgDdQ5A^(_eAILIb=YV
W@727R.V0^@JC@G8&0U3ZE[IABRC8K5Q=-O2I=)0Y<Q(H@7ODIMZ#I:[V#L^c6#@
;SCN[eBP8_CYH-QWN_CJO5/bY<[4#C(Z]KQ0YZZ(S83e2?2Z[ZJd_FV3^AWFI+][
RP1V-^T#e=^GTT\3&Xc=b1::8T@:34,/^#2W@ZD(Sf,R5:[Xg/(2+Z>^C<7RdE<2
,I]S3_F#Y_dg&\7\0G52R1&ee;HYTYB52NJ;LVf\D;_=RLY/d:7@b\;:?.VDeg>_
MdWL&<=VKOd2(HUMB69@<Sc#??eAA<.Y#:7>f6VYHW?[T@c]7S#P(5B:[ae_#G<L
++U#/])cSK45^/cQa&L8cY:<-\@5<4d;Lb0gHYf,eTHf[(7b]2Mdf:(Y9L1,D+<1
?Qcb0;4.8FcLc>S_e):?^0QU,[d/6c8d4(\>A@NO;AS?R]AabDe(9/@>AJ9Fe3A5
P1<T^9[6-&U6(2I_S8:P45L8F,J+=X1RAcb5QNMUeT[YHJXM?HM0=OA0?SQ_XRYB
)?Q1e6.;#D>QgL@3=g3Jc9-II7.)JKGP<d&@#/2=[TN0#a26,=fAZU4D8\U13BY=
Q\&gQEF\#SG\A3c/Rb7Fa,NXc;=BTQ^R3-(g>DXTZ)@2B5^Y]X.ZH@.33=T0XZ]?
[/(Md0bd((7B(1:0OX,2fGa9_J\+f9/=TcI)@MT)L#\4_:/B9baff.FBDO62OV,O
_VB(L5fSaQV,V7>FDAc(XA[/a<=&-ccg/M=B5O#M]8g8^HZ-TN5&N+=?7<),aT4M
\&7#fc.L)GUI0Ve1\3cd2QcOPEHfd/X:TU:WK3<>PY:Y?(F/47F039@OG2J)M@^/
5Q/e2)LM]<W2_W@5MM<a0K4@#E(@M<]F[b8JZQ=?g6P;(bFCF;(B5I/Q]TTUg\cF
M99-HJYbV6KgXU+ER<+=HKD@K.eQ-K2\?gM@IPbcA45Q9+C0(B/@)gB<H9MC5-5Y
FQQaG9?]2[,a#D8=B[;fVPH9dEDV4Q);A7/IB@6]WRR,16:fT8c0BUXA;[4g;O&1
6U0]Nc^-\?#JWLEZO9(Y]]6)RO5Z.gG7.AUg90F>,WIX#GIT7:aGZc[SXFGaJ:[f
-.-12A7]D#^9H+D)EH#dH^P-HefG/\S0&T[@;,DUKRRaJ^@:GKNFHR];\N3U@#:3
(XF4Pd9-J+E715S0dF@]c2S;WY5>a/P>^WCNVSYVQ&\/+8(#JM.ab5UHc_NI13<R
81:E=KdLLU79^XdJ=F/9\8D+U,,485,RcH0C?63N[I&>0H\TQT[1ZPL;I-46P[78
#d(NKZ:ffR#Cb(-<HWA4HUN46E0B+cZEBa.[Ne=KZFFO4FQ5[G(LR80K.9KD]dPJ
gbd60R[6C/TF3]1cNQ-b1N1M2+NAa5b:1HXJ\M2\gMbW;-CUb2\dK&IbX@07B6.P
Fg@(.9Kc_]K@3ceS?PgbcE[;PO]LWZ\NPFUIH1]NM]2H<Z)[1N.IC,U#3f2>+GRU
?f@3\RT+XbHgB6AOgYeKQM0]bBf_VNP,F:2Z=:><d5H]KAOW,/M/3]+RD7;O>EKI
30,;B,I[?gVY5Aa(FL<@C-G>@g>^V3ag@KSZFAEL1)R>7b=PREK4H#36EB@S563/
S20R#^[.S\Y)?Ja_D0O4g2Y1_Sg:MGb/6e\eeQG?:\>VI-d9]0_L-F#\4U#?aBS[
D.,I_D@7J;JR2H93V_3ePR@PBOe[ME5#7f8N)C[A>0RL<1CNe\C1HQHLSPW:KZO^
;QAX_ce@&MS6XK,I]VY&ba<G.:JWAH;F3_6/eD7?6^+I3YM9H3Z>ID>)4Tc>UYB&
;.E#T]Ja6MN]UdWG4=KZ,RS__E\7?dg,,V9TcM/DON+?UbN\Q_GM]Q-gR6@1Aa=b
0MM,<(+T-N&bdKHaMd^/#@9D&HNEObe1MY3aR8Q9-6:QHcU7,-U@Qb4fU[a:J[=b
8Ub@T-M2fPI&M)G4R6KWVFfXCX&PSfA[McN3a=L[F3F)1G7(8N578Af<W55_7dM_
<^]MAX?51gg4gac>/A+VFF(Y7cT8:Jd[-@We4P?(@S.5P,Fb-Y+dU;fJV]^0-f1-
O\^8P]JKSJ4Wgg7Nf7.3NcY8[QH8cCJ#>7e4MKA+Z.5E]#SLH=FVVfdNg=2?LeD1
^CTe9HETYXGc<=4AfCOLOBC^(:Wc0W_DLcK5:RAHXN1)-5<2c5()[\[eT2A6f.BT
+aQ\^,6MOHXF)FgF&eQ-Df[X_4I&P1F+\#Q@@K&3DT:a=f0W]?d5W_U.Xe8K8ON9
:/4[)EG8RI3];DKTFX;c(D9-8\5VK8)Oa0;9^FQ2H/ZKW)cX4T^bB.Hb]>1=.TeF
E;-LH-+WBggOR@eS+MLOe38>[[D6KPRJ)H)5GHdP(<?SV^<&J<_K-YL,H+XL_4CE
I6HPbeO_LRaJB4@0:1N+F0,@dEU^fPW_-FR>KX(9TO\Ugb&D=]1<]=d4bP>caMON
</X]_C8M-@/;ED4J=b4J.c4R/(QUCOTTRWX)4)IaZg(&Xe)eX1=72KUcg_Y[;(-#
S;,V-&FUUT[+@e^f<FQ>6WY<2>6<e3Aa&/c)RXP/+73?Z^@9IgHUfL<QY<OA;]Qc
Cee2(UK5C^/0,FN^F(CH>QP??HY[]HfeKTCBZUTbQPB8H?R]9S)?>AUK-B]9Y8Mg
F4--0>UFN4;),HX^&H-/=c[.29Pg-]P#.NFC,MDGbO/16dBDGMNKK2e9=CX9/L3GT$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
