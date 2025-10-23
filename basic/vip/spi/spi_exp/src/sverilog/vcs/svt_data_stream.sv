//--------------------------------------------------------------------------
// COPYRIGHT (C) 2012-2014 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DATA_STREAM_SV
`define GUARD_SVT_DATA_STREAM_SV 

/** @cond PRIVATE */

// =============================================================================
/**
  * This class defines a generic Data Stream representation, for easily managing
  * the access to the transactions flowing through this data stream. The class
  * provides for basic 'passive' and 'active' dataflow, with basic accessor
  * methods for both of these flows.
  */
class svt_data_stream#(type T=`SVT_TRANSACTION_TYPE);

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  /** Next active transaction recognized in the data stream. */ 
  protected T active_xact = null;

  /** Next passive transaction recognized in the data stream. */ 
  protected T passive_xact = null;

  //----------------------------------------------------------------------------
  // local Data Properties
  //----------------------------------------------------------------------------
   
  /** Semaphore to control simultaneous set_active_xact calls.  */ 
  local semaphore active_xact_semaphore;

  /** Semaphore to control simultaneous set_passive_xact calls.  */ 
  local semaphore passive_xact_semaphore;

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new data stream instance.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' active
   * transaction.
   *
   * @param xact Active transaction delivered upon arrival.
   */
  extern task get_active_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the active transaction.
   *
   * @param xact New active transaction to be associated with the stream.
   */
  extern task set_active_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the active sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_active_xact();

  //----------------------------------------------------------------------------
  /**
   * Method designed to make it easy to wait for the arrival of the 'next' passive
   * transaction.
   *
   * @param xact Passive transaction delivered upon arrival.
   */
  extern task get_passive_xact(ref T xact);

  //----------------------------------------------------------------------------
  /**
   * Method used to set the passive transaction.
   *
   * @param xact New passive transaction to be associated with the stream.
   */
  extern task set_passive_xact(T xact);

  //----------------------------------------------------------------------------
  /**
   * Method to make the passive sets blocking. This should be used to avoid overrides on the set.
   */
  extern function void enable_blocking_set_passive_xact();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//vcs_vip_protect
