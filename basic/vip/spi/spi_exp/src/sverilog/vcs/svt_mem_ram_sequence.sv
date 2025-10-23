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

`ifndef GUARD_SVT_MEM_RAM_SEQUENCE_SV
`define GUARD_SVT_MEM_RAM_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_mem_ram_sequence;

// =============================================================================
/**
 * Base class for all SVT mem ram sequences. 
 * It is extended from svt_mem_sequence which is a reactive sequence.
 */
class svt_mem_ram_sequence extends svt_mem_sequence;
  `svt_xvm_object_utils(svt_mem_ram_sequence)
  /** 
   * Parent Sequencer Declaration.
   */
  `svt_xvm_declare_p_sequencer(svt_mem_sequencer)

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_mem_ram_sequence", string suite_spec = "");

  // =============================================================================
  /** body()
   *  Response to request from mem driver by performing read/write to memory core.
   */
  extern virtual task body ();

endclass

//svt_vcs_lic_vip_protect
`protected
VBE2<,Z>4-#@XC&02WA=e1EONHFdH/HRLe_QFdD<E8cDPeK-1/C>-([-SIIFT]Rd
&VZ]B;cU7CT_c/1\_,ZRf/R4Z45L&P-WXAZMgD/3GUUf@8QL]G&gd-XMYPA1YF6(
2HJ3,)\XNADb+5Zf@JZ.?f,@BD<Z+Qb5O,:BI>VE3_E\^+b/8CBf9=bR5>@deGXg
HK1G\5MDb0UL-7V0?4+LZ^,@QW>;64Ue]5cNJ#_X\_GD.N023=Ub(<9SCW[D<>W#
)?J9A[+fc>\:KM(MYg-7Ug&dA>3H3YJF)\C=[X^5&IUcKcB&LTUG#W\RS,>/fYE2
LL?&65W=8F^,>@TBBG=OA;J+;0JbB5U#e@TReZFP96CdQa0SI3=7?52f]b^<0SM/
:/ZG8JF5TC<L/[6ZH@@G>2.6N?J<dP_+2^B<M4+6(F0R44WgUICL/1#.c;.U-9@\
U_f=B,0XY[K>I=(>@6PX=c<HWG(.A<NcS4]G^,U&2?G&6N17[c^.E82?WQC<C=.=
fb/EZLg2HH@fPW.dO29MJgGb(<faB6^A3RPdBT_A4;K\Ac#?W2/QP4RGb,W.-_,S
PN4F<X;Z&)f67<G7gE#<GEUK/e4W+9WG&?IIe6+RE?J>S4ZfL3QRMUE0\PJ.7A1b
dTO[8,P>5cK/3<eLUQ6I))9b/c)2]caZRL;f,TRU&<c8aH[LKE^dN9EaJ:R)1gKO
.Q\Re(VAd^;6Q:0POB\:=_X=-G^5P00M0KDb>,O]^9VBNCgQRg\KUFT(JS0BaR0,
W#F,_/O>4?P8=<GaMFC.WNFN\\2a;-R&(f^eB,XQ&b_SO-B.I2fP@1NYAD[GHIFb
;A(;NXWeBB@5M3+#g8-.XTA&cMA];fON<-c#Mc&+bfFV/Y8LKJQd^\SG16PLcTb0
#WX7#WQ[-33U:A(3G6Fe_;dg1@<e+(/I+T#QA(6@;K/+FBW[c2QbL?\cT5L(f-L\
L?);T.ZR0b-;:=Kd)_B]\6W,4.1>5dBT=MU]CVLQ,;FSFDX3KaRX:Z>4]EWbNEL#
\6YV8.dF@:d^757MG8J+JGT=e,=9XDR[746D8[W&1=P7S5S#?-GO5@^(:X7EW02D
=+[W_,DfQ;T?3>V^/<1\,Y<>=#15R80,2OL=WaV,5G+FFd8fDK(g7-Tg@\&OW<a[
ZA.MMA)7L7//+X8^KMLG,-Y-&\)F8N()>8f;<F1#RAWB]gfW_B-Ga:85)6BXc^O)
WcY_F(_1]\\8EGPBD-4gY\97b&U.KE[INf9Y>(QAJWg+IQ^U#><>JH91g0EBZ&<,
D(Jd7RgT3?;34Pb[3Z;1(/N]:>^+GVOgRMD(.3]HdY.DYJW6U[<==;cDeCBR3&A.
aHPU?bP77/MKY<gOYgcUZ:\Q<GY:LHV\_&5XT5P[V-,Kb?+IZ0g,Kd-N<NJ=eCMc
.8VM]..75IXM/V]1^YP@Z3\Q5$
`endprotected


`endif // !SVT_VMM_TECHNOLOGY
//    
`endif // GUARD_SVT_MEM_RAM_SEQUENCE_SV
