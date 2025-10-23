//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------

`ifndef GUARD_SVT_MEM_GENERATOR_SV
`define GUARD_SVT_MEM_GENERATOR_SV

typedef class svt_mem_generator;
typedef class svt_mem_backdoor;

/**
 * Callback methods for the generic memory generator.
 * Cannot be used directly. Use the protocol-specific extension.
 */
virtual class svt_mem_generator_callback extends svt_xactor_callback;

  extern function new(string suite_name, string name);

  /**
   * Called before the memory request is fulfilled using the default behavior.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that needs to be fulfilled.
   * 
   * @param rsp If not null, response that fulfills the request. If this reference
   * is not null once all of the registred callbacks have been called,
   * it is used as the actual response instead of the response that would have been
   * produced should it has remained null.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void post_request_get(svt_mem_generator       xactor,
                                         svt_mem_transaction     req,
                                         ref svt_mem_transaction rsp);
  endfunction

  /**
   * Called before forwarding the response to the driver transactor.
   * 
   * @param xactor Reference to the generator instance calling this callback method.
   * 
   * @param req Memory transaction request that was fulfilled.
   * 
   * @param rsp Response that fulfills the request. If the response is modified,
   * the modified response will be sent to the driver.
   * 
   * In most protocol, the response is the same object instance as the request.
   */
  virtual function void pre_response_put(svt_mem_generator xactor,
                                         svt_mem_transaction req,
                                         ref svt_mem_transaction rsp);
  endfunction
endclass


/**
 * Generic reactive memory generator.
 * By default, behaves like a RAM
 */
class svt_mem_generator extends svt_reactive_sequencer#(svt_mem_transaction);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

/** @cond PRIVATE */
  //Memory core
  local svt_mem_core mem_core;

  //Default Memory backdoor 
  local svt_mem_backdoor backdoor;

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

  //Generator Configuration 
  svt_mem_configuration cfg = null;

/** @endcond */

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new generator instance
   * 
   * @param name The name of the class.
   * 
   * @param inst The name of this instance.  Used to construct the hierarchy.
   * 
   * @param cfg A reference to the configuration descriptor for this instance
   */
  extern function new(string name,
                      string inst,
                      svt_mem_configuration cfg,
                      vmm_object parent,
                      string suite_name);

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * Return a reference to a backdoor API for the memory core in this generator.
   */
  extern virtual function svt_mem_backdoor get_backdoor();

  //----------------------------------------------------------------------------
  /**
   * Return a reference point to svt_mem_core.
   */
  extern virtual function svt_mem_core m_get_core();


  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the generator's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_uvm_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * perform svt_mem_core configuration.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

/** @cond PRIVATE */
  //----------------------------------------------------------------------------
  /**
   * Fulfill the memory transaction request by executing it on the memory core.
   * The response is annotated in the original request descriptor and the
   * request descriptor is returned as the response descriptor.
   */
   extern virtual local task fulfill_request(input  svt_mem_transaction req,
                                             output svt_mem_transaction rsp);
/** @endcond */

  // ---------------------------------------------------------------------------
  /**
   * Cleanup Phase
   * Close out the XML file if it is enabled
   */
   extern task cleanup_ph();

endclass

