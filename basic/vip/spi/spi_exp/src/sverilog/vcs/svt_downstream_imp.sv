//--------------------------------------------------------------------------
// COPYRIGHT (C) 2014-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DOWNSTREAM_IMP_SV
`define GUARD_SVT_DOWNSTREAM_IMP_SV 

// =============================================================================
/**
 * This class defines a component which can be used to translate input
 * from a downstream 'put' or 'analysis' port. 
 */
class svt_downstream_imp#(type T =`SVT_TRANSACTION_TYPE) extends `SVT_XVM(component);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Queue for next incoming transaction coming in from the downstream provider. */ 
  protected T next_xact_q[$];

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new downstream implementor instance.
   */
  extern function new(string name = "svt_downstream_imp", `SVT_XVM(component) parent = null);

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the next incoming
   * transaction.
   */
  extern virtual task get_next_xact(ref T next_xact);

  //----------------------------------------------------------------------------
  /**
   * Analysis port 'write' method implementation.
   *
   * @param arg The transaction that is being submitted.
   */
  extern virtual function void write(input T arg); 

  //----------------------------------------------------------------------------
  /**
   * Put port 'put' method implementation. Note that any previous 'put'
   * transaction will not be lost if there has not been an intervening 'get'.
   *
   * @param t The transaction that is being submitted.
   */
  extern virtual task put(T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'try_put' method implementation.
   *
   * @param t The transaction that is being submitted.
   * @return Indicates whether the put was accomplished (1) or not (0).
   */
  extern virtual function bit try_put(input T t);

  //----------------------------------------------------------------------------
  /**
   * Put port 'can_put' method implementation.
   *
   * @return Indicates whether a put is safe (1) or will result in a loss of
   * previous values (0).
   */
  extern virtual function bit can_put();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
0)EB/=?A-YH5f^.S(VCN3g:^DAZA/^#\JCaU06.78Q:PVHV_F>ZF7(MWX4;3DZ9D
<0+08V(/N4-3L,&;\0WZXBI1RcL;e1;@;JQ/0[)^9Db^6,_LH^]TE0]f1Dcg_&P9
<HD4W/C#^0g[Ca1N3C)gQ89+C;PY-,D):Mb]8.K0P2;dT]?QW,CDZ[Q.bD+g:[>X
M+Ma&MIF+4^CTK[c,c,LELIK+1Z:^:DQ:Z@g#?/^S9.)+e4Cd]<a]F3/E^^/,H:U
c0UH7PQe@K--K:#f=7G,IE[(M=f^U(\=VGd?E4;3^>Hf49@QcR_]R9N8b\.@X&X&
)L^?4\O2#II[:I?[6).OX6RSV6<&Sa=26^cW]06-gWH4Of3L::aY50G2PKBVNQ-R
31X_S^SNJEaW#P_.5\]E.;QP19G/L_V#MAN6E0KSTGZM3LYJLH04=RX_gYYW]OKR
RSc>Q2e0gYQF)YBN8U\?SFb-VUMccM0g^=?<X6Y.U;,^=cKJZ>A)d1HB]FQM,J-V
VTNJgK(PZ6WY(48D-Z]Q#aH(P9+g>4+_9U67Eb?eECZ;^aac=UIE76QdIOR@)3Mf
cE\3-K<]/fE1\8]Y>.GCQLN<K?b;^(e<dSQb2G>T6\.c3dN2Q.UPPRI?LaF+dbUW
/X?36JaC/#VY)N79+b93PO82gFQ9g][.X((_0b4N(7[SbH35ZgOS=TfPX-3EAS_1
,;=#&J/F-<N7eL<;(AY(ALI7NY>XQ8[HOV2A80LW71L]=aSN1bgJWQCA<Q9f#cXW
[42)I7/LbS3OSCW4_;RB8G@+7K1_c[5R^HU7/7IF/6\^-)KI8dZB,gAg94@-NEOa
XH8^.[\SJA,)ScGf&cI.LdcPTfE>WQQD2=.\GVX9@[VU#;6>V9Y,e##Hf.KH/6-E
<fcKJM1T_0@ZAdUF&DJMF7+A,[.2bCC-0)T&_fA3V&Va&U@1#6T1Je#:,I=[O.J,
]\g-N+cbcZgB(Ie8V2J)119MDM,X-eDbg&I+-A<Cf\ecI.f=CJL-DdU&U8;G\VL;
4F6e<;;RdRJCJ+5V@AR2WW1P/&GS3AA./Q\#?/a#>DUYHW(\;NEabb2IHB>B+X4W
]\TeG&53NS,_dJISP5T\.X#427P+J)RS&SWV6LW-(F^25bMf-J-4EbG@B[W)XA-P
<<T+-_@dCZ,c;0=O&YG,?+f0O8&;@SD,Jb]?0]_<9X5I>F\<;9/HZZGA<^6e02]Y
(L<<W0<fG[;T+]+]&[;AbP=BE4NX^?;gKQV[=0LX=:a(dE:aC.2_?7<7DP\1]=CZ
KMKBKC(g4-Q<Z2<:aS.N(;=BbAb)(bT4/75\-1AgL3/Cdc^Kb/JM?T-:GITZIW9&
D6bA:,LYMK_-Y5.0R7:g]SZU6U:4W6:.7^#a+a2JJ+bCD:QFeN#3I^N-@=7-Ud09
B\A3P1FCKNBJL(7J<IGf9D,E()8I1+c^7-98e;1\MXPB]H:)ZXPZ)aA&-KTL?=AP
JF)OOOU9CJ&V+9)=Wa?2+gPSU?;8T2FRf(P8He30Y=TbJF_6^+54-8c<+]bNG:95
-3<7YK:O,6377^Z5gHe;M<+I+/8gQ7^/<OF;5+^7S?_:DNbQ(d8Q@82VLdaZ49,8
Xa(N7_f>15B-7)T1fU:O0YIVOO&:VAGA+YWGK^+[<+?\WCTS@3bP[f;9+1Tf1AH4
O8W-DT.SU<DN?=eJB)aM#L0/1)>0M438\J\>S&N]fHR7<B=(g75)K7/L7J9;J<MW
#SFPJSe8G].:)K8e5XPXN\-Z8JEV]R\aB=YcLXGbH:T.N#)7#3>\g/_/B]L<,FSe
^^\?0df]&=8W[[)^B)^Z.:[0;Z\[2T&Q/(K(#SWA#2fZS=U69LO6+cO+XII);T.3
e&D;;Y<&[b+E#AQQ=QAg^f;RJYA0MHgJC)_S6WE[>e7fLP03>g&X/3L[-7^8dX<H
7Va0T.+G)cN_-M9DSL0:+9R?A0(NFFf<Og\-D:-9EF;N.)^CJ8D5#XL8^Z;K,)P5
aWC1^N[>BM<\D2CTUf@bKV8T9#K0[2dc@IcCNM2RW?XVT5XB62:NOZ-I;Y#0\];&
^GW03JQcI6SI5)Lc+P;gK[8T3$
`endprotected


`endif // GUARD_SVT_DOWNSTREAM_IMP_SV
