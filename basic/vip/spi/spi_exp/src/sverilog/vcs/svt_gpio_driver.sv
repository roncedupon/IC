//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_DRIVER_SV
`define GUARD_SVT_GPIO_DRIVER_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_event_util)

// =============================================================================
/** Driver for a master component */
class svt_gpio_driver extends svt_driver#(svt_gpio_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Event triggers when driver consumes the transaction object. 
   * At this point, transaction object is not necessarily processed or transmitted on the bus.
   */
  `SVT_XVM(event) EVENT_XACT_CONSUMED;
  
  /**
   * Event triggers when the driver has started a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_STARTED;

  /**
   * Event triggers when the driver has completed a transaction.
   */
  `SVT_XVM(event) EVENT_XACT_ENDED;

/** @cond PRIVATE */
  /** Analysis port to report completed tranasction in the absence of a monitor */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_executed_port;
/** @endcond */
  
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
,@:P-f[&4BUR]2-:=5MU+,TT;M,[X[S:I6N,PE2FT5IB+2Z6?KcW)(2\GC=A\0@.
D/.5:b\/ecf<89a7[(HSA[^4BWd0C6Oe9&-[B<#K\RMP&IQFf)O0.?VbEU4MNJP.
bPfWF#(\:XB1c8f6W;BRegVg>;A0GD5:O85NMMGOBR41MAeQ:3_X/fDa?2J&21(<
[2aB@c+0\M1<\<&HI9;HN/]\XHa2+QZ(1Z[Wa,)1]J=;dE<E9OO\S=P>ZCIEB8Zc
<SE#4UDY1@K2I+fD,(@ObKT0BVdD#R;6)fCbD+AE[:1Y(B(\HV/W3_H=\;(:@GMS
Mb3JBXH6E7?@@)V<BfQ3EfEL-f_>UAc/g:S)LUa:I.5+Tcdd,FGP.6T\_2>2eW@+
.4NB]bD3=>gOcSX]CLXdG?8a1LN<(<<<.U?;]TBH/K+fXCK3YK<M1M2EI(aA3BEL
9]a47,2364<a6]1RXXD@4GZQc@\gYH.<;$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils(svt_gpio_driver)


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new driver instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name, `SVT_XVM(component) parent);

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif
  
/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /** PRIVATE METHODS */
  // ---------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
