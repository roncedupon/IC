//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_REACTIVE_SEQUENCER_SV
`define GUARD_SVT_REACTIVE_SEQUENCER_SV

/** Determine if set_item_context is implemented in ths version of OVM/UVM */
// // 1.1b
// `define UVM_MAJOR_VERSION_1_1
// `define UVM_FIX_VERSION_1_1_b
// `define UVM_MAJOR_REV_1
// `define UVM_MINOR_REV_1
// `define UVM_FIX_REV_b

/* We are using OVM so we must use the workaround. */
`ifdef SVT_OVM_TECHNOLOGY
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 0 */
`ifdef UVM_MAJOR_REV_0
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 1. */
`ifdef UVM_MAJOR_REV_1
/* version 1.0 */
 `ifdef UVM_MINOR_REV_0
  `define USE_SET_ITEM_CONTEXT_WORKAROUND
/* version 1.1 */
 `elsif UVM_MINOR_REV_1
/* version 1.1, no fix, so it's the very first release */
  `ifndef UVM_FIX_REV
   `define USE_SET_ITEM_CONTEXT_WORKAROUND
  `endif
/* Version 1.1a does not have a specific define called UVM_FIX_REV_a, so there is no way to distinguish it. *
 Therefore we need to just look for the subsequent UVM_FIX_REV_b/c/d/.... */
  `ifndef UVM_FIX_REV_b
   `ifndef UVM_FIX_REV_c
    `ifndef UVM_FIX_REV_d
     `ifndef UVM_FIX_REV_e
      `ifndef UVM_FIX_REV_f
       `define USE_SET_ITEM_CONTEXT_WORKAROUND
      `endif
     `endif
    `endif
   `endif
  `endif
 `endif
`endif


// =============================================================================
/**
 * Base class for all SVT reactive sequencers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_sequencer#(type REQ=svt_data,
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_sequencer#(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequencer#(RSP, RSLT);
`endif
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else

  /** Blocking get port, transporting REQ-type instances. It is named with the _export suffix to match the seq_item_export inherited from the base class. */
  `SVT_XVM(blocking_get_port) #(REQ) req_item_export;
   
  /** Analysis port that published RSP instances. */
  svt_debug_opts_analysis_port#(RSP) rsp_ap;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  bit wait_for_req_called = 0;

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   * 
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name,
                      string inst,
                      svt_configuration cfg,
                      vmm_object parent,
                      string suite_name);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);
`endif

`ifndef SVT_VMM_TECHNOLOGY

   /** Generate an error if called. */
   extern task execute_item(`SVT_XVM(sequence_item) item);
   
   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req, input `SVT_XVM(sequence_base) seq);
   
   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp, input `SVT_XVM(sequence_base) seq);
`else

   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req);

   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp);

   /** Continusously wait for requests, calls fulfill_request()
    * then forward the response back to the reactive driver */
   extern virtual task main();

   /** Fulfill a request and returns an appropriate response.
    * This method MUST be implemented in derived classes
    * and must not be called via super.fulfill_request(). */
   extern virtual local task fulfill_request(input REQ req,
                                             output RSP rsp);
   
`endif
   
   
`ifdef USE_SET_ITEM_CONTEXT_WORKAROUND
  extern function void reactive_sequencer_set_item_context(`SVT_XVM(sequence_item) seq,
                                                           `SVT_XVM(sequence_base) parent_seq,
                                                           `SVT_XVM(sequencer_base) sequencer = null);