`protected
,TbcM>c3EHEf[6g6>H=(e[Na3aCW(0L+9<=MPSGG(M7L?&HXF5LC-(JE<H)ZXH]@
:A7U(@@7g9[1N2>]ONSeOQ043&J&^E)Y7Uf:S=0[5?aAE4gLNG1?8TH?7])(VU7X
d&N(B0/I33C9JOXX^4B#fR,V4R=&5WZV49-FJ?_W+EZ7U;J_Mf(4[84>/M7SQ(4Y
7+IMEUSGDE(WHdXe\;aVd/1fP46M>P>RVX)RUSc4a+_gWH;^+Y-/CA&;fM-R+_LW
KT/D=e<g@Z)FH904:I5^9K/4?++g@<:9^Ae]f#e=B:b;EW=1^9+>;XebFa<c(:U1
011JGfZ&:X/Ne[]c/PSY8\dd-FFTMM_d4c)90C)74)Jgc=eDD-YI/JD\)DP=2M_b
9^3O#eO&D/^[=cFZJL@J&B90T[0.a7-?9>Uc/D&cF729R:S/\9e/G9U,geEVLHDM
]PH//AECXf\=P4\Zg#5H(,EH5WcI4UZg=OMXb]BB+V_OE2BSf-1I1+#SUS@5g)9-
NC](0I36gBXD4LR^1fAO3+aV_Q7I>P]&39faK&/f=JYc4D<[[3g01g9-DUfG8X::
X:R^20O#9&_A&S2,SSZ\[Ig,S6V09KLDO7->#?C[#WKPf]J;^#0#<V3N.+5U.BM&
-N9d^B+f8f1gWD(Z@PF.OIUR+=bV9+LY[K)[b^X8+FBEO?<6+?KQ=.0XI6QKZGX3
?Xb[]Jd2T=Y=:6&Hc,TV5_6D:cK59@6aCDJ/?EGB;CQT2[+aZE@9R:H@dA^OTgRK
MDN_b4#E,.CbYHPNA,SR0@R9eNZ\b#?JVLf36GEM,f)TBOOLbFQBf@?7d7K)D-((
:LUEN\[O)aA.G,1gXgFQ_]H[_P29[M[<6DCOe)<I@2U0RY/2^1Ge7YX6\>-@I)Sc
feGQ.3[ea+9fR9g+L?8;7++;O?RR^8.+dW(G83f3APNcg6+VQd?AN\1d9&?3FJ<Z
.fW5_?]\TS7&gASY:7)H&^>9O8a/gA&TU?:SC.M\CNg&+]C]OEHC883TM4(5/CQ9
C3-Te&LG=VO/e?0HUAHcR)cPEYO)]W00DZ#<=Bg>PVg5I[d19U<]+Z&d1H@Eg/)9
S4b991>P4eAEW/\GP#O:JdNJ&S=BINBLe]eIFC(1cWJ#c/d\<MS=d66_?RDF[9]<
;;91VeKDC08^1#dMSUDH?#6A(?7:f)8QLO]@Q,8R]e;dRLL6ASI0,(J?(aJ\+TQ<
M_\cXF(e\(4c^K^.+?K65=R<S.WC&W\UB@,-e=+@g4R/3Y#ee\(PEWf8b28c^5;R
_3\.@J=JO_bB)BBIAdLMP3dEOZLUKSP((W74J589JeGPHH@g=OGf60:VGK[U+2D]
)N9@:7CD9,<A;RCGF,LEaH+H_eS<X(Q8M(gN)#)]1/&O6fXRV]=^gAY\FWICbd]J
ATe_@b&Z:7f2=&35UK.I,&06687(.W?M7aLR8&NbE+M><8MMCNHXb2##ID?DH0D/
@RGKKK<#M0I&.g@Gb),eMV1,(.TU1A6TY+V:J]@:53LWF<94#T#AHJ(HD#S,?f:R
PCV/f3&f8]TWNbccT+f9ELM(1=Y9@7@9<dTaC(W,P&VHSKANR#)UYDJ4g3f@Z.4\
BNEJIQWJOF3ec(BJ,b5>(d9Y>IQU[LA7B+<L3#-B>a4RH3_CSG0X^-cH(FQ0D8gZ
IS7K0M2=MX[d@TJAeN_IgA)g+G<ELMQ\@a(E,TA>SRVM.KPM+_F6^43B]L:@\.,E
<:O(,&YQ-]g_d:(3bIVb:]Y6H;fW+G=.S^<6SPK[?R.P[MO_N>&0_#PE_#7>7#T_
d1Z:cZ<WI?1_\LQaPFSYeYX8cH8S#Q]5.PcB^O:bV6SI&;,.^cbPSP?3K1VKVH:U
9R@;?bU1)&:2d9Y/M2H>[TfI2V\fO@,6SV)TBG]Qc:e:7<<3.2YZNJO3J8D>T8_/
fOb9L_6_7J^_8V<]QAW^?,HPUJ9DaK)1>P&?[N>#BT(6UPDP;26XgEc:c8>B;:.H
<F<@[GbOY=9?DbUD/S>\<We^-EN^^bANeOcg@-3UMN4?J_Y)H],bY,;O>GB@dRFX
_PX#H2T^g9:R>VHQ_\g-WWN5[DMA2V8C@9&.#^@X-;AV,:^2DWAO8fI@(FNL#LGD
@B6=UL=;\6WCc6+4PZ>N@S+1XX7GcP&Ka+0O3Q4BY&8V[7e-dUKC(1(2F(.J=W-?
gFg+OIRI#RIPbQ51UR#gXBF4@/AGBH,cI5ANF[<./fFCW8^IPb6JH0ZZ#0D^F@,R
GEX.]>]D[9X/bW(?_>G?4QSbP?V<.Y9.#?D_.[0VbH<E^DEZXQ1J.C0cG7f(aaLd
=-5(6W[5YV49MF.A@:ZMbC8PPMGX+0M+?/W\^?]6;UDM>N?GT?0\I-1R4Ug<FGOU
36Cc^V-E)&@(9@WV:d8#2M8P7$
`endprotected


// =============================================================================
/** @endcond */

`endif // GUARD_SVT_DATA_STREAM_SV
