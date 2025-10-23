//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRANSACTION_REPORT_SV
`define GUARD_SVT_TRANSACTION_REPORT_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_REPORT_TYPE svt_transaction_report
`else
 `define SVT_TRANSACTION_REPORT_TYPE svt_sequence_item_report
`endif

// =============================================================================
/**
 * This class provides testbenches a transaction mechanism for reporting transactions.
 * It reports summary information for individual transactions that are in progress and 
 * accumulates information into a summary report.
 */
`ifndef SVT_OVM_TECHNOLOGY
class `SVT_TRANSACTION_REPORT_TYPE;
`else
// Must be an ovm_object so it can be passed via the set_config() API.
class `SVT_TRANSACTION_REPORT_TYPE extends ovm_object;
   `ovm_object_utils(`SVT_TRANSACTION_REPORT_TYPE)
`endif

//svt_vcs_lic_vip_protect
`protected
^W(PUa2J7d@VPNEN^,0KD8&gGb\G1)6HZZTZ7?fRP=-]e865..)_+(/KNP3Rc2BT
eHMY\>>B?fd_M.B)\<Ab[NZ>d&.P,6f[C(YL4^?56V:(DMLJEM3QR93Zae;F,92g
+E8P7;GJRd;(WI.0YYQ/)X4R.>CFc[E.KYgQW&HOe=9Y0,KL)AO6L)31c5EDRBI(
4#X_b\3-]X[460LPAN=>O3Wg+X6b+]/U\d/)Q24H8O4Q06=[G-f[9?+V[\.;<J@J
e\G-NEgC7R^+5-DM>CUQQQHII8.d0d8cA^/\FAK]Z9.QJ&]:?80d.ANM1=;AS@(1
TQ2@>=cdeW+&=4&LDP6N(<<d>;dZAVJS.7E=,AD@ec;S?aV-VUV<6BRJV2>MU2JK
L\0F&U6g-)Ud\S&^V(H?-6g=,?U7=bBA_JSBT2\;]IC)3a.=3beR1Da[;OS386V3
=?67R#P?(ANPQ5>/+T2;2Z]#;N60=JI-c52aceLQXN2ObfK+\A3Ab(0aFb88?B7I
[PV\YF0700(>9)>4FB4ZZ/CBIZd[Df;#X#HH0MY&N6GCK4Jg9(A0DK:D5d9G_2_\
cNB<^(;=Z^E)P]HRH0@8]UHeST:B:;CDD>0f()eK,X4TL\J8gN@6Qa-?@45@Ueb#
8K#bSO?L@7H&;B7],RK2](He1$
`endprotected


  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static vmm_log log = new("svt_transaction_report", "class");
`else
  /** Shared report object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif
  
  /**
   * Used to store the tabular summary of null group (i.e., summary_group = "")
   * transactions as seen by all of the chosen transactors and monitors.  This
   * feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this
   * report. This is the one summary stored directly in this transaction report
   * instance. Grouped transactions are stored in their own `SVT_TRANSACTION_REPORT_TYPE
   * objects, inside the grouped_xact_summary array.
   */
  protected string                   null_group_xact_summary[$] ;

  /**
   * Used to build up additional labeled tabular summaries of transactions as seen
   * by all of the chosen transactors and monitors.  This feature uses the
   * `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this report. These
   * contained transaction report objects are not provided with labels, and are
   * simply used to manage the strings that go with the labels.
   */
  protected `SVT_TRANSACTION_REPORT_TYPE   group_xact_summary[string] ;

  /**
   * File handles used to create a trace of transactions as seen by all
   * of the chosen transactors and monitors to an individual file. The
   * trace feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to
   * create the individual trace entries.
   */
  protected int                      trace_file[string] ;

  /**
   * File names for the trace files, indexed by the group value. If mapping
   * does not exist for a specific group, then the filename defaults to
   * the name of the group.
   */
  protected string                   trace_filename[string] ;

  /**
   * Indicates whether the header for the trace is present (1) or absent (0).
   */
  protected bit                      trace_header_present[string] ;

  /**
   * Controls the depth of the implementaion display for the the null
   * group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      null_group_impl_display_depth ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * summary group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      summary_impl_display_depth[string] ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * file group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      file_impl_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the null group.
   * Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      null_group_trace_display_depth ;

  /**
   * Controls the depth of the trace display for the the indicated summary
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      summary_trace_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the indicated file
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      file_trace_display_depth[string] ;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name The name of the VIP suite.
   */
  extern function new(string suite_name = "");

  // ---------------------------------------------------------------------------
  /**
   * Create an individual transaction summary, with a header if requested.
   *
   * @param xact Transaction to be displayed.
   * @param reporter Identifies the client reporting the transaction, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern static function string psdisplay_xact(`SVT_TRANSACTION_TYPE xact, string reporter, bit with_header);

  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a queue of transactions.
   *
   * @param xacts Transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_queue(`SVT_TRANSACTION_TYPE xacts[$], string reporter, bit with_header);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a transaction channel.
   *
   * @param chan Channel containing the transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_chan(vmm_channel chan, string reporter, bit with_header);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Generate the appropriate report data for the provided tranaction, placing it
   * in a combined report for later access.
   *
   * @param xact Transaction that is to be added to the report.
   * @param reporter The object that is reporting this transaction.
   * @param summary_group Optional group that allows for the creation of multiple distinct summary reports.
   * @param file_group Optional group that allows for the creation of multiple distinct file reports.
   */
  extern virtual function void record_xact(`SVT_TRANSACTION_TYPE xact, string reporter, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Method to record the implementation queue for a transaction
   *
   * @param xact Transaction whose implementation is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Implementation hierarchy display depth.
   */
  extern protected function void record_xact_impl(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record the trace queue for a transaction
   *
   * @param xact Transaction whose trace is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Trace hierarchy display depth.
   */
  extern protected function void record_xact_trace(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record a message in the file associated with file_group.
   *
   * @param msg The message to be reported.
   * @param file_group Group that identifies the destination file report for the message.
   */
  extern virtual function void record_message(string msg, string file_group);

  // ---------------------------------------------------------------------------
  /** Method to rollup the contents of null_group_xact_summary into a single string */
  extern virtual function string psdisplay_null_group_summary();

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summary report. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a transaction summary and/or
   * file group.
   *
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_impl_display_depth(
    int impl_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a transaction summary and/or
   * file group.
   *
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_trace_display_depth(
    int trace_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /** Used to set the trace_header_present value for a file group. */
  extern virtual function void set_trace_header_present(string file_group, bit trace_header_present_val);

  // ---------------------------------------------------------------------------
  /**
   * Method to retrieve the filename for the indicated file group. If no
   * filename has been specified for the file group, then the original
   * file_group argument is returned. The filename returned by this method
   * is the filename that will be used to setup the output file when the first
   * call is made to record_xact() for the file group.
   *
   * @param file_group File group whose filename is being retrieved.
   * @return String that corresponds to the filename associated with file_group.
   */
  extern virtual function string get_filename(string file_group);

  // ---------------------------------------------------------------------------
  /**
   * Method to set the filename for the indicated file group. Note that if the file has
   * already been opened then the filename will not be associated with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param file_group File group whose filename is being defined.
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_filename(string file_group, string filename);

  // ---------------------------------------------------------------------------
  /**
   * Method which can be used if there is only one file group being handled by
   * the reporter to set the filename associated with that file group. Note that
   * if the file has already been opened then the filename will not be associated
   * with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_lone_filename(string filename);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
_:Q3UH15@b^BZ#E?:JYeFE#,KG5MAN7TZ0_^;[&8=H@d5D\1cB<[&(YD;H:5/FW-
Pe=gd6UDQ6>^_eC1TW;2+.<T&QM99O8_ba,Ve@7PIK<,FJQd=.QVMSB7_W@Ng=:0
f#Q-aD1M2Z5c&JA2Xc=?,GOJYe?P3]d@;bcU^-B:4AHS1T>)Kg<Z42C,<@Q=L-H]
1f3^e82OSL@Icb&_H-VSL(];E4&=5O-[K?QT]KJR#R;+:L?X[LYY\W,/9LTDKb?b
5)_JXW^FWc\FNMM/B0.G](DV<[-Y&:<M,c1/YA[\M1;aX=/;-QeQGA\F#\TK5MDI
1#JWO1=8C;B?VgCZeA_fUFZ3gT)b\ga2OGKO2_&Bg^G+LeGKG2,HRP\(Hb_/8BY0
?8&1=R4,UK0&BF:6a8UDWF0;(YJ#58M=NZI+I,/(R7Jb6Za-M4<R.VI99ED\-gHS
bbRdFDcJ74#YPZI>7D&NWa(c-1@MCT[SXT?67bVYTEQMCfMJ)BN5=44PQ6gU?VGW
9d-&K,,I4Be8LE4JA3G32dHWB>^S/bV[[I(D5<gGRJdI,dCI9&gJ6JQ^P3aQ.5QI
gD^Acd0X)RK5NC,H<0SGSUI\Wa2/LLZ:1--19/W0O5<eRGL[E+[NM70Cf1Y(/]N1
>=PI;023/8-/&+08;Y:?1;cO)^JMF9S7NC4JYY>,8c<5P.KYOCQBL2Ig4]KaKdTZ
bZCI^):W+\LPQ_:;D_DQ@Z8BeMJ:2S-,d3^6O\&5Z2+6[2fZJSfGNB.9JKV?:9NN
R<JT5W&>[N]1U;SLI&7bg-FLL\c=TU)ebR7+)RRHVOX;;]_,85H+_^>2N_X?]d(M
8LVe)HBVP+-3M]1P(K[97@V6ZHN_X_,Z[2[F^b^<WZdbU^2D]X#eHF/<T#CEE]7/
aVb1M[DSOQ?WC@bW/LTXSe]cLR5X&-8=O?ZRUbJM0,_R)]9fXDC?e)7?=7&R=e<3
bG].M;DdIbYT/&&D;g:17gL3)PD9XVG&>f@2>K,2PEK7H\L.DKSgb_)+7W4?SVR.
SD2CEP7^CY-Z1.&09:e7&@E#./M6A>49^_KUI<F^9L>Jc4^Y;Jcbg&Qafd,PAS3I
AbK-9f1:YfaQc/c.L/N@Ff@8>H81DI0;WY(g.N0Z6Cc_>[XIff8D5>.\(QL6R8gJ
J;-SH@-#?]JVGc]_=O5O-G[a0C9aJI@.ee9D=TGS)H70g31ZIVN4/O6fZPIaM_AL
-+RA;1H,eeA]Ae08.6B/e2OT91b8JD?W>D1+=c]&9TE4P<IGFC;D9L8IUfN9]IF+
+O^9CeV4TIV2[WSa2d6W5CU9(1]^Td;#M+RgTJc@Gd_?2^1fU8)7AT1/eBY000XW
GP<MO4F?M;H.[g].BTQ^cXL=Ha]T>:W^Sb/<V3W:W-cSOaAG9g0M?TFaEeU#.ID4
VB5]7PU#X&+0R20Oc;YY82@H/a>FM^aM\3dK\[:LD8]?T5]/,7GGc6(PeIM,H);>
B]S;F@QO^PW?B5/b2QOdB:BQTfQ@7TGWPaFT0DR6I.LAMLN@=DFg7fcXK_:?S>IL
5HSW]KgJE>?a-b+,Tca@;)[H\<Md_ERabLMEb7QZ;(ZX@]2D#g6)\S?ZI8g#8;,/
f_dg<&)Le>@ICJIXd,27]Jg#ON>gGa-4C2@6TZR>YAVEQ(2;G@cV65(/[GU&+XS;
>F8=dB]\BWRT^MB++;S(Hg\I=ZKN91SF\,W?#KfE>PVZW=+Zg5PTWYa,Y]OU=A0(
;Q/F?Z6g7\SUQS:f(WfXQ;\/_CF/99@-@[(?S<R.WXac0Zd.T3@EQHDETWG\-EF+
]<^C=eBgTJY/)M=)4]FN[BK=S5[?:3=NQCGc0)ZPbTTR:NM,4TUcTXP/F1XH2GC/
?RR3>[/>)\,9=>^2A;/YL2?XN6YAJI(<RM>NNbLYSMLEK+b>UDE?G.7R2<KaFa(2
B1F<Mdf(ED(/UY,[3B7=RG3J\AK247;)FGL+90Lb;@\5b/8P;MbBLEBfH.US3d&&
^P&YM40-RFSE[Y-U/=I(V,2Y6=Q?BPV\MT/+LLM^(ULL^SB4R64Z1JMXJ=+.J4W[
Ic?b4/f(HJ:B,1A^H2/?..+)3P?A=a?0M>;#RH8LcVCNYc-DE:@:FPH>cNT;JLUd
.@D]?2Zc0fL&MbNWLY9A#@e#S>(:a84(UeQO?;\\8K>O2.=<.75?beLg2RRK1UOd
KDR[;BGQSSed^9D\Xb)1^KJ6@WQ)A+?\cVFY/d].]H-<W;OL[Uac?I1EFJ+(_EX1
_DI(&HgaR#+TABCK0Cc?X.4\a)0&0047F5IKAEBNg+c3#/e:P2fSb,MZD?FM>[]a
QfcF@1U4NA1P1NWH:=?9c,?2MS>-PNc@UB_VKbYMad2>afZ+SA.U^2OYdZI^A,=.
V,]W45MIXaIDCZJ8J&@0e.W,\-dPOSQV\7b7;SX]C-:8UE]ZdPMB?]00ea,2g>aN
R^3=O1TTSO;(@IQD50W::\FI4:1+@[N^U:,B3S(1Lg8Bf;E,ZYG]>OQ:.D/G9Jf]
K#K,6A-SH>LgM)de&&@eVHOT2I(,]<fY:9:C+?c3P(a,_WU[<Q[e@KZSM=T2)c.6
TK#a\[F(P]SLa<\bbR7PU@[,9<dSV^N8YFXaXQ(6<;F2]1HaPGQ-DI,)38IT]=N<
:S4/B\daHWd1\NZZGU)0A_e3FI:?DL2MA+,^XgXf=(b1\-Z<-N0aI&fc2)d1HYXG
?_4Q,&-+-PJEa?9)2A#H&-LB7aeFd+/?SCL=>_b:ZM[).A@0g8DDBV,d^NW^A+2F
L@T(C[eQEL]F/;>N?d+b2X;a,++8gda8EI3:6E)a<Sf8&ERIYE?<PNRa2E?#M.9X
-RN,TRY/HIY6I>Fab4DL9X850]C6bc>KL?5+SH=H[4NP;8TB8;0,\4(bJgPHJ?Qg
.Sa(,[A_Xd-.6,:b+28cfL5F+/;2?=6<#;#bY16FKUcd0KbTEV>N1N_>E>aZ[Y2X
&Y=TZAAcTaIFb:Ee0=J2C>Z05G,e=ONY-GA70#JN&5(U8HZc8R>g@+M&OS,ZFfVI
N7IF?E\>CAY3a8Y<=Z-62WM[--#R3FK+7Qc^,HQ/VA2d-OBEd1^W1\G:8FaD.J1+
faf&V0S1C1D#O(4+1&6[TfP6-_@d31NV8960/YeEP:QZ]9f35P,P7b2QHIS,GG&5
S&abP@Q##0dA_C[4L8FJNf3I2#/G</6A.[H8W?LN=D2USH^A<&@Fd_c1H@K.,3&N
9#cC0F=T-HeTIC\6e7W#\)[4bT;QF_.YS[C95D1NAV3#cBa37I(gfYM<gd0D/g.@
KQ?V7fB8SF>B<UW#^@VE,g5LNg>C-,d,U&EA80KGUI1QM3WgY]6=[YPY=.J]V?gf
@ZT7/;NEfg<fT.<HPd-cW6-B/3NXD</FdB&]fV;)#+b,QJZgOVa)(ZbU-G72+\E9
)+EO](d@@A?(D;5TP]Jc#T#efdKMAM@(AC;0&?9(cUPO0gXYNK7W?,C#=[FB5DXA
&Ce](?d.G@c9_59TTB_5[3EMUO_0SSXfZ839g9,/Z#a]HGEe5;H52NbWbc,F[/-M
EJE&Z9]8RZK2L-6(-IL>TT1]Q3b,^RQe(S6EgOQ3=7[C+BV3U-6dD?f+U##9M;gJ
:>R86TWA0DU]@9T;>]fZ6.PH&?J^(KAWMJ#@QKgWP[0aPNYX0)5ae[(SfIXP-&e2
7I&P7B#5?(=&fb0&6&DC?Z[_\U2E<1;=\]S.B59+@Ce0+3T)eH&L?];IbL8D+Q9W
J+Cc7<a_7AbEMDa>Ub7))&#;CHD0D[@+UP><L:37gWeV@Qf<4C9P5UY]\-_88J/J
?._9<b2K6G(Q(H2OIU2C9=<5GU&@(,19_?#-P\@S@eeG,DN4&9-1C^(-/@[&89QW
FG9Y40+_ZU0Z,7C<aMZ9_\VA-WI:V+II47C5]4OBU)W//0f^CGKBO+O<H[PT9B:5
:;NX]<fQ,Y/CQY<H-)eQ:.M0a24[f7faM<=81&0LI;g)@:6VPEMNAVMCF@bFBLb<
Z]U1C>)0RX@W9:2WN+J^I3OfXN(5Y/fQR:,B^D09d?)2TaXBQT8eF0^cRXX:1-8I
SR\TOLIT#OCDJ35?_ACY1>(B)_BEf34AU0-)0EEKNbAJK#^,-KGIP_L?/e(^N1.A
M.<>5+W31(&ZDMZ_3a-QFNW<_<K2XQ3Q/.#193GLGC>Z]YgX+gER,O7TUN&a_87J
\OY.=0E?RVAEJNadcS<f[H,&@/#cgY:c7<ST1</9:UQ(P23:/4<Z/0QPK5EYPG,[
H0:a32WZgI.@4,W4YP>1Z/H#FK+U(JNeYaGd-2Fb<[0:W^V]^F>ALe:Z3FUa@]]>
+c98Ub;=>7IMFbG9OYJBT7L7MU&MT_;V9#EH,[0^-/\;?;+A.8#N@b]>V2H-D1CR
EF\6(9NA?,4.AO2:A)OT=?D:-.fI\Y/HS)CP#]bA#?3.Y=6:_K(?APfNb^?.;I__
0VW0;,f7\Hc,c<GR.41L<VXVCCO.?F7Uf=33D[0bNGXU(XLRd2XeZ7JDWK\g6AfJ
K1c[bG)[73KD(=>HBR_#/I34;W1)GBIQJ-UP>A3R_(FfF2TN?YS7NSg50)6eRLS_
+I@I4(;R_gU<.0PO2bOBZP1]5LVRV\4B6Z7-R,#dg-XTf]8(B;Ya/>B\>63VPONP
.ZS\J7.\^VWaTBI/DAMHV1?=NM)2TS?EN[\@g7(=I0ZRg[Ra>WV;_K=/0)NK=T=c
AQFRAb?e@W6.=J_cNbca-:PB;#A9#>FXD<ca97MbWBF#;#35J;gLHM.DBg288V40
X]U)4KD#O>Q]O6=[V:K<D#9=a1C#(L@:ZN3F>([A0HX9bA?;LbR\LFH(#ZB],QJI
g8S-(3K;F?:UYe\A6f5?If#.Ma-THV6eX>FT<#1A828HJbI)dc1^9/\50SV?d<EY
S/Z8<2?7A@>b.?Z-P43c?XJSU?5GUSS#N;,6:5^SKE;E7LH0eFgJEL,.;X31N<GO
Bg1+A2#aJ:3\7Z/F2G+6]a&/aFTT_]FGV9X_P^BCEY/:IBaPKWI=#L(U+.L5_E6,
5R4a,L^&Qg6g)5<STP+JS&CZFVLG.(3^_UITWA/KN-d_&=&.cH>1D)F\7U45P96E
7ZJDY-_IS87J]Og.C8Y/O4Q2BZKPU,+1\.706?7TDbO>aLVgU]3/R?1)W3ZIE6g8
VQ,1\>2=3TW8,(<Ha-</gGgfBf7C).3^@@PWWH@d.JKO;G-4<3PYCMP>0JHECE6?
7>[7M:7T<N-^>8IOF\F>4]1T/GL-Ab]?>daW+MEZY,/3^6)ZZE96:WI#]4EJ\RMK
.#NDeYO.TA(^.QU&+O0V#<f>_b;f<APX>cI&B7@R#[;dLA07bb5C;&E]TP+DG3f<
VQdGTBf@A6<X1c\.7XgN]QEF^N33f+dKWMF&+7)\]3@M;-AL1&GG_a+,M6]-HQK]
+Kf]O&0#d1P;THBeYQ+6Ad]O:,.T0M7X7QM&EbF;8Pb2\V5]VPH-ObC(\+7ScU=f
IAcF0@;K?9P(2(907ITZ2OT6T(/:55<@P1FEc2VQ1E9c6F&9DWGM&H[eb:--&4I_
<?Wf]RLF7\=W/eAebFZP:FI8FWL1G?gFQXCXX?5g2?V<+^OYLWT&+b#RBCc8JfI]
f.=IWK4bSeY5[@d?6.+DQ=)QX0[e4QL<ZeE8+9aM,K@CRedS)=ZH4K4GA;/WPMD1
O\I)S3:-69Z&g[L.;(4R,1H_5X]?]Z-1\[<G\7QDK-X5+\.&f.].\3K/_-M&)ZFP
)><A+FIF8=3J0+K-^S2Fe(AC/D>5e@6HVG:M.YY2F6LRS]I:V@3_Z0/3gS,<6LU@
#<5a-ZFFC97>1&dMN^fC6RVE)-P<^][TgV:-E7NU>b5^S^\f23d]gD<7B3BDW@/Y
RLAE_d-g<A1[2IOY2/.UUbJG56MD^VK5<6KHf8=e=IZ#T<O4e@R/:+:QFNLEH.P#
WMEP,,5EHaC^XIPcD<_-e;B\5=OI+XU2)9Z\WKf#P?=aR]9:.W[XL/:3cWdV6,B/
b@=_&M91:=8^9B:7)AW7d]ME[3JJP@Hfc,_#(G,_44CZDPQ:NDbP#=4@-IgJb5>(
De4K)e(1VRJ1b6Y/7/M;5aD36&0XSe[&.R9MCIO\=CQE_ZL(f)+K7-dJ^0A+)/^/
Tc@4FLZAU@+GT8E_32SbFeV(\[R1-(J#KBOM3Db;(4Z-WW_ZI#9+JAHRO[<KV@1G
-GAGV4)#?D+d<U-7I#91g+]N6_Y>?_J=cE_d-d2+,,4/_WC/+I5X2,WeC<KF2^0A
.()YMLd_aS;E3C;A=2:S+.^a/F9CKe.356(a5-HD^N1M_H;S7F[+/9&eAL1Y(\XO
X\;?HWNfH<TGX2N87N,eg]KC[[E4;L;@]f[ZaO)D#U@Z1TS:)U]b,D+^f]K=)=/L
.10\U/H42W]SI_.e340e4G9eU8PMR74B;C]X9-RLCO[a:72V.a44;2XATC:<XdbB
:H5T>.E#^D=TL7Zg3,/\/#N<+N4(FFWB?66SGK^;\-PX2Y82U#1)(^a<5eO](9(1
4X7,:T(N7Ta^.cTB:2B-OAT]RRd[H5-BSa.TO>@<S:H-D_cSE,^#:[RSRCP&)F)_
aN1cd6O#+(CK<=,OA@QU-&Kf-H<GVZSSSX7RB)G.RcLHe1F_\^VLf2BL.:Y_3FQ#
b1J?,Le?>aQM.b+,D?O#EMEb&C08R9CG:H#UC7f=GfK;38+VPXAL1&=46,C):A@O
J<E\c^QQQSRU+UIQ43eC(W5J[^]5+N8e\9eB821[++B8F7@+6)R)78c)PP>cMg5E
eQR0PE#FbbSHa6NFF(A6.I1;::3BPZW>1NRFHJXJG2)eM<HWP?LF(YL0OgR)-6?/
>CQCf)X[760A(\Yf:M_6J+>Y9IIA.^&L7b3c7PC[bYfULC+?KH5Kf/D<_RDb2_cZ
C.XW1#,a:SPe_U2H+LA/N><ND7Hc[Rb8^ZMYIN8fgSgN7,e2T:Z-NR-g6\7>X3LC
0N3<,,5VZH[<eg3f>6SGE-fa&B0?g\V@70b1;YeP1ELXE1/OP^-1)YP^7YBAH9KR
>5JE^6@[)7DeP9W08N0G]1F[^LK4,RUSgP/NcOIfYU9QdMQG>4Z26BLF&)R4X5YA
\)R3)Q54DU\\5:+85UP/=>46E8JHW/=[LYb7Cg=0Ff?^Vb#.T[;O:F3?+.d_\3TY
cONUUU@M\_F<_[RaP&WATX/[XLMGR-;^=+>Y&O=@0U@.X85:?#L1Z@<?[(><9\9T
(0DQBMb6+6#?A06E-1(@QU6-FBN_4(CcD=DCL5&R+T;JXf/Me&fIE&#[600.K=:7
^^I-7Z[=eH&YN8IISOaV3=/>-VCFbQMWa79OPR66_G[4LdEc6&I(T?5W4:H:V#@9
>2B]SddE&HCd2Z;([/&dY.g>UGVBL@egTCSM8cNA:2R_[J<PaUc_aT3VEaK]0)I1
^HMeOI5:0<@<Da^I<IAgAe#^EC65b;K&V1f1g=_QE)D_cGMI[68[.RKdAOS(8dBS
0-^81#OQ>fb.2a8^1TKQdYTcZ7.P(MB,@ESB9OH)N27874Y\EOf=-)Ie?75(_0Cb
B,MZ9-&=-V/\[&5QSObXT,H:Agc;S<5LG#[ZAY+MHR;e.&D[E-(d0LV[-[48gOcD
+UE-7_>IfDe5Q<P69[X\,1@VXJIVLbbUe7,,4;]J6872d8VA,cA&499>1.ReR.1<
PRXd-?E\&5C]P=ELbJM0#1@7^6b#GPfXUGBVZ>6;@bef13WIH/7A?/aLO71.(MGg
^&<LR@6Y&_C&]-?+(V2:[C8^<20c[dC4HIF3[RKA7@Oe3YaE?dcE^16K@&-7F1/T
L[UL>>BH.K)D)V@X#B#/f.=6NLN)WW0G3G)0O_HJaQTcX@(7;NA@eT-0#76,8V5A
7bg?IAMEVI&b#CVS(N<Q#28=-^ZYG[bERGQTdc+ZCA-_dTAUKVfV\VI5.P3;[N)I
O:[WC:AN\V/fFFIdDFTbL5f>9H2RDGGX#2<Vg9QQKcKS=P+S-6aD#V^X&#)OJW34
-_8]AI8;-.C7S_#(FO_aTTS3J?<GP9<22FUKHKCZ)RfTG,=gc6A4D-N9LgR0cM(Q
>C;bJR3(P<YGg.YQ<8N6K2C)]Z6S[=Q?0]0\cEOL0;YQZ=FWCWX0A\BJ(>=H6TI]
V7a5f1Q>G/Bd.+UbS2324..@ZXXOW7;ZgdTR=[G:]b_3Kc+#cXROcVXcCX)GSN\_
:USZ=7E_KSOO+YRd]BL81R)cOE^_1/_&cGDeS+Da4?V>LB/>U@YM6WN<JRN.UA1+
V2TMWYA)0b<A-E:4,C)27._:0M&#48GV6Tbfg?2XOF?.MaS6M]Z:H<@?7T0g#1c5
0PVd29O/5&c6?F=]LHJN<78ab46CQ[[+O.eK-,-JAaPEV+4_NYf7>M(Ag=]#C@g/
.C/&@LJ,.8ZXeEfX?&A7^#\=P86R@FN1fAa5+)KHM+I,7-TN-,5&UEI+=RB^SGQ(
F4+[9B/9f3890UP//JW>SH,#b<LLG9YT73#A#7\7f=D0S5S.?=CADWW,>)f^QH^(
Af,&M=?@PgRSF<e-6C8_ZX1<0e[-39/aG0/Gf8BS]G/]P>,&e?GdZRN:0<<0)bGU
9U6P6BDJ-EN[f\.0K/M+.Dg+M+2E;3=T9N\4](08d=4e5_N?e#H?D5ZQYPATJVR7
A@MY6:\U<4Q[W?&2]#:Z(KSa8E9F7e#H8HW9c#]dg&c;#.I=^Y>CW.KB/S=H;(>^
TSX7T4c])JN]?2gRE8IDQLaC@0<G0_.1?(fG/^cM1bbaIIe?7]P:OI)4WF+-F=d]
WZbJ^1-XZ.\6R5V-IPN0eRF8Z28>ebO\T(1f7d>LU8UM2[767A6D?\Tc3=PQ_2G,
MD;O<VK?db#[[KOcZ.g1C5ZH5=CFUe@,T3Xe;eS6VCE=H<UL+WgZ^N&.M3;-f9&]
9Z5>,NQT[1Q7G#N,?N^^DT4VQO0:YC@63-SV@(f>=6/#Wdd^TR/@-dGCCKY9-G0E
<,1,\V.a->P#IYd6@JE;T1WQY1A_7cW(U_d_^9=H.G<Nd-O;Z5B=+6P5K-.-&R;a
:+R;NE)MfFKO4FQ1Y9Y8@Eg<\5.0HCO,Qee/0/Vf\E7aO7-OgHf6R;8g([Z/MB=]
.B4FI;66W)HIHLWN,2b<c;.VQ07_HcE@RO]+XL4e^W&BDH?&0:;J1<<8MGG7K?KV
3K,PX,2TJQQe?+ISTe,+VW=g#<I9#[)T=8K)MG\2gBQaR)g+48H4[1CA^P,TX]ad
GW#=J<74.BJBb-<g_9MQ)?XSE;VE9L\UR^]:f+KfIXQ/d=UAY6KWKR:C_Y&JM:S9
5]1a:RL_\^IP(^X>aP6B32aVS^K=eT60:L[Zb&-BZCXVL&;47J_[L[F/PG:fdOS3
7YLa?IJG)V2K5;B(4L\6#]0\9<0X-g?=1:VK8/&e_0YT/Igb>?E\cXAW,DTM><D4
M8AM:NXMSbfS[0;-eWCZ4]=D8RYYQ7=VMEU;SdU^g-RQ-\O->Z?X^K9E]5[2O6D6
[90F]E#NF-62V_T]&3UVTb>+AD#G3Q7U8S5__?3Q=5/PN@L+]I3M7.a@02.Z7,<6
MVA.M/80@I3M&6dNTMT//MXJBeMPU9>a?3DcY[_c#HACbGPCJ99g5g5Zd<1-8eLB
H?Z1BEV/a>ba(=F5/Z7H)FMU#>.c[.,Wa_=X[\40f2dC+_0)4E:7,9U,CZdc^V;R
:E4#f[f797(.UA4d]?O(YgFc=P>3HY4J17.3#b)Qa1X,cJObgVg=4Cg(;d38QYH8
L;HTMIf1[)=^^/H#P#-3^3eJBIG;T=MG(CbC.;a@0]/H\OY)V<\Q<FfV48N7:59:
7T\Q>\ZC#UIKK0VJ_1CKPK:,>42D]&bfTYHK-:\+@#G\T@.>MI2@RZJYKYPDAV)W
0O?dBbT^S&<3c0T.TE63B@e=Y-52T9/TG^D3W00R5@U>;G1-CNU:EIf^W+PTA;aF
T;[92.YfK,:XA&[6JHEJ&XIG6NP<RK0b[@efAK7##BaP@T,bA8RD]V^6^P.QLX=5
@?.LM5b@C1D68gd5?SZdf+X3fP9QF\+BEPY(Ufa.<SEK:;P6Y)TDUL1?[fdU<\Hd
=;&?&IcSeDM?08[IJTDdVG.],)O5>GXL0HA)>LK/9,:cC?J633.+dHd.M&:>c3gD
gJVD7QC87TY5JC.?37UJRf@:4#P/b-dfAV,-+@>VOX(7R,0HPbZbUW:G_LRJT#@&
[<[9S:S@TTL<J7Q&)A/83I_37OfdD/1gZBG:N494U<3U^9P,d^6R[L/?E9>F57RM
=YHV\LDZ.?[b;R<G;3@LaT:b#85DX0aZaBZeWSO=H.FHI&N4Kc#C?gJN+G9Q3^DL
(]/Vgf[]?8L\17g.[E^egX#e[I/MQ>)#JBfGF_U,]S1HWB]P?@PD4Bf;\_]4QVK<
?RPgDIe]Sb)X=Y:XO=@]^LQ\F+aYd^&0=F2SPR+P<W>\(6>@Y;g(8b#,6UNFHP3>
,LR/3]R/;0cY3\>&IP\F4ReXCcW\>I..6A/(;>]U#ME=b;6MOO84:.Z\aQL.7&Y(
(6fF&_-WBA6\f4UI05,JAEe7(MD5NOCC_Abc#4IS1TQC,g#7-KHa<J7-348,V\D<
V_SC58#K?PFN5V>./VQN\1T6:HB6T[[[Of/EN3HRYC/^C=S),aK]3W.&IIKQ2d:Y
(60N2N>7N?d,:a^8SA[7ACYNdH#C(g_-.aAX/AI-.0-\B+:#C:9[Tb]Ia?Y6cZQ;
)[d1S31R(S;^K[1_-(ZOVN3_gFPR<70SGXLCM2O?c^FaE-W5gX@^gAd.[J\\^1XD
e=aPW(;@cY;a(PDLV^JQeA9ZOV<?)cge]SA4b8c28WMJT3@.MOU0Y+GPXe,AgOC6
?;^&7]@JWYR.4PBZ;^X.&?#.d&@42HcWIA\D\]gLF_V&X^K-/2]/=eb.=dB>ADPW
+VVgbL8=P5I7/12SO,23L9F4XPK:ZD<Q<>dW6QFO1D<HM>)b:HZ+LXB<Q99MS/fP
c(F>?]](ZQU/+#;Y5=Ad[;=O:+54)H@&.7[A8N0W/1REC5[fa=;77e-;XJBF#gE&
1.],Z,2WA[O/9&YLJ>Q@01ZN,8N07OC1H<+ILabIBFJ<0H>6WUV>\I4Y864UXVSc
8V8SdIDGXNUFB#3X&V4N_.6UBZS8b5I)^#F#3<FYgXD7[IQ^.(9L?6[d4JC?4X/>
)?&7<3ONG?55=GH5R)WCK6e/#7)>W2..N^AGVY<);BQ)=JQNA2MS4VeS-)].\2:G
g0.@IE\UC<I6/;=8Q6#LRb^>K-23+5YPJ:Y6T5\b8<a\D[Q0Q8gSN?aX14,04I0P
SC7VR-A4XfL,a2_c.=4P[K)8.edSZ288NA6+3@U7c3A8CH_b<>)90fZ-SEZ;;ZO7
0I9O5g;:f)]MP<Z0#L,/TRSXTH\=b5)W>\2=C+VUg=_cg;M)g#5a/>,;5e1CUO2L
N@S7<\a/.)U/K-eeV/F#UaV/F-\P9f8(3R#e5,f>PWK(5T)OEBEL/V.SX]MCZ0c,
KM;^?SV/\7^843.)C_#/TaR[OdgcT5(TMII.P\^GeL8A^(HKIa4=5-4FK>KJ)TC2
d-QK5VYO--CU^S^_a=4>_\4VO;g1cO0M^]_@Q+2C&-:gK4G916KdY([-PLON7RCg
V=TOVE<FW?b_X,8H#+0].>3OZgO;=e-]FD/+08@9cP>#]0G<\6XLY);P6<^C8g;,
AJ_]ODHdN.>9bGa#F:D9@:.LAcDC0?Y5/(\g:gI?P40EGW[,V&HU&9MMMLa+F/)Y
GW?6A#OD4WX4&57SfM<DV1.1:3YgG3d,_b.2E-bgE\:0#]R-F@0P30[0,?RLT<V9
2aA7\0g:#Y,SM(G#Y)ZXBQ,K2YKd&2@Q\QCE#5[bH=W<0XI+0T[2eQ0#DfdHZXEP
WcYOEC=O,^PVf,H0#gQI1e0IW6[+3O]FU\AODdOGWY4_FdME^#K@A?E<d>L96,3;
:KJ=Ib7#T2?;Y?3gc=b&).[EHJc:.X,c/b>E?6L:BPObZ2T:AAdZG6E-,c]QG(S@
<3=EQQK1FUFLIP-U/Z>9#:(6e&4YQ(DXcTR1GJeK&bL4L_[WaUbN5/.><IWW7AC(
_(cIa_6\01U7/5PT5B=<_-M5Fe-]A2IS6[f&7&7+<FVT3@2J^I[X/,V[/RXSCMH?
-IeJC6dg?[b]]-01V^,,U.(^,We?Y4<\L>8Z6F0W4C_bY.ZDWd+FSZ=;_FD]I#Ge
/TNDI8.@QMc2@8+N(7dQPF9,IJZOKD=MEDdW1L>C1)JL.Ne,^B+R0E>X\F.MQZD)
8QA\b)DS1UCH<XNX#e=b^W_Xe.(O6@-K)YaL/QO_f:<QDI/g/71GL4ca\_S?8)72
eZZ4<c+//a]B=;<O5GQ3cA8]Y2e(?PN5[UIV5O]&@IFH7,J^\DdUM=KNZDCE_b.X
>6R3:E4KfE]=aE2N7/G#&+MS7;+bbCb3KVVHKS.5B4C#bI@f@cR4DMSB_6&@AF@W
>5_RC;edb+:WJJd.-=3)MEAI([UUFb6_X^?\,;U+c^O<)Ce-E#V#,f\_f&I\d9[2
_P.F^8XXY;a_1d\\O+,1;8ZIGXa45?Z=QQ[B5^gOd1:J.Y5ZAJgaZa7MJF?WA)Tc
bg6R)[5DagCY9Y+I4?+dM/PF30CGN5\:?gUG\\:d256]4F.3N].[-/57&0Yfb+dP
1Z+M-Ic9\_=RdPc=[.Y_,L6S45]bH:]YGNSIN]6U]CZMVVR]9Ld1K?ERX=SIga;^
a-FG>;:4290UQFTE\W&IM.2//HJ1YeF91\\bR\4ag6@F0g?fY3-;JMB-@PHKE)/N
BYHNI;3A_O##@,^6+FY/,F#^RbGX<^XA=R\B6JK-H+dRDL3>3TSKUOEJY8&2,@62
06NIb:6S,FFXTeJ00NR3)ff;ePF4(PX.);-1]D@Ba78KV0C(S=ESR(37>QTYN[L0
<WXFLCeZMN-,[8+6[-@SbO9EeQN][FQVQ52,M-9X:1LYbC]@GYca47X[J3]ZCKB2
#dW)e3OINNJS^b:3\.Y>HScHMNAD9ZLW6>c,c0+UTX^-+bTCFeD3[?:.JfEX6QTL
gG7I.BP+d[XKM[/,7@L.ZaE>A?4+8I5de/eg:+8@M:^K4I3O=0?WLPB_,K3cYT0Z
]&JSQTZ)U1KG&4+KQa)KZY4TEGbN#G.c7@01fTDW;1eL/CT0JcM.La#D0cWMeeXS
0;>4:F+&)JP4T4OKb]9V,I95]?JZb2A#IPJ1c>-H[9I_UD[:+_ES22&8KL1_OU8G
,gTaC2X+4J>E03VM[CDC_S,(dTH5FU4P[N(K/Rf6bdFdTV7CI9OTcFLNZJHP(;LL
LZJ#<G9R^AL4]f6=RZ8EKHb#KU0Xd@IA9Q;X==+M3<LL@749Q\\W=9DSGMVXPH0;
fcLMH;;^KbgB=YHfGC)OOORCbd:1M5.(^;O)XP.#dfa[d?0\\,#ggYSEW+9SD+JF
PL&YX:&5Mf8D8.aeGQ][Xe5c=A#Ce<A:YYaPd>M[/7#bQbaHK4KLR8=f@D7V^PRS
/5f;=BU(WXfV=>KCGMVe^0[PbO,YA./4TccU<0V]OJOR-XOZHC4bbJE12#DZPeNF
].(?,g4-8WT=<;cZdV/ZXI@-@VGR<##G#[Zg75L:I>+8X38<K<O;YQ8^UNCHBA;U
O_ITPJ(VUcDP>d[gR3G6P1H-7PB,P^/)X[M&D6;^(f3&59;b08S9V?VGIQU,.C=8
8#H/+XA/gNIW0?>4-6C>Q37U.DPW+NA8A7UX5@^:([KSgHgNPJCT[N?:)-ISEDaA
/c=a>)V0SJfAMN5/[VW??=BQ@[,AE=7/EB_^^H4>\NGR[15L8..@0YAN,9PH83F&
;-RJf8#ALTP/OERcf8deZTC>CZ,[OH9FbBU35EDVV[OX<Ce1-.G>FWEf=8\;JZ\X
YK3Q=Y2Ja@L:TE_C=?+Z89aK@^Qb;.Va3/M<,KUZ5G:FFbH9M3AddEGGSf\#6<DB
3@\B6Ec/5?X[ZfN=K[4fAba5,LG4X[V>0c28T/4GU=\V7O;&?U+6=(0G0&5bU(F4
B#+K3?K[+MP=]Gf?2(b?H,PW#U1+f1R3@#8aMJIE^XZG>WLZB3Pe.B)E<0<=0a9=
?]M.MEfHO:=E.C.@[RG6RgA)?CEg:+&^OGO<AeSe?6>RKDE^3MY]O<EI+4W=:6:T
627CR#1](>VXfY&SCBD#X_&-(A5I[O3.2@XO\)=+J@,DPJ/]Z?eb_Ef6S>015dVB
E.[TG0UMFS14MYf^]Q@7DB=/F#91^-?XW=BYCM1-5M2J3[^]Q1N,>)I/AG<O17]E
R[:@[Z1OdAJR)Oa:FGW&G:/U#EEV,?C2G5)2KH8<\X-KbB8Ve.EQ96(Lbg.:^B==
64//SG+SD0TLdY,QMceg^;^@9@G0DRM+<:PIKK>Lf31eBeJUSP#3H,E1?X9DXHZG
10d6fFMVP-TV_(,aOTd;cMJN)N^d/GGB;(CT1RA?MR,+Sb)3EgHN+>b/>3TRO^HC
ca=Q_YW[M5XRO4=Z?92N,7\@dJ8D0Y3CMU<fCgZF-T\KJ:^_c3/f,Y-5K-6a3,IY
&W>>EO0V4Ddf0SgGXAEe@6UW.PLW1YZDQ<TUMQ;/2^9-Z@.Z=DK<9UIC8P@CHJfN
DY[aE<J:RE/5A]#0<&N-IgXb,_PE9+Fdb7U>fS<133)=B,CXHB8ba?3#CG#<2bY/
R5UWL1Q>aOGW,DRY3(Bf+\I8R_RB;UM&(;g6)H-ZRDeD3#d=Y0]4/L_a5,>7VNCg
]K0:AbS[b_-1/eNO@R2BB<]V;[\:&I49d:.B21^f+-/,7,3c_[246UP&QWBI7?<d
\+6FUKZfdJQcC.JT4gC.;OM2I4]QHQHG<2deeJ,NDGCRe5][-X^3XXe)V=IRHg_M
c2MOYX]GJ=4A(d87C.(CCc<QX<8)d7EdA@K2QWIRM@)T&.8DV_VC(OW=&a=Z?Z7/
AHK^3([G)a;W^aV1[SRE>>\_NS6Z47B[&0Z59R9BOSE2?W3@)^bA-&94Fb+A>A_=
@WF9=:.MgZfNA7gdS,CL/g=]?Wd(6H>Fc,2BZZO0]^PYP=DV(1KI9/--C]?I)JWJ
XbJG)#=V[&Z_=aCYDAF80]GEG)^1IZS;\C,>YA<:=<70->;Jg(:V^+[AY_=2Q4#L
?QS8S.eg=g-PCS,dPQ+#TdFND/(2ZWE^:JHf>KT,+S\&ND4I,=UfTd_XVLO+;JeW
QZ.fe@cDc6a_>[Wa4g4g<&\1MK;eG#<Y-#5GE&3Z1TZB/LZ1eW#]fF)AAHWX?C6T
OV9;+c&<K;<e8],>Y:fD>gJ1=0#f^625EgA[e@7A&H&:A(9XETe-_224;E:-4RcC
(CJ+CE&+HQVU44M?]9&E]C84g8O)Ze?F4g,7I_K=Xa&;;/H0WEb#9V>Y-@HS&_f.
aFcQ()VKK^I\G;;D6HeW/4Z2(,Z#9Tb/e#c(L=18DZ.1H)M7EdW3^:Y/G<4=cJ:H
gX-fRK[E6?KP)WVGF&;P(d;=8KW/f)R<)^YN7R>1_Nf9WVf;L)Of,H8H1YQS,gO>
G@S=:^<E]T&B/&c7TgC-A&VRO3X)&2CL(F?RKVK]g3X>/#Z\#/IYMcX8ReRM\A9.
@GF;#:PcaR_OV2DgAK0-E.#Fe1,?UNb.]S,;/V/ZJ9fK2+>6236UROf;+1S)G2SC
EJ5A=;=Ha(:cJ?>LKJOR2E@TC/7F<2VfHG.&G/S4@C4MGL_edPM5<3cgU(1)ZgTa
PeETA<f.2B6YBb:2:UEU;&=R:?;(?;O[R,P,FCL7?bLDg&e@CdKZAV<PZE&W[XO.
Eb70Jb3+Ug]:BTeWYc8>A7WS0F-^/[I]RTaLF:T),HMI[XDP=5Y7GO/O:GWSN^.g
Q-?1^gf0FW^bFA,F:Qba(NQg[aWP[9+/@6[/YAafd9WSN8F/U.MS^=M]J:MC6Jd/
0cE][6?;6ILA=M+HQP_=PA:g]FH]C[<#_/W<f6(.S,S:cgP9(XG-_#.H,-8\NPf7
EVRKTO]&0\?5E=:1C<a(GP9^3(HaQ4F5>O0M=(QOdg@VgWNGag4Q)Z68GbUE:G):
TJ;WGR&CLD#Ed#=M9--?bT94+RUZg?bZ#&SX&-RU,AJ>KB0BC:NA-]FO;+2:T;Da
0VVAM_4A:&#e8+9Hb/PNc7L8?d8dgF/dC<fHb<DF2eUf[]((6Qfb;SKK@KB^D9Qe
_[(XUOdQN+C)N>K56G5()KOOWT(TKE@)gM0?5GeXgNfEf;aeE4@?Z4==R3U]>Mbg
d>PD/+YaW?1D&X;<S]^)_3gF;;N@&=Vb:NSa-7a\>7,bJENedB:3QF^c&HT<G.+M
g0c5)1XOe]^8,>@E)g1WT8^^c4g66;#fGWa/&HMHC?@MM)>Ba)LgeX_0BB-VF.<,
&QDNO;E.>0Na1A2M1F/&&cDaE\dFN4cF+H3X[I\RdTTS<ROJ@825ACT@8@aDa1@)
ZbMG8)6^5YaFTPMBeXS#I0HV_/86[cEd\Of/5bFaF#.d,Y[TY8>]=81X_EQ&;RXI
;HL6R\@PfTW7WVdDfYGUQ[6KNB\=7E3\\cOAe)DaSd8D;b;Z+M]=__JI#UISK7JV
^13@G^J#3.eB8+,8@&GO>RbWTLe)BQPbc,4&?,cfgbOdPCWPI^>_b6M3GdEQY>SW
2U#E7EMG,9@(,D?=P;RABDD5&@^;d_>=,M[&>e?A=.TW];]E4bVF#aB>>/ULdH?=
;A/HY0<66358X3@[Ec^fNQ)2/#@__P2bNZN]ZYB9KR6^Ze@DVV1K2.+VAGAY41K?
E5KcG@ALP^90GfUK(&4^.A?VB3H^OE_X6]&_)0HLF/eAf/c,J/RSK,F8PEYb#,YE
1T_SP^b@[UPCT/PF#R0ZgN2QQTJ\A(O;VF2J1P1I[-V]Yg_L1M>LK+BH4IbA.Q,W
>f:1GS[Xb9^RgBCTg7J.5f2EcQN1QGaCD0HTWW)4R5ObfG1Lg->PZTV2QJKRc6HZ
43X;;?HCA?a^=4O;1PM02M+S+)2g+T1:4JfCf=VD=6E;_BS8V4<IUJSVe\gfe>X[
[_Ea5@-HT_DUBDNTIQ.d1U.bN114>/d;fbYVCB=\SZ6eZNZR#e;+bXCbG;@OJ2T5
[<f1[(_@Y8aL7P;TEVCHA1S=dH]_d#)[I+NfWQ60e6.FY]0[Je\d.+9#UC9\N?0K
S:#eWAL6FNcf[+OP2(EeQWC2-:5XcT:D.=94<bS6e[B9[27+TUb+[B3eYLEQ)WK&
?eML0P(E:QgYSVKW/WN3cBcB.[[R78eIYgWW.g4N>W9W[a6WLX(1A^9TcF>7;,GA
E[UUU8^.-KdO3(N7=9RSGC1H#a_XCgLXWeW-4S6JB/Gc78_EF?Oc+dL>E?ESe57E
eH:M/<_GV&]91Fb(GV(=+M.&_0\c3Y#-<a<#TFL1NK?=6EU)W6:f(EP6J=A@71OB
=TQObDJK#Rab9<4385SL90AgfVg/QIM5B,/008=/#(TCPK7Wc2X_88@,NJF7[=(a
[d)PEYeU>PLIMG33JP.34EbX^,a]BH<fC7:,T:9V]:/g]/e(Pg3)gMGW=U6+4Te=
:_A8&EMWG+:_?O^2&>b(YcDR1-/)KH(/2OGa38,b_<9RfG0R^W(041d[D/+Vg57L
24V#AB/eL4SI0f0DY(SDO-c0cSVN]E&^3CUW,0+/a(R1C?Y@GI:]UFB@PG60Kd5#
EK=+3E?TI<@WTDB5XD:80VQ-T-I^I?N[E9JW:AN]4G8@FKL/BaS<^=2L4WL0.V98
?JfLg49>G;B.3=9Z;He80SPE.A6HD.OUMaN<#gYN8/cN(SYU1KXgKQ&HB6R4IC_6
gY-<SafL)(VGeK>E:0RNWSZ[S(Q+ZAgcZ15A+AY?f^)@^G]9=K9PG@Y6dc6+g<MA
16bTae;;N3.L.-,.J88Jc/@;_,E]CB<(D@LCB(9367-5+V1YEbb+Mg=6]7UG7=Q^
PJKH<TfD:1ZF/O]d(H?SKBW7W+WP,b_U=N6Z]Hge.]c<&7O.E30LE)?c(&dN.Y^g
F/?IQFD1?Z4-R.WT#22\CS3.8g8RPc+H>7#f_&AVF#c;GJ8cf]Q[SMPIT(HV6Vf+
H0))2;,T64/]fP)bOJK]P]3\geN<LVJQ@Z.(2cQ+21>7QagDcL4H^0G@@,NQY(-2
P/01dM>O,[0J(HaG8I^EHT@E_;SB=DD0d<)J/>&.R/87/GaW,f/IaUYD@b/9X6cB
18_GZF#GW[74V^9J?3:R-?V#NGAU0D-4K8D85GG@^EBbK,GK;I(@91ME8SHD#V^N
aNFE/UIG04,ARWe@>8a.f6K4K3Z)N3.YTK9,5fUS(5Y;5R5\@Zf[+=aMaK:@5:T;
L^e5H\02G###e(W,(328If[,W8QB9)_3L7R)SVW,_JY<RN6IRZ#&CBWA:45ZK/A#
6IKQO<3^Mg8&R)MDA/_R1(#A96MZ6#@D)f+4H(R4+_Cb@B-Q394165+bI;]cKC1b
K)3]_2gA<=a94I<+A>702Z0[G]L7a[.1/H[QYX035(M7_9LQ/=XVH1g,G,E0-D_H
<Zf#).G:;P-C^\W?G\gg#cTN/(d-&:?S425/aL;NT=d3UJEd9a<[S9TSEOZe#8E/
_eeSUaZS^.G,JcJK?P^.D267^8,ZE7P7&8E>=N9QKagJB,@_@I36S;4dV,-1RUT.
.LUQ@Td+\Fcd9Y2;,:d-G)+U/_4_I_a:G5Be\0@FfaUOJ^8FUK[Mc5_QEd+O(O?#
+d#&A?_M@.3;IeV_WK57YLWZe&&I7(+I1(9IDD8&0DB&Da@;cLcODKZ;:/=_5-B=
MW,Zb:Hb?)HPS4.]OF>HU-N1Wb/Dcf.7<0-Y]Yb-.4YJ?TMb3HWL]@0C9_#WQf8M
;(d^bWX<DX^K=N.ISZW8-XC8^^WfcJ-:QV#11(8b36^YP0PUCI+c3[LZ5PWI)cOF
8;0OcB2B]..1ZZ66EE\F4cMPYb;EN:9OY_bAAK7A8VfYd]0><(#.UMaC(UF5W:LK
3=\)(0I+L[T41G4b(6CHd-IL[4\4INTK,-F8PX\W5>-47(OO16[Y;:F_d5#b@.?c
>ZTc>B#cQ=O)Gc+WAW8^W[=2BSaV<:K7f:X7=\JJe]_V&B]&c_+2I6=UC3RCG:O7
?b8ca_^X,7&c04AS0Z/+X=OD^-T[-@HJ&.LK8@(1ZFH^b3MJTe)g4Uc&EX71cdD#
OJQaZ_[_/:cbfJNP/7@?3cJaG.LgD,Z6H-F)fNW(#aTBQ<(>TAe9c?_M:Ke@ANO]
RP(TH@(fb:?.8(L@-_M,N;</?1(D^]ggG)U2O6Y^M7IHUcbZcHA9<G=,Oa<9VJ:b
5.E@=L#S0^)L&TB5=X4>AHU31_[V60);ZJ\Rd,eJd_3IN8MQIJ;:\cCNf4-7G@&.
A@_cM9/K:T+f7:[cW.?[>J-RcPD=gB(\](0ES=^X_H?a+E?;I&IdL@K)Y,g_[13G
7K]ZWJ]#bD,5NT]1<-aTH7I^KI_>JPD-PaB^DT7LbMf^b[YMJVNQ?<W<[X.<3<HD
3HG4^<?SL5YL[GL0:Sd9gDL(-KbHZ0-cN^PD5/O-,1Z22J-ReK+cK@;bfc7a]Ne.
JT@,YSN8DX/[f3aH9ND[cHU3L&4.,X/X_RD>6)DVM4<.]CSE:GE_70([;-RcSLOJ
IQ8#R5K8->0E>?C^-UHH,D:L4Yb4SK4D122OcgdXG\bd0&Y6N73^P[.V(D=a&M>#
O8=/E&G1b]0N-c7,\\>Qe(d@#HA-.YR7VG[UI[1e:\>0(_FL>-S3W?R\3Re^/0gd
aG]KdEXMYb0H/@<=:0>b)S__=#O(\,82O7[aKUND@Fg;&#]g\H:b=&U5>X:CUMb=
WML#f_S:YN[7e3]e)f6)f@^dQ^TCO^1IRG[/-Z,HUbZBFLLP(OT)(64\?#GH,R(L
WVWI3[V#VCc2.d(M)_DRXA#4CeDN9&^Sd)Z:NH9FC?46O^CJ6^H\_C@4eP_#TTP9
V1I9X4=U[01(ad615FMFR9&=A;R@MHR#@1P7c]e[-J,e-2F0S=7R=X^JYR-VC0a_
3VZZL^gI>X54fYE9ZRE,;FC(HN_afDC.)5_XCEI<&6cMANFF9-C,<[W-Z>./6.EQ
^A_@[[VCMa5^<fb=RdFC?-=?IZ8:0(_9Hf&Q@EY5:&B(_E,BM^0_c0g#UHW:(\42
XLF&bL7/Y_5UXfG0?U4d_VILVVF^3Y7M_-gAW4+_PK=+XVAYG4cE#a44H_M[(FKe
0cY.=:L>^1;K5@eT)3>23-g+9W4SRW+J(\e7ERP.KGfd0a:=H\([URf+XfH2;4D_
?+NPFP1=egX)-eAY5BZ<d=>]?ET\RD4gE)C8&EG#:fdW)4KG9<,;B-#Ea\R258TW
86]?/JZPf\8S_ANRWG;@ZZ-dJaLb[\S&GKI;dRB+I:OZ.@#1c:WaC2ZEO@7YIN1I
f1Z;7HY08)&K:eg/K;Gb)]^G&1I+C1UN(;KR4P^FcV.?e?>F_-/L8fTUNB(eRRcO
DG@B#DZ(Qb;(NAXY,CCI.3;fd\HcP-,V?K,Id]Hf,f6MI]]?43LT][\@#6\:ZXbU
gD,<_>d+E&GIa1b=R57(fM(A)V@8MAdV/C\KA#B9XZ1:GZFaR7Ka(@9L<)3#0DSe
bdIe&Rf8Cc7bdJ,_?_bOBVU/LDID&gK(bE)E1.;d5X@E0TX#:6DQ-__E]_@<bEUI
MX#_ZMC.g:1KQC>0V#S(R=2H_NE>.P.WCL.QNQY86g+Cg(N),^H3a@N/dCFe,HL-
WGVC^:XMCW=3R?^UbGGD==BPALDFb=50,+bK+.FUU?TPJe+e^68E_O4@+cNK-6f-
DO#APb(Z@0&AgcC?\2JL29=K<GZME/^6CS3D[@\<B.6_YT+Z;>&-6:O8@Ad0(C@;
-U=dA=3^CE9,,+^#DD1UG6._].cM-P>)]c04+U[J:<+-eEE\6G;^Gf/+Q#9?3J&c
Z/W.9abeR)3CL:F?X55VfK-0PWKNM;;IBA9].KN4(?(FXC=+2/UDg)A)]39NRc48
FVG34D/FNPIOC\?Be?A)Hg]VUZ0@1)/WIS2L-I9_AAQ7C&5\=5N:Z;b>_VdX^4V4
ENdYB(F:>W;#8^EM=Y9O^cTX6JZHVE/2T4MLM@REK:I6M?2(]:2T_fJ]EZC.G]4/
d.6,M;.S=PccAeCb?R5&)g2JB__J:2>.-4?WAgdE.VS<3VfH.L@)>20#a:1-dac0
agKcR/G^+=Nb&;AM7K^,(TG+)c3L/2/K6XY]R;_>YZ9.O>XGE/\6..UXX_,Z&4[O
;\d=50OfQ80G_ag7(GNfW7C^?c9,-NR\>eT57SZ?YG;;3@bcW)L75.C0g+S_&EM[
UVPX&Wc8+JQae<WaD=_Bb35K_/)0X]6gJ6;Y-:^=4:9)C-fL?cF+>UIZ7#+#K0HH
OdE8@2R<cb-:BZZ,TT&_gW#\R((Z([-ATb)49T^OR5JCZKeO6Tc)+RVHFFMb=8gR
Ic1=2N5b?^E8N0;d.=aJPL.SY;?DDTX>?80/N0(//E1d<#9Y7))EB1_Vd&?8]aMJ
T&V2DaNQOIc,AF:F<Q2;b-?a3[R.=D]RHLX6^1BTW8;30G&eBY8?Q/_^G@)3]A[A
4:)\Zg/.BMdEZY4Y+T7]ZPeEFg9>)@1RB7Ug#H/QYbaS36SR&KO/(OdC#f209aC.
VV-0V71d+;gK(UG@c0T&1g7TS2US\:f<IW-UZ8;GT.HDH6e8JIX(C/bMAPcFL]RF
VFHK+/\]#K\B,\/X:FLHHY-gXC;&8OD:6:5WY=Dc?4LAV\aL?FAM:9.:4\dZ472@
2>J:>A[^\4[WE)D#[\XG;dM_GY.UJA#fH(#G\bBV6Y6:_?f-[:1,)@_UPLC112R)
K_U/VUCa8(BL^VHQO3KR.77_G?0\W/N^#K,7>YGgV#2U,R.LI^,9]g,_(C;#H6Og
5J5e=#)CMOc6CS+_A8C5<g\]Eg]:ECFA9a&U)D,7B9:;:VH]4&bN3CR/;V(N]AR3
Ja4#IBV1>.OPS9]OWE#G\ca_\Cab\1EF#d?/Q>5PV<^6(.P8(AIVOZ-G0^:_FB8c
1-JAD1&7?._^STeTcZK16P830c#V_[W#X0L<J#+^@X#MC@LZO(Z>B&f.#TJJ8X?S
Y;_:f>aZ=?8BA^/55B;A_?d=25C-CMWJUBED3M31FIM85>5@f;c7O3C(2Q2&Tae&
/^S5,P#@VTaM]EaXFM?FCF-Tc8UIE+Ob4=M(a?(@;bW/_f=6RO&P@@3DWg-JJHXe
P<-?RUB6.?_\S2)A\E/6I9S<Ud^6TIW_VEgF-9bR/Xf49FYPQe],SLP=fQ46TCO\
VbBDc6)5P8]4,4b2?Z7(Y++(?WR;Y537GdY9/K=eI@DEAUb:\E\&+HYM;F2XP2?I
S_PMGRRK/Xc<[;OQ+e/I^7((@_?,EWbg1570Wf\JVBD4ITE?1>8X[5c,)C]_VO)5
3;-aFM\XBF2aS4W<KZJT5KM;2PE66#2.KFFCaQ/PcM<V,?6M[[?NB<gYP210V9T,
VdSAD3M2E_BQG\&,\JOQP+7Kb#BU/?/)9RaU7CMOFSZHF1.IgMRY?RW/#:NGM6D=
baXXXK:e7UZ/<J&CYCEe;L>WcU5WOF>K44^FFBO6N+O\Q/>40-?72<=GK2+fWEN,
W18-1&UMC_d9I\OI&1?/5YXX9(V\6UFRXPY0_MN@IW=>;N\4OUHHR[MXZKP[UHbN
d)HD=&T:,a@7PYD=;\0eH/eX=QA\,:4PN/WCWcO3>ILQ0YQ#A?RC65A4,Z9.FW[F
G(2@;R]&Q;EfYJ&I<D4^d,XfBF;(A;W_0b(W0#^XBTE;O3:6\Z_&>g9[UT>.:V58
8ZL5bPgL0H_a05F[9E5,fK>bI#F184R2eb:B]_L/c:-)W+Q9O(^66gG;d[Y</_\R
Z-32L^db^/MGDAa_<>,WbI[<-9_\5gAGbXW)+7?=Z=Y=NG/KcSeaQdI.[.=S(c4_
cXO@,aKZ&1Da3<9d;SDDTc1a6,[S(\1HgJ&&EH2<Zg8#SD/-;cbX:27M/cgL9N>Z
1/53JX]f[?I[)2fX1TaCGMPd#4H&H)00Wd7?@2I?\\=&WT-/Ec?\#D?_EFSZaIeP
c(B1>01T=7/<]1XH-<a3b<-KDWYc1K^9Qc.WX/FELd@K;59&;28;U>FBMcP>\YVW
;ZgI0dIHPKgH\2P)J?-E0J/Q].M]B>412>MFf1e^KL^_]TL4N(L@J0R_?[JC7)-G
=2WQ52\fG9<@)@QaNCUKO[KcfDC&OM\54<Oac:)=N60_f@PLdF(:;1Gb-OPC#F@1
g<EdK9W4IPUJeQW;N.7g2,898+dRJ_OF)XL8ZQ=gF##C0LZIfSgII=KKb[YDfMYa
cD4@:XGZ@8ccUCdCXeb]?<\FK5H@Ad)GTJSI0b]SJ1W4)HJbEUeGX0;1B:M6(SJF
a=N?Y[-@36c2(;PDY#bUgd].YDYY=TI=BfGJ8-5IA@3N[S/]=K+<_IVD[)3Qg)]0
B#TYW#\W<ABIN<T74E^<=G\8=HG=cd1B:_38:/A+VRXZFBKV=LUX7:=9@RG/_5/f
)\PT2((d[/:f5>aKAXY:Ig3>6+[2)7,(?;9@4-CNH29H9;VE_+g.:Y>g5?Z;@H+>
a\ZS(WKgACDR724GP7d)c?4gGc&W)@GDW8[WY?7<[>QEd27RPN;f2bHQ\S,TNcaX
3I=Pd[bBLO1D1.X17FPB8DAR6d.)Dc>fY)00)039F#e\XT1cfCVHC9/de#GPV0&U
T5/AX&WT@GI>T:bDQIX/K<Iec)e\#@W&d^bQ&J\X>;ZW]V7/=[;Nd)cTN=dbMWOJ
Y^-Y6.1gW-]APHHV-:egU^OTQSX>B1PL9/\+g_?QD1aA1,<;U)9.b&I[Q(7gWcK6
L?=f,\4137B?6=gcRA#5-MV>-84I5,H^b;IG_Q>XW^5)Ke:KcO[d\<N2[VZJL<BV
25H-25F(gZe+_d?SdYcXAW.HeM@;:gb?T<#Id/X=19_,^::EeIa?>R;/bEC1?MVG
eWP6=XPVW6N:M7:?4])I;KM>b@)O.(=C?d35?aD++LO\aZUP<QV8Q\7N0\)Cgc1#
[U/.M>.J,DR;XE(@cf9,GNTHYH;cW;TAV:<I0&b))RHJMW,^@5I0JSJP,4+gAa]3
T07K7SQXS?408L2<IM;B0(TB>;#=Z]U421c5G.9Qe0M[be^\a_N3-Td,dZZ<E:6/
F,,8a>Zd[AR1N_W&Y4f@_NI\2>3[(479#>5dgKb]HbHaQ;3Q3<-5&N01Y):Ig95T
f4.M.4(;#g/C]5aUD..PbN<E>SC\8.8L+[L\T0<FT(-0(U56^?=U9Xa)SV+O[HT9
#<e#A12D+bEY/GU[OG//=G[.?+a]]1^.N/R43@:9AKGQ+5OeTV#=J<MM=cCKBbdd
.01cNN2>-]U@XB(a.<c,FS<I\)a;ef@7gZU9D7YER#7IFD_.(@<J?Sg^G<@E-f/)
@bW5RZ):XO4;bY/L#E]MReZHIKXegYf^+QVDUdB0T0:A>+E[A-Mba<>9Ia<+0^B4
@5<7:5?L4>a=gM_TIQ9I8g(3J.BS=JHRUU-9:U=:DV2cC9M=&@\Uc2FW=)&EX5<^
T#_PF(DX@I/Q_VOd:---H4+BWCYAK@V;H<B\;4D))e)@983\(,=3C[PV^(?Wcg9G
,UfW5L:.1^B>2.(1(?f&P1R#c@T5QXf[F;/cf1Ea_,S5;?I4CdRR-?XPXXP>JCW[
S\bQ,)?FTc]dOUV.Oba=C<cO)c>RQD0XHWK?[b-)3&g.U^F,L:RLPODUc2=gg/7b
9d9g0S^@b--/,&@Q2A#c0)7F\,>Z>7EJ)Q?BSEfNF(--<N/C)-K.;H(:#^=e-FD5
9T]4==O42b4c1+U;>QLA@1C[91(J6#,RCbWOIL/TUN7gBgNcL[K3PJN8_P];Tb4^
-PH5:Q&S&_NW3\.6[V>4<5O@:Ud/PaCM^Y]g\13YRb#OaO55<T)V=NVgOE==-FX+
f]c4LJBY7)>89)RfGa752Zd1=M[M@)E-XA@RX#A3E[])Pf\\_3MC+&<;]\9NC/_.
\H>P1\SO:I.@-JDSOg8_E@4VZ<Y5cVZ.WE\\#,_N332WdUdDXWgA7,K6RL(;\^N6
TK8\+<dCfNIQ0ge:8\NDT6/E&fGF53bV(geb)R<F?Z=_;6GLC@_,I+NY/83eK&2>
UAF<7ecTe2+cQf-YS:OAFOKA9-DDQVC_GXaH<aY?-><.YJ<fB[(EbgfZ=RIO@<4#
\Q0#GYC]Y+8AUEc7(X>C4f(2@]ff.G:#HGf.TYeUO\N_E9\4?6)_<KbDce=A(TaP
;&^QVN3_YL9Md#TNF5T]D]B]Ce_G9P47F@Ad_d#1aMU#^]PJ-+P9/3C:fE.Hg&Y6
fY^5Ya6P72KTN@-OBWc@#7#_^53DcNU332;-@)@3>ZUG2]:R6UPRICN>;9Jb[,\L
L4GCf\Z-Q_6TXfD,UgRUB:>e4NKbYE2gbT,(I14G\X9,H<^-V9<M)f.gMDaCeZO?
:b9EV/OIfM^KOa2B?G\C8_Y<b\T8C_.UHO-ZY/1RVS><Uf\D(6=H#N\.c-EK8/5?
M&#/b;N2P(6=R/6MOCYC[5_aFCd(9=#?fA+>_I_#=<BL)EDK3\/I/A;G?ZF2d82G
FYDMPX)&2AJ\d[_U>cQ=]@d9<A-C+D@fP<d_L+__#;a?GLU9f3I[XF^b?42<7Q.H
ZR=@CRU+]I22SdbbGP4]F#4N(V&B^[R.<7fWF1Be=.J8:Pc-JJUU3C2P7L_0DPOg
+;(5-L&CG]0;#f[92ffee6N)-&/[2c:GL.4Q,BL9>TX#]J5;XJJ;]d4J+R_M;f#V
.DTLNUCA9QX.gZ[UFJNQ]QMGC3J904Tb_&ODJ_^9gE^@3K39<AE6=H)e/>Yg3P51
DB^B(PcM0]ZD3MOXYD=N#?:(,ea>32;@?L,]5IPCQUM)#GW@4^YJ0<?5>d(JFR(E
GMA&BZ;1&/JeO\.86;]We5fJPBF[X@_@8_gc78[][;Y:_JX/B/?IOP6Y&g8^2WSV
6BN7_gf0P_:V;6G7QWKb?LgC;@S.KbHQK^[)0GNN7]gN8VLB&I/I)#d@Z/7-\7D?
I6MVN)aPBL9Wg5gY/CdRG16;b6WJ(3=RCE\TCT+S,dWEI0/+#d,O;K+NK8SO5/R6
C[Zb-V21+M]Z;F39A+LD[-WX:\)<7]8LFbd.-DC<)Q3>TfS5QON&TN64SL)C(]OD
aW)6Q[239ge-]Z\):1[H7,Jg\696AI_-GSd#8[L@.DQC>cDBU\a;9QS^H);LBXbJ
K1g\,UBL[b(3,HUH@Q;\?Rd<H]WVN;YcR.Y3WQLUVE@EdB1S,8Gf\YF&CP+g8U]c
8QaFYeb7-?^B7#NaSaMV9+KAUH@.U>P>^970=N.85WD+[4L0RBNJP^[5Q+R&P:/E
>/Q36-YBRG\]A3FVP<Eg:VgC:/9Y^XZ+@:B.,;\c[@72J0]DP&\SIg]M)K[f#X#K
EeJIJNUb6W]1R(_Gf_E.WE-aMEAZYU?+1Z#@==/:feNQ=5d4T\Q@2H2X/&=5@Jc9
&[bB7O-S&F\.X\=SeS7T_46U1GBVI20D1fC4AbF6L^V?:-IU[&F[9e:?ZR6HdOZY
@&)_A_G48M0P,PP0C\V=fa91:fG#=fRE>QEO5AWK6]DS;5Bb(RgbBYL]?&O79/1J
.e)K=9-\7UgNB&PD5gZ_=#OeJ[(-1b-Ng6H[+QcSYRHd>K?;H:+^8cb3T^5fX^D\
/Z./>857[AD9ec17=/&)#ACYQTc.YUZP=8(bfb5@DDd:7>_R22+[\1K/FFC3^N[P
^+.@]9J.J3aa(WX#c3T<59=?MF?;/.b:gAbAZN]eD7[K;Y:a[A>^gU&:LV]?9=>G
@=PU+]8-1&+F)d.F2YSMGZ[-ZQ-E;.E>ZfaZ&S83c/;f&M)bP_58D4UE84\;J::_
&DYEe9#ZX92WJAdg7.EG87ZYS(Gf0(dW,V5Xd\Ue;_fO-0M)(?_O:THCMBfB^./g
Q.EYP@&^e/f;J9EGK:8@P\>Gf^[@]]acdHXDLe)9IJ2A-a\IA=-M4DF^#H69KDIQ
LcQU\aPSPJL3ebfe&-35IJcA)g.85MV4d&BX^ed7]abI-//-)ILbJBNd/89E.[AJ
MT^f3B^LFbV?fG1gTM-N#7.CWG,]>Y4DXdL&e=13RD-<ICXUXXSg>(e3>fA,:7LX
E.CB8NOg<>VQGZ7)K5NfOTdFKFL,N[1A98?OTR<M,23.>Y@.0>],H7^5R,CACHOV
gC)\;R<a\:FFd0:77c\KbUc2,\YE\F:<:D\aQMgU[K#BSOXaI?XG0BSQgO:Z5^X.
:C:dBS2]5c-P53gS5ad<T=)[UP^a?fQ&HM1aX940RKMV;.,;>GZ>/3DV[\bO-&6f
B<4387,/Ne0[dJ1KUV1<BATYLS@+8@b(5U@^KXJ<SU;0=dfLg&3He?6Cb&3ZZ3a^
W<FW2:\E2C-/2[=TD]XD#Fd[URSb:JFMX#9gVg?:=eYUQYMgXg3C-AJ0WL2,+TVe
;HLg,+FH^RDGfP,([HLXP0dOA4Ub_da4+1<P4D&PS;OQQM&AY-WCY7R]gO>7@0?;
f;F>:Vc[BF0,&Ad/&Z#6=VX,_>U.79[L9Q\\]F407H:eXD,&R=?_AT#2LQ[;H#C&
[#_CHFaaI061e3CM6VN@?#TUBLI89Q4be+N-5Vfb_ZJA<_dPIaCcR.Z5]Z332d_P
Q\R>CW0cfB01XBC?47f[S3D3fC5:Xe?F#7:;M6G3](3<7(B^,A/5g2e3>#d;2-;D
42L;&4M@8[K:?JG0GDZWSP9<D;6/1GJ2\,;b/bCZSVCfZDb=\W]50NDP<R&UVSNO
XGN/?Z(MO83Bf&_CKf+L@WEfOO:#[LVJ1OK0(GZR^^@WG:_Q<C\=]Q;G@F4I\d4;
gVGQ(+NT076\LB1\HM@+P#QXA\+8?,(PYU5GV)72K7RfCT6?L>KM/:/[G\c#>b^8
7<PTZf<]0ARdfEcGQ?S)5Z:S,MB&e-QOVC/EUNYbEOgJXKdf9KbD5CH&.cI<\eKd
8[1Q+/_]#.>d0$
`endprotected


`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