`endif
   
endclass

// =============================================================================

`protected
Ga=.S?OA);2IU.VQd@+WQ2W1CQ-Ta.99J1,89TCH0G7O]a9PgE.U5)VO,&/S5Y8A
)e6Y)0-O_+;MVEWCF-,OU@W>&FHWQ:(#(WE2C/6Z^eA4Ya#CF1g(a/:J][[Fe56g
Ad4Gf1>gU-bKL^;-Zd]N1.?cc?PA&1E49)fN7N90;F37dGE1:XN&bN/TH/2/egY3
;3-bCdBG+DM>g4,Y1)9d215B)B][/efH+.Pg@F#Y&aFVVBBAeYV&AO/P7SK58?0F
6@(\L5<Y_VQ]]aQ3:F0PSJ&-\A8W594cLC:E#Rb^XT2NF-W7g-cOCFG8IE_;TJ0J
UWgObC/;c]8E6aROP-QIa(8U)2?2g103SKGE#3?9=Bb(I\5255\1a>ef;\/>;Y+)
f(&UEE5]C<Y18JO&OZb]=><.-1f3G\ff?gI4)Zf0ZFYNUEV\F\H1XUeJD=,WOSIE
O^Gf8UW.g[(IIG@&32_W9XC)(S#Gb^X15be@TH[g]fb.aYRV=J20:V3Xf/M3OP2(
BS)L8+C&(ACM8IR^dG&W=T80Q:WVRC4IJ-O#NJ3B7/)BZ>Q0@[ETe;BX&BOf,AHO
/MJ6(1:&_;_WI4./UR<F7(8PHE+0T5\bd[Cc5&b0eS6]>RZ4PZ]#ae9/JK?1LNf1
D9g30ZQAd.E(W\2-R55dH5NP=Lc&2]gXFQY0d#9(8[_]BYG6HUEfE.9^8aT0;XH0
.4ID0a=0FI3TE@B?b7HC8#gf7VT=4XIWA\;<_@?X&IN18P5\QWRS494<G5NG10-8
TM6OHfV0fa0:@U5A.L<?3#BL5IeXAGE5cWV84cNQ:@=b??If7XFHL/7JQL&2d^AW
6.LT;-?VGPY<4c0@PASICNL0C>Q\_NJ1NWKEP/:RFGM./C?_89YPbKOTad>@&2U<
3<b[Z539<4CA7gOMD)ffWG\#O;N.8,-;7FfA9W#X)2^C+gZO0?0eb1^SM5,d0Z^b
^I:O2_6FW<DWGOdU[FG99@8B27RZV5J(^G[>Q\9c(\?I\<G,CDA-=@f1<2,HUI4Y
48J,N.D@9F3;\RJ=#+0^4+)NXA@]Q17Kfc3)Y8QXU7d\95NcFb-_-SZUF2:N7(Q1
QMTa-AXgX#5_VC@I\::+):J\JSO1.CH6;CS<9ce0-;OgWUcd401afKcSTSENI7R7
]^>B3)gJC,6:5R\[J;V_AI/J:@1B.C6Q@2CTQWX1Y>_N\:517ZVM51#a0bO)TA16
2/6+XUe(@7M)6)4TWYE0=/PHLARKJ;KDAR4DP^XVfN+@.e>K/UD/0fX0F=L>JD=<
2=FL?111@OYAdPFcEaB:(FOe#GDgE#QD@.[3306[@I@6C))+ZD8)>7]2&?OS5^?4
9+_f@3@X\@@YB<I^Xd+4F+]=8/]QUF?^aERVH:K1^Kd_1_Zb[8TT7K[e_WVJINe-
Of_U=L\B3D7V3V>]/#R<O:G6QDC]70+E42fY&1Of>XLN:1^];1VP,AgVAE3;5^<B
ZRM5O=1a9DT+b4FN[5M+,dHNSR,+,RfSQdWYF61SS_7E_.(/0=\gHb^f9-YK=Y?2
QA0J@Q);@KZRH\XQC@]3aF0(_0&J2-c&&eg;E65&<R@_KTG9bUZTK:cGQb=I_J.X
VFeV5A5gOON<(]DVET98d-.)f6DcK9[B.1Q:[<M?fafVXS<UC?<Y#XRTQ_.;cGA#
/T5g]ZX(M4W2H/gFZY/ZXGQcYX;\fU(ffXg<-dF&0VEgY:L6\U02f9FSEE4:C[(C
<Oad9Y4-.VV?Q:Z,B3g38.,B,@J-A.C5+@#^J]P_He^919T\2?.B#cOPHZ^&g]0S
06L_PPP7B[)3fPXWL8WE8X,B2$
`endprotected


//svt_vcs_lic_vip_protect
`protected
DFWQd,+NKFEY^-\4KM;QD:]2A-VZ-e/INL1O=6a_)NP6e^GV,D[V.(:TdV^gD?0\
3E;ad3PZFJ)HC@12EZ+0R]6^[;CceD<KH^0N^8KD^c#L&FM]1gU/RcXC\<e.VSAD
]\Z?I,PKgHE+VVV=_U_DJQ0g4,efFdZM<T^.g)T6O,&_LEJ?E0d>AJTXa\E5^?;c
4-WTM423\DVaD.g)0J65.>N,)gc7@V:WWFJ,a9<[(2D-7f-<>_(O,GeEQ8eaV8SU
W&?AK>(H5&JO:WAJ5fMW?6;-X3.[XYD#>;VLYI[^/.ZN4QFB/]8,;<bbf4?g1gH+
DH^4I?24Hb#4fWW:]_OSWd(E(&[c5,5OG2HP240-d_,G6+,>E^Ed#+>?]A??b#AW
?26TAU7Mff;AD]D]IZ(GEFGfE_UTKA&A0cJ0_cgFG@A/faFf-GR]<SG;cZ<KI4&.
X_Z+U_]U;>W1_Y58H7]V7W.[Y\V^]gT-7UINB1,GGOW#dIW92S[9TVb7IL15](1V
=YHR]C\1?Y\Ba)O@<E3(F5ODXB,>db=KT/#MX[U27[CRYAQQgcF3PXJY>[e\K7Hd
((>[MPSCA]EJa.^_WD#TPQU/N2=_:.LJfc[M?bS&M[NRQ6D^@Z&Ag9fX_+3L3?P@
2W2H=9Ve.A[fU^V_DMGKD0-4gJ<PV:91JS99<<g7FXQUO=O#M4aRNSQDc@Y-4@;7
^]9.PbPHYB#_?[.L+87[dE;;01J6f;=CUXBS\H4/-PcNE&5SOC_?F,+[G-VH@dKB
;HUS.I@(I=U-KJI<S7J[,@UBVOBa4OK53(JD7Yfe#))7S.+37SW#7;<GeM?63,ON
(_/>.Y[L?/>03WI<+EDc>J(EA81XP[\/NdP[>eJUNJgaN_B,NS8&F?dZ74geL0TO
04EO_7:[12eD4H=X5;@PK4CL<F<499O^LE8)2]WG-fB&T\Y<ZP;dVQN;d8<=GSeY
O\>@c]YX@.]?U[HF6_92&R=VMd1#PcXAD)_7Z1bO.7^0Y2HPRVT(PDSN:[/;\K[_
2dL4/0X)W=3NKR(@7O2))bYVDA^TE5MPQZ:71+)8[K384UC([&,#eF=#G,VMF;]_
2a6QecdfD-0gX/<9>W6Q5b9)J-A<9R?P,f/YOR.W=fEW92,HI])[89g:+)^2>/WQ
3aIH+5QN&HTOSE_EX\b-@fL@c[4gJ@]];.-U32g=J:CZc7g;+<LK#<[N3NAG_AdS
>F,-b,fA@84c5G65T9.ReTeGGDUb64/Df9]W:TXC\9+DeJ(WCe<K]eF):+C_F)+@
@[Z)^1@?4<-:.4AEWRaK32#0M32=g;.8f,;/@NKLGBM1b9DR^:EDAOa)]QZ35X&-
?CFE88BU;Z&?SOZE(A7<W1(O^/+-/F+cB(P,KP<78#8T@Xg);)Y/OgGJ?;L(cG=H
MaWT530U]\JO.@S#Y21Wa&#V;b-N5J<<5WF>KcSdUb2^RB(H6#5_=U:+1f[0VSNG
5CZ-HIG,^c3)+?]C^/@^[4A_@)0PdI6=+E+2]_\X?AV/#=;e6=U3K^ad[a?N2#XV
S@U,SC=g^::I7PTL9,(-abO5[W65++ASD12SX.@LU0;UL+X+dd7^cB6cQF8X3=KG
K#\&.CO+>@@5=0SE\JE1G>A_@T@^0>FA,_]a[UJ;CZC@2NY,2,==6D+1(7f\S(1G
/<)f?e:YIa^7?)bJUbKCNe]XFWg_^SHC1@D1]cE&AT&69:/&eZ&>&d7(:-?79/6V
E:4[C:GI^TG9K#2S[0M&f#>T>[)EdD++g)CC7QN5#WOZ&9YO1WE9:S&=;SP9][=L
Y+RbUYTWf,:Pc)O&<6[\#3^,4@Y>fD(5EPe#-#,;PH,X/e=M7W#T0F:.;DRF0aa1
5a_P_YKU3)MS:65E^XI)\Z1_WLI@LLZ,SgN4-AEAEX1G.E)F3PNHR08G(L)dUTJ-
^fA>21H<\@\=C4fgDe7>Nb#<<f3]d0KC98&f?#4_YS7=1O?Zf(-IIJ@eTMc/\@e[
8G>OCc3C[UIUWFad])2:C^N6I/&7cUTe??M#S/E8QaadVVPGaO@R&S04OU+[b[4Y
Q#)\W6d1E\X:<[/M-&SA,EGNYF@f+eIER3UP@UG66Q0:SND(R<JB8IL<6MW97Y[g
)IQY+b&EgY>O)7G6>[a)A6>4&-UK.EQ(.E;6]/8)_2TWKB^#6(>/IS-I6IH+c:f^
WD+F?b3][ZUcXZ??Q8CR14Y@c3ICV4^TZ8c)c8-);:3Q3L.]Cb#^.&N_XBgHgg[#
eH&:QFX)_OL@NcRLK]6RH4OOFZYW\0MF8G<_KA3S#[@\ZL6e<HO\)9ZEW@(WYO#(
IbU-_Z-N#B1:=+NbJ3ef6KGg8;Y6&6G?)BbW3[Ig.[A](=/W-BbPW=f;V?>WY-JA
HJ?)/1ZYd.K9)TV?;HLDCDB0)8)&/a4Qg2UAYgPad8XXTL_/&6((:2+KL-I)WeY2
>;U)[.PRTa>WdZK<Ag-\:57+G].H0YOQH]f&5-.#24L//<,\U?g[,fAE1?^RFY\d
L/?;fD^,&edO_V9S_:@>)1d?d>6LF&E-JD8@g;XNV3#AUWd7W=3^I,<gRE2Z7da@
S&9A,ERDfHZ+0=UD:5@9MRc)6>29FVC?2-)TgH4J&O;Cd[bAP4PW<@R,\9ML5?&[
A&+&D3J>]5]O6-,\#c6Q_(537d\7X;LX&QTaA01&;;Rg^^9_Vd.8;[5_Y>Kf0NJZ
a)?MIf<QDUEMJeB[N=+8LEJG.-_2R0+DH:W6gM9<4#,9PSAHR9^NQQ.]W[Rfgbad
8PLGIDS9VcT5TA:g+g2:LBHB[Be-1_-1Z(1^S;3DT8/?VC#+OZ0J<XRF8@/^+EN8
X9<8=D.<;5,O8V_G)7(;P&_:8Y.[C(S8B8+O8)>SGNc/gaCfcCF1/TZV6NH(+3+L
B/FXbY7.Deg9g>P-/bR(=(]RSe:?B8K4PZIINa3MDfQaF3,:CQ#[<>L7_](g-NI3
YY4AgV]23b,9QDB^W@K>5aPM?)\;6&C)/a]KI6_L6BgE]1RVP/>72]1>T3T/-HF>
5.^d_<:2Q>869<+>AQJH8=@1W/O<J[e2aUgTe3YZbfPY#WZBZZa5_EB:3<EOIVX3
3@\8I2<H(@HRVP_KZYOeeEAP.7e([=3OV2>.>>4=,.\I&/X4+8[3UCI#Rf5@E.4S
_Ke6_8W<8N1RfYeD)ZUU[SP=;dB.KEI?W+2;H/EdOE[9/I>+I-)-dH;[+GJ:=,7L
]?C0YWTR-/_f1dE7?8ZPIb20YaZFagV4A.F#\Ra[b-8e/5.I7U0YHgN_+<FCO)_]
DRb;KN)KS\-IDa^H<KDU<E(#4D\8.UAIdXL@WRW?]-5H>H_&(d/>Yg>+E2&XDPI;
C\UbbfC0bUVcC&#F-U]BX6>V&S1T3F?LcE>XZAea1CB]:C/]@><A@[<&)1d9^(GA
6((1.KL<2OM+H00SCY[e3:Q3Jba/LK\1S7QfYU:/>4.F(d<;L/gXNIZZ,5MO+SNR
UQ+^BSfNAdLD,5DBU/^I9R8g\:8>J(BNV#1/:Tb44g=Lec:RfDD6A/9-7<-g]>Oc
^/gAaC_J+b&=C+U?<TaCcAVb&:[A&NYTVQ01K31QF@EaDHKRTQY,:Ve=3DWg./3:
fYR/12:;ZX6<\5aG+fT1=4Z[2394d4:Q?S4E2XXNXR+493gF?9XT:fY9PR?[0>H>
^]-cSV/5LKZO#fK^a.OeJWG6GN2gF[fD97A<5;cDW[POTDUCab>,,OAM-53d/5>:
]C2cSCTF(]Y4F1B],@fIP21MH66NC2N]72>)W8Qf4VH2F0aE6@68@WVTRN_:--(L
J[MMT&1^K5&ODLNX<^eM6E3R-8-42RcUd6V40T)6S?,PSUV11O_R7_5bc]V:0P52
V#9=AbTLAGAd^?R>X;]N2]UA?>P:R0b33Ig]aZD,c52dU3cQOGdcCI[Z(BK)&&2G
O@57C.@(@E3KNTOJX3M5,G-IZ.C.d8X=\OMP<MD]PBK^Fb80JF61<6@^&8+.BFeB
JP3f:#Y:BYJWb&J];0X@X.R4-)-A-Sc_Ub_QDc\b8LE@a(gNP:,aZ0V5^<5^U:8G
X2O/3@RKeBc^-^W5F[]JB_O#,K^O0#GZNI>>WAF+(g\XVWdFGUWU\C1G&-.f:368
H>U_cI1FYWLVT>Z=-QHB.c)(43E@P;1)UeG1a\_PTa&]W]ZFT+9,<31GJ$
`endprotected


`endif // GUARD_SVT_REACTIVE_SEQUENCER_SV
