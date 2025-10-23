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

`ifndef GUARD_SVT_REACTIVE_SEQUENCE_SV
 `define GUARD_SVT_REACTIVE_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_reactive_sequence;

/** Determine which prototype the UVM start_item task has *
 * UVM 1.0ea was the first to use the new prototype */

`ifdef UVM_MAJOR_VERSION_1_0
 `ifndef UVM_FIX_REV_EA
  `define START_ITEM_SEQ item_or_seq
 `else
  `define START_ITEM_SEQ item
 `endif
`else
  `define START_ITEM_SEQ item
`endif

   
// =============================================================================
/**
 * Base class for all SVT reactive sequences. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_reactive_sequence #(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequence#(RSP,RSLT);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

   /** Calls sequencer.wait_for_req() */
   extern task wait_for_req(output REQ req);

   /** Calls sequencer.send_rsp() */
   extern task send_rsp(input RSP rsp);

   /** Called by wait_for_req() just before returning. Includes a reference to the request instance. */
   extern virtual function void post_req(REQ req);

   /** Called by send_rsp() just before sending the response to the driver. Includes a reference to the response instance. */
   extern virtual function void pre_rsp(RSP rsp);

   /** Generate an error message if called. */
`ifdef SVT_UVM_TECHNOLOGY
   extern task start_item (uvm_sequence_item `START_ITEM_SEQ,
                           int set_priority = -1,
                           uvm_sequencer_base sequencer=null);
   
`endif
`ifdef SVT_OVM_TECHNOLOGY
   extern task start_item (ovm_sequence_item item,
                           int set_priority = -1);
`endif

   /** These functions exist so that we don't call super.* to avoid raising/dropping objections. */
   extern virtual task pre_start();
   extern virtual task pre_body();
   extern virtual task post_body();
   extern virtual task post_start();

   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_reactive_sequence", string suite_spec = "");

  // =============================================================================

endclass
   
//svt_vcs_lic_vip_protect
`protected
AW/;G?AX(cef3L,HBZ2AGdA5RXIOWR\#N[C_d(#b5H]&A6^K4Z9Q5(GMg;9WgT50
+OFARXKI9Yf^6VOfU?QGFGL:.6LC4IHRQaO,_@JAH(0<]VTU+XEAV?G@b;E_(3)J
MM:</L2=CWYfSM:\;LE;E;>d[9(0TGEQ1E3NVR#d9#YD-a[W06)Y3BS.S63aQ2[g
JV2c@;A9_1.XPLMU)4>#RdCDb@&]UJD.(BW1_Sce^gBI7,C3?LM6+(Ua(9EXG8JW
]=cEB++KT&NC,O@>W@>D;]0XP6#\gC7&6ZV0R8<gfg@3XB5g#8?<YAbY5(#UMU1K
a(W5=_\HWIe#M+U@1Y:BT9)?A;MN_)Fc0K,P,NB6+.3@B>D8OAgG=Ocd:C^K/0YC
=WV:^JLeR84L1dJ[&7A-+<39(dGLf&5/-H+X^E\KZ@9]DVHb.L_DV8.9UAN3X5?V
dc2X[=ZE\HD11IA]AN)_V_QN:?L;;N-cUb4Y+]N-R:#3AP9ePQOU8\eE:\gCVeHG
7XV[3gW>)4>P7LU3c@PGT^/L8L]d,J7B2)E9[W<M>G[LF^OA]=V2NV2?efdC[UEM
<^Q:-gb5PL-6EH_M-0?BEVa25G;49S[_+708^?K+=,Pe9_:I81H/W;c^:+)#fOLJ
O+gAV?gFA8fJJRQ#9b?2ILdH&>0d,QKQ^Y/8\/0\D[E/gQ8JdReY.(@^/R-JUQ9a
afg0E>)6Q735d1bd5K9d?E(B98.Z;](V#NP;Bge<\ZZM+-XVTG#B_9D336.45b@Q
;5e,8O=#)+61?D\OYG-K^U:B?+[#+1c2L+O8#^HV,^I#^6aJB86.bHU2V?(b#2#P
S3Y@e4?HPPPc);+AUT(e(&9f#fBWgJ-\+@(O=Qfd_T4/a7Q<MY9W?I7QG.bZ:(>8
2<&P\]+V9/B72OF.M]SK1&O=PfA#NO^>TT#_P]5V<ZQ4^LX>+Q;CQLE;O.LB?.9f
MY37;C0B8AE;R9SCcCJY0AgM.:-SL/=>)A)L7c(NP;A(4JJVG3)JNPbY:RfJFV&f
P\_O>5XZSD&7J./Aa7fA]L>#,(\\b?,f:deYfZ?LX@CHc/BU.(Y5eaD[DJ=cKV+T
N^.Z+KM-WHIQ[Kg_ZJ7]#KI35K\:YGP&.>HRdKM;?S=.]DJ;3^6UeLc;^VA+N)5(
FXJ[#_:?FFbPL<=#KK1;,WDPfK6C1Y+_CPeFXI@LdRG>CP[J0:Q@3S+9>5R)6[)N
VA[(.3,e#/9[J2JfN=:2#YT=EdW]C\2#G,3[8a<&Q<FM[CB56bU9E/X_gS]@@EHc
eA<1_K,<<@A[_DX5NKId.U0MTES(?#9Ygb.cZ=CD<aB.4BM/.7YdZCI0&6O8<Q4-
>8GKHFN4.^5)Y/=I8UW,\Me)S.Pb1@5M&=?LW&;c,=S@B^_VN#G+0+:@L])J@&F;
V_Cd8K47d]J-V+XD\WeKa45D&edG7,-N@V.cf#3FVOQQg&27A,E&,HH0.CfV[L77
>QUO->C28MI.:[P]780?f;g8.G-;7ZQ]9AIX:5@#([#fd8BGd)5O+5LHO0+7]:[9
?_9A1A9)5T#&db0N6K(Q?.IX+W&?d(N4G[X0b5b@\)-d78/(bXa_WgXWZ39FP9K_
\?B=EVG-L^+?HM0[7/_^KPbS;^FQS#V-4>KCdJW/#_PUR:MYcRF-W/?,PB7<,@4K
E)[2Z/VE(cf._W&Je2H4ZCCWAJgf9LJHRfe<Q4,SS+;9)fZ[a],VR(U<HdAU6<A)
MDdU;RdR>:=UA&HgGP>^7A)CQZ\(cbQKD).=Y-J(P/FFKN.G>:;FPH_,d<bI3P.#
-A:VEReL2)4Z4LIM[,R72L+VeAC\D#9P2VK&9I[]9#Z_3?baJGZ5_EZH\#0=IVD>
:B]#9[X<D^LSTH)^;APfW1,?^5+?-&\J.00([1+2+L)?Z:D_M[Z()P.IBWMA#,gE
_S?RJCI\B^ga2[6K.gaPU3K72J,R6KHB)g+d&,BV^2a3D.0b0OL#.:Vc;CfQ2<^^
N^8ZVf0De7ONP4MN5E27#J9L,Z3=g8,gISJZMV;,\8CU.VVBT#3c0=#,<5_(#]&D
U.@1[9I6)bd[,2ZMPSNB_SEA>,@:\:cR[K@2ES[:6@9BaJ=@3X?-AYLgSdf2M7b:
Zb7gD<[Q)#E#G1++-;4GE;:Gea,PFJWd];?cTO9]cD[CLT#,.B;YS=I]d_OC,2\)
DV@H+><-XI0d).b4:L>UM2(7Q>e^dFYe+8We74NUC)Pa224/US4]:8Yd#.@5/Zd;
<P<cg8FBXT8c^aBZ?L,]+Xbg]\96gRZ<b5?UYB^472EbOG@-\(:7g+O/T09:XJP_
J3O;6,f=/&6K+bV.BXDB=)+ACbbM12(\a]?\cN<Z:IKLb.F30,[;+:>Fd2@OD&1Y
;,48H0gD8YJ)aBH_-DB<eLA\Z(KW@f=R)A-=[.P+UNBO7&9L\RedJe2E4b2,,;HQ
e7&NJX[U-AVP(2GFO:CF[<C=3.4f#<9=eG9HJ,Eg(CFMFFDROX]@()f:E&6TBW>a
NJF0;g=#6MZW\08ERT[,fe3FbFK#PMY1T<g9SP,ZY]eU+H0fZb@?,IfYFA2fZ.]U
0O5Mb[]<KT+d)KV2-A_+I6JfF@.:J8f_Y?JMdL#cZA/VaZ-^S-_,I,SV,72Tfeab
MS<&?&VQ35@D,#Q+@2=B7Vg/4)8c:608:(@L;4>^B<OWIgbX3Hd?eU?U0&[/N;PK
VdGFG,=\[d@\U,MBd2X)8#e=B:dQ#64KF<(IPXR/H<Z0/;(.=&e#>Y4@&T#YU,d#
6P+gR_0R#/(VVg5C/(ME;dfSS@ee4&&JS+;>G;5&2;f7Q,LC1(EX[PTJ)C0)_Z33
4aWLJ4c\SR5JM,fg/ARAU&7,A2NN<I80^g&I&.aPWeUE,<[DQ/eC-)SM&-DgT,8/
^;NN;0UA:.OZc4d^Z5aHEC]3VdQR-[RKWBV>I<#,G&K/LJ)3H>1EP(d?J@#HJ]8H
.Z1DZ1:9RJ_&33.Ygd:KB.g;KfD727eVgdNVc/cV<4]FSM;QPR6C_(bJ2Ec+.EZ\
?D]C(N6/C(LY[1URLXKa?XJ5CJ\O@FC5dK-XQ<4<ee(Y50dL(.#SYW21E+dAW1(L
8f^:LD@Y\9EeVS&Uc8QLYYX;eQP/T3C>a]JCXJ=DD^+#R^NYNHHW-<.Lf&=\:-Ve
?ILc+1@Gf78_GAH:^1N628=J#Qf_IV/35I>AN,d/&b#X?O#IBY3d-&5Ze]I=[^(3
)V;4JE7I=-ZECfb2FI^5QX1CW2GBZDKZ[>XMH&e/B9b2Y]SY3VSES2DT@3@VcEP:
3g)cc-0FT,>0Uf2gDPF>VHS37&f(WgR_WCR>,-HQ[]W+eF]&R2E5;_4bPC>AG&Y/
D6aAGTJ&>WT,6O/>\(ONg5LT;Y1E0V=A-FfO5.#H1#56W<18G01>R-Ag)ELb6XW3
XXS>S5R5S]bQ,b7Q_YY10JY^5Y9.H<N45].?75(Y)(8_Cf;8DS,H4e?V_-F(W-&=
D[a-V#8W(>IbF9OD+#@HfXa>eK0@MbL+]H.E\eVMX]W#/.SZ]O-c#8IL(P8@Y8/.
;ZBM0bU[U(SWH9[\e#O7GY-PR/dM>Kd\,f+TL?BU(+74bd:1Gb.7?[207S-[,WX8
=IA>6RAd1T,C-GS@2S:Y6CcD>J8A#JP4AWE2#NZYD-edORRWP@A?&#/DR)GN+:V#
+MBA-Y8G/OG;@\bGJ3FQZWQ=b+fIKN/NPR@C\G[-EXU[=E?^;QRSD)6K7#U\JX//
W3JY80(_28OT#YF0@PF))@=/e9ZA997IL8/C?\E0]-P==2aEW:FM^;,7YY(1Cb[H
,90eA5//>gVHRS>YW.9TcJb@H^g4:&58F^e0QL.ce3=3X3.YaCNfb4/D9GXS_H2J
X3M6)M=@L\6O8Oc[K]];D39;Y\2]1P+186[1D^6C4]#a0)bM@Wa^)9WfCTL^=.DD
7DR^^/]VCBcUd&<H&05B5SBVYZa?Q7G@&Y;c_=5+J@@05cg9X\g&LZ.^a_egc3[^
RA6;I_+f99)a2^b9@.O,]]e5>N>KgI,f<7W5_ECK>0A<-83a;2[YEANQLBG[RMHG
8?NXG)]XLGT^DgR)@S4Vb/IN,DL.7097IP19<Wf8\)OAg?fGW#_Ke]gK:O/gg[4@
:R7U+L]R+V-52PQ?[XEJeNT>-TP0F)fOE)@NWKQ]-J1ZK;5(5?T[_H([;:9.F?)<
_0VWV@[a-,;(bJ>QGe?.<+N<\HA6GeQBXNRT6P-])(MY0?FE8,EIQAOa5?KJ8<fb
Xaa/,][cT/GI\RdL:8I_L=N<4$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY
  
`endif // GUARD_SVT_REACTIVE_SEQUENCE_SV
