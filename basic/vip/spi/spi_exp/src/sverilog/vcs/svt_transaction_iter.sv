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
=)W=>g[D,/^,UP>O=a]9;OS;0)Yf&Y<e5\f<MebG#e2U-(b/<F+L/(:1ND2e;TYP
5S[#P[(b9CDBW+9fbW4WR\09:66gH2XY(8+M3aLgCBUJR_XQ0A^9HJ&WT3^LLZcR
Fa<(dFPZFb-^LFY#A/L[7)]dMS=P5]:d7b&D;e[[(>Y/G6E[2C93d7\4);C/?eHM
AdPGE^ZUK\J#,S-)+[H6A-;I7KJTaS_;1DTD\X3BGE>6L(&<;>7[U=Ua(f.\X/GM
5<T]eKe>4b;MNIZIc6e&Bg9gGB?MF-\Q2cYUf=9^d-B8](Q=-H80fDJ./e,9<f8R
DF8S5]6-M7?2E:XPSY><)4(&/N)=/A(P\1YN<VZXde=<A(QAd2_5LG:]0F<F[dVJ
8YA9bYGMeC&23QQ0TT1FGVT.H@_MP4c4dJ;3+EbNQAUVLP[:g/<36<N_+&G51D(>
U_OEQD?1:cJKWS#O[>2VU;;H=W2edT2;U0d3db^YH4D9&ZQT9JRFOA@>1C@Z=G22
8W[)CE(HA4(8W3:QBRX1]I669K&]D40W9ADg-O<X7MAYD<41KG.dO:B_G@/TY)1E
[)#T]J-\EG>DB?XMcHZaf;7)ARR=IHF2RN:UEgZA]]<O\IFS,U->,7BV2M9P9E?W
VUU;>Y^:L6\2e\A?R6RcO]G;B4WJ^4B_KD.I,\,g>0WM]?/ebS,V\Y9eafAD9+E.
)W<96E3V?6<Y0V1X:1O660D&9KFFVgYHRc&&.TB\QD-N093]dJ@RW(47KFKPF_d?
LBBD9SXD].9ZIA,fVPRcWZK5\H#I^@F[O4d>VDVC<Z9e/;A7O<=7DQTaHXHO@ZNM
9^5GG6.JZERQ[04XI891VR_ZMJ)6g-#HR/2&Qb@_<=G[KBPIH9+;D3(NXVC)[7Gb
2T?/I=/HE0=W03:N0]f-_DfOLdJC9>4L)@Sdb\-cPde)O2gT\&bXDGdIVAcC<8;-
b#2dYR3O:N-]@8?e(+K[6J^B&87_fK03GdSE69ZO69:4B+P[>NL)>GBTO9NX=4K(
1GFA8LV>Kcb7=\(E-NcB[O(_EA4OG1GRQML,W,DGACR3LE<O@@I0fP2:(g[W;O2D
@.<79gfZ9e?FV7R]XTTAN1CY/?V>E_+IK9Y)5,C)[033A+>NR4?5H\Le09PcL-2#
40dOLLY&&>5a3CA=GSOZ1CU,Y2^/)6;I00PX9^&Z]#Aa&#@f27XcT&,;YdJ,Ae-T
FT5C@ZM,(bJLHO?JE8WN)aKbfQa-/3N-@Ye8gaGHN>V4[0Z(=_P5K(GVZ<4Sb)QD
G-I1FcN\E+OcIKGI70/#[8YOb:QYNDcg^;NKf\ZZI?:gB=V0VUR_->PcVgfaPX+T
1:ge/>D/+KAfT>KC2Y@&gV7RG]MY33JY17b/ccY&BD83KM;Q#N+2a//ZMN]B4_]E
W<]-(@OWD9JBFN\TVJ4+VP?>bY^36Z(f/MYU5IPGgVKH3+5V5NI5VX]>;JK5P,B)
XK(&<O-9S^b_=eME[,_EMK+\KHS-+?3B==_DE<D<K3:^62YDO^=J0YVJV1SDgU#J
>-L^5cd-D89_261Q2bg5DR0H&J0d2,7P<R>3VQ+V0O^L:DONIAY+>=bJaNaCfJD>
.aY>NHac>]a5PL8Pf2^NYZ\NK82RG9KXVGXV5bYPBbJ>06/-#?3Z^L+ALaRY<H_U
9I9MA(<L-b\+:\b0N(PWGV#.W1f8M(2)fOH6:eYa2PJFbH/eML?GVFb\=1HGa7BC
5cJbI:=Y@?[#?2[SU^d&bGBU@9/@R[XGE>=>g,3f+c<Mb&6-)&MRM@V>9Md@:]1K
(3VVA:7P5D(3=D0D5BLM4PS7DX5(fO)EOX<88:+a9^Qg,)6AR_J7R37C53fT0MHQ
@b@];9R.Z21e4+dJdM5T+/7T:RdE93GLS4[2C7X2LCg(NJa68>CfeJ)(>OOTL0#a
W_H_:17#dEPJHM=-XWD.IZX25-(8^).M\>Hf0fB?.:W^7VL<H^Cge/Q5+>O]CZ,A
FCC8>>&+TFH]U(WSD.\98[OSQUbB8;V\)L@V?YbI];TDAC,Z,Kg3b8]63\gEL/LY
]A=[:F[OWCb#KEWd6DDM+V)RVP2ECWR^bCTM\IAYA&2DE5V]>E>ZIDc<c2XSB.T[
7LIa\1-a1.,6@7aI;VCM95Y:Y][&<_/Vf9?M4@V,WK32K\eKQ\CH-YZ/0/()\\BV
9)S6g&BC##Fd_dc&QOZWD(.@Od9F@TBdA8J]O/b^[Ga6?;2I#;5IC0fW7cacb^DO
HJ\?fYB52U.V&,1K_gaL)1CZ6NX2T?1bVWaLdaU<[4b8MXY^TG-L_/Ng57aKH4F^
S/I#f93J25)2P?CV5.:H[&.MWTWI9TH0d,NK7S4\)R#7Q3fA96E<;7La4)S9[Tbc
H3V^X^HJ18QeTe2V5TSC&OK.&+A0A+&KQaaQF#I,S5XV2^N.V&B@Wg&WO;gBZ/1:
Pa&14XLeH9gg4a;Q]B3L8U0-G34Dg+JON28VJJ;WA)/I),RM0S]=;_g+-NV&IW#7
_B?4??D2ILV77A7]LcFOR1Pfb;-c<T+AFf)^g?d^&=aU4?H]=8U4Bc5=05]_EaD:
UW@PCf?0eIZ9VIJU2[9X<<WMC=4cQ([0HF7:,B?_f;BO1TUW->W?/NdG?9#OE&SG
+AWFKgZ@bAaUEX)]EEOQQ2EB=CQd]V/(,d^QaPLYHO/bQ>WBI^8eF8Z\LdGET@L@
VBOR:a,bB#E;&RJZC[U>SK9IX1Aa=XLfVbg5:-a/EC55VOf/GO#e8^_=V\Q<,):G
T]+DHJ8HI:G_+)[LQLgURKaEI_0bBg8EBEg^SHRg#g9H\,R7a4]f;3b(,@(Dd9OT
OU&=H8Q#+S<&UVN#;7ZD_F5]Icb3.@?6UH->bHaH_U0NLgcSS34B6VAc=+3)4D#A
5J7O=Q4)N5A8UX_G]g_cRWBLL>3TccCd,fU9C-^dS]T5dE7>-QMLf>b#gIE0#[Z\
:f<E^a86RJe=X-U1V-cLQ\K0=D3fD^TD1g(:B/HK[>O7@2Z>=)OG#SJaLRC6Pg4+
c:]ZY91.8HVFSH=M&7\-CHg@T.4Y2g\^M]ZW4c6@\7<dEYH.RK46<\e<&X_UZVQZ
^=V(ED1HTJ&UEb/9b[6bc4RR(AeCTA#G6>5^Z.fJRM@:b<_MTeD@\7Ee+XK1R]P8
\<[7g\.O0b>cR38\00O5IR;A)LSVg/5NbBP)(8aRc)V7CI<C]J[XXM9g&S;f#c?.
9g[9UA]f_X9##8ZUK>=K0\J2Y8-G5/6Kc573(>KLD+fgA1_5+H5010SF(__HSX8,
:\S3Y&L2KNBV.]0C&bM8ALE-d(2V]@Z&3\5_ABI&+KT\F4MC3CB-aR--G4g1C#K,
#6<X3A,=XEd)BC(5B61ZKA4XV(dR;S,L+_XP(Z,;&1X3SYZ3LV(;V)V,&E3<B=VS
-N32M,]:P6WL>V&M_7)<5KaVF-J+KT0E\\d8dUFb#42IQ=ZK[0.cA9O:JXgJ787I
B/+eB.&<WU4b/SZ:?Qec51H/=OLP/9TO5[R/Ie<KabJP-GY+\YEad>KW_fV.+6A9
;E+)AHE)L)d>HW#\\(4e&SQXT-Q8@A:,M@G@Zd)Z3_EbFLge:UIVL9Pa]3T(AI>g
:JZU,^C3ESDFO+.WV7SKUgTQ<Cdd;GUGD4JX^dWM1G,LUOQJUB=[L##_74FNH3,Q
A0_BS+]@8V#,9c#7dSW5e\.WV)Qde9\[C32R1a64cDAFg2&MO9@HQ=/P]40J@O##
,MVA53fC/,ZPQ<Ma4T>WG2c#Ra5+NWP,RKaTW7\V\a66Wg2Id&8NW^CJQ.\T>?_;
7[5OM2,\UCM0:7/E]Wc=PE?2?ON\JT_((1YdFd>VU8\P_<9F3TCSU):fTGS7E;,5
@JM>2/fTR]eR9RC=g+c2WY8SJG_[SKSFT^P(XHUZ1-@6aNO:(AK1fFb1Z7(O,=W\
^Q]-7+[K@2WBH>8CRAed,,b=A+[,T^dXU&^WKAgV2BBacFfG]EA?+bE8\H+GT89N
KJcATNY:U)\X8T,1J.\+UU5=[-/<25LC-)W#=[:K1NB:?:R&6U]T+>=Mg>KQ_/[T
&(>]E^?2=bG9f57;B_;@BQ0U,@7CQId1XLZ;7J)(?9I]2OXJ[/59cAd&V@PV=3QH
OXYgQB>;80(Q=5dJVWD/\.=_f5&2[5/Y[HPgW<(-2Z]@VI2]7RdQ9LLD[#]FJ:(/
5CVIUMUBEZ:2[e7dQ[T+c;4)4VF0F#39:NB]91+3Q#NT6Lec@FS5X)53(ZUXf&^a
=>589Te]36=^)K+D\<G<OQ<A#Z396<Q+F(V@TcNWS=b\D>Ie8A>OE0)a061;O@+C
;8#a9OY&;1\O+5K.KGLQT\K^/7U#bIGM@Z7A1MAbVP0,:/G3[c9;ZH192<G)VE&?
0+A#(F+L_W.aAW3[M^GN[\JB5-dCV-U>WY)9+?#d>K)KI<01.REPO>.\QfS8;B59
dg:5cLA8O\VEIYE-1Q1MHF_5b<+-.GVJ#,\0W4R<:>V;RP^ZH?<(<;T7a4:\@USP
ZUQF3,5NfZ;cQ@&;<XH]O;?Cc]aL)8DCC/VCQ@9cD#M24K3<0E[+<U8<Q\C6UXWW
>g3+:7#74<8,WGN1;O:AVQ2@NS8N4DXKeF;eK0WP(.OQa(-CD+Na4?GM)/g@b:]#
]gdV+U5CCX@2>^TWMJD-?YQc)61d:>6?;d.K<5[aRUEaDRgH&eM^eQd>&:\DZ&Z3
gUXOccPY&KEPd7gQ8F..C=3_WfJBL=TECEY+29f.EX#U)5OV\ML,[(2eGa>]SfQ_
<BO-F<GB?R]Y^^U/D#\T7&F>P\]Oce(J(0]<3Z-af83(H,S]CF)1,-b&Z<U?E-AY
>C.>;K1#M<eI\[?M.2^?<-eK\dSO)O(X=N,UNPC,3#8]1Cg6JQM3]2/;#.Yd5/MQ
\;gVJaNeFg7fVB^EQD<?0-&J@C[S97(d>(GLf<8a<d2d8794664<N+,/[0.^<GG3
L]-OT[Q]W\NccPY7aRP>);bLQO9=QTb>V\9/4<:BH/[J?/3c1\PYFT?<@^S1VQR[
E9<6I3KYD@B-#<5L&/E8(<11[fd?OPU,L2ASQ)GYJ_DVd].(G]P5:D2&3aB;?:fc
\],WSL8N&=OM1eR)L0@/JbfL_NOQ\H0]+53^0FfbEZ\1J_ZC1GJ=>EBH@\#U6JTU
QCU&:K.#[cWKKg:@f9F[7T&HM>09^9B&9]9d-HfZ-HYc/E_XDXdVS/22Vb7(@.)b
6()Xb)S9YE8HQ+dVQOge1HU4TG=QFH1C<9-LB\V?D/XGf-3cV_MM-.VZVRL=e5KB
7fOa=?BaZA\WAV&c@TJ]C?[/SYB@[aZ+WDA/#fe=WS<K=)g8M;E&D][I0(I:+2EW
RCfH6e2;)?N>Ob/0DP=8EF)E@M)V4R^REU@a_?B31<Pf5,3-R/]G#(@\?CHI[.6<
&Z_]9f\fc?:B7g-[1TG=P9L/fd#bI708JfI.^G52Mg4ND+>7/[(X7>J5;F39,eeV
BH=.M6CGW54+0Z^YRaI-&5;V,c9d&bbU&,V>X+c+d4c])Q1&H^dcS<X\#DLE?6eQ
GULTAA<NcVWMd;=GUP.M:fbLDS;a<@C-_J\PYe35&KVVX\I1bGD?T([[8+IbE0#Y
V/(RB1<Od>P^2GO&5872.H=GI3ga3a0OCO&D.^b&?dK:M[ZZeY<a.1.gT<N^Y)>g
f]\_K]#bW)48]P(>>HD;P5(SHcVf\[2IUDaW_\Cd>?WOW.S:6:58;3?[G6+^4,FH
7DFUJW)M9b;EC;>(L47_^HbP6&,0DYg#GFDBg/4W4&@)[CG</)WNF-_[K&fJ@1HN
4]D1&VH,3;D3HLa&/NXB2L>,N;/UH,[)]UWLK6VK6^)cUYLNg9?Hb1DYKVN=,9E^
_a9PHUCZMN1W.GAfEe3W,Q^9K0&9c#N]AS?Ra+NRWU_W;X,B.;U97bTgBK^H+6[&
_6/SU#+UEX7);4,Z6cZH@O8cA@XBLG).467H=fD#34S7dU4+:-N#PcM5@]Q=eI_G
L,A,>Rb)/#F)\efCc-@HFUc=WOA]0KZ2f[T0&;5GeSTd?UP\OX6=IYIb-W6L76?Q
6HNQeTM:8;#P[-UEB[Pb6;I.W_Z1=3,]3a.8@aDNZc<K=E)BX=5_Z4M#HX0d4Wc.
_#C@H>\3d\YAYU&)bXVINPc<JcNbDBY=ZKdI,18d)C2G?N[I-NFd:DafZ&:NM,R7
ESAO)2F#KXIG(3#Z;T>>MCf6480C/(UHgUWTdL&2f>#[3X42-P.b>bZY]#f0De-,
J09X1O?PLZdTAT13PFLBb2[>@[49,K6bN.bUOF_;\ZR/T/_#O0.:P<KI;#0C]T5>
#D+Y8IB^:Ng8@4,N6?e^1&Kc=:f3EI(H7:+eggCeX,]Z8N_2GNM[TPQ(A#d\(eNJ
IfO\b&TLMd^@:==<>aeJMSOIO_MZJYHV=-[g>SRAJB,0:<1O@@=87&?T9N9JRf)1
D/::d2FR8_W_+85dH7;cR6KDIdb<S.XB)@?M)@-B^fF=4+5I/I:g8Y5QG,^;84#W
XHQFC@:YMGV#&^GaOO3Q(\&(d?UE0EP3cWSc80ME(S<D/g,P4Z?J=bGYOdV/8deS
LYGJ5K[bIR@e5_&UeOd&C]dCfS9/AJ\/C(ZTP5MCD3N3d8gL1f^75IL7J^CK[>NV
P,OKXVS,0)I>bZS4H=LL(-5P.LPNF@FCW8[]],.R;?TFg(b],H,9HeC^DE]/:<F2
-N);eAZ-FX_43/(6WC2[@F63b[#CS/GW:5OSBLe:,,d7[WGHVaT4[f61=3FOJ:.L
Z.H59-RFYbJ+<NEd8J8)R\77&>75PJ(CS9:]6])9Af>C2M\Z.5W892ARDG-H&0IX
YJ1VU@JTfC,g_R#3Ma\dEJFdVOZ3.#bSE&FTDJP]facRXCSJH\0[dM:Cc8dG/ge8
RaK;XWO-TTNOOIe)EX3MYTYQ0MKLL[;>OWQ+K+N>X\1;LgY,J8g>F?C=3dSPAY+Q
=/B]O>26\9(.+#aSMGCHP66XQ1KYTgF#+P[E8@LMJ-<EM+cS0&DZAT&9&CP5UM3M
UT8cgcLJ_H_2NWN6&GSC23(\9U^b>0]Pa1<@IK;_Q8L]&OO@cT2D+GSaP\<Ad;ZG
K6fe(]9F+Q#I=I64G7R[#OWI,65L?,EL8<N+>G0^-?f5T-ZIY9[QFD[[:-/QSOSg
LI(_+[>UgQD&#M.<W0_L(@Lg3KST2A(=HdO9<Veb\+?bQ_WWCS,.YgX(3K:2Z:]K
;5K3;.-QedbV7((IX3Re(b=8^?B,]#ReY+O0T.eSJVL6O,K+a9)LcXF45(#;c;J0
8cIC406a=?Ke#1:L1</SH+3#1WFTC4f[5aR3aTB+[4;R06EBP82J3Q&41LgF2JfD
^08)?_H)eg>YGV#00[MQ=&RV6&EUQKKBg@^92:4Wf#@0K<?eLVXB4MX-8UbZ>WU\
#M]B9A30R5HQ,[8/5.;JIMB?\S&6#[M<00<<NQ\gOTE(EOHS;^6,,a&YM4]5(dC+
WNGZ30O2J??[Q4GUc6<3dd\^,XQ,#e&+U\?,4JSMLTI<C;BSdG=Y(H[NX)]Z.HZJ
aAUHLLP[,PI]P&ER?0OVIA1N^Lac>/fE9T6GL<B#MUCC+KBb0/?DSeUANAN69OgV
:WY;<8V?[AP4#<-Id.HMA51=UV]\?.RRABXG9S6P[89,XWWSVHG]_ZL46O??/ff3
#]PO)>OYbNR\5#I;b-@8QF)cND0=#O#90)dV4)_MQQ=^dRQIP0E8=6#+.+VVMdHF
^&0KZQ6FLb<(89X0cOOTN@5Gabb?_(J7].@JG2M,L#.#aKGQH,.L0,ICSg#Y7B#L
ST:eF+H^TX4;60WOX@2)WRc2Yf-0AS5S,7.U,ccQ)a]\C.b5V>bW,NN2TM3T3A,c
6,,J_d&ZC8\.G+TS-MBVa=JQ2DaR18^<d5ST3gg@J=P2Bf[JTdXCMA=#/JAOSK.<
fSG,#94&)/PNI=7=QJ.J7J9CPUa\8<NJD,AgR1?Sf0LfBXXRPNEK)_2+B0G1MB3a
3W:OAe(1RXc9_8BU:1bN3&=EH],gN;B@PL1O:PEKA.S.a0/8;d)LAYYRR3@#X0YE
ag2TV)WdV8HG:4g>c&(T]^gaE)QeW2WGA9MYUR7)_bY77LWfF+De/Gf>A/O]g>Ng
;Gfa4=1_],\#_0Wc9821=<WcfG#1bF@b6PeZ3g:HF\J6MC++^93ET.3;#U(aD^&Q
eL[L_>f98YZ6Mf1f70GVf@.Xe9JS[-3\(PPb3[b4AY_2KIM[N7A\:HHgaXVA4b2\
,0M/84QaX1#,.RD(Z:/N#IQ.\bOD45N5fA9d2GcNG#SWYO@0L.7JS4R&Q><8>_0\
MNL/XX[3-Z\ET:JKYE\=Z&[TQ/<&DU552YR41XGA4HFZT#(;D]1X0S)/&aPY&OL]
[:M(@+\0agf1(1Ka;aFDX4<6&YICR+E([4\F9ILg>69:#M0T#Wf/MUQ9<X,C,0F/
^>M(Q_PCTa;ZV7b8>=H7O_Zg)RN;-6Y/e3EOHbf<b(TW9)deT@d>:\X7OW=5):H]
E/4&-/=3=AC>.:6]f?2;39eVgDINR\6I=MIQ@#G&&XDXTYe+7\-;Ab#aUgb\C0:^
?c)1V36(7T_;HT(<@]O@OYK&9).SbdM.8beFMe0d<ba_BB\MO@X&C)?/e8(^fM[8
TKC[I9;K+IUK#RaGcK@1ODDN9dEZG[Ycf--9NV-A03?gA74,_/[1HMP4&=R\2&d/
R>#T3.D/^#&:8;E)/XIOY:R,70?>2DaT/-IM-#VK>#S8OC(a,0KRXIa6X096S)>-
SX?@Ia=0UEB6XG7/PC4XHFG@f\&4K67ME3[dF8Yf<b6Y@Q[Y(AE)=BZ7_dc?HW;M
F7a&ERc5>fDg&8<bNdANWAPf/\:L[g/GOB8[gRdZLLd-(.3[Kg(B>(QAUA_F<AC;
<XX&IUdS;QU(/cHR<=7D6OBUb-C>B[=8J<XMM(\#E[fZBJJ8X;>(gN4183+EH3BL
?8AV7:&HBc^>5#=;Ue2K[3Da4K(CZ+H[NM83gOcB74S5SDR/5fC?;0ae:&&F:AfF
7OYT.4)eI.]Y6&03_O4WLaF?FVZCK5OK&DD1/;ZKUdHF:KO0QDQVX:3DO<,PO3R@
3cM^PVB(<#aA@S0Q]8[d0aV;B8^K:SgOD-C9&0HNJ;\6A;gIK@[)R^CD?AgS:L]]
8:.>d7acA6X7HMJU5\[3G_5@#/a7J?_N+?\..H/5=2@MN,U=fO-gd41fBg]IX&N#
VUD7:gP(78+X\>:&-[+ZW-P8@JIF#W.B:PSP+RWR/[fB]:=HQH;BDD[cOaK[/d@K
H\[cOaR<^SG7RR+;b#dQe;.2&CEPZa?P7/?6c#KdG;62D7+bM69D6@+E<R]R=5JL
S],5b#2,&g94JT9NCB6PHR2R<^G(Y,:4I]:>b.9;L2SAC?R25f@<O<@&D;6ESO8A
X/@0I^bEF/8X6Q>)AMf(OUF<D8)b05&@>ecSTG:L^b7QR\J6LWBZ@5L1XQO)<OW6
,2O:2J)-,7W?X6B[@BJ=<5#<gJTg>b>5&MMd8#S&U)8CZ0.b<&@^BA#FZ-60(4TQ
\:Td+2:CE@J8:\:<Ba&ZcWI<X,0>?e4>NgWDgBNdQcf<@dRD?eOH\8TMSD)[P[>4
6#a&N)I?#C[/Od5A?F@0TLBN1XMRb;;72;KdVV8HRK@0+H&bT:5,2b,8L>a;P_(=
#EVS2I2;4K\G9KX3-3b_OSP[(K9_MMV9PY[+E2/JX0S(VcI(&C9N[F>Z]9N;7/)1
d1?1G[9K<?]20FFQKgJL7:)4c]4YIDR)F]R;[I73Q4KMS)7T0](TH;a^Z<<dE,J\
@O&^#b6K.?T^K]d_/8VM@YfLZ]_WB<H71(MWD^5BX#&Oc[^@=Y96c#,2O\Ua4A5W
5CV7J;:c3b?O@HK-b_R5.:f=)LF-&RQe)9JA],g#N)fE[QA6P,0(BIRaP1.J9\SA
?WU@O:S2C;/CabC.;<a]2G>>Jgg=?]&3&]<;7X2N72;8gRY3(TT@D(SM9]I?4.N&
?/gaI)1aGJ43M3V44VTgW]83aLBH)D8T)^@S=V<g4CCCg_7(P/gKFL:cb83PY.O\
):2:Iaf]RbKIRecH8^Ab?dH9M+29:L&,5K;fH(F,)dMP8K5:>6WI:9:[9:/bd5(W
1Q-WBX#19D&.GCTC([UJ]\.&eW47)&6US@_-:Y&;7S35/1dXV#@_3]:/Z/4TOY_/
BGQRcVc^_@&Sc1\WgVM8=2U,Z(?KIf,#XB]O@H&(?ABXd<Za?-U-[O0ELdd;PXGX
F_5OKX4609<A##7QZ0;=C_YfD76F\C,TM3C(&#WbX9Mdb+1-.d@DF3B],D29QOVF
23F9W7[eT&+^FbD,6b3a7BZ#.2]UJW]7:(=5D1X7A>J^XeSKcGONbV#@7?ZO1/N2
7RX478UDGV\WFGXNg9:5[J3X\I#VBIWJ0_8;4O6M4g82b]UO4/@;AeMXg:F2BHO9
be_(G]>cZH,2S/VfH1f1cQ=A9F,E&^T9[4-DWBOH[[<dafa]R>3<JIA3fIJ?Gfaa
TEdA?2.:#PQ&+a=Ia95?7e?3NcJY+:[1>>gI_OgWZ,XUXH3C0E>cG&TXBAeOdBbI
R@#g<CI((bCaa]SCMDD1F,)/(ab-I648M9\9RcBB;g:dWNCE&^+TPGW)S?E:36Xb
P7DYQ>d@C5J?QBgXEB03_a[/8.VgL3f6SFeZ]WGSg>5&B-_ScFZS^2(e]\cXNXA=
@?U4NaDR,X1@_6>N8T/50&61)Fd(,64J5RS>?\ZVGcG,H4?,15SFg-5\bQeKAdLT
[V]R0/:-VP\1OOH6SD3YX-?JE9EBUAR2LKD>MdB-2;5AIgR5=LX1=ACO(CbN:8dS
<#.a)O6XGV@_GG^V51/-DWRa@L8aF^2f#)F?2?]LDK8^P/G^X27361[#?J5+PH]g
>BaDNE,JU4@9BIHO@MM<#)E4\BF/8H04f/:Y]W5#WL8?aS/540eaW\g?AZT=TD-K
a-E:HL>@b?&S8/<EOS>1HIBUEKY9WO\.)Z-_E)-]/WC;RgY);OH/J0/D+_c3G?fL
0aO8DeU<Y=1J/91(QU#A)UHKgYRM,f(5K-D-3ALg)22ZeM4NF3QJQPSSdf1#X6)b
52//3.S\M/D.WY^>,^2Rgc;aZFbSJNG\38HHO0[A8dR2S8#BLEGG]I1.VPed#AT]
\AeU-FD(FH?aL#eW#OO?ca:QPUY:@ecaUM/;C)-Z?752LKVAH79@Q:/9g\::7LQ4
1XbC-;&6<[5BQY[@_@4VDQ5d&c]W#5?J2W++0cf=c0G\1[,JQGOWT?0Af@L?--(J
H#+Cd+=_+_Sd&(PP\AG6X4#H=5b68N(;Bc)2+V^1H21&a(I;gFfZ<B7fP=F-0\,c
GH5PY/&?d:)-VU2e^IO(cO@O#:DYfZGMAP-5=:6S>N1.HASA///bSeVM1.2]e/fW
g)-d]9=FRN;(BcACg<<9cYf[S=8KLGJ[T/A:ZA:>Vc:.=N#YMD14ccDfO_f@6HOG
.3JH1/1KQOR1]DKb,d^-G\-QKO=O</?I.O[;,2NXPW50=Y(VdHAAK0]BR&X+AH/b
@H5/(4?R@:@J2.8VDb_X@1OUY4(BGVEJ@aV.ZP/4Qc<#E;ZA>:OZ=>\=&BNQ4D2c
0/bX)YZYY6O,/8f:R(1N>YS3OUA5P:4G(REbW>0W\_XN)</)5a:^WZF_d1T=1g6K
g>c>V.\O@0^Lc,/-8-@N0caXI9+J/W>G)K-1W5Y<?PBJ-5EG2NVf92#c<<P7H6EC
0VR:5PHV6Y374aDYD/FNb);AD1V6CVW3-RNc,Z5M3.;]5YH,Id\bg_b)GG<eRSA2
X?9WW(Ac11eN5IU9ES^U>\<O(B.>5cR]cO/P9M)>_N=Z6RI]g)DP(P.@>JO=L/S0
(b<V&3A1RW2,4cP[dZEX#WTc9I<2>X-#PH3UFKSaf#QV=TZ#CZ]6Z7@VYDTZ]H]T
>E>K2,eQ6TWYHPe1QHbTD-\=>71efO,6LXX)Be_OY/;(<L&FLF(5;-A<0D5:Xg3I
C6Z<[?=:LRQa=a::(Yfd9a;D[c4,UU1/QVSd:B^9GXcBXYIPM28\^Z4AUaI7fa>N
;DI,IeG70O,@6(;7)=60\<2_]ObCI4)7-LF]WY0(W],#3?X>5)Z>:a7O7MIN]cXH
BNJ4V5]g9&7U<NB^fP3PP5FK[7(2D)3d6>gG.J-^e+CBL(V40S4EVTI=>E]:6>[c
?J;#&DX?E\Df#b(G\c-&DSU:YAXLQ2/fA8D1)cE3SS2I&6=8WMVb?a?A@2Gg,e_P
]02\d.2KGP(5A]/==Qb?J2CBc:^L>\?V-:YWI#VQNd;SXE4LDM]5)eWb#2;^4XgO
_9S[4&RdHV,OJSN2L3PL7N2X#R0e2GE+8.CP)_]LGR5U)J,RS,f5WJECGg\JS@Rd
&[/QbH.J8O6T1AH=W#f>AV(A@c8V=,CEMa5YG3CNX]#7[G;5cZH[N8T5==GMR75Y
GJJUNa#L+b_<F+RdZ-C:0_?b_dffVD[-)c[_@eb9aDIb1VN--g;&M0S=.?JH;KGD
Le+M]cQ@3J]YQQ)G9<C8YMG10O2(9[78T5)dBRB>:dC=64;P(<KMJO/V7/,\-FLC
EA#4M7ZZ)E8.2eT./F(U+fb&FIL(W[)ZPdI5\;@\DJ<KNf/2U^^N)ZgGEUC8V_51
Pd2Db(2@U./a5[-BA4G8>QM-[PT]Z_83U:52L_IZ0GGdT@6?S8HXdXK)d@0gLK5/
7T^CDaBDIeLVc0+]TJKfg>.S(9\<4KMR\B\59@EAUH>;G#/ZGFK)ALV6:\\V8G7a
/4f)c?<.4?:BYC@@fb]Yc=-WCZ?AfdJHX8(g4@DKJ[;RTUT+e4[0>[-M65F=&UFL
C6STHV,&W.#K+KI6Ue#O[Q+<:5X<1X)g9_<gE3FF&SPLbRfUU24NX_&EJA+-B2dA
WS;DVIFNAW7_346T(DZ:MbZRB-7Q@D+cWcSZQ?A<FIX[12J,EEM^@A>Y/>+7[N&D
C\de;[/]V7/a#(^O=ZHYeLYI>:3P<H,NMb.5:J?-,;UdSGdD6BZKAA..W7=UX[<V
)+9D??JG_X[Y_e=B9.0Z5A]N_M\XH)(>1G615?:]A3[T/#^(CILM8?5L[eJ9526c
I>RVT&+_e5?41Qg^L]c+X<Ne.adXYO+g2gc/,_A@HDC9gV/VBZ(.J#AVM2=8&(UD
33MSZ6HL37)EfQY[Mb_W@O(:F,g5agQ0FU]TJ,c47G5@#R0.VV_ZT33ZK/S5Ue[c
=OYRE;R2&#NROVbAfdB\7=);RRf0+1KDD>\F_BeI<AfSA2a[0?=@g?9#+U_#6<K<
([)+eZJBN@>eZS\]=Q#NdF1QT7QXG8Q2e+/>/B)LS0H-:A2Ff5P9Vc;HI&A[#.,^
D+##2OF@,?:F20L80]97Ug,bNGAVRFfWSW(.N?9_EWe7KL]faQ8IAP.5]TBRAe5O
G-S&DZ@XN-6:)c#PNOcR/VLdA1/De8J45+MIfV+UWIV5H>1XGK(BJL]5[HeND@)L
[MJ.U48(<\.5>>[=Q=aKX>IJVU029d8M?9b<5@aGW;L._(.-f1^S=T<H->&==&-d
N.8IdLY#?E@YOb.21(d>a+,@)[QXCa.@83/@;b3M)YETUeZ?1AQ88^E=fZ&L8d2I
JI_&4:;PAL.G&)DM,9MZHUQ5@.\_fXXd1aBRA._L>HZRcG=a,I0E>]R<RK1Rgc86
#,O5P?^8f[N.I102-O&8?S/M?a/.IbR^#K_B^e_YK=-#ZZ/c7eT;?FDZ)RCR7)/P
.f0AIBI]26S=3B[UcEIKHaSB7?NgRb0O&#gRe@V;TdFU)Ia@CV/J=KX4-aX@.Hf7
Wc_9V9@Ae\LbZ?LE/N.^&X6.5>E^)@?56Sc<]BPAD+B9ZZRR[9+[BY&/M.BES[;#
4bK>Y=:7eFKWf+8E#EJPAO^8WKD7g,-.O(@COH&TV?PdJ&6RD6.YB5X20PQ.C_9M
8&WEbA2I9IgZ&8Y^5V/DD+=8G?NG&PaF<<J7?]6[aX6,0bU(Q4@+e7U3c06&I,6H
;);>]OU36V>2+_Z8NI/K5349(\aV):ee07Q(SQ9-E9QX:B05=D:9\T6Z@4,e<<D6
Q&>)F^4,J,.NeE1cUPH;;#RMII/g&8[17AEV#PN6E,[M:cUI7/fN=DP2=JD][1YL
S]F2;2Q2RHg:2J\Y2FBfA3D&Jb9aW#0TT;_b=.Q#6A_b,H((C@>8XHB[)5,;=>R>
LFG&7B9GBR_U#1S\O]cFF5F7dC&,K,d4/?PGGKK,L^&MP>KS)c&I6<Z3W^^,S-8+
Y<7YZdIC1<g[Y-^4B>[4_?YLdTDO#:D4S_:^@@9C@6BU/AcQCMIZ@^aR_P7ZCdY<
7YJXF:HO8#JAa98]]+)R4;0VV-@f^3g\2VeEI#+ZDSQUG$
`endprotected


`endif // GUARD_SVT_TRANSACTION_ITER_SV
