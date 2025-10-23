
`ifndef GUARD_SVT_SPI_TXRX_VMM_SV
`define GUARD_SVT_SPI_TXRX_VMM_SV

typedef class svt_spi_txrx_callback;

// =============================================================================
/**
 * Temporary class definition used to enable VMM based compilation of the layer.
 */
class svt_spi_txrx extends svt_xactor;

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

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  int EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction
   * out of its input channel, but before acting on the SPI Transaction in any way.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void post_transaction_in_get(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_out_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_out_cov(svt_spi_transaction xact);

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction out of its
   * SPI Transaction input, but before acting on the SPI Transaction in any way.
   *
   * This method issues the <i>post_transaction_in_get</i>
   * callback using the svt_do_obj_callbacks macro, as well as the
   * <i>post_transaction_in_get</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task post_transaction_in_get_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_out_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_out_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_out_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>transaction_out_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_out_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);

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
   * Called by the component when a SPI Transaction has just been ended at TX..
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
   * Called by the component when a SPI Transaction has just been ended at RX..
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
#?N<V?SVggG-Z#CNC)>#Ug.033Y>TM^bVVJC>Zb##@^JI)7KaGc^6)JaSQK7,IK=
<<+P(ASUM3)I7:AO)=077#P7MfSPc3OVYPR]>M__VX6.bK]H/H\#Z<I[</1IBO,&
Q+Gd\5VACd9BVM9<U#.Z,D<C:N3P616d[(L)JL1Y7(J288?A2>QeDW7>MF>VO[Xf
T7Z+J:c3b^)bZUKYTVc46Qg?GLFa:/7gQdZdLVPF7Z&2A$
`endprotected


//vcs_lic_vip_protect
`protected
_&Y+L8>aV0eF(;Z@Y32M>]CNJ=B7+\EY>U-<-dN^d8VRF1XF6INN+(@K50JUET?0
)<+=_B>fQXQDME(,5DaN:QP/e&6eGV(4]1E][[/GX1E54bfCUc\EUNb=gId(_4NZ
+WU0OA+524;T>fS655(V8N4H4a@Y^GR@Y2eJZRPcPX]AK(17=FSD6dYJA5/X1FW@
.fXV:e=+)cF1g7R+/^;\@\RLSM(N:)G]F:C(LP1^.ZK:#g<HP,Wf/(Z<E0YVL<=O
?<C_ObJH#)SP0K1@&@^#@NTUNA]>JWbg[?T7JA&G/D4N48U(-:C.N@B(0Kd\/<.P
FdRZcc7[1a:ATGgggc=L0gPNNIHY\5b_MQG<9MC4H(ECcJ7TW[1P6<23K1H>7=.+
@(74J8#+IXgcCY21GYCbPGFT[]0SV#^9^Pf8(a[g;WJT9\4b&?>5/)_(GIT.HBHT
7C^V];cg-Y&KZ>aNZB>2+C-7WaMSE:@0G.C8dfF6:>QUWF+\[FMeV4(2Z_C:bF^K
T:7#PI=g9cZA68B/F:^\:e3E:fER#c#Y.-<M;d)K^--ETaP78#FcI#XC2O]WCHb:
]2_Y(&f=K-FC..HQeb2cfZZ9W/6W?,P:U2fJ3,T(?IM:8;b[H#_:f.8+U&D0WI85
\Kg4SdIE)76\=6X[GO0C:P3&S-[;(FX,KU]dGUSfE\c/]:@XZYMBO.19NMK:b1^/
LX)EcH8afM;dVgTaFACL:S/(=?cL?Ze/X-?DI/a&Y5^ATdPV(&-..0@BY^[@UcEX
,<85;99JJDa)ZL_@(M-42?bAg);:JX,M@.-ACM&9b/5SQGYH#+T\8SaBU#FDCI3f
(\2OKCZUaX:Iee5A<MN2#XB-e^154;5/<IY<.AeUdUB>B#9>><AJ5]NNBK2;L]Q3
<>TM3JWF=SG&Rb/#1PBFZc7U.,g[&EDCGeTgH-dEWN/<Td04VbAEF+b5Q5]R<\N(
Z,V]L[cb4#GSQaD1I&.CV/.P/.UGcB,H@@C+EIU/-efg=+[d\S1ASN47:LN91+]0
(2ZgR./?+N6PBVb#V:5-5.?.[;GH)<XPAC=@dd(fQ\Y25<BKQ31T9ROa.dN(P?SM
8BTV1CJdC-OOfMEL_N-5Md.EDG)1f7_7g&M62/K(HgJ?&dV:ae1Nb^WAP)XGK=SG
P(eG+IWJZ_e:HXA?3ZI>KB;\9D1^RJ\4gCT(BYd&cReI,9#2#BEUV>,+DQ(5eHM:
[RI]#NDQV#eeK(bSF1dfdNLe\eY1gCCaFY)7U[5Z:PK,9cFQ?1\&LLTXJ23W5cdX
JATOEV7@8EJ@Oc;aEM9Ee6S7S=UO(R724?[>BI&ON:=C:9\\J=TBcd4Ea^1HbX?G
U5#?FOY4A+=eMBO^bV#<:E>YVaH22[d]18f1/BFT9]ZTLf.bPbUe]NCY9P0E/TIX
<YG\,E8K?&:0cbdWB7\c)e@3ZG&-6Y=DXfU03=>N=\W;M9ITJQ6^CUQNCQM8f6Aa
TK-41,5O<P?E1A\1&J[NIC/TE(ZV/>^__KfTb4a<8fKY+b?\YEZ=dD0)Gc;MQ,g2
Q[-\cQ^^NQ0E7D^@6]/:]\#LB?T-CT@A)cFN8UUHcb.7)g7KN>HFG5(YOV?-[.Y_
>V1C@7bF;f0dVEc,<YT(W#GYVRZ7Kbg?=U8YUT_K#b,8Ye@HK/ZZ(SUA#HD[H&QH
#+G[,;T;b]=;2cDG_JS1,CC(H).Dc#_5\QT-PLY2_I;E<.Y=4GK8]Q+6GH+P2Hdg
&dNXZ\NOD?5VEGIYCb]a1+[DV#21:TT[<&&9YFXEW:BW<M/f\c+<Z=MZHb/gJ2KY
^#ZC/UA&,><O\D:ed-0bMaXDg<\I@B4RW_F[;;/_(0+&bBd:N/A<89:O#eLW;CU6
D])c0/ZeQ1b.FG<28PO5H/[5#c?:?Rg2J>1Q3.dgQ7SRZX=NgDTe54H+aG(XFf/D
W6b?>#,RT;[^JNS8+RD)@<Z=OBEfLAVQ=0Yg^JKQR5^2eDL#,,Y);XEWc9AV8U@_
bDF[&c65^B@385^-GU@9^d1Pf^/CF3UL;Mb1EN_BEOK:>PU_.A1,H[cQQHC#S>_a
RQT:58c><@E5A&]B\YaHdKR5Z^/A]T0RLMNI-NL0VTS(XC-/EONPZ(;DG)0>D-Zc
aU>e>Z<@X4E=VJQ0Bb7#D).;&&cG1AIbV(.E#N8-8#J7a>A_L[Ma3g4-\RL=eZ4L
CPD,0>Q#G_aE+W&(_OD0@IeSHa\@KFO/B90,)C0V2<G&SM7\gfP&IYREQ58,P3K;
Gf)A1dK)7aFaEd[L1cV0/CacY](HZ_S>eYUL5O#=eeYRROdN2Cd_7-4&>:<0W]XA
..H7[c[OXWQKE+M94)DF1JN+M]3^9a9]@<H@@Q>EIN0HUS&ZHeA]@3OGaF5a:XR-
1;7dWN64gef^1fJ/^:aM>/QL^TZ\_[N.ET-7#)SFSPSBdF9;KV<2^cN:HNYH#&+,
J7bGKa1.[SX[gVR@/6&A(agJ/_]Q^Tg-&YIeM#a6T7&8GPSD9OLO2QW=g\F&DIRd
6L?9O9G.)X+C[JG:3OX+D1DQL&-;=6@]BMS(a&?&OJZCb=T519#DJCCT<5/Me+>Z
H83G=6+9@DVKBd](Vf_:agL4bY\@JL+>7U5M)g&)He_G>1G(J/HFW/9FF97]L94&
@<C8YL(;^K(27@:Za3X&T(?50>]3;,2&YRc:cG?\ENQ@M(I6G=G;.2#=&1:\#7UJ
Y/dI?E,A8/NEMTZ1IL3=WBT/3CP>?VU\0Tc4E:A++;E>RB.5R#U&>4HGK@@5\a1)
.\^M7;+RT(\-PK&D=-eRR[8-#CY8_<e9\b@0dYGE7aCGgNPSI#-?NIHfV7,W),M5
d\V>\9(@Y;PN9^_DeI3=9RD@EeQG,4Cg@$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_VMM_SV

