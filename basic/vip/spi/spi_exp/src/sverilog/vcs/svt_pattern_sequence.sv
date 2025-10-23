//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_SEQUENCE_SV
`define GUARD_SVT_PATTERN_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object that stores a pattern sequence as an array of patterns. This object also provides
 * basic methods for using these array patterns to find pattern sequences in `SVT_DATA_TYPE lists.
 *
 * The match_sequence() and wait_for_match() methods supported by svt_pattern_sequence
 * can be used to match the pattern against any set of `SVT_DATA_TYPE instances, simply by providing an iterator
 * which can scan the set of `SVT_DATA_TYPE instances.
 */
class svt_pattern_sequence;

  // ****************************************************************************
  // Private Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log shared_log = new ( "svt_pattern_sequence", "class" );
`else
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) shared_reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_pattern_sequence.class");
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Log||Reporter instance may be passed in via constructor. 
   */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_log log;
`else
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Patterns which make up the pattern sequence. Each pattern consists of multiple
   * name/value pairs.
   */
  svt_pattern pttrn[];

  /** Identifier associated with this pattern sequence */
  int pttrn_seq_id = -1;

  /** Name associated with this pattern sequence */
  string pttrn_name = "";

  /**
   * Indicates if the svt_pattern_sequence is a subsequence and that the
   * match_sequence() and wait_for_match() calls should therefore limit their actions
   * based on being a subsequence. This includs skipping the detail_match. External
   * clients should set this to 0 to insure normal match_sequence execution.
   */
  bit is_subsequence = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_sequence class.
   *
   * @param pttrn_seq_id Identifier associated with this pattern sequence.
   *
   * @param pttrn_cnt Number of patterns that will be placed in the pattern sequence.
   *
   * @param pttrn_name Name associated with this pattern sequence.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", vmm_log log = null);
