//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_BFM_SV
`define GUARD_SVT_SEQUENCER_BFM_SV

virtual class svt_sequencer_bfm #(type REQ=`SVT_DATA_BASE_TYPE,
                                      type RSP=REQ) extends svt_sequencer#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif

`protected
2493J>I>>8=<c#9]<0-g_71A@Q@N6eP<BgB0903G+3XM]fP&;]O30)^.U&e3<)5<
b5dM)egZeC31CMKaBE1C>a7H&;@\/N(5://PNS,SL53[;M10(9U\@cXd22.QA]JK
E-6-QA(I?e25)=#VA,DFM9OOZaODb4JbI5=7)6PV?C>V,=7W@.@d#GXdO$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the parent sequencer.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the sequencer's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// =============================================================================

`protected
FL,-K?MM2W:VbA#a.a&JQA,RL)dOC]2Eab4BD.4N[@+66F[H;O3?7)7\@g0_HHJb
SbJ]Q^g(];CdP]&+1bXWL+V2FV,d1P_09B(fQPK-eNV;/S9gV-D(O.;Pf9HLT[/E
[+/.gPNM+Z46;E]/,.,\IUcM4eKeO&6)T=KGece<C9<D#N)[XY9]Q/3_@QEM,Z;I
cIDU._.0OUC+\T@([5LB7[95ON0NIVL?3,)[fN2_#5gRCX.9]7>RN[TXdGG)#YfF
#0M6;-QeV4KI,70eQ^gSegMB+gJIG-:GL8(#aXW;K?G=:cb7R0[I8OYX^.W09fI;
RWDCbdE)=5SIc)FZ-a6^<R_@cJ#1\>:<_VL#gK1/)f[7Q4[7XM/3b46c_fJdCG_U
b[S6DRO(7QNTN;3646eLQg&4?[,(+E]_O?7Xb(d>37<;@T#W1>_aWRZfBNac]KCN
E>;RWZS&Tg)4V6NQ1^@DHbI7.W>O1CG7/(R(If:FUd&_^ZU,(d/F6#03;f2EK_35
F[/-O]a=ZP]L8QTFJ7B9;>O(;U0EZ4Q8g2P,a51HY582_PJAY7_\b\OLKf5;S#02
V<&Ae_IE(&]?-K>2;==0IXONIN^6eY,_:3AE]XaI^fa6(29L?\NU4R38.IAD:=:D
<_De#0-21N.@#]:Q.a#<T=D+3O9I=M1]6;g(H8_0XKTSWda_LERF&<(VNV2eWVV3
#W>)T[#@+#37V<QAeL05C@+=\?KFZN&WB7<B(R)U@/Se[D/6]UeU,BO/UKV9L&A@
+[),XW[3<B.L6@+DPYC0fK6g:C?<OG)BXRE+3EJf^_([X.ReeJe]fG>[#PAEG?D[
8#>PF0c\EcI9Q;gA,3H7C)P0Y@CJ]De)C#OG(d>b.J&)?<8&d_-3^>=.R>cg&&)Q
^0UN5=REF2Z<&5#=P80eZC)V88.RgY1:.KX0]^7@MfK,E-HHEQ5X&K2NQXWGM00;
O5>8]&#((^(SK>RbEbW(\d.cI1N2FASM#)1UB\EaF7QQ5Y>WObLUW&SZ_3Z]32_D
a,FO3NU]#NX-P;=I;.7/1dJ41IGY,c.;5>=1cIWP77>2eRWa9/d&C]30_:JV=bT]
\DLRQ?MUgV71b>9[3H(Q<8ZdGL2e=MDV-5LWREf>7g=[FbYW_[SK+OY>HXP&VAA6
##HYb+@Z:_]4(OA1RHF_YHA2O.&&K0&c6I9?WP+BR0C>AOB&3QF@VVb,aG8We++-
>]2>H?L2BL8S.;+0V<Y<L1QG3d^?3G.OfSfVH/IYX&EHIY8dET<E9/^F]:+YeHb.
J+S.d_O6D+@3HNe+BY-XPJ7gXfT<T4(N(Qd6AEP#7+<0BU>E#0S=WW<POHI^\WeL
61gO<)71R_4_-.cY7/E/c;1f#]01Z&WD.R/+CXUdgN>X5#5;XA2?-c_O3)6OJRLa
=(7NH#X(.6PLTLGg7)P\f.\=#R_/YS5BfK+[Z[WU,3]]IT#EeTVBN>TS]@N\AEb<
N1U/,64AgYJL^+KTZF.G7J?HPD(H?,3=69[e=0I<?EBC7/DK<</U=,K[XJ#8&J;D
<,I@4[SV3:H-[/+XH])?\=,[6[9B+0?A+4EZ5LJ-E0.D<0XY1,d5DJSf3aaJF+A8
?]RHJ_Zaa1M0],S7H:1e9ZQDZ78WgN1..20SJEf7\L8[g50M3b[BIcXEN)]d]gcI
:]<aVB0<d+&3LZ?Wg>3-F,[PKfS(VZ-L&SaOD#=HA#S4UAMYQ.N51R>^PJcY;>[+
=_KAX0R>&M@V@,)&P#.4#V81KX@-ebc)_,CeQIS1,1Ef@ed^YE9dfEVe>C.-7c:b
QZW2Z_S<]PXXPe>J@G.UE4NWRC_8>HNX\J/ALOgI.0]HW7S9RXg.PZ6&TYE>3U^6
AQ)I81U5\[dA#AMUReF],C/9ScGHMbDMNd:2f^Z9=CYFQWE9BZWPS+WgPMd0<(S&
5AJK>cDXc6KA,7a@Lfd)e(;E]J_(&dSHYQNcHf,6,FT=T5d?DVR+.H-]7/=72Z&Z
\MCJNe93)T85[eM&/1UDF269Q2Yg@E]gKG&MPEf(,O5cJI/e\5d0&\^A737,RHKV
:&Pb.M>ODg/EQaHH^Hf2I?NL+DZUSB+gPf-Q-,gH^g-\XU&Fg++72dV_EX<,SX&+
MLE25/K+&N1/LJA0I;^R6I2aFJcFcHU=](])I2:-MdeB.#E)T<KSD-WeO4CN1>&+
>/ebQf>(_c2B)Z=#=63GW0.g4X2)]4beK5/c&f:\:VPbN6E1IB2V04AWdH0ORaE#
U,2Bd.;JNQPEE&QU7/)7E#L>A0SOZX1H2c>5Ud=UdL:&B<d;T\2I#K4=0?(PU.@2
R1gM-b>Q1HWN&1Z+J^8_/R;VgEFfQ3&bMK4&,/6J/GF>4]e3W/:U#f_DY?PS8d^5
_P.Z9dSNZcY,eBJ:F,@aB+UO<MIbV^?EW()=NN;@XKI3GWE3T9#\G0gdFgJ(3UX2
WaQ#,Ee7Og/GgTEN_J7\IEXZ,,^gK,H.ag8PWfXWS:A)^E99QVJ^7XS6&4RDe03[
6(Z8<N7cFCVV7272D,X,ED1>PQXG_faEP[)>1_?U=Tb^?cF61@J+(/O<&6.MDM<9
>cd^F>=7P+#=Ada;A)MG,V>Fg4_X7:4RB#[;X_c?0&?1[9/gVb]]<H]#ge[e2.PX
ReM1SfUgdd/O8EB3I3O&b#:Ed5-FW@(MT4RPKF=8&C]DA@gU_IB<N(>aN,Jg#JP-
+)PVFd.GRUY#QO77FFH@gDY]HMg<H=_]c@>8NKH_aeUKLTT2^C.^R,c(2+;@H8VJ
\:.MYc^WBQ\G<aeUD;Ha]f)BUgO5O@ZR1EW-75N&UbdecFJ^8T?c&Xg8eZEU_;H_
M-bfgM1&37@d=@b(^g\;.d@RP)OC2U=][:(R<M8;ZJY==RR_B#GJI]18.[];>^,7
E(Y3KMS6E_EQ-LEP;4^K_0\MNP_/4e@=3KeZ+Q=a5_Ue^I4c3Le;>[,N>H@A2IR&
C@TQ/=?]NO)JVKJ+P@?c3f@cIY+FJ/3VVR@Z+D(@5@b/J<W1,a:_DdbBO[7,b92f
E15NA#UMT7,C/>7bC,E4Lb(ZP9,ED#J]C^_1P3He/e2(N.gCE60=O]QSFV4I1T68
/,=c3eGC[#VHL;1;JX#<)._e_)X-b/]e1J.d[/R4V[(I]Z]GU1cJ5bM?f[?0<R):
M>MK<(23-<^E4f;5K10b5UTG/?]OIWNZISJW[;.3:=PQY2?DAadJfK401Vb^0HKE
6XH<WKBOgBbc]SeL5HXCJY;g^R7KNcQb1c5dbaLc4T]UP]W?FF+E=c/C4ALS-8,1
MN8?96ULNZTD\^XN=-NKeN&I0K46OIYg2)5>HM^-5MKK2_<CL/SXL[27:\(A=9T\
Q?<RQ8-eZY?;1&N69ZaNG86:&9J\<Y8\DKcLDX+UWE.2-4RLP:e_)+[#YJ=3b7L@
YQ51&Pf(_??OF6CSG7LKO/8(YZDQc9Z)UCG=dRGdaB][036)IOJQ_<#P.O6McI1^
3,17CMf2ZRe92XW4M;H^c:((5Pa+fc=@A/c28TGG28DBUa93W#Q&WLOU)Y1TM]J.
3Q<Zd(RN5;7F0SY2)2VUML5F/FP4TbYFA7EY.5R8+6\L/N<]T^UBaac0-Ab7G;FJ
_?,&bI/T>J<gR@.RV\63R(Y9U3/2BJJ^aYe)dbeF6fPS+Y(>DeP2g-IC]+Y:G;^N
0A0]PHP_SWZ?eQ-23[N(aM/M_TgEcQ;NS@P4M6d4f=.KJSEeW<_45Sf@A<3-\N8e
Zc(aBT,>-,Q,_c,(_BU_Q<bP5HC=f1b^#]#:2)S7@9K;a<Y5V+Y>)D:fE9Y[W[SS
U+F&VF9,NfTZ7JJeZ00.O<]g^+:FUHT)@9Yfa<Lb:/.CHCc98<P,5Y-U8C6c_c4+
[TG,FC)<_2GA2-feJH1@D]<ac/[(K:XDAFL,DGRSXcfe;Q6CLBOH,ZPHA8[>N,24
5a:-dE:c[O:(7LdBN5R]QB[_OJ2O5&+BZ-WFZ]aNY5X>SUF.09MTOAK0d.(44H^6
O>SJ5&F=g_L0\>KQ):3R]b0OeBA+Z>RP@fQ6-N^@R;9.d-58aI\5WGGXggTT\d0L
#?MOLeW7TI=NB[O,(6a_?/CR?O4>V-6-e5>A(2963?64Tagf7+.ZU],YZ.QWbI>D
S7WKScLSPGG<6dYcC#E(AF<#MG#9(GH_;AW58T;^N[g9RE3HX0a.)^)bPN-B4@fa
]?G4cF9eNOf\4\WOTZ[XHFCW]b==UAEKNfSR&/efFQ)/Z<JUe6dfE7LD9b\@FgRd
YICG),g]3>KgM_SDHJa(KaOV_4[3S0CfD7P3Z7UA>cJ:g8/1FP9<ce_YZd+A_f1Q
KJ37F&Y-=FI(>2L.3(B@;.(-X0-P9NET7LL,]:,QROT;O_TF8P5UKTc-Oc.:VT(T
K/ag?@4++K]N=)UXR+,:U)H/#<dUI-)^)2MW9O)WA<+D[A/?PD362NIVPbWe0LZd
O2#70J^/cg7C)d(1g;(e49_1+86@f4@UXScc@B:Q_4H\1S6O>7bLLJ1J4@;1bCbL
Mb#MOC\bY1aDWF<(\8f:8(.DG\5bYP#[@#WEO4)42;Bf2^#Q/,M=B-I5);XfK#6>
CIJ=7NFJ]b2G2E<J_S5UEB1>A9G^Lg274</N:W6Q8<VS#V=e@072T&5EE952&aHZ
?UW)W)4F>1aU6O1CJ5].9PMe3eKD@?U)E[XVaYGWd?1E)4#H0aVb2JW(3gCQONA[
&ZQT+;)CNg>9+?8Z4cE;,ccYD(K:L0XOZY#R5=?Yf<GFI_d6VO_^)DFbV[MaLgUT
O:W^;(HO^1)?FdH/??,XbYE20.@=NYc&DJM.R)gUGf348>?a^JTN&S<S,OM;eSPR
H_AdOB)XZ>V6P][8J\P3H;OJG=B9f[29VPU8E9P:dRS(bPA3HZf.(#LE\9F(YD92
&7.;-E-3J8X\TTT,N=bR2@_&,S/+WU/T>8RU4?Q9_bLQG5Q:3F&]TPM4b<FUPWK)
5C<a;537(ZYc86X@BZ^70Db\V8F@U[>(>(;^H^b^3L2_Q+N-5aRBYJC_1fH?_>73
(>^.JHe)6;3aA(0IHeOP<0#LY<Y&44T-?)>](W^_70/]9g)<V0\(#QdVWQF<b8.a
M3JG5D37L#80>>F_cc;TCRL<DOG@.eY^XMXM2@C+)A^>_Td\KDQg8\]M5b0c+^AJ
/9N+Gd<==XG^MQ639+<DL4@<,N.=TQ0\S->6B55ac8_6\+cO&CVcN]>LJX[J=G/&
9&J9IJ,O_/#BF?8_/4V/WFSV3M0ILF&3dRYX]T(VOE^KE)FgRB=YL.<Z>.^..3?\
RA]bY^+.YNHfU9Oe8K?dX15FKXI<X4-<&59N,#aZ]GF3c>&CD(efWU63J6?A@BO[
H[?7V-\IL.TDQ#@NP755e&S1c<VIfda>DbGOQBO180f4L0J^Gc+#N3F1^?@5[YUT
(OX=G&>3<L+O^).:Kd/H+JJ&(92.PdXc]0c;T#Q^E@B4#b@18WaQB\G+:G6baeVN
OeTKZCc7C<V1/LQ<GPDA#H/>P)UY>4WDSg:JM#@,D;JL^faS;/eBID[/N\A79I27
a97^Z780g_/WJC)_dRc)#f3K[4@5-6R?,Kg]aB>XG^N&V^3c3YYLPPC(-PLCN_TS
aYG-7D:S2,&R:Y00/V#&/^8IP]2MPb7PG;B+QdOf,A5Q#NJa.&TQN_TUEf/Y0M3d
EC2]\:M&OYHZWAQ?Q?\NK[5AgS(TdfE/2.MCG@+FX[L-UgA+T(A\+c&28AI+dQVb
/###JR.:?ZE;GbC/Y4@X@I@2cE</He>IH;^#\R7UODa/HLTge6)I[7IYML?6@^G\
/[Lcdf;Xa\&.\?QD1)^Qc>c2.(<Ab;_P(8RF[:/Q[__bTVcFS2S=8gV^5YV+JgN0
;8&0<Rf_6#cJV7C]YB[-g>PL^D/9d/EO3+8UX?W8G[=F:DT&S89^ZY=b)7@+F]PT
8?fcHcJP+Z2RU0aH3_0;PZ#9JfMCPHAf0b/#?5(#BD.0?=LO)93::\J-JSQ?WX)g
#RSG6OWL)(53aBFaW7MXUAFf,H9g0(@^S>U)FD9L2T:4AL1AE63<?V;Bc^YTV,&9
V.J7S0LSYIH:TU^.c:37A)a\@JOAd:@G+JNXV;MKR9@bgf^Ic/HSZ,,R;M)RX7L7
_M^2a:0E--EH]W0()dSc]<UU^Ab9NG&C_&^ZY=):W&&@J:YG1GN9KHXW0RFa6ec2
JCVCOSP2^,\WG)U\RGG>Fe<M<\@MXX#8bC53^[A[VVH2_EC-/T7f8XR,\ZGcIc09
Fe0\4<e;(NW_3Y)H].7dV@4>\K1^87.<Z-[N<\J5N0LZ;ZEdVPT/GTCO=0P^E026
,BK^Qc,=G3fdf>)3\/f4[58<VE2)[g<bS<a(&M[5#=_8[D.fXHJ>Nd8^0S\U7Bc_
IC_=Ed6:<9>9BFASdUGRKZ1)PU:VW+GH.NG5=X_Pd,4JWcbQF5PCYN4gd+^5VRd[
_+2OX#NN;6X1035+,dbUB#0e7P3Kgc.a:B,GdR@UG_9673\CNNW]I@F7f4(5AaJd
AbD0<4&.FE+Y:SP-)0M,JFD5T21JY11Dc^Z/_46G(K@aY&_B/3T&SSB?\8)a=8eT
92<K&.X8EPTT>Z<9XVXc6O#[e<L\X,64#E[Ue0VWF2f,3]2Z:)Y^/8#NF(B@)-JN
-W:1L0:AF):8/O26Y^7PfDJNOH4\Q:3CaUM4KGRVZFPHR>L[12f(>f,.<_XQPXZ,
;=1:T+]7-DCf8[?J1_?OE7OGBWLAG9@FC4RPYG5L<]#B1eOXDT;#:_QbB0FO(Qed
f(a.R1_Q^+QVT,22bFK:WH+6[[.?dg^=NA4?g@E)^][C<WCc@-Ye4P@B[cb?.G<S
e,_]RGZ1Cg#8,Q6:I<6G=g]U@gNK:c;NKRRB8Wce5GI#B/(#]=KJ2=B7JXd)K8eN
9=H#dF9JeR[?0.W^:&NbWN_P=7L]+?Ue^Ib@.b0-P_E/BWfA^G[W6;c7(#aTJA?&
;&80YEF-bS\K17g?1-+A/]OF##DZ.#PJSb8_Y7+CKERfA(8;=HAK)5f/0UP5TOP]
X+4aK30Vb<MFH;6Ce7.Ebg>M\I9/2AD+2\5&Lb]e_A^U,f])HP2WU&TES8#A+bBE
FUa[CXU2QMA>)2.@:dR0P=Yf9]HSDWR_I>_K^X?1_H4WANXO+V49L3OJJ:NV(KK<
B^eXUZ&[XJ9^F/,S9FabKB^SXKW]E)b/.I5]+.;EDWZT5Q3MV##M_#/^T+RHJf^c
a\A6P(XfV,7KT0d<+c8U7)Cd\G9cgd9-a(?[dAZ6QM59\+-)J-:8(7H2A^>c(60a
WK7QT@AO@Wb3Jf)),-O0SA2(_;2HdO+WZ.\>f.X:g5K=fcP=V,T40LUfFWDK^dU]
2D>R4&(8dKT82,7+(IV?VRD567:X1R>7SH1DGMQ#SCP@CeD@6TP+0f49-Tc((#eH
CU9eT1Z6ULc;fK]@L#M]WS7c<^J&(W9IQ2JT4,c]]KfH+SD-H2HeGD>XIY,ZaALW
RRKgCHKAYAUgUA6XETABdg2O4ReLPS@GeW#f)&2e,DE2PY;dI]TW3SI@C<ca/\I9
E:(Ta(>:NO3EV#cMSGZd;&2_4MD#X32Q1&aUd=,65e851ULSJ#F^1+W46L#0/IFK
bFSRg\#AbfZ6I,?2Vf)E)cQS]LR+89IPE(./^Q0aXdZDQgV>C;/DMY#Ge4<=de##
XYRYQc.2DMFU&6:FeMUA.)8OP3J[<,,W,1W1HebT]+@^BLc[YIL).bD]Q)?W\59Z
].6EfBVD7,DLDFIN62YV2#C;R.&SSR^UeTB&1(CV.(dIPN&])F]Wg^4@I9E#>-:f
,f(eY.BW^UL@S_SJ6b@g>5eOPMO4fa42O3;NPF?/8]FJG=c.&FOAM.U<+2W(H;4Q
>9A.A1>KAEWCEJ1_/O&I3\ZM@D=;V<W,Nfa+F:V0b?LQegUD?/9+Q=32Y\J/b]MS
[?3bN&dB7T^2S4(8NX#G)[BHU;XQV]+L8e\:/1QA((Q6XFd@9RHb97cLP))+H?49
A5W8-09HL@f@=2TcJ4cBMG[I.+FPQ8D/W&(#;&<F1W^7=#R[DF[<<E0ZG)D..]Q+
H(1FAX:cJ;3I+,W69MP+:&gTY+&e)5fe(O0BE5>.7@XK3b@O4O/1\H8/@HN4Qe^T
QXP3Z&=dZ;?_&#UP38E6b+)Ba^308^S+eJJ\)O?S9-Q_)PE;_D<UF6_dFF#9SE5;
4LT+8bUD7L,?;B41R&W,,e1E>7PL/JDL<S\1OW19/.&0Y+SW:#MW<^gL\6GNU@?W
R8V.][IM_;_Ca]3)]-L9g)ZFJ#_UOOQT<f<3IM7Wg^3gD+)ReL;6]8?XgV:_,?PY
KfZ0?>#aCdR::;]>0#+)3(INS3WQ#<-7=;0gFZ-#I-7[Kg]DdRQJYYaZ7]\fc2XH
AX22B@.MLECd4EI-[^5P^a2Q9dLLEI^/^,T:5&7&S:Hb#A&AW5^-HV+J,#KEg.dE
NY2C8Q)>/WV<VRAYJ7\U>W-X6R1L?,ILJI4=Y11_gB7G@ABG.KPcKbU31&?&bad9
C\XZ^:11JM60)YJZPf(E[GWT6@]YfNDN_GY?RDW\33R(+&8RYee)6JV6VIK5VI\6
0bWJLE6dI-@a[(.bP]@0=/P([MWPYOL:Ba.6LKH1g3MC5b9[Z.c,NG01L4(Cgb;S
aPT[OU2TdSOS@Ge-@^ERWV5^)fJg&AD;SW1F6[LEQJEV62>4,4c(F&=O#WH_3:fe
?XM#-X7GbE,+K3V0Q;BHLOU1Z//H08H3Y7Ae<G=1c9A^K<^ScB?O\WI:;QQ)D>V>
_@@,g,c^E1DV2+8U<)Eb&@HGSC.f4SVHd5GN(I&M/N4YINb(H2BCL-I:I$
`endprotected


// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_sequencer_bfm#(type REQ=uvm_sequence_item,
                          type RSP=REQ) extends svt_sequencer_bfm#(REQ,RSP);
  `uvm_component_utils(svt_uvm_sequencer_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
     super.new(name, parent, suite_name);
  endfunction
endclass
`endif

`endif // GUARD_SVT_SEQUENCER_BFM_SV
