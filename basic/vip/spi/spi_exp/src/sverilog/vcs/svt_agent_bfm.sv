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

`ifndef GUARD_SVT_AGENT_BFM_SV
`define GUARD_SVT_AGENT_BFM_SV

virtual class svt_agent_bfm extends `SVT_XVM(agent);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

`ifdef SVT_OVM_TECHNOLOGY
   ovm_active_passive_enum is_active = OVM_ACTIVE;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;


`protected
42E9I8cWBKS#]R.;2eT4()e+H@Z-S(QNa\+-HH/A;e2QJ8PI0=bS3)fg</bTE;aQ
OB-UHX8.gYQ:]72LA+3&?:.O.=g\dK1W\>QfN.>DY?8JO>9G?EMGP-E7-^U:9-RY
3NLG(A^1V_L6EG,-COLYOWS@9.WOP;&07Ne,-EQe6<NXWC=0H&)4)DPL^>QN-gEN
C7bJB_8AY3(f;b-PZ>)\>.3]\KQegYc>GSg5@L\8<2J+<1XXPGNW)#PLJ$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new agent instance, passing the appropriate argument
   * values to the agent parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

`protected
[3b5>(]7?:/-Q,M4SDJ&,0;6Kf6H8a&Ff#0@2MB955a:]6GNYg)1+)2EZbN(1dT:
^&CK=U/bcS4]2D5d-Y?P8@U=:9QdXM?,H2VM@If3Vb(G;Ka09^ffU;1]bGa7RMZ]
Y):GSKQYYC2)]+.1Sb\S\O_3dPW;@f87:SN1\T2L6e.GD$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
_#QeM;(0T?3PGFg):W4WK9Z_[,De\d20>B,T=Ag@LSg3Lea+<SNS3)=g@:+3(&=e
&EWMK\6EWd3UGDZg\2JRHaI2WaR+:b4b\9.GU3TZV;CFb-V\eUe403;/N80Q.S)O
(2adW.-6?X<U/$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the agent's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the agent
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual task set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the agent's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual task get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the agent. Extended classes implementing specific agents
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the agent has
   * been entered the run() phase.
   *
   * @return 1 indicates that the agent has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_agent_bfm extends svt_agent_bfm;
  `uvm_component_utils(svt_uvm_agent_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

`protected
47Ee^162WM]MSP0L#gZTZ)dDYMM;AN]O[M/R[W0fVTC4K))M/X\0))AJ@W@=OCA7
@A(]a0A_/>dGX9eg?M4+>&#L;X[V7B^I#(B6abM&;bWEDQ^4H-U-OB^6W#ZGSNd;
>BP?I.P&=;OGF26X;@JV<<g9<AHZ;?b\7YGdW7>KOWMNDQ@JgZNJP-UQ>H)8<9KL
EJ0U9c1Y.OJe0VW&[7-SYC5A\c<<DE3TeBCS(eg[1PK\10Q5ZPbB,Y:f^-:W?@X<
g-Q#13LNSTdENR\ERE@dA;b#0QabME._cT\4O.4Wa5]-C,RTIbB2RZKO[)^R24S2
KJ;KYf1^JIC@OZ76W[Y90OFJ9STPHf6e]^g-:-g3HTZQENE4GB:D(9FIAN7>F,:K
B;=KMdDB.\2Za),<HV:d6[B/VA05A<LSU=_]K1aXF]QK_@/&@/6K1ZeK-1843ZPK
d<M.2T6ROd9Xd?)X9PG?P)Pg&;,UE554[M:#:AQeNZ(a0CK9ZJ]&XBC1X^Y<BP/2
NJ;KPNUaYPIbB/cgEGC/X2D35TR_.PB^Z.P:2C5I9b(5O(<-[OAPKeED:/[S9LAM
4-XOYRUDW0EB&UP6<>IVMPQVY>L??@MH<f-,]a4f:P/;=OR@db0_:QLR&aURUQ>P
3\GOVZ&REYH^KcK)BAEc0Z6E1+B2]O>3ES_;IBg?<^3&RV2fV?KS0->P>X@^J\-R
g<;^)/=/U:)G309/A\<F_+XMg9Jf]GA>_RAPYfTD/_FH65&)WJ7X,Z:fd7f>FOYQ
2\?M3&_]?MaUM5N=E@7ETKG)ca,NS2-TcN6;AS/g=7J(gME-0BQ=.0:#:)\6SX#Q
9]d\3f]Xde3>LW_1^,;^Q[,+]Nc;2\IIM:0>KM.9W/?Z+\]F-]=U=#WXdTd;dJ&g
;?Yb(#;cAgd[LCU_bEB/.8YL<9eWPK33eAQ)64:1d&d70NaaD@350F@@2#)M)MUH
>TVB4&KE_e?Z#1bQ](F/SL3Y@,T/,29P.0?)<Pe47,F6+M6;QTQ,[70-@aFMa]e+
Wb#RaGN01DV0/^/@U57#)T#A95,a_<OMdG#_;V>a^G90)-GDeKBL9WTLZ^Z<@5d(
\C]/?9259O>/Jcf0ZN4[7MY&LRV4.J8TRCcO0S&\U5KPO[E#87aXZJ)RY?4/><b2
7d&eH#(;)4+X2&b@1WF[b+26:006G-V/gSfHeaAQ@Lb]V+W;#F:)V1X.-_ac<E[T
-=]RJ)>Nc+aX3TKQL(DNZCU#PV&8eT@IF.;d?.-aU;XBX(+4P]P].;HU7SU==BJ&
BPNEJ&7^Z>EBRg,29@H)=55eCae-&G+UC-Cg#VE72,(92^5_?4=O7=BKV;/(C7#6
):,#F]+CJS>[Y.9.TIX2V.LcXd;32g-J:J-7CUMF37OLSOb+U:V/?1gXVA2HE5M#
W-c6e_\A7-HN:c;\A#,.6f^S-a4IH-^:3;^c.>#30VU0K[JN)bZ@dP[L?(CXZTNC
Q8L4LLW+C,AGNC_f[:geePM/@>aYWH;J8e.\fB2ZND.B^X9g:PI6M28>5\K;C,QF
V]FaF\3#F_&775P\>a9g6c5Fc,f/G@L-M)1UV2+FD-[[=-2](QF@G,5Y2_[-A<+K
1,<0b<[7be93Z@CcA?]N.d1f#F_^c>D./D_gUZ/\<MZd5[cNNC7gF&NS-0:6;.dT
]^E,NbBD?7R/_&<-gW+cI_A@Ba.;HRI#8-E;/cXC@AOV7(Nf=5VE3?A,,B?<-<1Y
CB[acD#4GIOVRH)NO?LK9cK.N)RTT.Y9c>JIMT[c0TI)\@&ADY1(PBA,RX^G:cb?
5^J#^BeHE-BQ<V#AKNZI^G=#aW.QAN_9+BRQN\\TLW@ac()+-ZMB32<0-.)_a=I[
?>O,<J[4-&WI^]G&W.JePNCVUXBD6\=\K793VB\-?0=YfXa:64>MZ1RR#fP1_5C8
YZNKV5fc^L4NZIe/C]M,ZgSSE<c.Ng?1-/&S2(,02L<+/-X+TbJ=S+-PV1d1]DOD
V45V]W[WLaJ/U?2-\9P]DV0&3/dbBI^=(34R\&>\/4DTKJ#6_HGXLP6M@B937TN0
Pc;<#G8KA7?Zcg7,0(;&10a/M,HRaCM2#1FSZaWG<Z[RR98F^>,(F)[fNge//./g
GWdCNYSN-)VU>KgdS]G2=4J)b:A+9G/^L+<<X8\X(CLG>;NO@)H8=gDKDOEQHPNZ
B27Z>W4R,A(;B1S.9QKXC/3H#ff@\d.Off(9<B68QFNgS5>@M^/eXegKI&Q)8P>5
V1;]S^>\7TKCI[<[b7^eNSYN&Q_N6:Vb=6W<dIT4FIc]-d8/T4>(PW/E;XL^&c]F
)ae?,d-J\<>).LHD@+J9?Y/4<4=.&(DBXY&M:6?aDc<a9bXGA;H\b61ZY89\;Q5f
6C>#Rb(AOK:1dT):X^-DS5/I@[9WAQ^^K-MQ+8aV44,O0LgKX28>7\+b15RWD8=8
?e(0SZOF^:eGdg2bA)D^IJ^EADQT<=@>\3@77XW6MTQ.AGe+G6H<V8Rg+&=aL;AX
JDVG2C5(+1GZa[P;IY>?NAgfE?<L)1f2@KHSRSP^(bMG-G&(8LS>CLK<(bb[XTXb
#6NXXS+#.>E\)#Z+UY,?TTR8S]#_;LPYLU]&5_J?(5Ug?BGWJ./WUKY#8Ja#EIOY
@@]eSBFQ5?d4Q1OA4?I4fZX:O)B8[<92U,N<LgH8D-CO&dI<;)NA_]@C5S_+g.:D
-C)W]QfAEBV1(^\:?fVDG&bW_(O@N+W2PMG9)9T[CC_0eG(TAc8D&U)72a)XM3Bd
-^#(>XR#:0CEA7Ff@\8NQ:4J=YC/Q]Mb?Y>Z)I-]9H&7dCKGd5TU->.,G0,=@XWa
]0_0./g3UUWMR0aJd2?=gCfQBH#IZF?U8ZJK\J\A.<O#.\:^YZ0[1Q1OT+MB+TWb
R?;\P@QXOV+(/NB],8&OM.f[1bDV@\KF)U.BH&^_R)MRcSEI&R[2=#[9,DZ&H//>
A+TFW[7DA_JaFXMagcGVB2^dN>F8#=B<,VG)GaT4_f9A1fMNNJAPWEUR?T?M4CPV
\QT2X1>K(?c,[QN#S]9]fQV30ZbF&A7EMM_[Zd@/]F30FAgc<W(c9UFM;Z/7[UQ3
7^B>L25Y<\QYWY.(3.?MJK-Hb\eU.=5<Q23c2#HMH3I)UO.UX/>H^d)f_#XDR;Fa
KV[>g2@dEFM)YEXbMgbH./e2B7S_;M,;7EJ_Z5^X7,cK=<)>0a;N1^.D5,\^0X\:
S^N+W\A:cCb3dYd:+5N<]0ZFU7P0a#d>XR(Ab4,1CHK-(+aZP@2b=D4YMZ0W-R;e
:]R56=;P?H5FEQ4[LdX8aKG+dO+G@g9?3>UU#e@b7]Q>]Z:TZW6A?BaJ6Y8(D+JJ
=Gg)45JN-],X.-561__X6eYgV-[6D@WY-X<8LU/-8cR7?N\,_RZ;@HWeVU<Y7gY5
JUHKFO7)S^XTK()A2U8JJ;.<=8-QHGN)=Hd,FE>#6)^,N?f=0BEQE(NKeUM(<A=.
^LLU_FdAJRLW=0O+#(QCG<W7[2W:f,C7T8^F#aS#Tg4c?+]e4Ifc-Ab/Y6KJ<CdT
7VTHR-)RMP8PRN8D=&J4E8M[#F)?aO0bB<;6B8IO5.5IKf3::Z?V6IIQa]T=WV,,
H[Q@6;GUK9UN-DOU;RO+#&<b<\L0V2.Zd\R?:&J;=.BNR#,ZL8HaN,6J),G4(N,G
BS,=Z)cEXXX76FBbfF_e101;:GGF^P9[)F,UX9LQ737>29G92QU;&c:GJG#U01>c
H0aFGDad.bM7Y=.1Z[\d).Q[[QAH9,KK[HD+CGd8.\<D[d&?If(],d(a4O&Q?A96
QG2Y7+[>ST.e)_R28VK2<?Yg7VS#2;J]HFZEf143/>O\EWN\AKc[Q.960(Z>a\R@
T>TX-#T;#geEH,9cOI5:6[B2WUG-U03[7C1RW6e-F)#A==8PKF/a1b&3R#QE/Dad
X/L,TOLeJAB.?;RQZ3#5HC=3R:+SN@cD#4ZH>,)9/Sa#O<?E3LQ^5bRZ.8EVRgY>
Q=>E\D<7LF9OGLU7\V26Xd?<a0#RZW:2?:B@W][a=UB.>b\K^Xdb+,.L^1,K<1T=
4=LM+Q6ACQfS<G)aT8>3T)+:RUVDE3ag;P2fXUAJVgHfKUB40/-[4GfK7BE9R<^b
Sc_4585I@_\g=-bV\0T-L?+LJcWI0@c(6)TDP14W&7c\:?Lf,^8Y9aQO@95O8<OC
abacV(E47bF#NLSIfZS[R/EZGb7?f_UZAFb^FTDg[HUG,^<F[P0XT,E4=WO\1).4
M]-+OBI>\SFLP59Sd:79<0\35WD^eF/T62/L>a)6A19X5\CA\=Ea&b9:]cUaCS6T
.@,NI>J/2dXF98QXN>F>MQ\Ha@&(8#:8#Y4AU??4F.5#ZMI9W./YCZ7+LU@L93)G
XL\=Q?aE&XX)4O3V5GRfVcQ^^(RW3@cEDQ07dH+Q0#-Ha2DSZUD(<9B=dFga]QW@
5(-G7:a1JLZ;LY^@Z<D/5<87M&M?7AQF0I1G,g.0;7d.O6[_/]+XA(\b^[F;I/6=
@9F@R[OIF)8cS#M&)K\=R9U3X=(9HNaLAP,>>,<HPf2GD8#XOGf]]PYV_gHPPK<=
7TKX5RVNZaM2H/7QJY.2YB&YO=-D;/HA3.+f@]P1\a/@5_/P6PgeQ\[fT6eU0/Y^
]5V\FE3Q+<IG,g#Qc>A2XTHKdQM1O#KBXU_g;MA=BKR_@7:)J;\T/Y#@a09KY]>.
^6/?-GBXPC;KW_TGgRB:LGET/9<0&F,-#PPXb6=I,W:KXXQT&8A((cJ;eQRRR;aZ
/R#M/_[N@D0XQLUCJD1;+E>90-UJ9EKdH.L>Z88=-=;Xd@^,(=5=b^4_XMJP::#c
NWO8UU_W/2bP2@6-9\475c&c0PL;Ab9W#cD[dQOXfgW[f8ZV7\G8^UN/WJ]F9,>a
&VS]P?E[R4=&Z4E]1Dg6XSMff]Q9++Y8>@-24_E?6eKA1&,OIa&[=:\;YVFaEaXO
@@<I8)fd>YN2Q4O4M[C<3=KH(F#XF#&)bC=-1GPf]-MJ9ZHJT>+Ff?FD:R(PGR;?
-CMb+-^_C?XJN?ABggLC\JR&]41KSb]-UIbVE/8@WWU7N=2f]^AJ)@\,7(QX4Z75
[#ZAYf)XB:=KeFGAR;8PGa0R(8R7WY39.Q8&H6CP,L:K;]D^A@Fd5M60IZ(Sc,F>
,,YIIE=1;b3cU,T/H-45U?X-_F:-R/eaHWbdg[P.BFYZ2:d@d[9PdCK:XJ.WQgg?
S7T]#-)Wg&Pe6,[R3JcEdSG]L[XZbPHK0<?84#e_IRA43&TKYM7DYT,JTV(U4T\U
I<]JK4=5=UHXcT#2DAUN:@NQM06Z[+3XBS34OIf@g3C3@RH-SHXIb-BGRHM3E,?N
(b/;9EPDT+Q<?>UZO4<CXdHb1@g7CD@eZ)3N5(I)9W77OIdU:)YB9>9P/@UXaA_E
\1=b(0AQ2D(]H;I75D[9aD<TVc60V5>OHE#.P?_GY,TSZBOO5V#NJVU&c\68d])P
YII,)CJad4,URT,YH[^^VZ:,_+3_.VPS+?+-c_7+KaD:B\gfcd7]FfbMQ/DWc]+0
=P@+E?ER:(//DS40^1A+-(,69^DH;SecRJHV:?L/?Z>R(dFH#AJZ0<FN]C>QfFe=
?)R8?F3P9e1L;(a5&2MHD407QE6XY:DN]MH0Y&WZUeV@.B_OJ9a0HL5GBFDRP):(
[YWQ;/UG4G3&2e<XWS]C=Yf-](,&/,^--;&U0EMXFJ7PXDI>_24Xe6DJ)4bfa;f4
eT[-.#LU6b,,)U(^\<aJ/dD5#HUAa^TD0BQ<=P=3#3WIBT0ef:+f@6Y,G_?FPGa+
TRIBD4MX0FB6>2gR>N)+bBF^^)80L,3Q/YDDZb#.DO+2YQ3QVJ=LKAV3ZIA.aA4/
[VL_+FKYNY/EU1-AIEA,.0EgNS?DX-WOJ42;)@7HKX19^HUT2C@.6G7X4>S8>7TF
8MHVC<J036:08<>R6=K->REg8$
`endprotected


`endif // GUARD_SVT_AGENT_BFM_SV