F#dWK]a-SX,@GdCI6BO75Y\=fD<<T5EEI(#YeAg18FNWRUHd7bSZ)(86@;P]>IAQ
S#d7\G=+=dLM?;34+Kdg_S+gPSR?JeI0]DgDII9;LRP5)>@L4U18K:)K+6R0;GN.
(B;(A:NQG4&XbM<:=c?COJ_4[4&ERM>J.Gb:FX=e5F2O\+,,Y^8]4c^@#AcLaP7d
cdAKf=g_,PAa40L9G6>CEZHT:_@e;:Z0cF19:T6E9c.FaHZV+F&.b[[P:,M-N1;>
9<0JdKWZHD1a,$
`endprotected

  //----------------------------------------------------------------------------

  /** Method which manages seq_item_port */
  extern protected task consume_from_seq_item_port();

/** @endcond */

  //----------------------------------------------------------------------------
  /** OOP CALLBACK METHODS provided by this driver. */
  //----------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  /**
   * Called before a transaction begins.
   * 
   * @param xact A reference to the descriptor for the transaction that is about to start.
   *             Modifying the transaction descriptor will modify the transaction that will be executed.
   * 
   * @param drop If set, the transaction will not be executed.
   */
  virtual task post_input_in_get(svt_gpio_transaction xact,
                                 ref bit drop);
  endtask

  /** 
   * Callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void pre_observed_out_put(svt_gpio_transaction xact);
  endfunction

  /** 
   * Coverage callback method called after a transaction has completed or an interrupt has been detected
   * 
   * @param xact A reference to the descriptor for the observed transaction or interrupt
   *             The transaction must not be modified.
   */
  virtual function void observed_out_cov(svt_gpio_transaction xact);
  endfunction

endclass

//svt_vcs_lic_vip_protect
`protected
F]KW9[BHD+0;:>D9-Fa-TKGGf?_Z=2Q)+?cQa3C&@\L)A]Yb\0#,,(9?DUV8SY9V
2^ebOE<9FD]eF8DR9/JBSALG3G@S7X#M^2CU7+K))\,G&1.04737+M>?YUNQ.S4M
dAV;/7JUR0Q1OD-+C>T5R1ZA7@XI#4GS968C[V>;DT4_b<UM=L=8.g2<U8^#4E)g
\3<LNAFLE.6O/(&Ka/M6CD9@bD3A19H.,X\Z(P2886T&_b?V7WV,V>]N>N2Xe1Zd
?e)D9-T2?8WAb0.Nb?CA&VAc^^-V39)\2b,-R^_ZNHGdcPJaB@e+VfQ8Ug6-d#-W
5XPg+Sb-KXW)YG1>1^SN&NV+3:gg8&^PWg2(?10)=McS,)1g9<RNbG8CNMC\)I:b
HJ/>ZdTZKc\LZ:[5QKUMb?6/(3W:Yca9caOe_A\T5XKM\Rd]XLCM1TTcT^7LM_38
,HX0-FP_G7>(69JC&#-&5&=^N4^2(HdA3I?RZOK_Pde)MZ1/gDIB_e/0K^Gb>5GE
11_8EGGV#ZM1Y8PH&8:]Z)Jf@8.\92M#CcGL_T161fe\\BY^)46W4?.WN_^UO?85
MFf#L70gU0BKJ.]A;D4=0W1R<)X&OJ<]aR7a]D+A1OeG09A15bc6PFW?&a(aZc5;
Z#B#cb:_,^gQCF_HX0)3;_cV]7,[-3+P<ZZ_@XH)GSUeKUf62^YCB.?7.8@CbIHY
T1D6dY<3GJ4>OJ5IS7eIZeb?B6dR.]OXO71a@D.6WQ?fFg):M5XL#KD7>H219,6C
L#F/Z>&gFb7(5Oa#90X)UA^)+Z7SC1370D)-Mb/(<=)5ULH17#eY]JO4OTbZ,U0&
^;W5[4BgM)CF8Ha7;&V.<,1GbbfL;?VN>WHZL?IH3c5)fBMPa0?gI<eJ3a?(W.+Y
L-#LFGf]0KbK3S0+IU,=ZYO/dCeV,SZ20PQA=U9P@+;V7L7;N-\\CHbR\)X<M:E>
6/@dH\6IEGZYK35LKE25XfCP6([D&/:V4&+J#fM([9Q,\\3A&O1#1T0/>g;P&_F)
_ABe\4?e62C7\P-T4NNc/0F_@DVTF868)CH9AQT]CbB[XaNQa<14O,=-\#4dK2^E
9Q]K4]0O#H</\POTZQ>WcCN1d0_8K)+[;U<4]2g-M\7E;2BF8IE.#CJ/YYQ<6_DD
eVfVLR.HR5UfWCIe]D,AO:M5_aTDIbI[U<RW:e&B9^?/AaEf5/FK^FP656Y_6d/S
PTU]L[S0((K-/(N\M)A2TCWeA>XM=LLJegfe595\9M;&I#YX3_ZG]0.O)4FZ\E;/
DGg3\e5IL/AZW\Lf8=;?LH#Kg+H,2[G+Pa=]M8c=Q4e#(V&_K7J@;ObO45fgSV63
1aE(?[Z?LS>2e1W+=3YW:MeH=^9.G198:6\S(c]E6+)6G]H8G/HCUZ=:3K8D?8eO
(&T?ABUOWCNB&.1MM(D_LD);\;13_+SCDBDUOIUN1,7ENXM_=QXUP(OgKdbSC)[R
92.Sbd[d3HLY:Sfa9\(^D,/GQ>-MC3JgdDCX>.E[A0BO.S,^[]2JOdV02Q-QOO1I
e]WI,0B=Pa_8Sb>W4gS2eb[&WDc</G33+\&b\<-43bC;/^C&[SbEQJ.,TRcFK-S[
bPKO^741R&)^(.I94&//KX3H-DMf6c.<PHD;7a#NWB=T>gNK811]0HOa8G@BOBcY
;aURZCT<ZLB(WSA,VQ^g(18d0?:5cL?=Y3N5RGG=cXP7SP/KQ8PJ(2M6/6:@0(_S
4RPKURgO9OEf)M/W].KCL=.X,9285K>R[LG\;HK/4;b\OMJeN&TF]I<:07EC[18?
2A.,K_D6>U^31FQ(UgX+=/NC/05fdP#g>-cL[fOV=.8QeR+Q[XUX7F(Sd,,:<)YQ
g]/2M4C=9T74G>S9N+cKZ1A\P8-YV&\cCb.G0[QT\CgET(28QI+^IAg[TTO9fQ5[
\M<;QgMfU/D(767Lg#VB4-V5M6aG3a-1T_W&V+5FKO#7N.7f>QDVE76<.g9IZB^]
K0@\TD:#G:+:H)JZQ^LfQ39H^c#H-SJY&JP\^-M_JcQJ/eXG3ZP/F^5=.B.?Bb^D
WgPEV<I[Td\+/M4IK_WR50g:70aH]MYG?YL4]^RbF.>Q[A0T5T#5;AW1K8DN9GPO
T.IDEAVg4@]1@[S2bJ@YCb2fb?^5OAJaQM(A+H.-]K&eB8dSNUMDE?5@Y6-L/YG.
NQ(7OIO8VU5(TAK[^6Q=LZ7[H/9YB[DYfA(4G#=&STQ<NbM<]LRc=5\=fY^A-IY[
EfKF](Q23_D#\^9Z++HM4Yg<4)YR(U)Y2KD6bI2U);513HPA/EDE?g;TNUR5P(=b
LAHf0UeY;ZV(Y5C>]ZHFZF\=Y0bSN).?,P^G]f##Q;GUN150<_=O;8(H)C][U(W7
W-J]^3e6N]HG&IJ6/#?XcQ4_KdcC53VaeGdUY0bK:gO]1&G4IQ?N^-R39Y:[GO.O
@ZYLgBRA6#^6W\<,1b;&AScGR4J?W+-JWEC?<[H?5,+D+5O]).c5U;;\0N@?B05(
]X&&J3G8A#_^V\5cc0Q\61.R\,e/HNGQR8QZ[FcZEEBE65d1N@acbS/RT8XgP,>S
c//1gT0&&2M6b:1Sf]]&d?U:R=,gg\aWPA./g2;<@=:93AZf;7CU#3_L;MF&32R&
TG;]6^=fFA\6MT@NbFCd]S-6=aW4YM:acKJ&BEO&Jb:0WFKd6/30\YW-Bdf2Z2.2
ZE=L>L@7=aP[1IC3NM0bYHGB6aWS</E\1P)&/QO/<MZf+D=R?)A#SG>9SaJ0]f3e
HQ4B3>P7M(]U^NWN?^Ca<NYRA^2dEEH7dDEPg:O\\7UQZb+Q.&>Pf-(@e/DE(Q,-
SLSP@.WY5G6KfCCN+HHLGXS\e_.WHa8JaV<6^19JWMRA?._ME(/.9SB9BfBNJB;I
_7/-S>2<=F0&YWDTE]0CUZJ;0Q7Y@.2>F?]X\>#FdX\ROP^b;&C[d.E6IH8gU7e0
N;Q>7<,TRNE<N,VgKDc)?TNg.,C>Z1KFH90/9QR0?P0#:(<A-9-4:3c4-[3^e=56
,@75KHd\B[gTd6##FT.-0XWI-9+8VV6K2D8=e>UMF&.Y0F&M;[OF^:eDdd=Tf)T?
bE<3L;M.?]-;@6D17.3WMeAL/>\2f7V(TFfP\/g;Ca>^87]^/0(Xa1B@[#NZg\H4
_4A=BR<E@f3=8R8Yb0O/4_a;\3[T_LPfPgD[f_;e2@?7Q\gC,dF???Ja;#a6?.XL
gNZP8[Y0AT=eDcQdJ:8Vd_MRK#ISC;#?D&AY]DY<[YXF4XUUCY-dZQRF1a;N.ge#
Kd9Sc>_&;fad@Q7GZ#K(b#ec\P(UV,9<PJ<WO:2H/H:YXL8BB]f[EVVKO8LWHA=?
(7Ae/&gK+)5P>0^g3f(&eH?#JRCRe385:$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_SV