//svt_vcs_lic_vip_protect
`protected
/A-6_f9S[\OLE2+/;92Q;H50()ed&SI7LE<69S3E0CI8WHa4CLJ5,(8eK\I-UFg:
7JF7[Ff&SPU8:W[c48dICg&CdHb)&YRIML#b)@-NO80+<WIfRg_bEdeV)gafF/E@
A(,e&VcDA3VR?N?O&]O>6+2A59@8#;O7OE[I0<3@-N#5;@EQL/AV/aBA(#FUgIM#
NQ&T<3D&WSKF0PJdJ^T-?I7P(EC46>7>OP.;YFW.^3=+8^4dUb&_0[GbK.OSH>3\
GMS^VGXP>^_0=6SPgK9T4U+OBW+)4LaU,E>(@KA2C>BWF>VYQX15Z1QQI8.F)bDJ
KHW2@.-fL>X=4_30)G0A;+_W&O=+g@]^)V(8&:deH0_OeVT[J:-F,S6I0XWG[#P)
>./?T8V\BQ53a](NK]_+KO]_EZ\dUG&cgH5IAAU7AI-):G6cgS8[B>@]?C53,(T#
BNRG1W@U_6P>c6_)=&Y2?b&U@<Z.H@eR>Z^7I7A\cBXdgUE5FGO.D.(,6b<<^G/:
N8.G>,e2:)@XG+e+J7UJgHVHZ#/g:OE;^<][L5>:83K(RM_7))@WMGUZcABdM:4I
bS^g,7X5XX:]g1<2XU^@U17\08DI3geC]P_dQ7_:W?b).CR+30)[DP2J@0+:I)/U
_f0Y0a,7+Xd^Gb@JV=@ORcY\?[@GF_>gC;.WSM0[#6aHL_,87C1g=O:C^4[X3QLK
SY@AaB85)9W2T5c\Q+;7HIL7.,X+6<UCJF@NF=AE=XGBMFc]=,9beJOS6C\f46U9
0_/gSTDAMN_G\gKcfJWJfGU3ID\><4:4&a4]C(@a2I,bW>Z,ERO8IHH@E&9FTUC2
LFH&O]JEKL^S]dPa.b<JcL:VH+ggc:I+YSWPN#ZM>VIBK]1W\f+)b&O;XJ(Nf5JG
SB-D:AYOU8T]>0G^M\+>1<N7&IB]HI&D/X9@]L/TTa4&:)VAZ.SLUVXg&L7b>XK2
c3,23Q7cV6;UJMKf:LOB5,<F455PM@P(RePC_P7D(G6J9fY,B00QRO82/WO?[Q;Y
RIR)K;GK^]XZK/T..9BaSbQ>_PG2Y.IL8X;/\3JT7@ZQK=;]f9<FD5M&G\9(,Eg\
FJI#HY2Id(7,7OBHf\eFLDV?_)WHDB\Of=TgdP7KX0:;#bE^P:-)7(7?Vg5#K-[)
VJbH@_0d?7cXXc7O2\c^Y;2LdEY\]/\^C&4dDA=N:[T9),B33\7SJM[;4?QaOf[2
8#2+a)Q(/LWB-5+2L@?.ZGdXe2a^]^>J7W@S>2d_?=)&U4bDgZ=&9TM6<:HOLb<D
Z7>?dB^S5=HGbST]bH/A:P8LV3Lb??)/WJ@;CgL[E1J:8:=>=>:ZN(JK_A5_TM)f
,+L5[(?&0Z?HcgIG;7QeCJ-AeOAC]/UE>CSA.@E7(PceB#65<ALIN?X/KD@/8_]:
:_):Q-Ja2J1_IIOP,T(WFGFKN1=ea5T8>(FR5_dg8YB2FL&&5C<cE#)1I)9T-=&>
,[GPWbOUd-G&2/)=;RJ@\O]YOAR0PW\A1X&XT4]EaF)[f=ZH;K;QbT6A1NM4?[<X
7C]a8#Z=U+d,(:Q:cC2Ga?d;)C#(B7I0_4:VS46C1bSgF?45P?_F3_P:_(WIPa-=
XD(1ZXNHZF\3AN46e07J0(<?WK-9f^Ff&FD)#OZ:Q-1:5A_KCLScUd\8\U8aXOHP
d]ZQ+LW>a]-+dBG&Fd9Z@fb/E:2\2d&N57?^-Qg_9OKb1S9OJVB[[O[8dNV=.fcB
(I6D205D<(XBTV1b[O.L.#_cfWPB<-DXN[@bP)V)f&de8S<bA@&8^bQ2D&gKZ\F,
FLP#/>LRHXVZMCF:UO@e;A8974@[bcMV#/7OM,445I+JaC@6:T\+>gE\K29bI+a8
G+MK&B_K6/03Ggg7W^PYAH+bf21GWf/M\dgG5@/c900g&b>JSZ7>(@9eB^@<]5I1
XN,I0S^M>526@9Ze,d>g1Y,K#JRUe5VdN+eSEB[_V0+=a7BcF5N>3+B-gPP+<O6/
T0GD=?/A]<G\/IN5>MAd\(\Y,XP0f\UU(FEZC^X86-4B:OP@((,G3N1F&0bVV3P9
)0_^MOZ1Z5-+LKfWSQ^1+V1a6+IL^?ORc/VZID]Sd;U1e9<,f/:Y,V3@+A#D6UNc
da0N1X<>1>W7V#O=ba8UNc49YOOXffe[gS>>8KLGJ2()(.d7_Ucd1A:d(2ILLL(F
a\X-K8236O46H4D6X04WcG7WU9gQD[eO40Ca3F9T/f\>B@=R,Tg4IGgN;UUd5[Aa
BaVFU5S=;Q2/_3DEZF7,?&JgB.TK^8U51=f,D:-.:IX=7^8,\CDZ?ecD3b-+fbef
X(?G\BX,8(#2R^QA8?GKM<b3)-0ZD>Q,-\=(9X)=5+<ND\^0J^-9=SRRAY1,/U1#
&.fOJ\O8>Y(:XS98a<de;H+c?XgEBaU_P-1/5Q0VT[[b60<277L\,fWC.\54,X5+
4d]f^gdTOS:KK<A73HS6VcPAEFQ8#)Y:D37U@d6QSTCVD>X3V/O1:g9;-Od-(?QC
S)g,f\OcG:Yf@E1aEI6[+(EZ?JS&EaW,8EF#4:-C;8EFMNC9gKRPM<R?97Z]9:35
b\O:F/FZQF9@g[H5+?0V5NGT0V6+e[.2M<][NET[1b>OEK1<VDA=I_F[^6E_WQX_
5-S9YF6&9;ZCB64@5<DIJ+IL)aKRXJIKM4.H3aQW\WYVZO_N]^d99FROED?J4/0;
KYAGc#))^PaKc?<SVeGZ99.0gCJFOQ5D9]C9A+1+\=@194<]aSBeL8]TBKBBNSTK
?T\RU]MW[1c/7DH_A7@P?9MY2XB(H>@6/QgJ05[6VeaF4)]ZY^SfT/NXHb+<Ub1Q
c_IDDGg6STDI./#V7WbH@[U0I25)ePV5^ZEB<.g.P0Z>:KQ6,b&J2XVD_D&P\fQA
>,c8d(]U>.O-@dS-bQ+KU_6YE8&BBX<H2IU\b^7>S/&AU#TOFO;PZZJ6Q^@,V<I]
2dG0:fJ75TVBd(XPQcU<4#4R5IY:;C(;6724<UbKJ7KT-[OZI3^S+K?)?NR/8BSM
<KU^CLH&T<&2CX=[]N18g)9UWbK9<VI)1R0N.K8RVF/06G0>R#3c\.I7^f/DXBa1
(F-+1.dNG:SaRXH<=X?S/Q16bFSQL>c6=Wf,=5V011@T/(34CVg.B]C<a;/LQS^5
TUN;Af>#=_8<#FR4DaKSX4C?L2XD(FeF86KPF^HDD&;SU+)SX5+T,^[8Y6QTY-1.
-WeA1X=V90bZS6EI)4]8IRV+LT&\c.8B;3[U<-5I<E>N,?ZW6RLg3^>+.V\V[A/Y
)>#RHbb3O1,f#Od:F;VSRJC(3fXS(=bHB6#,gDd(Y8Cg.2L\BKa-cd.=&,L>D68Q
aZ[(YE/D-1@8AO)8eaM;0;PaFg1/_bdZBV>>HEW=&YMR1>G]4DW)0]BOXV[<cf;/
&)6GD:-T#?KMgV(I9;bB7c6GDca[.]&,fd^&)P&@G+J:6QS,-,S>#,Xd^PgIBG]G
QF&&P,<?A)+?8SR\;\_Ee@cA.a(?WBI(),KQefaRX=B<#_<Y6WeHFYKd;?&IFRd6
H,LfHae<AH156Z,a/\1(>2--/\H/[R^8b<ee^O\^S_IH@g[.Dcg:FZ<D><4SW3#5
HD,bE?9Yd1P/]N1BS2NYV;_4F:GDO-(SVLA[f0OK@=.I;IA>=,bbT#F>J(b-K7?W
;1/b:8fSL/5JgN6V9,AZ)],OgXd#(1E@a;BP,OW<P1R@-A+g\?8:W\8-G)#H?eWE
N3cXJT6N1=ZF.Yd_e7;e:04R2I+^AM_90_,L2CUJf6f;XY^Tc4-cWUOPEP)T>5-S
:V04/gYQP>bOe7HZ:.?\32f9#43V&=&]3F88)DSgDMK+P;DbP^<QRW3/1:4GI<S5
WPN-gba[OY=7PS2X0L6Hg-eO=0dT?C_BM^PX8,=Sf6H/O_A^gePca3IbI\4A3R6N
,C,N[6&9NM?Q67>J-95A/fHb8ddPU\N#2EZ,3.N.AgKH3&acD<ILJ/?eLK9J@G/7
#65a>B8T:Cd4bFEBC\R8RY?b1+>TfHGQE5-#gDP)GK(0G#Y;80e#PbM#YL9]643D
E@7/RJ3)3&GLR;T=:_,+2LN><5R7a.Ga5FOEKW;WeOXH>G7-:H>ObSQ&0H71=Vg\
,C2.L([aAd2Y4b2,)?f=-XE7Vg@,U.V8Hf7W=6Af=<VSA7XM+RcPcM,)FX4Z8=4a
3HI=OHM_54)I=-#,-]-8P;fR9L#(ba56<f-<CZ(FY7f-QW)-Q7;JCV,)M$
`endprotected


`endif // GUARD_SVT_MEM_GENERATOR_SV

