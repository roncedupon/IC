//--------------------------------------------------------------------------
// COPYRIGHT (C) 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_DISPATCH_SV
`define GUARD_SVT_DISPATCH_SV 

// =============================================================================
/**
 * This class defines a methodology independent dispatch technology for sending
 * transactions to downstream components.
 */
class svt_dispatch#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Shared vmm_log used for internal messaging.
   */
  vmm_log log;

  /** Channel used to dispatch the transaction to the downstream component. */ 
  vmm_channel chan;
`else
  /**
   * Shared `SVT_XVM(report_object) used for internal messaging.
   */
  `SVT_XVM(report_object) reporter;

  /** (Optional) Sequencer used to dispatch the transaction to the downstream component. */ 
  svt_sequencer#(T) seqr;

  /** (Optional) Analysis Port used to dispatch the transaction to the downstream component. */ 
  `SVT_XVM(analysis_port)#(T) analysis_port;

`endif

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

`ifndef SVT_VMM_TECHNOLOGY
  /** Sequence used to dispatch the transaction to the downstream component via a downstream sequencer. */ 
  protected svt_dispatch_sequence#(T) dispatch_seq;
`endif

  /** Semaphore to make sure only one transaction displatch occurs at a time */
  protected semaphore dispatch_semaphore = new(1);

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param log vmm_log instance used for messaging.
   */
  extern function new(vmm_log log);
`else
  /**
   * CONSTRUCTOR: Create a new svt_dispatch instance.
   * 
   * @param reporter `SVT_XVM(report_object) instance used for messaging.
   */
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  //----------------------------------------------------------------------------
  /**
   * Dispatch the transaction downstream.
   *
   * @param xact Transaction to be sent.
   */
  extern virtual task send_xact(T xact);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
)68C5&0(>K1g<8S@_/^C^&0;g;2#J42JU6]32WY9e7BH3^8(HHgb.(L0)7Sf]RU.
+1?1N\-eI#^>WJF(>\)GZBe(ISHRVPRY,>7e]&_X1,9#^G6G@S.72>J//.OWa0DP
f(4g&[^H#+5+3(c]5f9WWFd>-14Obd,TN&=_PbR2IE<Z.D<MLAK@\VUg3@.XcN;)
M+UB]DE@9YV.J6J/BM5HOeSR#8H3N=a;]A;14UMQ-<)Mb9)_;F(ZeN5,(>NKdXb?
&XWB;1Q5K[)W61P]25cZ(g@)4_U-M5B2L.7U:Xdb-JCHf;EaER5D7^\1<+>2\A@X
0+(0,OdJCOaAbOG;BNUQ3N&UAG47LC1^Jf^d:C\8NBA[5?C=.1dS(&YS_TY-^D_0
+g3K>[ZF/59D[R3J(S^7-W15TA641)g.^V-7^bccI+GWf7N+]>[b<MYW1UAb_59<
U2LH7&HW;>RG.M5NUPQK3B@HdHT5_[(F\6AO5:.JFKeP<R>3OZMg6E3?Z(fV-?Ua
cNFX[OX]0&6_@a-8T[>4^XeN\d(-8QRdXJ.\4<9@c\B)=\.e>UPeab;?f^/(=7-2
555E+2c;Gg>Ff-?5))95_^ZBX[Q(;Z6e)eJLD)=-&K\>I,O:e-d/AF&(^X^g5[@[
JW6VPK(=Od6=N_9Hc[P&O0Lg>fD[;UOG;a@M#[NBV]:SBEJ49EJ?]KYXedU=Zg#3
4[T1MF00Bge^d?J1_VEIB7;?6LU7.+=7>bJKX0)35?9HL/7R#@Kg#J2NQ;U.M0@e
#[2O0YW?4a2[a/6.Z4QDKWC)S:Be_2Y:E[@_aB)M@H]Of1X&2F&NPL;OB4YMc_6@
PU+P/@BPU.N64L4egS@K/^O9c2b_8#2YJ9-ZJCW^<W>)CP7aH_W9;;CcO[A)fbP@
0V/NFJ=5M_Md.RfbTEV-EBQ58fX57>a-=Md<S_6g[R2M0QNbQHFD<;\TR2T40(:D
1;?-_-#NGO74-c[QO2HW9:^<AcQZd,[P?fgfec5a;a5AaARM)8^SKB@@O7GfW&GI
L5?\M;WP72d(7_H^?C.48Na<T/bX7cE^B+bLAG6Q;W30NfaQeHS7:?Q6QYLQX>VC
8[Pf8JEZf=E;cPe.76MQ0?8M+<04[,55;PO4:4gHA#VLQJ^GaS+B2AFR^R5VTZ,e
;/H3QYcSZX&G))c9+\G\N<FEDRb/L2T]Z@^)T421/Q_WB7F5_e,<L-Z^b);<0TP+
.g<FgGYUTRM&83_H7A08W+H1DD&E2?_YW<[gcf?BK/74VW/)f9_N2MNM+//I5J;O
e.)eI9&YIb3QID),9;6dK6#HQ?]-JR1FdU]c+f&gCK>7OC-Hd1QB.3NFK1RXfK4W
7&FL0NJabL,c^_=QF3?2;LJ5_&KI^MdY(8^O,H\[b(Dg8WEOJJd_JOFNYd[f5dbT
ef=U:I1H)K#P:b8UJWc7&X6.\+T.:J2/RMK^<[@Q&^H1TebaEAfT:Z+R_/)OS7&O
VRe(>GXZS0063CaBc(/I=?N+8fFX4Ycf_)ggT0V+XR6XVUGZ@Rf[WAS5RA>aW.PP
(U;9aMb]F/FE\+,WNNWbYPVJ1E2#;ATgW?V>S#da7/S\_Td4485Q]Y(HL5fOgdU[
[\)TgG46_7IE;C9NcLc6.3,DTGAA[9E#b9#G;f=d.(@>5d4T4\IQ:?-CG-#;LYMa
Y\4O+(72aM;L(&ccJ6DfWa06H?+,CJ(2AHK)ebWQ8b08:Xd)@0]=)@e@.[?ES7SW
[M:J=/4<<8MAB-YFYK/>FVYI3I3)aMgSUP]CZ::^MQDg#-4=DZAa3^-\&57OD:OF
T+COLfLWdfe^\\:9O7P-JZG@=9=@cOeM(5Re?#Qf4:R1+;LQRZYd)<ID8#cB>+aW
03P8_L7@UfECb9XBZTPR0MAYf?0CWD^3c.>V1;U/(HX[.L;R7.O@HeQ-P][-VWe=
#,)V=\#EBO\6=S&GZ2X\H+AG8&(28S8_MSb^Sfc973]0^6#TTcY>gPdDK39B4,7f
9cbS@;36_E1:c=]Y3CA/WVe7H#<&+MO74,I-Pd:0GK)OaK1RZ)].dbVU9gD)>aS2
O<3f8MYdVaY(A->]#E(BSF#K@-b,gE^5cJI3[.e5JIfDB<bXCA(gFQX8UFG4\[&+
5MS&:.M,Y\]7<QGG4<_^\X49@9@0Hff27<AQKX6WBaB3Deb=X=#GT^Z9/Qe2FQT)
EKbU=XPI5L8F;C^?#@aR@8.BX-e&0>cWTX.FJ_12QG004e_M10?KbNL&,PfW79WU
V<I:;Yd1G>:KS)P1R&O#g+]dBFIT)6J48(dQ-B_+@/0baa8Q+U_U^SB]E(LP@D.(
-f8PPf-LB?[T.WXTgT?_<62g4A6F[<CP-Ede0Y]/&Aa>Y9S@A>f8=Ld::d0?;>g,
P=efc>_O#/S?9fOW?GZKO,JUKLL=8P9_9$
`endprotected


`endif // GUARD_SVT_DISPATCH_SV
