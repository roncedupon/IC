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

`ifndef GUARD_SVT_TRANSACTION_ITER_SV
`define GUARD_SVT_TRANSACTION_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_ITER_TYPE svt_transaction_iter
`else
 `define SVT_TRANSACTION_ITER_TYPE svt_sequence_item_iter
`endif

/** Macro used to pull the data object from the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_XACT \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace[top_level_ix] : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace[top_level_ix] : \
  (iter_type == TRACE) ? this.iter_xact.implementation[top_level_ix] : \
  null \
)

/** Macro used to access the queue size for the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace.size() : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace.size() : \
  (iter_type == TRACE) ? this.iter_xact.implementation.size() : \
  0 \
)

/** Macro used to figure out the first available index */
`define SVT_TRANSACTION_ITER_FIRST_IX \
( (start_ix == -1) ? 0 : start_ix )

/** Macro used to figure out the last available index */
`define SVT_TRANSACTION_ITER_LAST_IX \
( (end_ix == -1) ? `SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE-1 : end_ix )

// =============================================================================
/**
 * Iterators that can be used to iterate over the implementation and trace
 * collections stored with a transaction.
 */
class `SVT_TRANSACTION_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration is used to signify which data collection the client wishes
   * to iterate on. The supported choices correspond to the collections supported
   * by this class.
   */
  typedef enum {
    IMPLEMENTATION,     /**< Indicates iteration should be over the implementation data */
    TRACE               /**< Indicates iteration should be over the trace data */
  } iter_type_enum;

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** The base transaction the iterator is going to be scanning. */
  protected `SVT_TRANSACTION_TYPE       iter_xact;

  /** Indicates which collection should be iterated over. */
  protected iter_type_enum iter_type = TRACE;

  /**
   * Used to do a name match (using `SVT_DATA_TYPE::get_class_name()) of the scanned
   * objects in order to recognize the object the client is actually interested
   * in.
   */
  protected `SVT_DATA_TYPE              name_match = null;

  /**
   * Used to control whether the scan ends at the name_match (0) or if it
   * includes the 'trace' of the name_match object.
   */
  bit                             scan_name_match_trace = 0;

  /** Index that the iteration starts at. -1 indicates iteration starts on first queue element.  */
  protected int                   start_ix = -1;

  /** Index that the iteration ends at. -1 indicates iteration ends on last queue element. */
  protected int                   end_ix = -1;

  /** Index at the current level, based on single level traversal. */
  protected int                   top_level_ix = -1;

  /**
    * When doing a multi-level traversal, this will be a handle to the
    * iterator which iterates across the objects at the lower levels.
    */
  protected `SVT_TRANSACTION_ITER_TYPE  level_n_iter = null;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    vmm_log log = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param reporter A report object object reference used to replace the default internal
   * reporter.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This creates a duplicate iterator on the
   * same object, in the 'reset' position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE allocate();

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  extern virtual function bit first();

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  extern virtual function bit is_ok();

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  extern virtual function bit next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /** Access the svt_data object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param top_level_ix This positions the top level iterator at this position.
   *
   * @param level_n_iter This sets this up as the internal iterator which is
   * working on the internal object in support of the top level iterator.
   */
  extern function void initialize(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 0,
    int start_ix = -1, int end_ix = -1,
    int top_level_ix = -1, `SVT_TRANSACTION_ITER_TYPE level_n_iter = null);

  // ---------------------------------------------------------------------------
  /** Checks to see if the iterator is properly positioned on a data object. */
  extern virtual function bit check_iter_level();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
K;[&fCe03Y1Ie&@^Sdd(b<<S9G1MdA/1a1QE.W^d1TXGd,KS-^R63(2Sd..PJ.Cc
Q>#TU&O;^&;VZVD2BYH,\;e6Y&LC=AO;R+RGMHTO7eF:DagQ6/,P?5Xe04T8)a]O
GI@N.cSLN]<C#K.NM2(5:)g7J9bZb&39D&E3YJ\@+I3;gSBR[61A69+I\/1\3?XI
\U-615H+?:W]/X.\8LQ\.IYOO;C4Y.N+beFI8fW:_>#gFcb_Z[4@AeD#>21E\[\&
K6)f0UK[#M\Q:TJZ)6O?Y/QI\@FPJT)90L#VXRD<V@5#U6,MNbU46:(P06dDVY<H
Z12^.Y6a_]&-)V134F:UFe;cM/;aZDS/J>VM#NQ&]BZ?TM9\bX(d3b\SL6U<,1g8
V;9S@Qc,cOX+Y=bfP<<CJb:=XOd]Y6N#19Z&8,@\J-3(a4M1H;ID@LH+c48dK/dE
cRbQ4bGO_6_cV#7B3.b2gS#JW;)Rdg:Z(g0M=FF?^?<B#e047HaK(UT^9+@f-OL^
c.C_09UQP?gL@J/-0B7IADV<:5)cL)MLbJGJAF)=6;6_[d[<HDN;BGX?S04^]/.5
OM\T;07;eF&4aWREJ4&R+=)JM&XW]c)GS2A2D/8R84<d]Y,SF>3Eb6810G9I7^fd
2WI[X49HNgM=]<d^Ocg0&375LcU?V6eQKaZ8W?VV]^&ace,JZ_I2<+VT^&B^6W2Z
2<[&J2(#ad6Mf7(>:<(UP.OMVT<SKH[F[?:M.IS8agA:;[-1&>9&#-U^e^D0HAYG
L<01<Z,G:EMf73QTV^KJ:XP;/dR3<4+VT;1K?Vf<f32T2HbVeTG+@#(-9S@1Y1<;
aPa^>UcX8b#]7)@[=QVT4;_bGH+.U-PK9STJJ,:H7JQ(F9?Qcc\9B@YE>2<]>5M#
M&Ae;=>-R/c@KB@1SEf(C-/KHZ(@<HLT&d)]SeKC(M-G\YQ0214dV(X.MF;DdYNY
[5NT?-[aAVG1&1(M7\#[NcSXJRT)15BXW@6PbXIV)B^W#/ZN16<^0J+WQ4^S6BQ5
3/#Pd_D2V<PBb47;8=Y//]LVeSDOBWBcJNFUf\e\X+8]Z7=&>LZ.b)VSG_JY^ZTC
J0HX0+(\0;C=GH6M8?W7](5LR7GE4GUeD>X@S6HG58Y^EWR8P&B0)K-<G@[,M9]e
8edaTIIATdJQG;GK3gK338O85BQ;:,^,BEcM4J(PTQ#U<a>FPSCW\[47&RJ2+#1A
d98_B#UQGN5+BbY:H\@-(_@SGcZ[7F5RcO/dd4f76TOU@.J2#E/:]+YS?&S81D[0
.Lb4O&/S)aD?TfJe^:cXG#3RN44+B&C&H8O+ad?V<I&E.CUddNW:^KEX^:4N@[E5
L\Y]C+0:)geYN36cbUT&)g]=+6Q1D9&1c;QPU.RI#=&OMZP3N68NV2[]-K72]b&Q
5,8EcI6aY-69-/b,E[;D#FN?Ja)AIg;F\e#K.Y87(H>bID6KHMGd^^JbFG?cb6JO
H-F@7V]SaRU@bMZdf4AR#/JU>5c/Ed385X,Hg4LF:6ZO>U8;?ILLf=b7W2-fA/Oa
=8>#C:gQ(3caf5,@[CLMf(U6THVCX:V=2^dVJ,.OB5K=<13ED#-:,3OWR5?0FQ+g
,dOO[,B9cH?9b7-#X_&PO+LJEg-g>,>fUO&>P1OZ5FTIDeM_?95HgW+:YXPKNEAF
,+N=[.>GQ,02;ORF1]B-B;SG8FbT[)/&=UNGU4=H#//(6HJ8UU_?Y?8U]_PFGEU@
I2aS>He:P)G]+HX?RE)5SCN72QS8\)AJ:;8&DIECWafW=@F?,R)8+29;)FL,5^=Z
YIB=LC.U1;#><(VgWK)_/U#S@?WDQ#Ic/C3_LFX@=9>7CHG2dTFO=c)gP_V>/9bD
aSW+BP(NEQBcM:OQH6GTJTLE)I)0#W80(L/Q<GM\_P])L7aW8L2.@bWXT_GN(CS)
O+&cCce?9-UXf9,,/;)U]K\5&dWQEFdd),R]E8Wf=&;/=6)Z)PYN]EdV5a9NOZbY
Gg#@WLCb;Y2KA?AJ&6-(OPK>]RF^L\C@EF_N_Jabb7;:=L[e&e1KT+CQ58M111>P
OIZBbQ5cMMQ@&6H3BT2ZI/#8.-I69],)g2,+fY)?742=K<#K;+V3PV17JU,_I_\Z
7;]5G,JaS-AfHN8NK@?MJ04H,I<\QL1(0P687b?:[EcU]846M?:RR/I1=ZD801S@
7d@gYTH,&_aXdG-S,?#-dZdcHe1.^3OR3X43NQc2[#=.=E^><-+>dQX?A0)&?.8/
dg#D6BKYgF=0V?;DD68+dH7:&5aB,C>B-+&,HdA(FBR@7MS.Fd1Ud&S+IFF@Q_E<
RXd;g:44#)RaI2:&T1F;2Y[7+G67[<J)1F+>aA(Tfg,GS\V;65RU\Zg[,13KQO5_
He8O+]aB#LEX6^DR>X^4gZE<)8gX]F(M7]0\eVVC-<5D)BSa:=F#Oc3UTIP.9<EZ
EXW9D4>1I_b[I]<A_DC/L;Y,AG?8/fN0_\U+\F8U]T71I-Q=:]d>:TC@D/Sg[WKB
Wbg7HP>HJNL3-&EcHFW0Y8N8)W:);U29VHI.L377f9:\BgV][=f<+8fd\cB6&F9A
9&-H@LGTUV;:JF099]/&7/,QI=C&./,3<KE=/X3X>U+)Cg;8;0D2[5#Y7);@449)
WW?VGU\c/^_DZ[36gefTE1Ub^\I8#4((AJQEKaG.HKF&J\G-#MXOLA3a@5P:GWU7
:WW8GMU-BNeJ\^g^AIT3-H[KBSd(70W,RKa5CDUDcUPdAX1-;R-]FIGg#[F(X1d5
NWK4.J+(c48<]QcI>,Gg1R@L,\TWC8Y^]H1A)]9TFX4^#H.29Y:GeMWb9P7@7+bT
)1::[K]J0A2PY^/d&e-N<#;@LK5cd\N?VARb#M0/HGWB1DXFA&.&95/6,7YLWe7=
HWS9OK>C^UZ0B38U6.5+9E?3UUKC>=(VY&d3+^,#d3QaPT-<8Jb+GDO[,ZIX@CcL
(-\;;/+>&dPJfE/LSQTK1(@g#ZgVDQ>N7]aMCB86C)L[[A0:1_L>3F7]ZG<:He(C
KL#O.=/7NG)=6\APUbR28N^C[4GXGRJ&8S8TCf0X:Y4S5VZ/IfX3.510J1:N:>(Y
>JX;6>67DD:F(VXb&\[KO?(6J_M,]?ea-52_2bWfAJ)];3PY#MeVG[UM5X^4UfS0
&UWgSf=_R?#@/Z>6OUB2;24WBS[G5YBHccX>Wa0>/)SUA;bJ;CMOEYdV:@cBI?<<
]I4)M/:G@]A\S9C3QF8_=84DW?^JW83N5X/dee-Ge-<.=XB\E,;GTN+#IZZC=U&R
6R<>((#beG^0F?1=Q&-5X>ZI;&T9^@d[IZ3JF]Bb2HE\Z_CVNHB7D7eHaD\ZY&Dd
]+ePg<[2I\_f&g&U_f97c(HC#-H7->EeJMO0ZbcXP7ZPER2YK0L(D/)MNX++,7#.
//K_[.QgA2K22Qd:]R7P)e^)D4?D5,Ig6e4L#2Q-3NO6ASX=bUJD3KAAM[3.DEDW
VM&#\5MWB5H#HPN/IR6IPDaNC9aOFLNY[78^BWP04dDc1831CHdG-c75W:Y;\8PT
J@f_Vg[e3?XP#XAQb8C;b:b(/#H?.9>9;0/9&^LFfQ<:6@VQ;>a^<(W[B5)FIg,+
g=.DL&H+P@=-XX3Ob0gQI08\g46M_&=49X+HBGPfBR6=CU\9@)bL[=\I^?4,+1T,
N1UFF9MbIQ4+E;D?-/5PaK#fE\3F.76I9,+);C:DbcYdM9QJAE=NJ9WQ^?\CbIOS
:WbecFGSAW97TYIe7N[e@]H_eM[&eD1SN_(^2MZ:(f/J]J87W#23D5^/_QaRKJ.C
C^(#0f1-:LQ8?)^+.c)5a4,-4b[JaHb\g2]H9[K0-WM+I],FLJ@.#)+7>FTfCNI)
2]d33T+3TgVK-Y9J;\O[2_>9dHBKZ:YI#c)<:[.#8ZRPX<O6O>W5\)f2G4Y0UO:b
N<F29@T@TXZQMBCb?GIEaOF;M1@5IN:VJ(O=4]^5_WSQ34?)A8?Eg(S>SK5-1)BN
P9a3V+4+Ig[+XSZ<8MS=dJ(K7+_S-Y&]^<4dCFc4[5;NbSZc#E,-=9A)&2?^,ESS
e?fQ^8(Zb7dL\?=40U.J,^AY)6KDU\7OfK9B#<>2?1M=B?>NM99=4WQIcL/fX4dL
ZC#2U,g<X(+/LLf\Qf3+_GM@.WA3:Qbb8&c?D7#H7>03M?UF,FH7M/1Ac:a:EY1M
7TVeK@W2)IfLVVdDW)@Zb-9M@Bdd&UCY8M4P0&^3f[1^eab_5CCG._8#UMbQKV0O
dB?a#@;@:J;8POd;.4HE.?9M?TM\\&/59U&T7G&(DJC>S4KB1]GScK5?Z<,C?IgS
>A&C0Vfa]-XDa80V[OT(>A-NG:Na7Ic&L\7-SHR;##Q7\UN-FM#5aT:O:J;JW+)4
e69=P8]3#X6LW=M].WE+LeC.Hg3:H&B)U#71R[H>fBBZPW^,R]GDTEO0YB57g;;5
7ANd0Vf+ER2@#:(f]5,<2B@@&6gTAgGP#D3>A-K/,fV.Je0Y66b&?/6U)I16Q;4[
B9)fB+/91[;_0fgW>;W1CFac-KRdO:IAgK.gM4&;dQP>NfBX/F)U4]AA^>a8M\N/
6Kc/DWVND>3</b(8Fd0IHJDJdR<P;>DFFP\SEQ=6R@F(f(S\H)bKCdM6-ZS^7Ag5
cX]?8<?f:NgG?@/fHedLOY/N7H\A<c0X,JN;@2XQb76aNY^eU;7;cedW^DQ)DPP#
8Z0E=[7)I[N8G#1CKg#@>F<dbY8-><PB@5B^6#Ib(PM=O.,=[X_607T,S?/CU+VO
gG>_?E2LGCQ<]P4X^cMXR(TM:cZR^+:SeDQLY1+#/E,LU=V(a&dbHfK8N[e;VDg@
2?Yc@b2#H:/\OBJ?T\C/9E:d,ZVdO:>M)1\]?MFOXY0T46-d?&;TV@SQ4M7(BV4L
GA2HEC9(gb:@ZRPHNYgMY_E1g2(/aM9@,,,M)WMIcW_:H]cNH87LC#69XS6JM^#5
<+Y2QWgQ<PS\<V)7J7.L>@>TT3C_.\?;3ZeH:R([>/H;RCKF>=_-_KGX2f;D1T4=
+CD5L:cXLCbK?[CH30,DKD87FK),Ga8ga)HM685XA)cD=6B(#<U>.G?bbTZ/6EW-
QU>fA/BABPM89^cR01;(3[30b]:/PF\Z+N1.?gP./);e2D,O2K;IB)fM,J+bF[e[
D)Hg>(R_0;J4+gff@L1LM.#MNQL(0fC[&21^&Z\S--(1dWDeBW&PZI\?BZ=>GK?A
Jba&A4B)1&bc40HV\BVYZ):[3XMOQ;2^FSY-#@_^82IKa+JT^N?ZR1;R4W9g<^ER
MD,]=(5ANa>\=1cN>,05cIJZIT3126K#QT#07)Y)]U[I<SGe7(76g(g/7TS1G6\C
XE;)O@b&QW=FR:]\(OBbBFG4[A>AE[7Ha]L6NXQ8,LXE50;JVbeHJ7U#a_76A)Xa
^ZaWBW#bHN1GK0F,UCW-WUF.9N/XPN7g)C<)1V]A^>Pe9e=T+aAG>F[DSCE[V_=<
3A1R]6fFbZP9\1dV;OD7,6QV(W3SFMSVM5eTKQV_>g^MDTY>;R><6+DMHQV#3=@J
/FSR.2U#B2?IMC415a>07WRO1NWH8?GD=FP2UaVCaJ-(P4PX,/L^,1d#=:I,:NWc
9aW=fZLO89ATLc.7.AA-)HUI_7\=GE/EL5^2HK]T2AR?@9[RHTWBQU\&&O2GJZ4^
><^\AEP.#S0/L7]4(/d\Pe;^B2PbbN,d<&/ePP)A\\bB9&<4)\KEN(T1Y)DBALX(
@W[B(WI\)#;VR5W68aX?<2C3XYT1KcW0DC#e^F-&#gSF6,/.;d<c(<6Vf(+F0^B;
Z7,@:^NXCLO/eDVD,X2T;A+8TWQ.I.d<UE1MeJ^9#Z>:G=708SF^b9T+4?.U7c[.
,D5-0#T-)cK<QOgdbP>DOR#P1=9<fNQ\A[c<AYd&_3/+(K9e+a1S1MG(&R#7O;I\
/F)<O[[e2a>(_Z0.E[Eg+bST@TJ?Pa1/bcbKT-<CRSDQ5OPL\=[:M)WA9?\W2^Y&
3P[,-MX2cFAA^LRK106IVU.3)UY>QXX;:GdUcgY2^CHaF3Z/a;^N_&TCTaBg>63=
97g=bIR22UQ#4X]SUH4=53PWgGG/J;30K@L-1<MQ><_<+S)8N=^]4Y_0BJJ\D\9M
[5W.E9(IB1JJU(d^+3VB495^S\BaG9^4(G9ZC/c[?4(-V&dC4a8\;4_;T:K[#YDF
W&FEA889;//6f<H070ZZR,4[abRJ](;WI1=E([cA<U(/IRNPY8-S&OY[?H/ZWe#<
GOQI>EcM:HB?K)+[#)MYF?3J-gN3a[Mf@PO?@:80-=-<1B.D95#4)G+#4W^E[).9
MG/8/WK@f<1NQ1<UeVOF\WE8S0?KT-?e?ZeGE,S;fS6X91C0C/5A(DG/R6GIaf^(
MW+B:bg_JQ_Hb?Q,):gA.XcK2;g,;7#6Q?(^WP4:X#/5bU[S:8aYH?7N\O7FOB2b
)@A/9X(4MXA_U66Z@=/3D_O-5UK&b<aM6NB[/A@LEBD890V=L_dLBY.[76QTIFO(
:\C7)7AY4_gOeQ4?>NTVRY?-gcd47UK#.DZg=,_K3d:07DQ3D4D>VK.7Ue)3:AVO
2VH.QQe9+dFR_eN18b)Pc;e_H4^GV[\.#<1VISG,6_>9.13,#0=f6[,\,BgS_U6P
f1/C;6b,[477B:NT;JXRcb3;D?c?/W8eMD2?\K/N.636Wd7HUE:Q?+:,AT@(_f54
c16[9NY9;_DM6_U^J2XVQf570P0]JOB?f69V?Cf1;9=CQ)U4),W#9O?X-[3E(R(/
]aL^5(fb)@#CO5C7H]RUE[?[J:g(,R(:=:fWND&S5,^)-3G\Y&MIc4(UWT3O+dJ(
XT<XIC#>YWdLIKH.+J[S0I],@7GSg_&25Q<H0.?b<.?50f27??Ua2ZX?1(HQ[=,;
ED@=P[?LYfEeG(IbEQ.1(QE?\6#+g=f1K8EMNgV4JIgD1;d@.UXVVP=d2T:?[]S<
Ab@XB0EbTH#;B;dJ[Y>-7<-eIAPQI]CPXW&W8,N,FWA85>e.UJN.(FT3:CY#H:8b
(M/af#8^e<O\&7FN-#/X3<1:CJ>K.IY4f6#IEOK+gfYR(B,RbdNTf)&J^VP6Ufef
YJ)RO]S;-a+I4a@_Oa_(6HdZ\T(:\?LOR9+X/NHV>Q,2\dP\^G+;T=)aHGNe?da#
3]IXMB5gdQ-.Q:1^=)&#4b7P&QZ:PEN^>T:7TLG^6Sdb6)Y[CJ:#g&0#;=#1NBZ3
LC<)([Nc6FLR,YDK]_>XB3?Oc8H<XFZX4UDMD4)D]A2?+(=PN\fT8W#-I#1N<F3Z
K(c7598?#@Z6)_INR>DM^BGC?ed=L^IDJHPCPWBDPET4&8J=]<H_GKI+F2U3),+J
O\N)>Q)>a\-R4?01e?0Z<\,gUD5@1?WGF/RZ=5MW;54@FE+faQ7bPVHE:EQH]4JE
R4T1Ya65LK4Z6Q+dO[Gf-YDR[4>XK?aW7)M1H84cfb?K-3]a_N=.\T,+b:Z->+(E
Q:^]49)17\6:-Nd4#E<O5IU[,&O&6NKAOMOcWCM_-dB.:Wb@#g2@4+Z+PYQQE8^a
4WH:]JTS2YYIVN7:3>g(e9WOJH_EV9+\S5QAG2<EJ^/E<A&Kg[1/KZ?N\B)7H4;c
:IP?NOH837V3d5&@9WH4)I?K9O1+RdN@=1][OS#1T>6L\VEcL)BF2PK?)RKVOO(/
1OcC1_//,7TFa^LfQUZ/2Y89/eUa5Bc?d3>_]&B>(g113NYOL/D+>AL-M3:0V1C]
E<\6H&7NMZ6e9U]SgDHCZ+&SY,1?E/;c)<RV5Kg09.#PK_eXMY92,)]PH@O=PJC)
SI1N3?,]c6Ca\)c6OIKU^@+1.OVZT-6C_^JY)+3U]aWNBFc^RBfc]-bc8E0CCF9:
LSEfT2@<3-U#[[_7\2EOQTZ#?,FJ6?;@I3RMDI:Cg]gF,C=T\6gVGM5dVPPX@-RO
38Fa<99&a2O2XIO7[8gF:[;_H;<3f<_4P]/&1Ec;FJ2M8[YDB#c5B)\8>;TN7,A[
6T]ZTUgN&LE&XFD_4388K9S]TOP3>]?63IbV1#1&R0B69>b+aEH/OX+Z3.SEdIXJ
M-e?Fcf7QGG,+EFS543cJWSO-\.GI0T-UKI76^FLUW7;JfX/]e2A=:-[GBfL.78/
\RS4_C]5U&6+OY,U8IHT7_#=(;^0D^,#JNMP7F(f/,6fa)bV,_])CXG=OGBBS^,U
L72[&QF_Yd3/4_+Gd9e_f;XTN+/<)(I<.-LP#VOR<G3JQ:BcXI/,#Z(433TReaKB
JI_#&Xa4GHc)=-U-<9Ya^VVTB4?1<Hg1:P3N?3L]\Ec_c,NX,b,KA,bHeRIWb6CB
KLYI=629E.P.0[())2VFa?-OD=N2+9E:;8IdcA<4PXc+f-E?[[]c2CX8KM^=25KQ
FDT+JV_d.AR,X_+QGSEF,cWaSS&+LA[BQ4P[1<&b,2e4NPM[cJZ8DX[&:@\TU>&E
[6\QHV7]@^b#W#/c6KH7g_S1=(a3QV+=-/:]WTg1UJJe\S8OCf&)AF&1RK5ZL=YO
1c2B8-3]784ZHM<U7(N6=.T\UD:0GM10W3+(;a.2/>/1Hd8_AELRYZ:cRJZ0\;WT
OfPA36IJ9B9?,b+//UB:^3WU._V;JO\?)+\P41Ya]O9#JL(\/eAC/?)M?;f+-I#,
Y<[NU5UgcCNIVH1>X3D[1g<J(>?#=d]0Tf@&G.bOK[cSKcF^:MNf-U)Q<@W3DU2W
I1e6U2JQAFYTG?F<^Ebca^_Q#J?2NOLbCf?<@&O64I_>@MYf40Ufg:c0SR>BegQb
ggPFb>g_8bT\OC<MS-P&?edZ71Ze5/8b]e#Z\>,d>@#>e<8;RN0FZ4]5Nfd5[6WM
RP?9MIccGMCY,-Qe\6H:g>.VERXPAX&QXIQ3USb[]KV^BYO.<TPF0@B72(6E4abQ
S6XFc[^f]g4SZ-9#^X@I)\P)V143)W(KBWCAPgDLa#N5^B<V@222C,c?g:4+aV8N
0..4g?;S8Z^+M2T=\#8ANY9aRE_#e)9@_0&2]2<1>:9M,R[&Z^_VJ/)4D4)E,CI0
WIdB<=e-;VHE</c+c94A]5JP6I2XZJ\N#<X^UQ,^;FCMBC@C+bg;N_2>f+UWaP27
4BY6@V)[g+9LE\(Pf=,K(R69>.Q-O2F1W>\@Z\JD4_8Ia.#;=cYXZVZHAM/?bALa
:^8^0_HDN]A8e2ea9FN/]R;=;F5#VW:A:4O3Y<acf^R/\7&W7EUKV0cZ>C&#Y3_7
f0I;N8Ze3NLaMG])EQ4Vb8&TKfb=DdOM(MT&U#TO819,(2PA,[3?)#cRN]<^^80M
<b4gZ^b0WOeUGWDEZV4(^VW.+5#/;ZbZU=6=Qc<Q^WXCA7+:,R[eTbW]g8M?UWee
@T&A_WN-PPHd:BD6),I+8,dZ(5;NH29#)0OBPRA#@>7AHT<GG(&gcW(_TP/O3fMB
1\J>][MIPR^ESY>LHf63S6dGI;Fc&S4+W\S&^/&OTXc+]f+4P@LZ@L1dD@RIdEaV
M:(1ZO6N5KR<.27O1b8IC\J6:[<P&DeJTO(Kc)E>D:@1b?VeFaa+&^3VffVICS<\
Nb][U^39XfKPR&P>()\:MSE_NVF^[c];5&g3PX0Y,R^:cbN?\QX5:YD0KM]fNC[:
-6Q<P@5?[R:/UC(g(WFUR5Y0J/_8K(+&QHL6bO@0\I[;>7#P(?LGX=4<&QADC@SI
e\JdV>1\ZeR+IdbbMG?b@0SXH&3O7.C#_a8+<J?EKQO^N5668)Q(2bNL.Lgcfg9N
YEW4@,9M=Tf/WVQ?7bV0&TcRB<e3M-M:Qb7]8[^]&99#a1R<ccT[a=>9VOF>O3L.
VP+H6.SFg_DJfHI4\H,AHS)QM8BHC\Z9(Y^HaZW>^S9E@A7f#EOV>ER[&>FBE[AK
N+<bPE5Rgd0R9:+aODF9fO:1],?XUU6;WWOR-3<26N75a=9&Sd]cSd]48Qe1:0\D
d,;6?50A4EY2eZI>fgLU?7<A<aD?F1=MN1@5N,O@F459RH]J4AZ]DLOG_P<gG]R.
+A2(VgAE;IG/HOT\OFO,;ga[6L-7VT)2DU<T]=b]2I?V)4fZWK:PJ,]:LX?K8:cJ
WL5]L&bHQ/8f<_2.GNc]C(:(]OUgM4f)e-=7<]9BE0M/^(NeA_?]7(VE_Db_>HFA
<g,?2I[45QF)>^7>T6V)23bP;+DR^H_F;=8S[CK?\TP<8Ne2d,Q/6JT/RfaCXFE>
=6&Rg:WW/#9/?+Fc=4AYSL4P;OIa1f&6<cA-MgMNWLFQKZ)G4a=<F\65@Ie\3X+3
DH:NMOX=0(T93,<6=3Na&bbCS>6V9b(QZG_U?L?HJ0EF6=X^Ff0B\+fc[K33K-@^
GK9TDd6,Jf8U)/OQ2Eg8V>[-FXK?64d#C^@D:geg]JG,D&YULAe4aYTd#W]<8d1^
4-H9(G\8e&O26]J?3?NSb;c^Q28M;0CI>8UQ]EB0EL1>G&e9=(e]4\ZT\F9QZBTS
,aJ[@_+43YQS0c^,QY,?<4V3d_#a;>4J;V2-(88aK=e,E9HL[N.SCOS0N_caDQ,R
79@WQ_MaLR</#P^(HAA)<,=C^VXXcXFNU,d?IP?ZW.GA(AMZDR;R&dFEGKdF4]1X
.1fV](ANbH]6@2fc6,.2:\N&<I[U=Y7JQT.+#Qb>We@aMPV.)^CAK;.186QaLBNN
M>]<KEJZ7A&?8V,8WUOM5bf,D;XL(X16UHK66a:<JU#E#8SC-a+E0D#\335,,?5G
BLf@4,2&dT\HR_2Xb+aSW^gCII#R:M6eE8?@J@d=85A_/6@CgHc_ET/6^T)2g:U0
9>SdXT>>H/,R[9(_QB1HN6DfW.+\QU/<]Z21#d^Z:PD-G>ZBJ5JJf(\NOaRJ#:;1
^Q=Be-_a@ENQ,KTFSG-;QdSGQ/3KUCSHQQ-40CTYg^HcbWOE3BZJE<A[gK\KU@S4
X>LNJ,,YC<Df4#TN_b1T&MdTUa:-E+/99+QXN_0NWX##XE+3L4@QQ<#]d_^EP11.
\2Rd0@g1&F_4e5SR1ZH+U/<BdNYAYP),dfD+(7=(]eHM0J6+AEP/cCR,_^S.B1Za
CWI98P6])0N7UP)H.dWeUI-&[Z@NNIegg)C[\2EUSL<.dKgX53S8]MC+2aP2TF7<
a/7cag)2]2b(+G),HLc9L>aPMD6=@3S03,;>3H8-XX\D:Y3)\(\I>TgY]X+/V1.d
9X<-f-KE2aLW,+\1_G5.7BeMSS,WU\Y#bN7FASOD;().aB7-267bWGY,ZEX^aOc,
1L8cf(PAP.0W1Q=4eGPS;-Af3I3EcYHf^070KN+9X,N6O[@I>]cE5#fG:_A\f&1K
93^A7]A+02BQS]<NKEK?XDf&=4ZN(>#=T4C?U:<9WMN(&1\\\(<@0)[,3WZd7f+>
H\ZVO@)V__<0eZ4:OcSV,FBaW5_Ge1&\gD^WI#XYXB9<QP?/U^VC]ea9B24AX0ab
XW&CL:gH)BaXVVJ(/7L_P]Tg-gd.JC+P,Ne8AQ6O=RYC(7A;(X\<bS?fA:J#b7<K
(KTcT0;T93RQSIN,C0?9dad8ACa+6MQ^Y[9Y^f[9G,MSYHW@-[K:1N40[F(^dM4B
[T0ZId.#<D^b3<X_B./#S=B.cZL[7VK7N\.)ERQ==VEC]\&eI:?#X=&FY)QHa2+^
>,LD@4SYG?(]L^9cDU+KJ1IN(^T;bZ3ZXeW]9_3fN)ED5BNPXad5c,e(7#=@c3NZ
?;dH:#?20?FF.(O]T7\2;N(W@LL8U22Ye9LRN,3Y058(8M8G#e]0.bE?(3#F\M)M
=eD&#YVGETEI,Z-9+AJL-8E1+,=&b9RZN_dV8R?4MJ_:g4I4/A3[98(>RJ26c(3U
Q[L+I9++[&M;V772e4I(cWZY((Qd<4Mf=,S;&?)GRg9V<\6U9,,UCGGJ2/(^?J-+
LEe=E8#I?84N>Gg[::N5RVaXW;YDbV7B22ZYU45F2#4DFM-aOPc+F[\/8\ge;e12
CW,=YK&ZcJ]J:bWE](6(,EfK?W@SB_ed#Qa+UPD(C97a:(,Tb:U6;85Y.96CD@(0
Qc80L^[H[.,24(#@J+SSRf7WL_H>bb8P4PGdX_?1Q\A-/&:8+aPEc=ccN0K;1,6@
VFC5LOTG;J.b,>XPJ2?6,TJ/DZ44;:Jbf#gefXJPSWfLN)?=dO)QQD4K5E#2DHBW
Yc&+)ZVJ&\O9J]_^^G2W>,_J19=_ZMQDMfb\TXU,;=A,T<>MF4SHAN)GZ2H^>&#I
6Bf5[0^PE<,)eRcIbQU[f-B=#KV[^BCT6[^O89F5@H>L1R?,3TG<>Q+QAX0B+L7/
LN(94dOd[?^1MF134<?UTT4\HB.BM6II<:D.g8fIRPWI1#>MYU136^]HKZa-F^A,
YH-.M.P:M2FC\ZR#FC5\)(Z=g_(Q2)DOH4V)DQP#a__;\4&f9CJU@(6D(E^A0C(.
)F\?HV(a(?HfAK?eQTW7dB?@U8VNFBO1aW&OK3F8:]B-4_LgV.LaE&f=+AN=&Z\2
=-6egN@.#3Pc.PaC&O5[,#N@9KeCAeUC4WfIN:Y+Of_dJ;#9dKE+Z?WH=28+RO=c
,7^=#->W/MOW6C\IQIKJ:M>5^S@<C)HWOaLYT@:SG+&#dW&L<6IQ5S6ZGRY1f14g
[D;:5&N>7bU.,08@G=K9(Y[)IeK]Uf\]@eM&eH:[?(#C<?aHY1e<X#K,C^R4,KUL
N7CQ/:G._-cdS<E9Q+\)H^?VF[?\(N[;6#/J@N5-7e\;XIZ2a^;.[I8:BS2VBKgH
CeLN_H4Q)OYIOSW#@@HP/XTO>Y#LQ2c(0BO=8DQQcC,ST9(UX_XCL.:\fB[85>9(
[.g>gCZ-3ZJT+1We<5^>e3L6GAbDB[W2O@ce.)e]K2;eF[TI_D4LF9A7I):[Vc44
7F_/<#K]gJ1AWB_7#2a(;67Q#P]EZK:(TS17.3a-8gf&[K&<J3#-d0ZIL<CAXeI6
PD4T>-8>Qc\URBfY73\:eQ7RV&CBT/L>VL7:]-\Ee>8aH5&C84P[:33?)Z:)96Y\
e\Q-R0U&Eg9XO0R(O=dS>R=-cE#1Y+BF]D^6G;cM(QPXZ(&da_9FS-6X66A.@YD.
(KJU(PB@Y;G1#H9FbgfN;6@KdC)XPP(@(?;<&5_NDHdS\8_fa0FZ<cZZZW:-?#56
@Y4=D93UAI4bS76\3]F1_:AU?<YIaEQUWg^5HQ,;5Fe0&>I[CC?.67TKP#,=3[K,
Y-KB+?6HbHcI86JbR&:^XO-C?aQZ+KXaf..0MVc#b\H>R8-VGY>HeV-49XfN::#(
P4\W8S+L)>PTI-K86N:H?TbJT@WDO^XY?(1eQ(,?dfS5F;M@JSC9=]3S@3AMPb5Q
KN/bEMe]eS&]_-XXQD@d+52MeP>d>QO=g[18X#5Xf,MZ7OFS:@5MD64DH+&Q:aQ&
X,g8W/N0a3RcGK/(95dQD@)\DgTU)&8L2#Q(ff42bWA0(A@HRcA[+L?M;TVXSVD_
bR43RO=OJ9JS.8eb/+78[_3;X;#A(4Vc1BN).Q5X/gT+3C\O[:9d^]&7Ye5ccD(L
1_H=2QWED-QVPSX8BM+DR9VOZ:,EZg]O&aP,K/Oa@eCT@Y#I>6WIY<?Tbdg^YHLY
>fT?g;@R2K6VGGg8B.c77]cf2,<#SR/2?]TDZ#_A5.Y)L-<[RUOB9]Dg_3QVN/IZ
@0=\0&5cb#&#15S_)/2B_0cPb4SJ(F/=BBPeQLG8A)J]6R)dQ;d=KG)@C,AT^2](
2I+c8LJ-Ba.RT55NJa5]^?2(L-aNNB8<PA,(7=/+Y947gFdK@,O<YQV+1ONTDWS/
ge]fR+VdHA@IQ;T9(FF46abJg9\^E\4RZ5d&3ZQ2]EKabT)?_AH2N4A0[-ZX]:\P
^=UaA[IaA9]C^eOQ2bB0RR(<-?b<S3ZPaf93[1FLXAF3<J7Zb#gG2&G_=#WY/23U
\8@H#7Sb1]PD@Kd^;84aQ=aX=OO:.5#>Sb;;K<\]D1BEC1YEaEa9FVCcY6P;=eNA
:T?fRG/,_Eb3+[CK=8(,@BM7^35>b4RZ,SdZV_g^8G@OB:Xb5#=#UN.T0=3=XVDM
JIfEG@FH\JL\30##;fIV\G=FD+FCM6A8Bd&MA)R4G(]6YVdZD2((_2]MI6#a=VV/
7_f^722H=9RcFG:+M@@RQCa)O>Y@2+WNe2a#A6\77C,L\UNNeJF/TB4V3>:EMce_
Q;^,5B7RO(9)>0HU^Q.V^47]OKZ#Pg>Wg4La2Q]RBC,WZNEI&+FW/JAdGF,)Q6=R
HRXc3GAcJEMbP^C]XRI69,8H.IFE+YfF4EKgf)Y=\VbGG+-Y43@[AR;VG3_J8f]H
WS_OFP>W&W(1WXfT-P)MY5F)cXd@I2JIP>:U;J5(0BJ+/IVP1D_..3beUOBP38&?
N9f^da85_:-)MD7+[#7YRH4VaII0;(SfGac]H#WLT:N+G$
`endprotected


`endif // GUARD_SVT_TRANSACTION_ITER_SV