`else
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Displays the contents of the object to a string. Each line of the
   * generated output is preceded by <i>prefix</i>.
   *
   * @param prefix String which specifies a prefix to put at the beginning of
   * each line of output.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of same type.
   *
   * @return Returns a newly allocated svt_pattern_sequence instance.
   */
  extern virtual function svt_pattern_sequence allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern_sequence object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern_sequence copy(svt_pattern_sequence to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Resizes the pattern array as indicated, loading up the pattern array with
   * svt_pattern instances.
   *
   * @param new_size Number of patterns to include in the array.
   */
  extern virtual function void safe_resize(int new_size);

  // ---------------------------------------------------------------------------
  /**
   * Copies the sequence of patterns into the provided svt_pattern_sequence.
   *
   * @param to svt_pattern_sequence that the pttrn is copied to.
   *
   * @param first_ix The index at which the copy is to start. Defaults to 0
   * indicating that the copy should start with the first pttrn array element.
   *
   * @param limit_ix The first index AFTER the last element to be copied. Defaults
   * to -1 indicating that the copy should go from first_ix to the end of the
   * current pttrn array.
   */
  extern virtual function void copy_patterns(svt_pattern_sequence to, int first_ix = 0, int limit_ix = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the indicated pattern.
   *
   * @param pttrn_ix Pattern which is to get the new name/value pair.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern virtual function void add_prop(int pttrn_ix, string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is complete
   * and that it can be fully accessed via the iterator `SVT_DATA_ITER_TYPE::next() method.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next match_sequence() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual function void match_sequence(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is still being 
   * generated and that it must rely on the `SVT_DATA_ITER_TYPE::wait_for_next() method
   * to recognize when additional data is available to continue the match.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next wait_for_match() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual task wait_for_match(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method called at the end of the match_sequence() and wait_for_match() pattern match
   * to do additional checks of the original data_match. Can be used by an extended class
   * to impose additional requirements above and beyond the basic pattern match requirements. 
   *
   * @param data_match Queue which includes the data objects that made up the pattern match.
   */
  extern virtual function bit detail_match(`SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for creating a pattern sub-sequence.
   *
   * @param first_pttrn_ix Position where the sub-sequence is to start.
   */
  extern virtual protected function svt_pattern_sequence setup_pattern_sub_sequence(int first_pttrn_ix);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to check for a full sequence match.
   *
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void check_full_match(`SVT_DATA_TYPE data_match[$], int pttrn_ix, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to evaluate whether the previous match against a sub-sequence was successful.
   *
   * @param data_match The current matching data.
   * @param curr_data The current data we are reviewing for a match.
   * @param data_sub_match The data matched within the sub-sequence.
   * @param pttrn_ix The position of the current match.
   */
  extern virtual protected function void process_sub_match(ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, input `SVT_DATA_TYPE curr_data, input `SVT_DATA_TYPE data_sub_match[$]); 

  // ---------------------------------------------------------------------------
  /**
   * Utility method to set things up for a match restart.
   *
   * @param data_iter Iterator that is being used to do the overall scan in search of the pattern sequence.
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param pttrn_match_cnt The patterns within the pattern sequence that have been matched thus far.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void setup_match_restart(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, ref int pttrn_match_cnt, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to get a unique identifier string for the pattern sequence.
   */
  extern virtual protected function string get_pttrn_seq_uniq_id();

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
::TdYLIUE1ORLB^/WF03DAQ5c^:P/QaTETfRP4J5DW\3(cNSIJNC+(5H&0SPB;+:
Q7W[&(Y1)I[)(/Md5g]1@?[4,^1e)0L6<d)]8b]WEA=3gAVFKMF]_.eVc+>9cRCV
6)eYMaBF\:UI7#Ga:;@Q[@-93.UMENLD/^6fgZ.7\((fgK[HH/aY18T@cO[19D/_
f0C/97@eV)W(bO8JM@WH]L47)?A11NO\bJ#QD:/TFU&C#^CAEI#@#c>_VYDY?@La
UfB2eUb(E^ZHQB0IdZfQ3)]b33f(,U\1Z)L&&/H8(HJ1LdL5MV#XM6]MG5ODS)<e
=-JgZS;)FDL&#@D=H5DbC7(]ddH@-A?GQT7E]7U=8BL^[;7C/2.[C[A@VL(0b@Cc
8<XgS;(HFI:/DU@2f:M0G&.e6+0;F1WgJ:E;)Af4FS9aFH+ZGR<f1TT3dQPZ>MTa
Vdf;PJU\><J7M_\1bY(X-5-b@/g?aKH;:b=2@S+F;5)@F@32c.,OQMM<4CX+?9SF
^:gM/N-8e\;W/aODS=.M:TPNE5>;/4KF)XgF/IBJ,PV9dE/2RV+LHc>d8#Y(\AU+
.>Mf80W+ZZ^6eM#QUFIBER-GcV=</Q>E[0C0SZ,5?\Tc(c:9#9,6U4,L-F3_WI(>
EUI1X+S+La?QP1Z7?9MA@J@ReF-M<f9@c=3#;VG4/6+=#F0&6@<&>X7K>^MH-^C<
L-GHL;(bTcZ,6,aTRUF52FA]5&bL@+5+GOPGG0;IMfL.6G(8Q<_(-3@RcFVM=COJ
a-Z;;P141c)B;)RW5#S+Z?F2F)26^dND,ZF_=LB8RHX8OSGY8c9.IeSC,6M44R_9
9HMZ>6\)PDX(e6aJA7S_GLRB+QT8U))A-A7::c82N:^N-]L48SPf_3e]A,8M_fK,
Wc_CQQ/bW40)QC@KCg]UB60.?IU/)P@4QRT7H<11]P9&W1,Hg_&V5,dSMXg\Y&0U
f2O6K[,OY0)>ODEE-M.bOD87@fGFaKc+AEcbcSb4cB,&K4K7C5X+WZN9^AR:<@1-
.PXU?:gNe#-)CWR)>S4_Y14FD-6I=NU(,#?<O@c9e7,+KP4d8O]@dY&PJ\PR]OON
V^Igd&.TO8<QX0O;+7:],#WBHP3d&#C,AEHdA5C_P)U8?^[I+NZ)CO/N]ZI3&_8T
QXE]AI@+KQdT:P[;7/F_Xc2O+fZ6NgF^,,\#--VOTeG;RA>4CeRP3L>CH5\,/@dY
LNFJKEWB,;F+aB.KE:ALXX2&7b-Q^Q,5KE[T_GK,NfE(Z?@YNb))PTX2d8Rf#M>0
2QYAIO90#LE-ABRNT>g_AMP:Q7>1NeFD\^^XQN#>E]88?BGIT5_?43FIO]W[\0<D
GGeVLTF3@)(#EZ)ef:I7H7@L@2+G7fU:FC&C;C],I_4d,E\b4C@YFC&g-e\H_<+^
^6]SeBXSBU^cXW9X=BI\;=0=Bd.M;C7GM^.+GI7f51;e;KPc\a34G\&e+VVdGC,6
?F9Y9H/Kg5^2&S.B>KbL=5558GA[HB6KWd&5dA-E4/9bMgH\H4M&G]eZ5P1ZBC8T
4Q4g9Q35(S@HYY9AG@>.^1W[I[])e04_>/7Q&^?W5S\bGK<C6=f.Of\59&1V,;S2
WIZeH]M=V:^KSdIg6^]^Y(R#&H)B9O)OQ>>IfK#F/EUJ_+bC>=\]^d43K&=CZ86T
NVV.=]27.CgfE7A\&6DHdW-7d?9Q<@28TJ:g<E4dKN\]N4;YS9&\eGA^X1Kg2Q80
>7^HDN^I>PRS/eZ7AP5FVfA0#e09/Ne+YQ6PIH>:g=)BY9HT=IK(BGSF8P.=_IOY
/>HQ@\E8[NU-7[(NM\TF):>@:bA]bFPRUXN4JLLeO6H_e>7P-bK6)W)2)S#bQ+L0
>R-#<.EJ..d/L2)g3NMT=bYTBAKBKKZ/[.3YOM8^#-=9ZSE2LZL;XaK3N_@YB>VJ
1HE+NNAHPX;4bLOW3ZOQ#3;XK>O<>5.ffM_)b,42EWaU[g+X9f:E2)O4;5]J+W<O
&1.G+2AK[CTc,_S-/cN4:+=a#[?RQ(+[G^c/]=eQcNCNE#Hd-,(#AK/6#7dT\-^-
;D=b^Pd9FR:0SQNU/-DVR@M9-BAIR7Oaa1/;)WQ:#Z?55495Z0NKPY&AE8L.]g@f
7(P(OY+T;=MYV_=O(D=K75N7JF+H7d8R._7be#M9c.5.b^BU_H2=&Qa5]QC3\eV+
cJaENN[J,/][H4>4CUCY5_104bJ&-.R];,Ya_75[dg2bUCcW@M\_#P5>f>+X<8f7
FT8>:FgdG?OA;C@94[/EI#=_N0<7_f9^KRI^ZGOPdgM6dD)9@cJ/[-bD99;>LV6P
<J]0N=W3Q]DNfMHU:6)ZO)a2;>7=UYW>>?X](MFK7Z74=0c+.F,QPY-J)79+];,&
?#9RaZC@SJf-eg,KC=OLAZe_^b/UAE?XP0\,Je\RP>M@-B&\Vc4f>A]1fK(2JNK-
VN:]=M9UgT&6K]=D8B^)]AVHA9/cP+-\65(7?@:1]+B8AZL\@<e/OLU?TRTC,?+T
LB<:_IZ7?M<YQ]/IU)]3)N[WT#+WHWOcfS6D2Q\FUG[_PgNO68Xc_b3IG35[FXK7
E)5QTFUIQKc-W](NW)X1&\I6E=)12-ga7VaPPb1g58I\@/HFJd^>&;<2W@,1\<[a
Ta(7:&e(45eb>J>?82K.=c:HC6&7ee18J^819V1BRROOWBN/6>dF7A,5;57&)Yf6
/S@8-6.9MLf2^Q>FKKfS^=_e;B].?.=#PX86.c)\ZX>#IU\MMGO8&dLN:\+-L#G[
gVYUAgT7]a2),96>JCdJA)ZAX=9/UN&_V8USQc/@7>RB=G&.74&E;3C;Y1RH^&aN
)RCXK@L?fDC]879HJ?e<[Y4R2:=TXCL4NCRD1F-ffI5_(LTAY_b6?1:TdH9F=JO:
<U[F)>S6UXY/JGfD@8OPcBYK.ZHWC;_/I<HV-#b@087_V\[(UX#d:Z4?M+H>BR/C
:,R^a(@IOPZEA8_g-Z122/\_?YZIJDCdE1VV.R]Db50YXV6D/LgBGA0F7R&5Y3^E
5d.ERYg(X@@/fOYY)6UY6,@J[D=)Oee?9D\c)W&A^,H(5I>_;M.G+.?7R^68ID@>
2.Ud/c6GGN[?FKANgMN>U&WNS4].3eUXD]bdbKec6HMV])g2XDg]R([8f^RP<GXA
T&H8Ia8ASVU,-M&Y0T>^6Sd;#:98?Y#3MP0XaW7&4YM:X^cC>:Ta.GW<<e8#NE1N
3VTEgGY+KdVb>+X,D5@[0J8H?Y4TYEWX=a26dg&)ade2Y_^BU[:2/<N\?VC&9Y(B
&KG/)0R7YW7_TE@WW^M=9@KO71BZ-]B24WE^[&_S\>DZ@A&eS&_#XTS^0fOGeT(8
R<4--Rf.1=F+<KHE,FWMO,=aY/VAaFBbQgfSG&,aETE.1SBKCbF(R)#)IQ34AB>&
W=FI(4=MV0J=EW]0)(3BL=>d?D2<KAa](WHDMU6^WFb47XbK;O:SO>(>9O]ZcLWc
],V.]ULF199C-C885HMCLd3>cW+TVaJ_gO[0T\O+=QPd5T]0c2-KY3F-&TSEHL.P
&TZJg7+dOU>UbRDR#FX>fa(AA:VH&)cR-;>F\]Y:=&e.JJ2NN?I\/20]GJS&@T?P
X-1KEP()_CZB:15YZ\/@RERP(-Z/YL=FDT]_DR9E<:3CE78FYeK-W_9#b6-?c9(I
,HDcP/Nd.RQ=8d\M/NP]@bgYE>\7/YLUA3A#1/W)(BU)JV;->,P28Q>^)3?db?1?
&[RPcNK;X7L8S:W&cdC[>0Q8-9ZDE(T7A@\@=(/1?Y61D-eH4/[IRDe.7YeODU2[
/fW6RS9KgH.CE.T,Q=7D?C_gZ.RM2T\?^3L^:;A[E8V68+/aSZ2(B7YV<(T:fa^8
F8Jgb&N+80?+W(C5=F&T23,U;]Ua:TG[^RQGV1VA?MNR[\,]U54bR#CgN.<;)ab0
/?A>7C2X:IZ(I18/f.I&WDBG-FEK:X7M&5=eK-[XG&5[-b]6T:Z8CNIJfDA&R]3f
367C@,U6#0YADI&#0X195a@0)&F/SVL@M79E<I?8HDJ:O\O@=T^Z^d31<HB]4@(9
U0E2=A6fdZ(DD8b1g;&1M0&3ZV061?9K9J:bMd1.>L[4f3-\d,TW:U^KF=IfHA^H
QS^4HB+fb/C3BNEAY.e55LXbcU-ge-2?KI8RW,JAG=\=/&7-VH<V8Tc2^#UMO^F<
.ZH&7aE/_UNPV:]WY;X]-ObU^XgOd:H-RKbVP.(@WE(I^SLCZK5RZb_/)+P>&P+O
LTD7]:K4Nge:W<JL/K87VNG:Q+1UBN]HZfVJ&L>TLc3GNP,JV1M+((?FLTH+JX8,
g2#CDIOT\PK6,>C[:M:eD+^#@acJQ^]+8f>a+;HXF@fB#SEWVgYcA=Ae5g4;>Rbd
,V3Y2QV[QQP#-2NfT(b&a@SINgJ=aT)f]BN9:EQ1:@CcQIFJ&B@QL0M5XbX&\G_6
:QY53J?]W\B3d=9R8>0:B_OaV+L6\c<(]4+E48N[L\Rf7^-LdW4BMD3\U(aI.-88
dM?^BVdIb89N)&(eF2^,<HAE_.cQb=._MZ&(#_U@@)86C_-Z)\7]X-U>.<]EXgT?
VcFBF)Pc9E#fI1S9e@?NRe3RR=fU]P2W(Ld:NBJ)1d:ALKe9-g]=L@43,@NX,H9D
9[cJ>S&FMQ)+IJL8bJ]4//LDB1:U:I2VJOFF<,3[a?f\AZ8I-LGLMb8QWJK#;CAe
CF)3ACR\\7NCV+&W@EQ?Fa:XW1RFW)<,JeR\R,=-C/-#cC&c7&TW8F:7?]WKXg\T
0EFeQIGIU9fFN^D]WK85,13XNR9]JR5.1N\[5-dXVW73_N&<?f4<0>=fRIJ+C(P<
6d&@Vb2U2aB+.5B>.3g(Y5=FfZ(GVQ]RL6&^<D,@IIe?=NY<BUDC&e1,-6,51bK8
U89K#c_RUS_(3Q:b\3Y:;?M(Ma&ZCGdgga.AfZ&]g3=;+R[KVZdN<(CEK1SCDZZ^
^T1R(c1]/W]a.a&T\OM\N0LY=OeGcc<=+VP8TSJPJQF771a4JdTab\3YLgf?RdKU
H7(bHf1L+J.[/OH&-C1Zg#([8)HTNLfFB_K+4eHZE84g9Z?BRbH&U>B2<eRf<6[;
c1L]T2>F)@)W=[BW7I,ZN7T&D5>::23)WDe7TDK46/)FS\EdZ_S81FcN+_GdAW#.
O2fA3E_>1G+>)I+J[2a-,FI-(^G3/-2IB7^C8+4.7?S38Og24EJ:(=[1&J-ILA3L
X^Y1,WNYLHI,#;Fgd_)GQa3)65;08T>+=1HJ.FD<FARGdTfI,KA-3U7_97CKPKSX
FT8S(TL+OUT+LUBR8fXLY7=8@7NKNU2C-d]\+LbQY#<4>9UR_JKJ.[ZRP:^F@K7\
I[B^YS-[J=5<g5H//KDL8XP<;HZM@aJ0Hc&d^-;c\:d3\4.K/I2Y;+GSZ1JZdQ,(
;H)<MYJUWC?U^(OKA@eQ0L6Cf07+F7;H@Rf:OJC7&7WaCJ>B8JK=-D3g\dC,.<;E
ETWN<GcW)/b-QS@G:#aB]8R_PbLO>b1:>6d=Xg#cCd6;b&E.-\N^8b1KU]BGbA^)
[b-U=[11SV=6YQLG#<TT0Gb@OA<bW.gB@a1DRLP,\O26QUSM(^;&0R=ae.[=L8ED
F2][E,4<:/N<:?b_ORSfYJOADc(W>b7M\ORF,=^62)-BE#L/E)9=f0SJH>R/RK@O
JC):WO^NE81,BP@WId9gR#_@f&KH+_?E;2?b.B1bI98/9>XKSV\=GB@/5\(Q=AIO
34?)D-RKUWO2O41.(]\RS/PJ=VO7W6@RIEac,AJf;1?)TGNAf2QPFQ+@\NVEKVD6
dZVIMbMGc2JfYQ73AX?-)PJI0HB#_8Yb]ANGR@N2_Z>LBUfVI@.#\3+WVf4?0N<R
JTJb[92UX44079@8d1;fa[X+A\cZ[5I5)CB=SIOFX=V^IR@,/#&U..ZQGb0=TZCY
T(&3cC0CJ>A[D>M(DfKV@285Ua2cf2B+15H]K,E(gVWHM^JYG+=^K[>4?bRM)C-Z
H4J<Q.HEI.[4^,<.LWXEgE(a,31T@4bRHQ+E4T-(=AMeL+fCL<V:f/.[^9]YbaA6
@[:gb#\J(B\]1&gEBPbK&<27d+a+fCH3D=AUUBG34];eVH[Q2#1bDZB^Xg.?:LVK
6;64T69=(6JfX#d26[;bUS<#2+,\K7P>[203g3\N2R9&DcGKD>2-a:5X.:Y?(Z1[
S8=?2dFd^U?dBX5^EW[ePBR:b.7JM7cS4JKCY1g@c090VPP/f,&L0&FMLcQU4QF;
.@#++TT/I-X2?N8f-XfdF6D1g@)T&2;V])[KaG(1#KOJg@E8H&>S(@-?KO:1[fSI
/].X]Xb,^]P:<4R/6D=2HQPWL7aQ:?&#4ER9];3YK:[7c9cQ6gP4<B\GS.@1gI1D
[eI90.fTI-Id-;0;Ra84297K3^L7bIG+g,ZW1=;gN8()7I1#+Yc=B4B,g<<12UA[
Me9<(/8g?ESWCJOG25MAdC2;FcZNJNQ<HAMOaY^eTMHF/7e-+>E2G^a?HcEd?cHY
YX7P0-c6Mf]W2BZI?ANDMg+VK8>8-AX;-.F=)N?+H:31KL5>S4d&P8A=^,>dO#2X
QcNbIJT3U8OTY48a:-NWV81BNeOb,>[b]./gB30OCXZ-ZV4=WSHaU<P\J@@?)L_2
BG/R3Y(R9]A@B>HQN9c>aJ0L(N)6+66Z(=NM_ANUTHAP85Ef]TI6\f43d5SHV7VA
2G=MU\(ESWWKT?Q0.,[LVe.DCAR/YdcAW&MZc[R,7&I.?ZXb8OaIT9XJ?L3;>7O5
1dJE/U+GRfCG\<9;@&#_J/[=YO=(8],/g0KgJX;HK5eNQ5D(I@7[=-b>[IA^7Z7d
BN;eUZJM6>g_CRVf_NJeTdg>@5EUMC8Ra:fOP3N2C:)D0NM/^8VY+N)P-&).&Q,1
gLANA4SJb)NN4MX0-H35XSFB4F#@0aFJ1_DKa>RU_U;1gYK2(2cfB/,YgdJT),-.
HG\g4Z-)+.dTAaB#59&U@VK.L.Og_K;PLY1Oa<SM7[)D:)gb=5]I,CBA0+A>A.CQ
f)MJ);aTfI;<S?HRM.a+\g_FTD)X:R#acX\bF46NfC3+C.eWE\bcYW;:9.+5O43d
SeH0_V>4W/4YE=;=1-B.ZB3\;FZ+1LK:[(B@Y\6Mb_608TATNHfNSZGb&A8f<4]?
E9DLY#3#];)(P0J[gI@X\82a4C16)D<+ZUN5a5c?8Gc\9)G3-Z<CW7eUCgCN(]DF
Q5L5RYZTVC);S[/9/BGBMR-Z[IL3g1JJWaDfB^:D81TU3_QD2dLGe?YKWe&cMA^3
#I0#R<Z:gIJ;U9AffFe&6QEO64OI6-+d,5QbG>gUbPS^RLe9:2&81WHf<,LE2LU[
=L(M_6CQ29K[T@AfcEX6WOfBcG+#?3T]N&>D@abH1C5M.V=A<(4_2#JJ_g;YV_9V
:J.:M+AZBA9<N-:J-A_YR6-RKNf_>1d)dYdE,:2NQ^W+=[A)>_YZ^M@:(J)22H7U
Fe<cT2@>_9=KFeU,-,S\WUIP#AX;a+&AGRBKdU-AZTZcU5[BPCEYOHHGV<#2:e&Y
P6JEW\]N#5CRU+LL_2,3g^MJXSYEc-GTTQ4.\TIcCU1KUY8cS6f]J?1,RKGTXb;B
]0INIE.RX2GE+g7=G8#XBG\WQ9A,S99NJ86#ZUbZV:/&3?N.U75IRLc#EHV]MI.U
XIa389?78T)F;5>O3fg6JLM2EY9J>_9B_(^9+@33A?A]EHW=]=WBO[G\/4O9<](H
8P.4gO5U^0-J?BU@D3\=L[2@DTU^9S0=R_0NNb>9dXT8H&)Z8>YDf+g^<SI:>O2]
0K+KO@_^?5P)XbG-SX+T,Y<@_.H+)C#0eBG;d_Z3XgLNO=L6T<CK<faICEMdPf\2
da:;>10,8R:KN6TbSY7Z[88R3WZV3cRa.[9EYe@I_a;Ac?#?>6/H&cLX/f28Fba2
/M.E&M2E)\[+G]4b)\,E7@We:^_CI.:OOIJ6cE2=f3\?gIJ<gR)TX42F2^@RX=X5
D^PHe9X?TbMc]d])5b<R8.S)4,@@^._>+=@>ce:gV8_-5[?geC5K2DC+>bC3/]C:
T.)c--C1(fH,9NdG)c&b\HeSe?_)f@;^+C_Q/JD57HUAaB1&d:6(Y=CYN-03NCRJ
2DCT89aBMH?,47d3O#=_8\U79)V57,YHW@UCU<7_?a61QU=+.@<]\SPKEO4-(Pf/
LIbc1)EC171e]O5?T&?AJ?01H;-[<PC[FaOZ2gW/cI-&)23E)_e6#cOe@GRL5HYT
YT4d_TbF;K0=H&.U_O@0X/:U8JO=VA\JA#b26+LFR.9B9P_fB@=/,Y;.=B[<H(D8
6>dgSF@G\FH+Ca4EH=#1+U]C0./D8I\2J#a^PE71PPZSPSXVG@WW)@V7ZIg^eZB?
NQ&O5)>JI8T4dc]cNIc>:<@60VF=&KXfY^NJf1F;F.)d\6/-F@.LLF8-G?(-N[BI
c,OBMWR6Hc81a&-dOXBEM@afSZW2\6HgKa?E5+4,IcaBe(_g\WJ7DbC@^V:AZ2PZ
V\<N/GNOH37_J8:^(;2P8J@.J)[3O91\S?WTA:LG,&PTAOW98X8&gH40JZ9&.4LW
NWa8g@A[22^fHDb:eMZa6L_GNR@]8]9_A)B-]-))T=TI?G=GZ7e.;=T3.<\HTN=&
C]6+PeaLLP/C^[:MZ/RT=V?HSNA(6M2P&1A<#ZUe_D3ZN0K3U(KX5IQ1,C<</1(-
-a;.1^I9S3^R?[C:f-^Fd[0^S6K/TX+J/C]+dg5La1:/60I2]S>,aC[,Td=&#HNP
Y;U5RR<WZQ1]NbK6NO<.1/<-AS\H/?K-@P#(C4/HL;8JM^5OeSB_,f8HQ@)JRJFA
#Z\.+9M8GH0O050\bK;-1050&C3E9EP?7HgP)dVK8Ac&)G9Z3@KeUF/gbQ,QH=SV
aM=\9K/g&<?^V5Ac(E&MV]=QbBMNC+UM^?LRNVUW?SIQSf[P/1+4dY>GMC05ZEaH
?^NH5I[X-Tg/2/KN2Q)_-,TSa5T&WL2PWcHS]c^<U1^XR]f;S#9J7^e<[15J0d><
KLf.Z+G0-Q&08AQ]D,MD+Xb##=[Ge,+\BXV/3T<485>T,1P\JLRc2]N97aMTU7V6
ecA;8B+[51[eF9<9P<7KCSgKV?g80=J.T-f..6#\TP;HWWP6d[(M_K-cBO=?L:.g
S-6BS&=+OED]:C8#e62MD8eCG)+@/HV0aY-5\80)@#345Se<)E):=(FdLZ83@c#2
N.M[Y2-MB:+>fe9Ud?]&&9Xa=)2GR=8(B+:IR(Y9\PB/?A;Jf=[c&Fc;BP\=TT#a
BC=ZWY+3H<)f12NRT6B>VMdOcHK=P6b).Gd]@];9bUPZ.Q&Z4/?ba.5-31#/?Zb7
;\Qg#1(I,3+V3E)Z[_L6OZ2eK):2[DU)FGWcWXRUR&=\&-R_9XLOd8T8//B;4P2J
@^IF6P(P-[SagK7B4OdF(ePfYg)9\^RT=PL6U0/QQA[4/XP25=ZWWS[>ZOC+BF)[
bXQZFaP0=gL.K&0NYJD@OBI;gB>PUF082cPZUS:1E.J?B@#,NK.K1BOf5B.M[[fd
C@=R-^])gcUF#F.,NE#+f80,.<3#6;c@BAaeYU)X6@e<OWU@,Yf+.MF#,\O>^;L1
LRXQ]#fObRIeb5)a,2YW.YO>#/[J^a8MN2I>[gX#M5YX+6.-<,G5?3.RTO->\(0d
-:;^&#,D;86EO,DW3;?0CN3PCb-,M3UH(/R[4b7&H21.B5]0#Zg;^&AfY8\3TL;\
.OC:Gb0K(c=/)_3N0+WPI2<FTaaH&8bMS)QXd&_2^0L6/gJ5^+T](ZdGb#5C+XCS
I-+G@P^F,&9+/5[UYbY@.a[I23G/U^KA-UR-/U6e:.Dc5cY;.(IX[?.CF6.7efZ:
S3U64/FATZE&Q5Zb.0bT4RfYW]HTRHKEAb1;N^JVWbYSF#c@8S:6gdN:5>O^S)P_
#N,>ZH6,RXO,^\;JAKDX^K<7,64f-@M<(e_E<J&7&E08JMfR\(9=Pe8EB2da4:R[
048></>DYG6P8WIS\/&&Y8aE9[.7_=O^FHW\a4H+ZD3>G__b[M/80<>:/MBWU.&A
])gaRPFYGRHHBeT=@I_#^&E\J1N_+<M&=0-Lde8S0Y(EdJ00c],:7\c:SA]R9,:)
9D2QM[WU_RM@Ie0SVIg9=9P[7=FWBU0M0-<\U;XV:JddXRVaG59g-(SGINIG.#6W
YK,,LDF8Z_S+[MC_&f9B8V@M+^/PY->4Z:@+IOCGQWaA4K/fb\6HMZH+.Rb)U_[M
=6QAfa\KVd_W2N5E+UWA8)=Wc=TG<B74JGRd3bBN>9&/VQE,@0dUfX_V:ER#Q>1:
02A@=)1eS7<1W:ND1,P&;::P0@\&RB4J8M/bT@R#ZaT7VC7YRR_X.ET-cK3]F-B=
(YUL,X_Z&^I&JPKgEGOB;3#:f,2Pa?6]:adD(##98;&ORe]QP+R=/Eebf&:G?>EU
Y0.?273_ADQA^e.gJL(H]c?a[feeKV+70)S@)89\0[OacZSaW]Qb4g@3\SB1:05J
,/E#befMfJPgUITP(EGC60^N@CAKIeR)G=(dSN_(@eR?P_4LR8/Cg8YMQ-.:+Zg8
LdZb/7>:,R-XZ86345baba0M?.24GXOe]cd:OQG0^9^AL:fR>Z=2?eg?4GQ#FX)A
0aC3DXAZbL2BG;RLT1WF<)SKE\NK?D0F9G=9FA/BJXg:Q80CK.ZF7N9&@#6KCa\_
7QAeY4?eWR<O;0K:8P.gg]0Z:\N42I=B91eg_YZY#@L8[e5^cC8W[?f78P@@#2<>
cQ71RR;a&91C:fd2;bX2QM9S9A>].-_bOTL7Q0a1>]]O.d[&g;0WK7W:SYg?^3b8
2&;AI+a&KU(c.[b??Bf,BCQ]4JDg8X+KdZ\EV#f#4?\,bNQZ[\f-=@^O7P#M8->U
6H8&5JS/#ESI)+W0WJPX(C/He7W2EMSJPaf[^),I-\6S\<aECHNW/B^fg<8/2]#E
\R(^Sb6eg.fa#g]YBYK)?(1,Ce[6GO,:cb#PeST.:fa;?Z-J+YP([:cbQEORU50_
MKBAg4.Va?_7\[L^I?+XZCCNEN.gYVT-b7;=e8_JZ_?7D.+@<d)?caB[+-,B9?X=
=fZU_EdPARMKOE,D7P3:[1KTQTXd/JUcU=9JS]]=9DJT:eUe:6e)I[#&NV1QU)W5
C&EIZYT13+7fB2(0G@cJS+DVQPOaNPR\+Nb9OBF>b^.a0MH+V7<JZVSbESca>#H#
0#=Z?I&bO57K+G7GD#^f3U5+Te:ZJ?#:HE6@4dXSgDO^>E_bR?6GA<-J-P;)6B>=
A3G4[EW^a,e[b[0:(PQ(KbWAJK;?NfR,S]bYA7[BO:5;O>FSb^8NZ[E]B)6AgZa3
_1d<7)=d?+BX[/&b\P;;D=4TV#0-171S<Aa\PM.[dGX]=8/G6D7VF[@BH0EDS@Q.
54,\f].Q07S^gO8Lb09PAZ7,;SIaPSLf-,4N9JVS]A\(8Z/YIaO6Sg4<X9dgER:W
NO,c)+;T\EFgD[OP.e/LNBA=I/5Fg2?X<WJEf:-1gdN_,BX4bR-BG[NMZ[ED@Vad
JeMJTaQU&1Kb9MX-Ed?KBTUND=8>TW/NR+00.#]0aIaRETTR=Jg35])E0;M5=M^A
(2@P/XT^:60(7(LQ^Q0=9XU#VMLSd1F;Z+/JU_Z-[L9Z[f5^c5JD,f9)BLG:7TIX
BQ0E/0a&)-65[>79?66TeB9X^Cd=5M?fE8#]CX=^.4g>]W?_dC_BP8ZGOH?]E(\U
D?Z)S&@K^d#29GGCAXdL^F.3E:TGY0P0OUZ()gYeDg(3?YcC(V--Hb>4E)4(M6\Q
HR#1(M+KFfFM,9SS2B5>IEgC#IdOd4S[#b1[]IJ()Ne]AXQM>5R:UI5RO+AgQcPa
K@G1#;[HW,c(E=aE3gM:QMTV&7V^LK9Y51KGZ4AGMPO_LCaacg#(UeL<^1Q=NT=^
]9+J#?S0A:7TNZ8+K#WV7CYZ5D((W9T@H)+,L7M];5M([VK=TE2.gFA;3OP2]8b.
Q-R3&0.4LQ<64QG8NI>/HRUA]#;/1F&Y@eOSV4\]9XIAd@UH\#MC-d,9Rd9&Bd0&
20WW&GKY_0QGf\f#.XM-aC/g+.c\HBa,^Q.Q=E+/^RM]M[AC-9M]3a2\Re1cH?#7
NTI0L-KNDT46[8:a#aB5^TeNWeb^5d5QLJFdIV+@Y(7K;>a-93a?+&Va#>1XY0V1
aC76Bcc>K5F&KJ^HbKD6+e6g/G4^&>OFLWcQN@9=ON13gX>g_;;NPM>QgD0<6U)>
&\&<K.Ff:35Ha&0fG>AA#D:-3B+;U?aJOaI.]I6ab6GCRG/VT#8B[VE[>P[bF_LZ
c6J_6L-IRXDc<fSLJ9P.TO>a_W6FeEfYETUQQS#@J4[1AF+V0&R^KAM@5<NV9We/
bW.341_9a(fCa??SN?Z:UN+fUB16^c9(f+/=+&/56<+5JT2>fR3cJH1Q_Z^T2SFB
_0A?ge=@;EF>B\8P\gC\^JN0,B-V_).+@K]Q\0f2(#)K:.LTJ^?(aVT9[&.?b/@6
AQ[1c\E\-.c&4?;Tg/C.c4:FDe/(A01eDSaR31aH_7;GZKaB/4EA[f;4dMP)QFe2
VEOgF(2\ZSHY;PQ.4H-4:Y?=/3YFRY])]674g/J(b[ZF+;<@)5/,O_5H.=L/a#e:
[1T?QZ?145>)6VC19<)_6=K(PQd89GWW+7Xc&d@K0Zf5bFBOSY\_3>;+T.0^XKFa
cX[01bdW#;V1R5Jg,I&Q5@Q4J_LZU8)Ga1R:R7H3&QJ:K=;0\/ZO&VBTd#0]a,E;
M]HW+?JUSQ7,5L43,C&_.WWJHBcB([,L#6B>9#=2OUdDZ>+]Q[C06?VU6\.:dVQ1
1&C&)O;e:A,fL+2(b=L3NV>dOfb=9)J7E3HY;e[f09-FRTe+01LFH=Od]C6F;4Q@
\?&gXWH,aA9W6;<(8\7=A?Tagbd2baB\8SNZVSLb1>23fPHJVNHH8Oa8]1a^L47@
eSHgW[aU_FgA3]5I-X&TA+W\DZ37R>(,:47R<8CP>AXg5Q;D5C?F.(R&]=.^.W@6
AIR^8HDg.A^2P48:5J^0@-,(1NNAP+_&e9]ITG4<.@cbZGZZ4&cg;d.<P<9;&QTY
#\R0(^?NSc@D0e+b;T#QB4La^Ce;8GIBg&6c],HF9KBBHFTMcbY:3@(KO&&1:&/.
(/RcY2>Q&+ED4)Sd=)9M)#VM/I)4V+I?6.g?>(+X=XNQc8R8b>GSY@AXBTC3E4X+
Z:^?CP.71EWf:E@AH^]:JaX]dLS#4a_+5)AEJ(/\0fT-/)4[WfdNbY1:<T7Va[JD
S5+^Ib85899/7Q2^^K&G5H+fP<+R>B.2+;DOGMUT+HOe;]X,96Fb)?-FDQ01;eL4
O&;7\(DS6@(7?8A+UE[3GM0\B#;,@1c?cLOHP:=[PMaOGAG.G3UE_>&UbaePR9:W
WJV@GDf71ALHQE;R.T44+MNLd#RG@Qb_PPZd7eS^0_6RW32K+8d5R:(#FRfBD2,)
J;d3GYM(RW@bBNDF=G/f^L/LQgg(B_.-F#TI(3.33953;/YIN8NGg/J22Gb](#AR
d46^cAK/PH(ZNW+U4C_<\22/FD9K47d11(6J@^L/3UZ3X+L;S>#^Feb64;WMI)U7
L05V_cg[>;H<84VUQ#=54aFILBQeUQ,5U/OS\H0BW/-Q?Q-<)3H8UT,W+OU\1&_b
HKE<)4^,PZUcc4Bdb@3??\^\A_gT[6<7GW:&6Ga5H^TP#fZf@].E-)HCDQ9E@^(B
CU)#]b1\A;]V(/?aBVL5[N]Z:.(1V>a<X?V[<G<(fc_6@?]Q/+XTO[IGHT#XVC85
NN93;3C&K<HQFA_8]U8T89__>UOScc<U>DDXSLY:WCJXFL:DTH_M,32P\1]CF^M4
D)+VO+dbE?YA<6[XWc:eUJI<&^4V5QVY#=Xcf^HS&I9\M3]W;?#D7.O#NF&5Zae:
YE61OKT(3\b^QW]c7Q7>K+S>HULe([fWDJ9FA_C(,GI/ZW=VYB(-:D:Qg1=)FMMJ
8gO=.WU1aV+^&[J+_T?\@EeM=[(>_1#WPW26GQ5+MUO0+95&YH=I@#S&.Lb^HN82
gYN=3O4(^@D;JRgB?KD+H\HB26K=MOg:ZP:4AI>4O4eeA,=MOQ/73X21a_YJ/5,R
4dUSDdNeGd[\,(T]HRO_g::BC17/@W&5c?OY_4P/FdM688&(fePYd^0ZT;3MX0?4
R&Vd6A=99MKK;c[4:@)g@IYS#2I[:HJfBIW(_X-1SRI^BVbI#Vd1Y.T.]:RQH>?:
<S@bB:fdf^^c.cY,SN4X?,^RN=Ng?GB>U2DQ&NBb:a@9Z_L9:C@^NH^R6L4/[gQ\
@@+LPY5Lfgf)-=,Ab6gEI0,c;9?a3DZI.EdOO=2)A:4B(:^3DYA[Ed-fSc3[F>[E
-(.NRZE]>\V98P/V&Gag:D9P&P_3;JT6<==_D)aAJ;U4<Y?MMag[bJfZUQMGA9(2
J0.2+PF;<9(O+HgdQH.J#E.>JB/IJUfa4EeZ9P4]A#>b]@=BCCJ;WQ8EP5W3;b&7
K:HJK6/3f(BHK4B<5KE:A<R,ZC0cCV5a0=N@a<R7-TW@]6g:S;AK7ID^Q1.:A]MP
?_(S1;7^Y>T=gLbf7dCG.]B9FUNZ(UZ21RUD.=/P>2fTS8D?&UEXG(,81A)E^]79
SQH6R7Y[DRCBVM3OVAJ3L@BO38_ZV&Z1=AR.]-E78KR1N=[W:BOGP.BRS3N83LD^
eFQ?F2R@&LU597ge^,:)=;D5XLM:IN<b]N4&8)0<.7+_]_\D\g-SEF,MVf_H;a>V
[]==d2WZI7><RWI.K&1BIX-cTB4)L9O^cL>U,O8=>#?&CVeb/#Y/6A-.5cT;PA=[
(2B5X_0@0IeX1fV<c/N5ZM.Lg_[_[f\Z69eB61)@._T0^6@I7))-B_L+>5+JS,Bb
3:GG(0M2a-QI_IW;8@DDJ>AM7@34+f>2G>E97FFOg:4Z,<&R])C&^,T@dGPULN(T
JV_Kcfg[8H.5&B/Ib:dTc9bG\b#6(_W.D2<@228SKL1Me8aa@Z0.I=W/(]9Wf7]?
^5>a=EeIT6N00e]MF.IL_)/C8Lc9R&Q7D:0(&\K&>1B6,bIG<UO_Q;g\ZS@-5.&a
CC&;)d0WX2Ge6-62df0EG(&K.6?^[&WddY]LBL^JeQEY;_PE[C6O,.@HPL)QU;NP
=bbYdJIK.A/f0b4DG/#@4M0(HPS=T9Z-.4B^_<)D;&gIJAL^=V)<CH:?>ADfYL^7
Q4;>J\9dX0W:Oc<YRgC6D5\E,#9\]:)X6<#:PGG(XGU:8Q+,&W&SMV,OI8[U0S63
,La3O#-Y1Ydb.Xa.GbD?LOM4_SYJIAe]0AMQ(cg3#/JKCFcU0YY\F2ODd6\M\b+L
dOJV6&>c/8SgT5J;?PR;>75NKbSJWHR\&b#&/A\&LB,JE3@>0+B94_(I)BUI0-D;
4:b>ddeQ.I&#K>C#dZN9=2XJMcBUf#>VE&X=TaUg<6>ObI5<Y?1=>fE&G,4d;9f7
g_C[QVD#;)RRRS(NgT).RE.U7TgT=T+Of5S=_M:AUcX&+YX1bEVSZSHF)gV1/dB7
1OO7HWTI.FRB8?A5;gZC&2-8Q2JF;^Cce4a;@+Q><+QZ[D#W/W9ZD4:6_)JHQH;G
:NNE>;V+ZSIQB1,349SD4V;ENU-NQ6WW#OK_N=4)-aIb_//\&[YC>d8f4P-agC#K
a#1QdH3T5/HfO(UN[NeeadC(X+]_]I\=WV\WYHbAMTJJ.L-=UYK02-.3,X>X]Se&
@&=68/W;?KcQL)^NF834CLIJc.[MLUY]PVGfW-(ADVNQ&=L(d\Tg0M7,+>BU,@aP
WLI^VUKOgg<6<;Z9Na^:5^g5?:4R\ef2e@Z8R.0@XKf:GE#1?CeC9F(UWdV0=6NY
N@58[@AFI#.Q3YOC[<[.X#aU1=+7TeF&3M,bOXBO57FJ&MYBVI\&(91?HJ-e;(#:
Wb.0E12+I@[QP=UUeAZHL9I1:60>)<PGP/??B(?_QSGaHNb7QaWFM2IM4/,5fUg_
4=.aHO;6Pb+T\dZ41M&9_ZXa3^CP&.d>TEQ-:7c/5U/.WaR57[\;&\eC0/W)e=.X
@gU\.bL+bCe&)NKg-1[MNT_Pd,&V)6C?a.\_U&Y-J)20b?^Z1WgPfQ]]<L1M-G>_
WITDQK0T:#&\Xe67^+CN9/\[WdABe)?<_&_Q&OfP5(;5ScQgG0M].K65-D3SYc[#
L7E9;6S&6X.UE6CU?9#([J0EWgb835)SG30[[+_,c:VHWU1g8?Fg:@6P6c+gMf\?
5aHBLA7#7JCgO3>=\c51=fgKU:d;FF>UB@WC#S)##B8R33CaBd8VF]Z3&Na:UHI/
/CQIJ2(c(Y?;e@E9g-&]4W7#cE)JID2=[H]4fH@a:,_fcV??QDI;_>McY_I^>(TL
5U<[)R3XGNcg-N&eK7PTY&]f^:e&^D/@QYZ+He[Tf9[9L5UXg@B4\D7(>L^X^JWM
>dN7((:O(;HL+f8VO-@(OW4P,gU<g(d.F[3I\=(<0ce&I5]R^UVU\]<QTGR/:]T_
-,M/HS6&,F8TES:Y1_VcSRcN;cO6<=NOVUM-L5CdB\Jg&ZDIGN/11)@]MMI_XV,O
JF_,/(;EeFg&4(8/I05L=;3KVIee<VMYMN9BIV&H#BL_0@T].=B]7]NK)0,HRO)C
@/0I0e4/aR_e>cOZLJ6d#BL:)-RT,H9F&B>AC5.e/6:^c5[d/42[=f^F[B>)L@\<
>ANRHPP7MK8SXKI\G<=R&\01EV):E-;-#Qbd8OfTKP&F+#d\#b\EaD9TfIbf8QH3
3#M?AZfGW.FF&5\NX&)5X^1&<9#T-IW2Q^:)U_^4I86S\e]cXbcS(S;F^]IG41)A
\D22:LZELJ9DF+9AKY23dJBGf89C^f\EY/H/RDT9U)8?6S;K&Zd:gOV1&+[2EE>O
TJcf[GL4AMR@gga;F,[XGT-)c:5+<TZaOW[@DNH^_8^<<eWUa.CDCVea7M7SX^;<
\<#>4W;-FKK)_PRQ0V5HLX6fe;T;/3OeCRE:W?+>YLLX.#&UNFTU+N5=aR:M,G3R
WTJ4SV(^V1gMLca).&?Z5L(]1NFZJZ]-&Q59^?PZNV&OB3FZV6/\T8LEF6g0?@Y7
<N[#A)Kf-<a)eI)E.STgRM>+(Q==+Q7]ER_ND=YY<01JJEZ5_+46#;7.LUWU)]a/
\51cP8)16gd(WAFTfaGJIg_.OG=J&b(MEP;32Pc5+)+f1[AaYB.IK\&;dSHZ5,])
.&M-Ie4Ff@>AY;aQ>=G_LOMV=8U?&A#fLL=QWN)bT606Gb@dWJ<YN;2:/ef7)_\P
V>O<)H/79C_\=>ca,4^O.BW)Q/#[3eS]OWX9(MSSS>X&]T@gS-\U^7B/95MV7Z=7
?)\8PCI@ZcTFSK7SPFI19D?.6>8,fSK&^\XOOTgOGH)1;,23D>IO-^\8[<XW4;,b
.;3,,K\dcM8;a[6,IaIMeXc=(+J1GX7cFCCa;NNIQ\/.-N5N7g[T::fU<RAG&J?X
0CcgWD.Da>f7-HT,gPG3B=^(2aEc_DEFBAT70.?F],3(=5(NECLMTSRVOd376.3D
/266FZfAV0&<?_>YgQB3/;J8-,E_c:2/^Q4B?:&RcHOAgG_#MTGK\b_G4:;K=N&I
JE,KFd/@8X4/M:RGcI>V4.?>&1HPL@4@gc:1GeM9OBGZ)R2#616)<IB9GGB8?4[L
VO.ELO,0TZ@T/8>S?MB^XU-e&\Y9d)9->TPW:0,/<5Wba8:DebR(VJLVLK9RCWZ4
?@EG11\B6W^08^>MHR-a9+LV2W&LfND,IAd7Y0#<;12<+[H1_Ya5b#OI#8f/2^:@
7I1O5ICF)H\U<fS#@DDa0;QP/8,R7aL6SXRP3CTD&ZJ@#93.C8>9:Rc(.6^4G[-N
3\56X0#UEZVN-&??2+K@[5LF9?F20Ue&-OK9>4V@-3<ORN@7_OVLD=N:\]76_?VF
=I>fT,+dYMIQPHNE4SDgK8-F0JbU9fGT&f_GB)6U(R+cKM[]Y1M\4L5A)O+Sc:;T
T.f80T;(=LW1HMY_56BQ1bK[\4)[62fg9:\]WN/Kd23E>\;S8+c6#@SUfT[BS\2f
-O7eZa0&gI4U8D<&Q\5R:.b?82>#BT\_U347aW]D.9OUG3O7KNM)dDf(2#>1bf<Q
bb@B3cB,a.K0@85L-W_<F?\YGF4Uf-C&RQgG()@;K_=VSD+e#6IANP@3gN=Z^W+G
)_MC6\>(K_^\#:GL@K302GE[/4\0#Q<V,C(<>F896#/QH(P+U/]89=>@/.+g[Q.M
F=cDC4]<=\[g<U],=]Wf?RaSa0V8G4V&45=eU:E4O>/2,dR(=U//ZK#78gID\P2Q
ZaM>N\1Ef/5)7EQ_,=a1W^YQ1FUJP&7c7;&R0dE=VN/^6E-Gg+)d[#L;.NECOPOB
G8_1N8:@R;gSS,/V0V]fE8TI38L>#JM&WVR^;M[0^eU<<F(\)3gXK2R@OEBS1YEC
d0)L^[?WX#cU1@OJPA,FSRA+R/ebGQ>2)?9=2XNTfZS>03]VE+)([YXTE3OZ78,;
)H>T)]KLVDNRLTGGfA4NAAA<O9?fX^=.d.(DO6bIQ+GMQ6bCR^.;\Ib8;M759d[P
4=WId<E@\7SB/[;9=-H9a#D0LIQ2-EV[C0KdS42.+EEcKDMcC6b09GZ&>eT,@;d8
HgL\JBg(19UdC/=O-I]5]>)B-1b4TRDa(e-b+^>80Lg]3H48GEE^22E=],LC\<Ef
cJU93BcaC)\K57)6=?_V>QI(b/OWLGY/IaNDHVeZ]M^3/:EV6^1S:;E7Q7=,[Y4V
U+Ufd9+QU=YSQIK,K(X]/G(:K#]61-<0^9^J[+VH#.FWJ=GZaFU=f@,g;R?#6Md8
Pg9TV)8@,ZT=J]5#C2J[;S.P0JIL1=@<1<L\^UX.PP>T^9^J0.8QRO\8Nfg6CL^9
:fUSV>1VD8dI5WQd+HL:4]FW0XZF#R8;HT_R;Q&F2c+LXBRe[9#+K<LHF+,BO87/
Z80<-L#^JKDX8F[HWVVI26GI)(V.,<Z?1ONZT9IZ/;HLW41b/J;Q>@QDJ<,+))?H
KAGLbHV^)]>@W;ND76@<7HPN01DM@\]@(^BYURAdgc5(&OU4FBfG6N-[+Z60T7FD
1A3#_6:F-_#X07LT@&L:-)Q?RU2e<1CB7)J0D6P^XSIYJL&]aP1-fJ3eb<E)T_)\
18Zf_^UG-CPg09Wf9YQSV>;(7bUV2^PM;7#FP-(,E5+;3?.JU<@->)\6JUM\XP3O
Q.>-=(K^HM_H,2)C.8^dU&a(NWGDg9]/Ec3TEJYU&P=RR5#_DV+04MMM9_1&M;Jc
N]H0Z9G.AbR=4NRN(&96ZV.C<R?KY=6OQD?)\LVCKcgI5P+9^c9DF5L#T3gUG[(H
,-0T4Z_8gFXX:f_M\=f-9KN4>W(+333f((+F[fJV+KQ,=WI]S+(JgV;e)@6cGE7/
>1:aJP9IgUQTA^(b7IA54d,>c?-FG/B;.FLG.>H8=[Fg.,VH()4TbVf:N=7:R81D
3JB9L)Fa9c3OC70.YTDIFP6&S1YdY,_7>3UZ348FIT<I3IN+-@SY#<4,(La-K>L(
F0_Yca4RcO@S:[AWdT0MCS;AfJT[1CX^W\P,-U3#76T[FZXB(4eSd37&@()[V+(f
2FCeZ2b^c5fXE&fWQ,bL[1FfESG<Vf?,+IF[cT+EUW8^;Hb0A?.:AM9Z#4ZgP-[X
(\SN&>Z&[RYbD9<6a5XP8OINdS(#C:);TP2/9Z]TYaRZ(+WKe;C/HTF?1>B.aJ/L
Fb3S&O&UH@#_fM#1;2eWA<LY+/\G-X+;cT)])FTAU/160g4d;YW08F9?YQUA<[?e
CIVA/=&^^KZB40=EA:cQ50Z^[4D_f4c)Y/P(ECXPY9B>VM/OLI,I-P?Ub3bRB7LL
AgdUfAD1]NA/-Jc^8+1[@)+B[:G3Ba,,S?YH[^R9d#T:[&\5N#>eIHKGbfFUKN(#
2,SU9BK2;GWG94gJ)Jf^P,_VD0a1JP.E9\,Dd;.<+#>).gZTU4=-=S)>?HIc59MH
G&N1GJ+e0#A.cE@f_9L=>GIRbOFMO?1=QF;-g?ccbSe^<3TKC:ff<^fB@9S2S0WU
5]KJT4QX8Q+/fVD=a&g+&+<c7>KHf^Z.eH.SST#E^0)aRVNYSBR^P+d.R2H@b0JT
:,#B)=];7I69@2cDKc>Qd3g/0X7QAJ-(WB&I,3FfN)7FTBQ37(@BW4\[>D(&0T[;
R^HcF9X+W)bG7d_4M7)R5&O#\?8QDcXTIf_9f(<&5,LP=8QIV)^d,T70FD1L,]RT
7Cg@NdA>._SO,bSP5&8#a3f&gg<+aUJ1VF^-C5<U3,AE^8.B((4B-=9fBN_)43O4
I9+^:YM-._NKcMZLL<F4G.[B[N?dSG^-J5&85QYM^@U,Z12^_AaG[QF?]D<#YTC&
Q1&3OffQ.HRBE?;J/85:\@aN<#cY4CCYQEW#P\1f[HR_I/UC7AC0F7D^f=2R622\
&0JWWTL(OVT+@FGD9/D\DVNa45/dLTbfT/C,JgUR,EB=>Xb3OW&Q-M3-aXd]MS2Z
.bG(_@#E.E=VP=G:I74FUe_.8N75gKQC8JDO7APY^8C&f:f>?AB9L1T4[M80IP^6
a\]9P+J)+@gW8\BN_UHLd#ALX_,,ae#^7GWM-T:cN^5KN\=]+2\::1.6B1\dEfX(
:[;af1AIN\T15gR?;1,F2(:_U)+M@UeHDEC_:+H^H\R>CFd65\M>8aK;GH=/gZI;
/38/dL:4?>eZ4d95+L[;GLSI9K<26&cFG01GGZ>c;2cbf8>PSB3^+1C[53-98cfT
)JcfD333#SRfVUL>\dU>b@I@a\K7@2PK[3VJ[^OV-_[-@X_]ZB@,5KRcT7eANA4Y
Y^4gVfD)DddOG)[+Q=YUHQNF<K-c+b.g[R+Ve^.fJBEgD^US+=L=(=a^[AaUD+Z=
E;IYUEb9K\II:;J&LEXR4ZJW8/f,Ad]LK/ORT0&fH12_>A:X?3/-\B;)-Z-=)9Ge
:O;eS&[FAR<=_Eb+=]I9DVO1]=e48NC9N,W#\B^]-,O\#F-QCXYPK)@1PY?@-)0;
Je/Q/-PU/DXbRS.?b_E]8[f4gP28#=K=HV4Y+V02NeUM4:cHEQZX,M#gVMGEH>,Z
c^ECc]Re-:+7HKCWS?HG(=U2#)fa&TXZ;,@(PYF7RDb4PL#G0I60+8&9D^VK2_d1
Z]^SV6KDF-H[+;0c8_YB,0/C]Q\gWK^0E?9F>:8M[0Jd^d(YcaTC_8@b?<C/C3c@
?fe>4UV#YCC&fJ]Ad5=AZ+Tc20B.Pd]/2#3V@QgZ.Y6NQ2Dd7LR&[RZ+^P,5PH[=
<Jc?9Qeb,=K4]CF>6a9O.5/U,)T-eMC4;KVZB@cY-;]^/eFM+>=DNe(Y7>?,Z)G>
[Q.3-F,a4I2O+)GAV506#R]1#XMU]fcG\T?I?Oc9S1C,c@?dN4^d&\F@d@U[8./C
+?;QVHDG\BN^U[QV+SZ?YJ@JfQCL8FM]Z9/a30<OO2L0E11AU+0K?/S)2>.71.VQ
DAQ0</eDO75O5SZ]_MG1f?2WZ^28U75X-^9b=f9UVG<_/EP/RL=OA-HVP/0DUKL:
,B&#2fc#_IeV5D:18/YSBcbS79?gb6#15<-\:ZR2^^0[5c:B=PUC+Gc+/\D60J5Z
J4,TI2B6D;XM#PTT(<1ceE35TBBS@I>B+a#SIO,ZE;5AIR4KFF#INc[>aNcTJTD3
.U1=#2P@]=d:O#[=^8eOF,BG^V>3>=b85-c4)L^XHcR/CX/7>]O]XDMaA6d.T.-_
QUR.I,<E-@5Aa,;cWT)+A&L2gLN8YKd28g/O.2Z5O(+@,QCA>fPY5_\E<;V#P?E_
Tg+Y/a2Z0#&]7(@3e9-AYf0b>YM3^V#SL>6#J8PDF]LEQ45RUTf6d)+:e-11XJ)0
&)geC]#4C[f?1XNVd?QA5]_#73<.S^0Qf4Y^[,7_F48Ma\ZX6<2>b8<CeGD@=\2E
gW41af^G)KITf4+6TZ9+b=;=Q1Z6V_5Mf=:D?d6O)9R-+]WDTfI/TRMBM5X+>:#+
eT/H/8f7,.4^f<BFZ\]e@@_IKZL50RGSW3P([TW+d;;U15W4;UXX[1#aZ0JQ7Ceb
1b+:)<JfRBW.K2Xd^&^+a#]/JR13WG-cVK0B+eG0+OF,CJWF-B5T6SUG-7^,BQSJ
C18M.][(3D#NLPX\cMdM]EO#Daca>T^1O5X31PXcB>TM3?TC/)=I>G?Q.>DE1E]9
AT;;b)L(cJSAcI0P2A2VD\)#7Da4<YL]]70D65b)d)aTd_Y)#Mf[]P5Vgb-N;Pe-
\L^.FSULf]:e72YB&F+2WB<W_#YL2QW_=?d_IB4Y@UOVU-OHL^]P):4CH/Z\IML7
)M+3#&D>V,-Pe-9S1Y&_&g,)O.c6;):ZXV1d4cg)FMaR]UBB)f@&_Q.e)X1[-acL
&Q]VSCgB>ZGaBg59a>1g@@aH?KCP+dFaG8_>PFDa21\>ZJ-O^I,9:/M;(NX@>RQJ
f4,=aR.X4:BZ)1,Y7((2KR,(;&DG?C],Nc:FQE]IBgCA:V#aAX<d51@b0EX>(M-3
\[DB<&#&VS@<M-/\7@e4WK3&8K9^F.LAR/3B6MFDT[W9:0I_>^_2Kc54C9L._E6/
TTT?<0Y^DbfIRD/JdeE0(S2?:\-dbIEE4^W.cV9D6#<\5]H=E?/++[?[NQ#gd;Je
eade:K\&<#<Od1?NOb0VG-J>P=FB5ceX_)+:,/(_\U?C2OG#HKSXQQ<_(4AYN<3#
Qb]AG((E1aeZ7)W1@MbaMMRSX#\2;K.7BH8_A#5D\7>(7>AY?;aT92:eOYW_]#DB
T#\#HB-Ba@QO>6&:9<bQa:/VIOFJ7NGNeD1GSFY+C_5YU<I?A,7H:9<Yc2)4?Z58
L(4YARgI&(IG+1KP^;EN-YKQ,P[MWf</BPb1e2Oc?RLgT4Ed(Z=Z.2(_.KN2]XJC
N(@:.=J[:B,dISJ]/(RV(g3cJ:D2g.S@JB]@X97\A7@6/O+0[Zcb4a0IOSC?eVcM
c6QcB,/DLAPQ5?S93>#a#B[5-_<#>;[CNUG>(g_8O[ZI?8D+,AM]KGFPB.=OT#BP
:_B=_CK978QT>]Y)&M=563Z2O,fbH\?PM=G4+NLNU.7c<(gcDTZQO/Pa+d6)?9C1
RV>(b);MeG)<Aa0@?TX>3&Sea4>,XX(6O?T>X3OfF+B#bHJ(NB6II>C6d.[W/E7B
E9aTFf@2PM_J[BM+[Ha)S[0.F6cUI7(c7KK,_/FYaW2]HN4eB]afTY<1S1;Y\1GH
1MBg3Tc#NWd^V^)[8c+g#67+a4ZQ?Q[N/UcJK/L&V.TB8U/VeOPZW^MI?e+D\._L
c00G#W)&.K]J.3I-fU:bZa:6[:;RU84WQdS(-#98)[a0.6Z6XVA:^]@b<1c6SUM@
=/gY^1Q50efJE3/NcV]V.E(O0HQa7-K1,TPP#EGea]e73>XA887L]PD&<7S6-[9_
O05Y?&=_)?W(,SaD62\6/;]dXZYQQ_8IH@G@=Qg;6S7VLN@/OO/CX&N,2-SfFH)0
L3S)MPbF7U8.8^F4?MI1ggTJE-O:cHaP(#KddCBbScg-?VKQQ3KWP^V@<@T(];:W
39[#61TJfEWabcI#JCB/51QCNIX[gdHFc:dWK6(ZV5F.9WTKM1&Ee+HY,@]9KJ.B
DSW6EQ\1ANAK:d<YXBE9LN\HDA_KEBL((WU,)7F?gDLX2B7;6-VZF--6J^gO0MCO
+.R^Ic^8NUcc@934Y4/.S7c)KDM1X+T)T63,K_9+XPdZ6HObXdK5W<G;Z79LG4b5
BH\@&+C;BJM.YHD+b?T_QfZf)H_Q0-7Q2TfJCS1.K3T-/K-Y=^0<=K+/g-S8NC]A
Z)c?e&d]>6:bM.+7,2QQZNIH[L,KS6<eHT#1:4XaeM-K1&_e7B(>&d;53AZfe:+d
XLNR<R;ED_9Xa)B(VZS]QU]/3I=3aQ&S0?O&1H<gA-V\b&9I#3L\H-eZ&R^JKNG\
cH2L9YJf\VJdPVf:\-BHO#0]X#(O@XDQOb\HI#B:D4:6&:&.DIAB)+.117DeGI_I
/e>8CJZMC+PSDPI>gPJ1[0OD?[-)DO#g1)QYLF&-Pf#PM;>LXSA(/T:U[I#QS8X.
0?N8J5@;YA.2HC)eP>G<QP9AJM/D98J-]CXHaZT-T)Cd:bZ8FU-Z?O6U]&bB6)RG
gM8.(FYUMLc?U8Z>R0UU,FK5b)3&\cV>]aXgO9K+O\?90d6<3FeANP3DT8B]cZFV
T@63#?;XMWIZ((=eOgG_9WPTVKe#A<d,M1=+@>/)DBd^N:&:\RP+WNI<1J-;b=-H
g).8H1@f_8I^DM_O-:>e?R@H#BGX=Od?X1]\Z3Z[0V3Da<[SF]7ZF;H-6PUe[Lf8
N/\(=7aE5+/M_ADWSZOV(&84CMK8b[N.>&(@<Df(9c;--GKQQ(#?Mg(gCLD;)]/<
gDH>2C\5,9+6JH9f,L^74O=;]e>DM^aV]5+Ke^S?fdEHU6B=g28M16F#HX6E1-S&
2NE?U-?2=L,W>J/?Da:^^cL=e3PcG.]/3+10LX@@))6XU&UX_cVR02P:J@N4A(gH
9<b=+XV#[g#MeBFQ<9^[8WfEP+RaYLM9[LfeCB-71d6B8SVK)6D=MN<fL4Ef\-+Y
VY5BOW-R[F]aT0D82&7BFXFbK^>(.\Z?a9/#]?)R47&eX81J(JE3TJ]WUaf^)7SN
IgPb<SXZK=c<K+2e4@CE1^?TF3(CLWc:O7V5Q:IU:DF<EQb+)YX;#<TY@_\DB-7)
O@__g?e+JaRC2g8N2Y[8d>]J9K_9aFU#2Z.69L],<@A.PV+IY&&><)Z7HAP1PaC:
#F+[;.T7^XN?HYAg@cJPRUe#+^b</GbPVg?7@<&4OPcaFM:3:8+7H;Z:OMQ@(;bR
8#AQQ>TfR>DLa6PM_Lf]L/[e1Ug[\\]f+CdA/=aC?(@A:<+dUVNA-T[.<2;?;@Sg
,PLJ+4UE\TS=[(:ZM]FbQR@I?WP<;NFW=7KYL_ON]8^NQZY)7N:;-\:+C4SO5Zb+
@T1Ze;QSgOg_f5&5(H?H9TIKN:[9Y9YTOS+K[^UVRQ,N5g\Je(=G/W9M]>4RG70+
4V?-)c:3-5]9\VBZ.0K0GTD>5@1I0EJY3AXKfX+BT]>,U&-#--_g@15NONUcDUIB
S[ZGe<-#(RG-4VBW\3B_PL(]+>L_HU4e1:XcF8X;S24+a]RV]IZPeZ9>QGWMCHXb
P>G&D,759fO92WS60.(E\T=2>g9MeU;LEc,\>U48K[/]SM#(BF<,V+9D3-P>f>:C
/@&N93.:D8U-O1c.U]fE_O@RTa3CNW+F2<g-JPT?VKb..RKK;>.)e;:7JR^+P#=a
YA0Lg^VNT=[+];<9;SCC1OBJKbJeX3G\Rb55_]MD>1_2fWZQ06,MW&>Cb9RP):;2
]F5.DYG+JLC8^T#Z5<8#T.V];N-#aYWgN.,g.ET(J+>55-IM9?HeU0)ET)?_d^(^
16:^b;f@R^=E>d]b&O8?YJaPe;DQ,?5,HM+L53DMB.;Te3,cZ?]QUf4?W7bJ4K,C
-=ZV[YIN.+0E2K.@\NUT@JL6cdJXVH<3)83Y8Rf+FGGQ9D[6KV\A^>A>Y-5HTO_:
/ZDFSHf4CMD>SKK-??#T1[7fL<^NTc-DC5W\2C<6[0c#LeL\-V;,,#b;<60e6bef
UE_.N^H5CJJX._=.\\X\K5ceeBb2c.^C;9WZgdN9/1GG1N5H;b\PQ2:/5O6(..f&
W_5IAZ[(KX@T]5\K&WP4EUZG-A1bg.)Jcc89EKf0VW^9GAgP#HbR_STf.+YBAcQc
&GU0cF_HJ;[_-\dedT?GOEW(B.+ITZeXK\NWZQ9<fP88=G9(;3DU/,E=U_Y=2a6I
@LNK\6.]aMTY6P]^R,a:9?\UaY3H<aAS)&PE)_MD??eT\5G@gK[_+e,G?TSYbJR8
CeNW:F@gEeZT[.(IMF0]JYQ@^M5[#45c)#a0?f.?F9Y<LF->+&ZQ>&JPRQU#P8aV
d1Z@+BT>RC0IZ.P<f(FP75gTFKPWFDE8HPZE\#_?+SN0?,6ec:IP5W1NY)L:V8dD
?+LQU._@O[X38GCd91JOI>B#,8Q;2/N,]9V_JUU=,1P-)K\=FbGCG#[Z.]V<O7RX
-a,1)B2S:S6H;;F<MfS(:.,9:Z/21\I614a,UZRU=(2ZNcNO_gMP-8A>]=XV83II
E?L8g;=OaG8Y#a1)8?<2]GgdS==A0O^e1E.7dQFRI_13:\AU?=G>MDAR&,dc;+P4
MH(]?^XB0feT@(PON#;-99=1PLUTeVX)A(C#8(UZ6g3L#_^+fTBGD3<^R06:T:&4
Df8E=MOQ>+,I)F[ZY4(@KN5YAfeYTW9aSR0E_#;9f=-:J-SXC#Bd8d0IIR:+AQ1F
d3/>./]D7=>OB@a.V\9_O>O,1aN10A)R\RZa3M5KM^^3TD9dF1:+Y8d&XPRg;_U:
)EU9\TPWgaaCb]<195G8WI#69VT+P(^_]SD;.,QV+G:AO#FFXf8Z@=6[Wb2Z<XBN
+Q7^-)1_7BO4T7(6)eF[Q0Hb)X7/>X1QS]._LL4H/U_Pb-0G:;e([>0<b#_ZdA<;
2D(1T9:DNf;1(4#\V:5G[FJ+\P/+RFT0/N?3;QDN0#,ab)G+:Zb4&B]]LIF1g#.(
KE_<e])0WSWK@Q4(?Ng1L4bR5H2eZR,?GMB2VA<J^WOGQ:J-e3G]bM(RE,\M\cdY
1V;a6_;<1I.-86:9[V?[QVZ9D\b+NM2#YC1UG>fN+ZVb[=)#[U_RS[XXd?[;A3DT
Jgc?AGTJH.g,TDZCZff?IHP3ZMP-+FDMe:aeP/?:;.J[K3-=CL?2b?;aeePB_L[V
RY_ZZ1)N4H^WFI2cfJ/Af^=c&KeXHS+-+\cb>7H+F0LIZ-W):5/b_=HPB@^)CCCV
g[c47a1gE\FLUIdADb+@P6/+ScR]?HGd([c\AVbW=K(</T0ZCgU87/4dE8I4RO(S
d0N0TMa1/L^_Yb4R.bQ-+aP_[R+1NXaQ,-fIe^ALf>V0T)(L\<b0&^\fScL+dXY=
1c@M0NM)aH5,I?3-U4JcS;\T>Te.[1E+Fg2+_B26O7f2e878gXdON[M7:K/E(I.?
CZ(KT=OKCO6QE/I+<VLa@GI6>Jd2N72Oa]W11bS3(U0eX)\3ZS)S(LTf2?;[3Og8
AR^L/;eDT6#]#VY9MKS,e-8_bL(^e9F26&D4+<H^C/c:ALL(S)fCcU?@33TP7A&?
E3HP_@NK0/MdS.;QC@TVSCI^R<3^A<MJO4(YCG,.=?@X^VV<b.OTVg\:c):dD#cc
A-aU:-TG_fXT/GQT<BKM1dK]206I-L&KS7Z[:^dX=G.DL;D8HH/cA/cQd==C^6&8
YS\?]ag>D3L?KDNa6gNQ]O8/e/7:cF2)<^HFXD(#Q@&DF$
`endprotected


`endif // GUARD_SVT_PATTERN_SEQUENCE_SV
