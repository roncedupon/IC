//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_ITER_SV
`define GUARD_SVT_DATA_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_ITER_TYPE svt_data_iter
`else
 `define SVT_DATA_ITER_TYPE svt_sequence_item_base_iter
`endif

typedef class `SVT_DATA_TYPE;
typedef class `SVT_DATA_ITER_TYPE;

// =============================================================================
/**
 * Virtual base class which defines the iterator interface for iterating over
 * data collectoins.
 */
virtual class `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log used by this class. */
  vmm_log log;
`else
  /** Reporter used by this class. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_ITER_TYPE class.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log);
`else
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  // ---------------------------------------------------------------------------
  /** Check and load verbosity */
  `SVT_UVM_FGP_LOCK
  extern function void svt_check_and_load_verbosity();

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  virtual function void reset();
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This should be used to create a duplicate
   * iterator on the same object, in the 'reset' position. The copy() method
   * should be used to get a duplicate iterator setup at the exact same iterator
   * position.
   */
  virtual function `SVT_DATA_ITER_TYPE allocate();
    allocate = null;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position. The
   * default implementation uses the 'get_data()' method on the original
   * iterator along with the 'find()' method on the new iterator to align
   * the two iterators. As such it could be a costly operation. This may,
   * however, be the only reasonable option for some iterators.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  virtual function bit first();
    first = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  virtual function bit is_ok();
    is_ok = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  virtual function bit next();
    next = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list. The default implementation generates a fatal error as some
   * iterators may not implement this method.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  virtual function bit last();
    last = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  virtual function bit prev();
    prev = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list. The default implementation generates a fatal error as
   * some iterators may not implement this method.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements. The default implementation does a full scan
   * in order to get the overall length. As such it could be a costly operation.
   * This may, however, be the only reasonable option for some iterators.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length. The default implementation
   * scans from the start to the current position in order to calculate the
   * position. As such it could be a costly operation. This may, however, be the
   * only reasonable option for some iterators.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /**
   * Move the iterator forward (using 'next') or backward (using 'prev') to find
   * the indicated data object. If it moves to the end without finding the
   * data object then the iterator is left in the invalid state.
   *
   * @param data The data to move to.
   *
   * @param find_forward If set to 0 uses prev to find the data object. If set
   * to 1 uses next to find the data object.
   *
   * @return Indicates success (1) or failure (0) of the find.
   */
  extern virtual function bit find(`SVT_DATA_TYPE data, bit find_forward = 1);

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  virtual function `SVT_DATA_TYPE get_data();
    get_data = null;
  endfunction

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
N>:\C?D5V^>FCW>9YN&6QcCcK7GN5d_S3H>G9A]/Q-f9SX60D<@T6(c0\>J1&LEL
]_T2=/;GYGZ5QXH7;+Ee2&CcD,@(J5S[DY;&>+:^3,=RSN8K9.0&^b7769?YO_bH
Q/?B;Qa6GcTCJA7e(,#P_#44-,a(HSe#0L>P9R;40Q)S.=^HV4(V[cM4]5V_=4e.
8>99b35Rg81RVf\J6GcfID@b-0a#Of,/V<N3XPY)=L#;9ML3MAR40cBL7a.V(KUc
^\>Q6;e@1/@FQC-8KZeMAR/>S<c;?dfg+fM:9L/Y8)bV02>P>+ZT@.5_E.O.7dH\
9S)&.Q6_AO+3D^a4:P.&Y=1a:,[W1HJEE?GPCFS5WTN5bO\F]TX0STd9>723F((:
R]TW<gMe9ee8<Hg?#R5&P+FXDK?>./S>I=0:&F9fIfEWKPg7dH4TK&K[>/C,KHX#
JS)4NI_H,=3baS]^&MZF+;=VXe)_eV4@3&434\YAWV<e6f=BIE;R.42PAJT=/]EM
f=bC8cIJ^8geTMQGQST-1[^;;X1\F/aWBQ+AF&R@;I1:cZf(Y:]3,0_\d-3aF@0E
5C1XORA1KeO?8?CO;7?1D57:B1Y9?Kca?RfDBM1P>((BUG,U5S)E.gg]F\(eE4[R
S+=7Y.Q-eLGg=TFYH@CTA7DXgROG&:A+WGIX;=<<[5X?68]/QN.Y#Z]DYF10+ePL
HI.T9\@?--(UHTCJOg+#(09:9bY8,D^Vc3[^1:?0<a[[WG647@-bF\?0C/;+[d9B
ODOXV7@?^=K?BOS+eOfO&CTQG]MNDJYO)/6Y6<QLVeE_HL9>fAT+be+X#P:JDOKX
IX0,)NN&R8=,3\VI]gN:dMTW4e(HfG1=aJ?0>B:W@c\f3Q[9ZNF;JB)He:U[=c^d
JSX.dDS+66[)=6C4A(U(ARg.97EVM.0@K.D(fT6LC\a+9/N7c,SR)(KE[GMK]N;_
35)B)9Y]GP#e&^fX/V,<=9,M)W\Ge.^KZ4KK+-877F4&Xf;]AP0901?:5g#-QXC\
B:DPO7(G7QGY;YCFUc=RY?LNXg^:=E4U#9d/dZ)gcT]16&7dMEANWAG<?6/C6>GN
d9)K@a#&/?X)KS->&d8=Q=B]<JO2GR<45:@[1OMg7)SP8(D_f2)<RP3VC1Ce&>OJ
7ScOb^A7OC:O8U]UF4LdDV)KWC/L<0,_D[<U1J8Rdb3G?+Tf&+NNG<6):M25?U(I
HZ5Q1C4OWYS,5bXK_CbLP=b^WJbK#\D]0,@T3;0+(T9RU?1OIXG=&0e]\)7P1.g:
P4(IW<QgK_a:C8d4[dJU,T([7PMNVXTBde.7E<#aOZ[7T:;OfX_@+fb[XLAY(A\_
dZ<RWbfJ&[a@8UT.X_8(b77(R6TI7QNTE[3FSV>SS&fFN,FLaDG+19MgE69AYA4I
f7K_0CfgEJbZf;E_G=/(6f-#F&9DD&^R)M2LXX3SK@cPT[.XS4a<U@L.f636N(9\
8,YX=)A/0;AH\0J5f23&a<KGO5[,BeEUW:MY+a4M[K8WH-e.H7(TFf/f1KLMARX1
dG69e8dPa94]B?ZID=X7NW9:4]8cN6bNeU05L,4@-c-dRA/QMS^R9.(-=>_c?6<R
59cF9,cSTS^I[ZD;7<gDZK]_6,;Gd;[4+04F(7.])X\:I=XacJJ+/bJDHG:6d=JD
[L96K(7P[8=<eb[R@DD/WCY>.I@&>[(4TR+?.R2Z_Kd-\Me:=KbSI0V(/83<3G:Z
X&R5JX+?B+)\K]@V12eQO+1:E:_VYBeFG19IZP>5B0-@+3R3+UMNgd-aH]8ITWeT
5B:Y5#OUAfCC^K=PabZ,P,d?M&0P;NO[L^&)6IHf4TC6RD?B,Cfac.F@6ETA.^);
FYRcM^BNP=LESL7I-,9XPPF4N=aUM5,-[U0)7:fN/ALe?+1_Ef,8UUS3S9.Y1fJb
^2b(3OSba/OXB[KgS_35VR9]c\>G_CC\7==32cX8Vb,TU)T7RZQM590GP:J[YP2f
XUe\bRZ8&OZ]=b@_HJ^)]\\[5fM^OcYXF9gF(-X&JX^0#YCc=f3Q#[3[1/P:gSU@
7,#.aA\c=6HU:V9=CTM=a7^?3/bZDEDBgT1dMRS+VQEMP[,=R)0<Ca(RS>G92S4e
d,ED7P-5<EE#P]13O9cWcb@(c9=06H>NS700aEa>G_FDXCg9H3(KSQ)0YaI5_@I=
EW8K&,7.A,1L6&eG_E.aCgZPRR8b0)BS5>\#La]?X7R)>\/dNI/LJID?#=7c6LW+
#@ULPENTXG15<GCJ&8[..SdN^dU#IR:QU4MZ#dbc9-A;.RW:<FfY;JeK9=);D7cL
]QX=3<JC>cc@.e>,OZ8]f,baW81-A1DTdAcF\^W\[L/G7>6Og94M[=8DSHdFWA;<
OURf-1MR_c>/Y^/(2_X&DKSb6.c,cG5]>=P&b0[^=H7=EePK?Ha^fR:FVeO>@K/E
D@;7I9K#SJL,K,I/L1U>=gaP[6EW\aEJ+I-=-MO.R(YRc=\=OGEbb:g6fd2_P0c)
R<.^4OBf@E<b5:DE?N:cZDd9gCJZa4(.HXJ>+06;FfAe>QCeVHZNASEE)AXC2IA/
ZY&d:f6ZfF>4J#g)L:L_E@..G_<Aa+05X=0Y/ZJ_K[dfXf?NeKVUaA5&E4W>V_KC
Q;);1@,(80H/R/UM#[\T;9PYP#c&CG;[2f3N0#.-V26+a;\N)aT@cb98>(b0B8BX
d[=F?9EWAXd2H0J-aQF<I2JMYe^+7Yd;QT,D4B8@cY9ZJ3:/D;DgYagA-eNR()Z1
;fLRb<#&(UGF]b^43DCESH3\dGc+.(JV5M33eC/H1;dbf^87&PgTUa5cgKJAP^I-
Zf/&+[<PIJV;>ZUf/e6HcTXHH8R1E+L7>1fA07:#0K(O(&+&T0.KIVeT:-3UHZ(\
0DLP9P+N5:G35ge(=?)J@-<E=?7.4CXg]X9IZFPTJM/g7^K&/W;V+.&_G6eAbO0+
/a)7C\7,Y/a+>4GTMVaFgT4_O2SMEfA693d(aFI;1)Tgga7;PFK[MOW99HFa(Q;7
K4TMd(@CW93b-HM9)N-[Nf^Uf@9D(RP(<f<D7-.LdTEgDVV,/H\2(Y)?L54SQKR;
.P[P/^cR^O7E(JHRA=;8=DZY(,GAb5HW.B-0MQBfY1:f;LSK>fZ3^O5DYVCZF(N9
XV#ZQE059a9dR0JN=.YgXb_e0Z.LY7QDD+:3-.>FOKK6[9=&.Q;:c/2N7UZ3PWg^
UUB3GSI-S.+9#B8GC>59J;&O:WW>BcZ8\D;4XfCTaC32O>a1@/<gVKF7G_fU;5[7
/E1EYVSAZ8b:=UI^8UO0&BJ\X@A8KAegTZ?W5SLFe4H7M[/]H78fI=,H(T12L_aD
:QWYc<W[VMD=?J-T5.aI,e1205BOa,UIacXKFQ=#W/87#XAQ.fT-U589=74c,/V.
\T7#6V^7A;_(I9Y^JFXNJb:&Og\XbHVNB4/SDF0W,2Cc8d+aLVg]ML5+\Tga>-:d
aTC3X6L9+/6##4gC>I@R+dE7Mg-YLI\f4A+Y>C8fD\3S:>Y^T0&[B73Zg?g2a,O-
_[Z.HUUX)]1;?cA79750Kf<g=3-&?+V[,VN<RY2?FUZ5Z7Q69eMK9BQ]O@EE,ZT>
QI^JJe\\7=Z<@Pdg?VXTFdHaVE2W<?eUE:^PaTN6C0R>e_Ge)UVJ+dNc9gc>7A/4
O_\+,XMUFa[SEX&8Cgb&EVR)GFF-3-7PX5NV?U3gC?@B>:IG3L0<G6e&g_aI?PU5
RJ16[S>JFJI:b3S<[#Re1C>>,8U30=E:-])(:C-&_\VG;8CT/DeOMNa.D#a#[OH,
UZO?6=538)]Uc/C,=AWg51VW<XVbEM^^[=^Q\E:b.]3gENWd\[K-c[1S+e7eQF&U
KPCf3_?XSc@P?I7>I45?c13Q))24EYLZIK_?Q&RdS=CJRC>cKb>P3W\(&+H<LH0N
3^,5B/V)fQD&A6>Q@4B0XQaaHIE_D)f(6e6A(T89UB8N6P+aHcY7K37)_eL?GB,M
:MHf?W;Uca4=AL<e1_62F+<;XXI,M,5F[B8X8QYF:.S<R<QTTb-\S9W2N=W+:Z>0
I6-?5cEb\SHXe[>6>1^VEED[282I_d10c?(WU9IG(a-,J]CA&\.LD8XARK/@(/47
BeL::X2F3>dc2;#?_ER/_]^0<V#eaZ6J^6[I:+8<.&YOfB#Q&8-bcI)Eg@5Z^:SJ
MDUA<&@6c6)EQDM?3J)Q[-g@(&A_@1;SJ9/C>R@?W^\TSZ=QRS,=G?OXK;M&);0/
.JBY#Ydf-48T974KgJ-5[_V.DA,@8GO2FSFA8/gHdcFe\-OF@IQ&,2.ITd5Jda0+
^4MBYN)/H;T[>@-UZBO4G7HS[=B,Z:+\@69O44(aMFVZUTUJIW0M:e\_^2=EdLd@
NFb?)>W6dVYRWd(HQ[<g04/87_Cc)@=#ePg:cJ.D=(T-c1&YBQd4gJN/IC)-UU:=
.,TTb.b7U_O.>\YbFCfCD68LFT)/?(K^/6^E#&AA6&+C;7+B#E+?TfPNCN^OcGPI
L-QP>[7HI04<7c:N:[D\BYU#1[<.W)2+=K?#-;.T+9FUOR5LIKY4C.H+?Zge.[=6
EVWKfXT(A9)R3DW(Q7P\7fV\>V2_92CH6,G4)^GC1SA/@K#@<+,VO6/.G:efdG0(
7R7cEA;39&E.[+(K?KO->?6VDcfA[ID@6fF)OdZ@EfX#QM^c.<B-d6X/O;b]:_2:
0?T?\QcAdc+GX-K0GY7SO7a7B-37&6dePcR017&YNRAZC\(7@-:Jag+Ab;g=E6Fe
S\>+F)[B>2gf:]a.C;5gSZRJA,OI(H8e)JUff-Ae:,0()cZ^ENOf.IgfTBUY95)3
J3XC5R#FQ128(#/C8C]C,^IcJ;Ufa4(cd9E/8E&J<(\#)4ZBgGeB?QL;N,Zc/=7W
;AL2L;:GW9E__daP/,N1R:f,#M0(;<BbG#d4:b?gP0g.YHKbD?_CAK/L]3(7eQ+R
#He1Z,VIRe?Z.N?.,1GZ:VeFF5fND<_P2>DU?JCGX7LDU4#ebK8[2CggJgULQ0KU
.GCQ/\c>ZH3aUD>U=W<<MbF4BV?_J_=bTZ=U&eWYb21H&KP+bE=a3V]\R-Gf.dAN
J&e(:Ac\#LA&J:24b)HDWK-LXg::KY6;1>ZCLS4,XYFe<:g[&KY#0S3[@3H?8f:V
#RQYcA](RcRIHM1e4-5BPI(S^@H[c+Y#8,a@V>c<L17O8T(fZ](Q073[L$
`endprotected


`endif // GUARD_SVT_DATA_ITER_SV
