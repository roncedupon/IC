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
bNOX<_f3MLa&]bXF8@7d)^afT_N><aY^WI=]C?c/Q^KV0bOQgd1b2((P^#?_)]5X
^LF[>S/f2f,^]U?-1A\VB9C[e:KIf:A:.RY^XHZK-GQ.)43P)48I0LAI2V47I<U?
OdISY:eMa:,U)KJ[]]GZ9A4JI(g9F04=E?.,1?M.ZSU\3]>LY4f[P1E>c5@;Z4+,
+e4:N=)gFY)613e9T3:=M]I+YE<((f.]5cTHZ,C;4//O<?##N,>(P,+^/USR\-g+
B=aUQ>L<.,9/LF^bNY\,RERCM2?0PG0#dH88M9J(-V-@1X@2ICgXAY;5A6@B^eGf
UDT&\-8IOgX]/54=0QP+AUFU^X.UULTfd02IJA1c?XDN4.Y1Vd0BRf4V9e8C:IJ.
.[2X-D1QGLFDeZ20TNgN_e30=#R3+aZRW?53IVYY_V7+S8KdQ_^67?4M<;Q.TEA.
X(ZAC]:UCRX6;KV=N9a_BU)I,-R^RDNRIDbGf-]^V>N-aBXb8WJGJbC/+OF=\QPg
5YK9^a:@<YPc)dRWcV?gYNWeWIWO2;&,\P?+9L_R\)(QbODFb7L?]Q:ePT]KVKPI
(7HUEUZ:CGLOMIc4eB)T0(M;O#(,.DB.cb]]WEG(-/U1+d3J_^Y7J\V&?-bH-5^D
=cORU#b^S8\]#]JKJFFS0BM;1$
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
-WOdIG#^NHAD9Y\?5aQXH)#2(B:7B9T69#MMMWAYQFg4cW[8LS(b3(efOT]PVD]H
LW85[.#^H&R;+D)-KVQW@,7&fJI?XE2@C_FJb#F)>X2=dS8)VV.eX>FGYSW-_WR:
-00Ye&1E:LW\R])1<d7N.F6M9;=7b(N]U@ZG>E+ab&EY\]Pd)B:25FH33W#9O5O3
AP>\;;H#26)(Vd?KO,YIEf3<]^Jf)<>449@GXfQ9DJ,fC39e#c&V9SN2_W-c4IGL
dJ@HYgPH9.c^MFF>A#-,^]Zf0/J-+E:C4e95UIB1\7IW+_KDPaMA2]+,c3.19>UJ
=S,K-FZU4R+G)?dGD]WT8gfZc11g>A8(//B)UW=fMY;_aBW&SaA^6G0Ed<-9L1T&
3QaHe]AQ@[1bQ[W06E3#AfY7gDYLU@bCAIU18:J24#7S<f<R<bcE6e][E3D^,[\Z
aO.<W5[[3G@)4bC)ENQ6bT8UBW64>;\ccUNI;^/C.Fd0JcHVK6M9aGDK69&.U(8I
1ZZeU:;a[=LPU5e_.->57-P+60fXB1(gecU^>YFCCf<U/DQ=DQ<\S]MX.8Vd@M(<
HB[;N1L)VI+OR445W@D5VLPJ7.IU=Md\Q_-?f7,JIX46Q?^g(TV<)H=dC89/X?^4
-Y-KW;V)HFLcD=?F(/7?.b?]f&F=cW8L;;AJe,-;.gd[LC80d^T)B]>+9;cCN;Le
^/)MJVYW4#C\,/-aBTG;DCZ^Lb=P)Q&B2@VP]]\ag7DVM)-aK71GT@NQT[:1UC>7
](c-^1&e6c(.1JbG]<S(=9P,ZgA5d<VW55L0JE6KLG\,PZeA/V@T@Y3ZcfeIP(TH
X.)&UOc28BK4bCT)Rd-:WK5.W=4&^7MRWcM#B4_^cE\5.e]b^IZVH.L^ZU8@f.VE
GU+&e8?>MPWL0;W:IL<Ga^+N2OCaL<YY;e33)+PcQBIag([UgCZae#CeYcF0I9d/
=ZV)b91-Y:f&=WUdeM@cfR2A97R(HBI6,e8KgW.RZ,L;<c#5)E=KIK#0NPaO2B->
RY>OU&22F,3MC(420Y7ADdIN>KIPa0M)0Sd.-cQ\@2.18IN+JMR9VQP/0]cXac0f
fSZLc+0=IUU3BBH=5eDX:E@JC^V062F5A[gC+LKfXS4SUH0W-)K5Y6DCg@,Q,J0<
00WMKb>3#(M\&4KJY:\=H><dMP>M99VUKSTZII(cg):2\:\G>J9^]L>5^@CYMG.G
\a_H0Y;^-e2b);UEN9(=NgLS=.SXB4WNH:N2_TFM&B2,IgLA+^GWEUYHFBIXTBIO
-Zd/24Z2)Z;#A,I>6_83M6,3f1ZV5N=FYUMF9BUWAR,OGb:,],R\0V@J(]d+O92;
V=@1)d1_WOQ/,CHFMP+Y543NF5]WTW,ML4+XTVF)b,2J9)QLS@IYTDVJP:MbVJ+E
>KDOR/4),O?^Z))ge73OCIc5J>:9cFLe63ID(SA,GUMK93/P.2AUR<X8Y#G6,3OY
M+LZ<Z(dNM][f/BKgCMP+BB>9>KR9RUM(3DT+Q?5DKBCA/S1g?YQKGMcF9-gE##d
#5;&a\6SB\#BP__PY(MC<#64gLV[-,:cSY9b213IP.?R&IN6WM:FOR8A-Q>/3>5<
&aCIK0M\;EU0B&JT,-@58]M,B:ASFNKf1DW;^b>)6_31YAU>@8E;1PV5T>@8)-IK
09g\=\DWg@(C862S@.KNBC:^MB8@3#ReJO-;=XfDWA,VDY9RHB;<1#+Gc@+-6a]b
O<9KRJK\<.4P=Qe(ZXdMA?D>c\LRIDWFEW:TWHN.2/\4_3]d02a)3@OP#CdV0QSd
BZ\B=e^>.g^F0>H:P127@/=E5XQ/.Y0R((ELA^MUa2RJ;6IQYYW^<2DX^FEDC+N7
]&<NRT)=QENP>U]1TC6,HILKO;PPS:bBWQ9>R]NS6=[gS-@HAK;6^B]X05CCCI6,
f?0Y(AJGZ\;Z>+c:F7+14]Nf89F5FOUJ&-3]F\Uc^42[]Q>V[>G0bL?(CNOS(<?&
8TdGHA,@g.TH=?W]</QI&&ZD=S.Z/8O]U960^^?>LR5eFGag:+AHE6aEI((R39O7
15Z[@gL8/0<c3:_A\V3g+[\)R-fG3/2M>1U?DO?;C)7R2LU]UWCCT5g&B14fD,5Z
OS0_N71Ba8=@>YM><];L3J)X)48UA]4&5HGT0XW&dH5HIA;Z/&51f;S1#^MJBGTB
6#-#.QRQe6\FE-aSEJB;(dL0F&Kg0O.EO]8\?O-V[bFFGT>XZIBWa:OI4G/RdE;G
B4N5,b?gb<5R_;@7;0(Q[c;8)Y7KGL^E#N2BGO-eI_:C.&cD&3gUQEQ#@]F+E/C?
5OP=01JQTV2Ab_Y#g(J+UA^;f:SZgg&a01KJIX]U=++XE\?GM1G4(#7J]+=Q:0A5
bOQ#0ZgF3T\2P.U6d_O-f(0+e1IHBd::W/5UX8Ud4)(9?B=]31cFG](RXZA+#Z(=
GA((=JN:X9PUP\Zb)bU)GM6UX?#Pd[b6>egc;VgbHcZ&2O+<+V<NLAeaa]I:#T);
Lb2e(SW#d[<,WbZT_Kb\LD7WI@8Y7fQ.-=Xf:PN+=,,Z<:8_E6a3X4Ra<3CM->B+
_C>]>:#dBK-F:X0<cJb0G0e(2IWW[Afg,]J^>PD6I-G<B[/T#OAH^\F+E<;1KF5+
800Y:CKc:f9TFD3BJWM&EY2.5X@^7(^_<(2B[N8&ZPWdZcC?J4B=Sa,QX=a>FSKZ
Xg,663E<5)40P1Gg72=NQ,=(_LbPZ&f\R(Q9+7AT2S\+<P-,_/P.BZTJI0H8/_>N
:f6GTI\NBUUcB5//L98[V9P/P4K0cNFF0\5(F7G@[\+7\>XcNVUEWXGE];X]Y1@X
1YK]?^(O^XJ9W7\HL80.L__X\]/6?DCL9gJfa&c<GRPP]Qga=_7:[DW/Y&+#U2)[
YD/W]9HO=IC)),g.FIEU6OU[F;DFP@,O0Kf:RTDK.6A^5f>??:V9cQ0ZG-/PLEK<
Z?ND/CK3DDf/9PFD(QEZ7)GVG2QJ1fIPA?7YcD>\^,\#A98>8fV<_E#_@X1@;(ZJ
bNG45Q=20<]7cMd/4_,(P#Z6#3K89dbcT7W/5-KO;,FEY,^7)C9T8VPFB/Y_[URL
\\B@<,:edP;:4-41g@/<eD<9JABR@I8^ZfOKKK&1LM&Y)YC2BCHDJ04cFY[M/6XB
ZQB_M,cO/&C(a[#7D_(:20)=WOPQ)V\VW,&GM<HIE-G[5H,C4>bb:O=bLddVgQ-?
\D6]1dJ7<cU\]<6A4QLJ6Ig/a4RX.AXM[F-GI3^^X;cS\ZL\O5LYUMUB=-HcJ]cV
@<F0>4SW+I<P7d^B&c2/C01CBd&_ZD5/RI7R84/V1WPf3H<DC.>)A)E.#30\^L@a
&(b_3W,K&-Ue8\54]IOB=:RDS58Q7OL;Ve9G_,\BIS,Fg#:NT&JXS_>7IQCKC;R?
;cE=^a1+:ZV[4^gY2=Y4f<3\6^B)UPY:F7C/f>b;IX^NN9MI060(Nc0&;1Ka;)CU
,T[)O9AbTN+>T3/8DHU?O)E]#89LHC)&Xf.#G6P\>RC,K)0^]GK\V:dgX>Vf96U^
Q7Qed=b:<Hb2Pf7>&d^AGN[NE#c\6G8B75I1>7<9eMId-3Eg5XNX3cGXgCB;g4M:
Ha<]dN,/D8f8]gD3G2fQRLXbF1P,03^6WfDFX<):ZF2,=0R+UCM#2/B77?XLI2H0
\Y/b7Ve&_;LT-Xg;E[KTJ_eWa+<N))NX0WeJ<H8cSPM:b+fSQW(]DaU;>3-GO-,-
?H13)c(M3GCUMN6PO9G9J+<ELMEP[D\#@-,b8)&Q0VZX2-D33fYZT4S3]6SM0Y&Z
>B\.eW495;T50BP(HgF.bWZeKP(VgU.#OO0KE69\F_3J5&ZM??C_)014N(B4d.Va
FP#e^7eI/H\KQ53;YK\?<42A@^<9?27:LQcV)#(f=MZ]A]:(9LE>0(6[^1g^fSB+
QRXeVd0=,a(A=5Rd1d=T4G?+2Z80LKgN^#K-+T]d(W^1I/Af-,K]c]&W&OK+L+G/
U7OgT<U3aK]&K6A;^ID,,Q07HX_1?O.OZJbEU0(WPG<P(ULG>K[OCa;I9Y27:XL-
Z)7_f3PHP=JBHYcCXEQggJdQGLVbcERUEf@;XF0YC0(G:a^(XB\@0Z[P7HUFZ.P;
cLHNb+F\RdTSe>>8aAWR><EIV31^fgN3__-4U>LcJO-dZG1,9UgbQPF-b#c;WQWL
YDNL60c>/=N2N.bGH.dGV@/88X[K83>^INB1<O)\5g0]dCR,Kg<0f_.0VT+]G.,6
]4;/9TMO+Q]M+NAP9B=Z[6_#?@@^[^>gGS&@[eR7Ef,YJ&<S_H@JT#\@](GU/cV-
9M7Z5?)7\/0fT,FCGbf<RE-)K<cM&5Na_8aB;B;(GN@0EV,PeZ&g-C\ZGFY8QWT(
^13LI-6AeM6X6YDNQI^NC;<[.HWO9=.@R+6&^1O[GY#6F[U[\_MC<HSYAH0M\XXO
8G:^60U-PBN&@6bUB3CM5<4Z(=Ue0c7IFe/;_G-Fb.[>g<Q_U\N_3_g@(>\/HB/U
J\dBLFVXW29E+WPPGd^WPDS9MeN/&f.C84W6A&a2U2LPT&^XOUGAFK0#EA07R#[I
J-3EC\KVFMBS-N/S16TNW-B560.NIbD7VbB-f4#+>3X_+b#;U)PK\.DX1af1EI7^
dCUEB3LU66_PGXAH_HXQ^Mg&8bZ:3,:KD^[H+YS2d7SW/D34)5KK&7P0cX+bONEC
2CFI9dC4XSIbQ?N7b^R_KR/JE=9bOCT)VRbX8b.Y;<&-P[]O4VNY.L>Rgg>X==a0
E5SRSFI=H;eRT_)K,<IaO18K6M4)gZPS]7B=BYGN:I&+4O_[>IT.\MVBCScR_NN4
^/45TUMV-AOSF)a,3KAPQOeTQ>DIDNN]bF@<<KSJFMMg))HfPG>.5B^/@,01(;;[
#+M8VGO<+bd^c\I84a\.Kab[\M1LA3#fMJRf,0_g:(,a2)SNF9UH>0S56;V\HYHU
>PS770U/A0C6ZY&g=#-QJ)QbX.&FA/(=V^/TK_AVI@9]gRWacMU_O]06VIUb7,\,
]]0HcgD2QNI[aUVV[E<8XdA:W:S@^U#\9IT9>7[\@8dQ-b3M)Q9[DP)G\]f,U:&U
ZbS[gGSDW=NgcW\AQ&6ZA+T;&C:_RfLFRa<;#VN+(G<Y.5682AKB)Pg/D?68^V3X
R:3Q7HN?/_3/550[XE@ZP25PU(>c/fNdb8e2&RP6JM#CK65)^LS8-EdGU#PR88@b
A\NNLGdGgdLF__^<Y_])98>Qg^(]\<#;Ne@)4E9TZ5Y6V9Mg8JNS6bY8(E3eK#(e
8(@+9\BgD6>3:c?]JKP5<QXJXU#WXfZ:.:1EFba8QCN32&88_^3)B+d,]=,V6&?Z
;:J?]FNec8MR)<Ab1XY/M,RT4JaP3./\MWNGacOJg75[1g\/6PXfU824g,CY3V^(
4<H>#\>@X]e8WY@a+6:YW#7,;@ab]/Ud=:]W0B)C?^^b.E#2M.=2+C9SQ3+M.R9W
;X3Z+0D^QDQF<W4P5&/5-]KUG+H/cW6P3.=@UU2VVEe@L@c@-b/>XQ2<9X<IS>D,
(MLga_UH7^R.0Zb0]JRK/5:B)&2NLZVLZ(P?0==E?3G_^:(QJMXf>25/,W9M>GRV
^,:PS.(MTDOJdQ;dETeOW6,##Rb>Uf8E_G9e?0VS1]HP].UO&5D#PL@><AVS&F5@
2#:K5JbNER+FTM.B>@d<R(<)YNFC4H.W<c(ab#GJY7Ld<I:E@E[VaWAN&^R-G>37
g8+1/WEQ/=FRHK>#f5V2Vb(N_3?5IJI8O7-Nd+4XBJ3eX<L-TA/=.Z7J_AD09H2a
2C^CcW6L>XJBY>F,N\EPM[-HJ.2]WDY\c_6<U.>f:_6-KO43C/&&dU2b.FQCF[N>
9SDA/K?cJ5?Y\bK],bAO1K[:bJJ79#>]JIOOH4MDFX>DYg4cad(2FG(^66[+M=P7
/4ASf@LbMD_9dYJF=Ye^F&Bb=X9F+)@P-LR+edD<;K0RRI=K-P0X?(0NBI/Q;:bL
f?cU1O96a5,474[)[=e,APP,X^E.(HYQBE;b(Q[&cMK-ENJf>Q1T=7/;82DM89B(
[/^R^-O;/IBI38X=A>#8@QVKc:7MNZICXZeVR+SPEc<,f@FI2>>2BZ(M;G+A=bGQ
_D@&aZ_J.9_9]\1+#2;g4aITN3)6J.T4[\D1cS=5GPCUe_JeK-,P02-J<D[29-R+
?]:Z^:899VAe<PgG3[Z=6&7E92L<fZZb+<gO)(;H4W=PF]M2eSKB6EILKT.-72dV
b(SQ8_TF43de:-9JB3=15E6gKJ88(.+#&KSH9&HE/US@MbS/4KSUfQaf/OG5=&;P
1Q?-e_P3S+99SM9Z^+ffRW7;;_^8]cB5&+-DaTFQfKg:Ke[gZ]AgA]dPC3RH&3N<
;@5cOB12B5P&fCQCaQ5d-DaeX1IU]W4JN5fV?]<b5:2e-4U0I.BQ,Y0L)M1JIdN)
15W_O0LK?.X+>?L6aK?U>G42/<0M;67KZdREf0IE;L^]Q7Z#\FWRU-M\=F^TCZ]+
-(?MW[BW@7:C,eb<eQ2F6TGZ4JVD8RF8??SO_I;#64^aMS.KVb8Y,Y=6/&P)G](O
+/,8EdUV\W^TJUca4)=/4+2fNbg[X1(@H&a)8;6.+TX?afK.WDATJ77c9DeE_0UL
.]E[Ud,/=F5?b8KcE]S^])6<O#2&;.QA\&F3a.:5^F&6\9Q=51DTC8HPS6P6?FC/
Bc01bH#>I6F:U9WePJJ;Hf3QGZ.RK:FQC]5C@QRV[L_&<93;/D-^;AX<:LXIW+f8
>4)O(4]6fL\\H,&Z;L4WD7@>@b?LI;;/cW:Pc[/CX5FI51-PUAN.F+J\=GG^[8c@
Y=8WS3Q-Kg28KPQ>7HG[Q]4>./1/8(fNg<fd:JH)5(^T#UI,&?451YJ/DdFT5-EV
ZRPb2HdB?V>DW(^39F;]@5XfF3b\dO8C50fKKXbXZPd5KL.4O50X0JOE<g4X)09K
Nc+SdS>6U5[X&eGD>U0M3EKRV3Ae8ZaN8#DAL\W6&?UF@FO[[I?42<4Fb7MUOEJE
aBRcEKCdH@6@A62TIUYUAc0_f8+MZN=?=._ZKDg?X]WM\\d4NT4aY)W7[U.VC93K
I0Kf>F21B(QJ8cGYSMWS\(Y11C8b.QNe=DL?2=C:2/A<WIE:CO@1WBNG+J/UZQR(
-#FIfQGcTD3DEf[:?:OANd.ORD<d6^#7fF.?V\b7>.5M(KJ/(XP&Wb\J[?I^EA<I
/B?)2?M<=/ES-0UM;MD2W4]D=<@QbA\6U)[H=9_]MT3R:a4&,cSAX6),7IfNIQ.J
N:QeG1]+WY54K2-RH20#>H-ZXJ(Ta.Mf&?X4KFIL5>CGQ-Q^MfY58TKSODJ[&8Lg
1U>[.::X@X-cG:6.EK5A>N,&Z+76G-b+@NR:P-7M?MC+;P@:/Y?>]SRb?FM-_N9.
Z5La()D::(9DEJ3OJ2JMNP>FWNG+]<N@GT#VOf_(RVDT#3^Eg<COg?KFgN^c),6N
M8BLfB22[40H5NdL#45O_D1B;;]7aWVK]=#gNO:1+PN@c^TSH6X-bcZT0DS&<,JM
21-V4]UW(->(B:\.gNZ-FTQYE&XVf,)7/088^e^5<YJCIf5H7X_IcPJT&H3W-PDf
g15_VR>6^9OE^]fF39T6#SaVLJJ:V-B?3Uf/?KPBeIg>?@&e,:0>#9\#849I4>2A
;_&;Hb/cT9:P@fdWU<ZM4283&g7SH=0g#d0VYA.bcA+SPQG4+:_HM1=#=9G9]XLg
APAD[XQ_eOMZ_50\);/88J8J7^c#0P6_VA5:]^b^Ue/fb.MECA^(fcR7-bM9XL+g
4/-QMFA4?fFeQ.g_B57dADFB>fI17[B;Z^beM(@b.;G+eQO@1SgP[L^(N+9=g2BL
3dfT[;O3#DPH.9P^Yc/^8#I8CE6Z6^JW^6b1S?OPM#O];FBgMX.6=G?-PV.BDYdF
3/;L5X),I--ZGgK-/Q?H^C7N5]CA?7aXJY^+X=3NE=Pg_],\7RBfdM/\GWFT=.W/
B[=1]Z(];W.H7\&Y^F-a_M\fTb0ZV2SKAIMV0UZAdeE(I8>>Od#/bMUb]5L.FG8Z
WD;Rdb>3B4XZ&L-VKX6^Ybe/F-&[]P^1Oc3+AfS^KZ1:TI57fR/Qf?+AC)cBQC(>
_K[AfSXP:21/9(cDVOS)Xc_c4RfU;7?FY9EUaf?XK-;.2LQ-f^^Bd<J/5fULYG5Q
QBLCaF00TOLT63f,2RM=,R18.^MKSMY-T\B1UO0];VY[3MX_e+BCb3GGG6Zd/[ec
24[J--50W#_J&4Nd][^X1+BJ(TI2g,@X3JT5DI1#U0^6AVR\K>W[I&V6d7V332BG
b3P0Q0&7(BX-BCI?#+cD=eTKR+g=\]\R^1cX:K5=)PRED0.@]a>J=AVb7=-3S)^:
32cT&KQZf?e0IXR_#Z9;O3d\=\c=JEJ<5&TfQX&P-+-B8_OS;YC\S5CV>d6=1]bJ
4@J[Z+_f8MP4<@R4497Q&(bFJYdWAJY]fU?=A(7-adGa0)9YH[UD3dL5A6W21F0I
JZG/^]?9X15MJ<YUVCAU\J>LXPWT#U[FeFbF6Uc#ON<ZaEa@)/UFN0]fIIWJ1bB=
\:A#2(W&+U4O^6BHZF=1a0CZ<_P/P^EQU)TJDI(b2\e;YY/SX6=-8W3Bf?&Q0A(.
aL#^H4@W6cf4F&A;d_MFId8cY]0T9/[@-E^S;.L.@8<f(?]_eb^-P[Kf4Z8=66B]
=ATF=AaQNg>GM4#@AQ^A3dd37b2g-CPTa/;X;8f:4<8DV7b=0,(>g_&c1R(9=]+/
GUSG@P+2HWI6QR,]9OUD39cF2gga>Ef9UKDDD=+\\5)U<<+@eXdO-88cOJ7Z9\cH
^gKSYdeNEd7F0IB>J<5,aWf5TLRABDWgf3H9BJK3d;0U+<N0e/I(#O(=aebSH(Xc
<1aDCBT-.G?5XD>OP;UW8Wb.bOS2/UQ]OEK->GD.H>aCT2PR^fY/DCYRHX+Q[&6#
E3Y#E@OKGK>L5;A]XJNU0]F7&6EJ(A466d/-P3S.c]T1<f0;0dIO>H=^/<-ac@;g
EI4Ef]A/2b8JfLg0^N[76RD]^:a<8<FYWe_2J>0JSIWYg02CT=;#]1UU++e@H6Y+
g#+#Qeb;[e<&9Ob&f4NSBM+S#DR5NU2?UK;EN,>S5X0YMZN,[?6.(b=I&BgXQ6Q(
[&7S\TGS93)66Ne,5:@Rd=-,2(-cOKNR<N=\PTOT^_aF0JT^4fMN6WLbM^V?c8KU
cgO<XN_:B6#)8^,S#F1=;V(7eJe&-cc^B@<()DZ3[Y=S92Vb^>CHK4-?0cN3bL(\
MgV&Vg3.60J.Ha[B6eNA1B[^U/ZKIU)=S;Q:LMg?^=g)d9@@(G+/U+29?fZC44-4
Y:^0A9[TN:YW;;VX8-;d\OI[+,(8]_W5ESeF><H)L[[a+A).D//)B-=gZ:GO=6Z2
_JVdBS-Of6]/U3&aRGWS2(&VW#YfN;V:_@[_eNdVWJSO)KgPW/>(DU,R+b,Fbb,)
LZ168]2?VK\ec:Dfe:M;=E)9^a]F^KD[(6FUG44&:(,CQI6\OfWC;--J?4+T9Q9_
&UKNCWQ(\CK@>534IgY7ZW&B)#Y8d24C6L9A+_B9F]OL[FQHMZ4SQ+5\AZA3[Cf/
[7G,>+W=UK)/R8]b(L,GY.Xa+=+P]\R6CbL@7RDBU7A.1S^DOD.9FbUHCe:c^MIR
XZ/T>1.((&S3>PCHL#YMaY9M3)6,[<UdcUNd)Of,;S\6;#bS1EV+eec((Kaa\7+L
d+5K1aa8A/TVOS.MO&J\P3),H3S,\>,^&(JfHBgbCCC&T7[.L;+cT.II9.](#&\+
b+dBGIHc8/^f560E<a58<C.c)a3(02)L<EO99AFW=+WMX]2ZNY/+8&F6337K=F[^
L(L:ee(d2G&/IE6FH_IJC3<5P5.Bd/<A?B;7)5UAKE=;W/RU,##bEB0KZ==^8O-&
DF7H6UIL<6(PKV,OVWD:Q3Z]O60f4GN8fTP]\W:@CL4;5)DaPc:Ve^SC+^MG9B>H
C8,GMG[Q?5eD[Rc2@FM=84=<a.DH1(]8G=E:(A/E;^TAS^VaI5&^\IC3;Oa.=U,M
P]<YAB<C@]7DRNC2&S0)K.+J6+[QM,D1=^b<Y22G:+X\:6;_gR_AP.Ee8CZCIFIG
6S^bIbAZ;^J\?b?f>[@[W]O-ZPWG4NLAC5J^VKZ6YF,eG_56:ff@HULL41H)eZ]=
IYN#YGg7eA#>4,+W=#@&)?1WgK-fd]-I-/g+Gc^)Qc-N=;/6N+T8=.b[fOY8c,OU
3QG2cbg#9PL)cL;7R?(8;3+3UUB/7Df@;b(ED>RN.K8(Z0Y&C@@dF<&Ue<K[2GN\
G:#g.[8(+c@EN<c1L;6T>ONKK,1;?WTe.I#LNa+TDb<NW4KRJ[c.KQ&K7g\8ZI^3
(H<W=DH]/2E3@6A8JRDBg9FG=N&\777ffNgL_F-FDRG@f\)SO3Vf8JZ1BY)+E[LJ
(27SY/6AZMV3L7KcKGcEE7I:,G+,YFBe@,+bGX:F.[S=/3E;I_GO=RCMUI.#&#Y0
)M]?^ab0Uf)D-EO-O^(;c3&4(#CMCAVf>31,NMeeYc>3V:)\4F^^JaFJ&FbMI4aS
6I;E&4SJ^NS5MH<\>RW@@&_OI^TNLc?+E5B&J]B,GbCb.R2(+G6+H7EJ&aH=]5Bb
BF.#Ee\S)B(=UM:c\549@\,(\WEPaL[U+YNH;-&<,JI,E5,CdAb.bZ>;YUAM>X[F
cRT5b/MfCCRMF\PbI2_\Bg#R1?Z,d0)V4V(7\WZXcTC10+T<P//-La;ba7e_5<M&
95M>c/;N[:bPF#:36YB;ZfAGb(B<OY]B(;&D&D,<\c^G+U<cX;=,OM(356H=XL#V
Y/C3#6O^J/J,bX04PM&+d3)W-67/O21bIfP[>TK:9eHWVcaGLPVQ8dCSfAAR59N.
)>Y7dEU<+_\3)(1@e3c7<#MS91Rc)AHK0OI@O6#B&?,N0KLS,L2:TI0EFNRcUFc6
:YNC)9dFM1D<G5DPScfX=QT4=^XSg)NW93LAD(?eTBIG.aTFL-<F)]B30)?CA&HC
>9C6cH1E>,cLggB484&;N6X<2:D>[gOJQ#?AaMc:3V2-]c:L/3SHdZ:-I(J+E2Y^
2a9473deB3(T4Q82f4/Vee?YTR^#5->c7bUEb\d6&-&UAf,,Hf(V+gSH]KTO:0dT
9O^;U(#VF(E2gaY3Kb?faUVTVGMXPXL5<P(O.=SBbIff]Ka59_24E@eRE)fbV\Wg
^^M-P3b.9NQ>8aC.fHVUMUd[/@gfW(#:9?AFaYHI@O:B+T([F3gQG4=/^^,;:d^=
e>^5]2aEJ-C<0[:af4<JbQMXPF^^^VH#.PL<a/W.4D&P&W?c+[-I<_.P5W;[N>EV
aMb6O699.GXBTG><\,9V1A#BZg??9fB69AW^Vef&@0:fO?)+USfSVc/U[.?41b@9
gQ:?X6<L,TYU2OYO\TG:3:\[/CVO&gNd0(NUd=_=.e(+aVDNHbFF;aG/NGMdM16Q
2fD\&Y^3<0@UeX9-Y66;@H=YLY;e4;e)I4P<A4)BD=8R5g6Nc,IMV<Qg))2/5/XD
b=ME+:4363Z9dN,AYQ/CgAddE)d(K[C47f-L-;C67X,,/1B9+6b:dTVX<4O3GP[G
(Z&S-SBL_d-+[ZC2KVb2K(FF>bDWR69:4>L32AB:2cLF;LAC[C1FDGZBSM,GNRa^
#LV,&AUI5c911VZP;FbXg^=>f#3Uc77KTTZcP+J\eAdD:DcF@HVcRXSJZf@HfC(G
+KXcA#37/NVQRNb-f^fU=J./=@VQfW4:SEd-VS\a_H573M\]#,H22XG.IabaD;F^
?[(\.R^@Pba>>HDYEPWPOTc[8<2U\/2/-IHWe,503>,V>decH,T?UL-8]c.5)MH@
:CP_J9HUO_A/<5JIZfQ3&>PIZ+5UQDW+YQ&5D3=f\9[_bR#M+DaND=G^FYQY<4X)
+KVRgI5SfPXA;J&@cP&AXJ^^2gVJ?c4f.B[S_\/1>.8_fF7/LZ[<9bJ\5AX:)SM,
>(76d/]I>3QW\YfXJRSAgF6Y?b4C]I1CY3XFHKU1?F1DJRS[EL>\ee>e@8+Q\BIA
0WMIX;=HIf(4+O;Kb4Ob\,E8?Q6ZL>K-8D_8Jad>1adcO>R(2&1b>NfPTJC+#YdT
bQe651W<9NS_X:;#?8<g:/ZM=bHG&)SB-A)bg3-eBc.V3&fb0P5cT@Z#4HdOMV@d
02@ENZYC2JS[C]3-9HPII-7Q(I1>GJdVA))8cGcAII[d/@,Z[8JN)+Eg<<B9-(9Q
FM37/JGb6YG1=^4Y),BE?D27B\).VA,GL1)^<X-L)@1BNFHWOX3WK44LXM3b=WT<
&)N>aY0/e_XDQ44aef;5)3\aSB3MfP0>J[2;b)3>d;X=7b3[;;ULHZOW)A7c^V=V
CA<((b55Fff>2+f3F=?@OS-++RZ1=^XSM029L/M(2X(XN5@T]#]>#JOOf+E-[-G(
E([VBRZH@M4>Ff7KP?3LU72g&EF3.>QY5gY?Q)4Rc@ZY_79J9CJ9-1J.:_-bZ]1H
D?HN4]-HaFaPPZKB4RDE[>9/bT#I^g&XX/IM^_&U33Td#G3=f.MeeDLZg.a&,0Pc
7\4V/M\735YFDBVCL)QLQ<X#5/FI]@E.B@/E?:5JL<)1Z;NEB\VHZI]1C.82-;a<
=5:5dgZP+)1W5L>8;>&>>UYR1MYN=NQDIW[XLS@1WI1VLCPgDb1Re0eCPFA5O_RG
8W_@.c&e-aEBK=bO8O\d(bRUZ<eKKURQ@<_DOe30E6GF7:5K@F8OC<9,BWKbb<c4
PT9bD&<AV\87+\c4^KP787=JU@WSDaH:4R2@,@XB@8aXN8EU[)XP17XTY1_aZ.[1
TU^A[3S::1YIN-0?A;BJ,F51c-69g&#B1Q-Y:YR\@BfK0M^3&&[)E@H3>(dGY(\2
71LGf+>@OW3cMK_)B_L:WQI3C^aP?Ug,)Q3E7LAS39QV^GBdX6KX2.WX5[A5>JTJ
?KYZ+.4U@e(O9TJO_787If<[1MZ;FQL6_WEaFAPJG@51B:,+Z?R@&2#B09,eA5R+
.[g@[6cGU_3+S)c_D1XA<-YYODX=[:L3g3\AgL]N:H/1Z/1[UIF\fI5X\[DU.L5E
.^J#bN>J?)B4H(f?)MQd@WfN:fU,3-W3CEOe5b5DI(98a\_a(Cg)[HPA8efVA8,U
\K<&^U:BL209#3V0:3S53N1[Y<__I-V8^>=;Q&_EYN+XWUV(T1;Z6Hf4<IEWU7MQ
Y(IRM8d;@SJWVf4K>U3BPXf6(&6TK^:+-bX6IJ?gIAf-f]5Ng/4/3#DfgXR2;\TA
I(1NP>EPEJ:0+W9CNEYAWCD#?9FdV#.QbW>]@)FeZ);7U+Fc(MM:aTE)IQ@KHf:F
&#ST2a4N7(Z0CeF+Q6HfQ;.1#fY,@fe;6@OZ<db,-V/-V5#71(;;;7gQ2(Ib62CX
U=?,JPN2Ae]F@Z,GQ^dA+K2)GgaP,^7_b44I,_cM<SK3aN4^gRb]YQ.VR_&b1YXO
D&.VR&1.fS,dHRUd1d_Q.+\S;=&VM9+K8_a+]3B@BaE#[B-2c3^)90L;_JX^bg2e
dJPP@2X]c>cg7c69T.<9<-\8=7=\O?^9.JgVX;4##I\B1YGGULAS7#OM&9,<05#>
@Lf#(.,e,\FYY^g8b&Na)G.Z]TD-E+3(?[U/9_c3,W&NJafGd25]5&_Yb2N)X)Ta
[cc0;ITEA4=PYK7#5M3cQg1B_@//.98eIWJJOXU^=F?DJ(^@>c.Lf#:\)DG@CTJJ
e]]>ZLaKf?HfI<>;;_R(MP#\@#BUbdIf3[6_O[#:,SG+.f;])/JWFF_FG(<Vb^^Z
9;O\CH;]Lg<DaI^Je)EY?^;I]3R>_,&BZJ0^RL8O&L@FK<Ib&^:X;2YS5W:cUWMI
fSbQ_4>c@5X;WOSb:CL/FRPfR7CV>XB<WY\FS&W(X[FcXH=ABLSbe9G7QNPO_C@8
>[@4EZ?Z[^Q]50U8\1Z1J^S_CP[-QB5XZ[E[BLd91d_6#H>;23B<OJe?^H)YHLQ+
><bXB]2Q=<M]N6PNc,XR7fe_)Fg1G9#cYG-X:Z;YAUL@S?:I(6A&B\?YVeHL[ER9
AIFQC/HUDTS@6;ecX\#U+VY?(\,dP()5#\gKaAKT-03N)&M1+WdF=6gF8:EB=Z#X
>AJ)7<^;2^?N0fB&)VB/eYG>12RgCdePTW4-C2]TI7c+9G>b9BW9aO4RMf-;bCfd
495W^PJ5e;ZCfZ1=O@(a@RUV#YY@.G+#3U-.B2b@H_:>58&[ee48LG)+PK:cIM;<
DESDVG_SEL7MRBb6,9&Ya83FF?eIE8E5E5Ad7O;,<OGF?fFIT1Y,Ff[GJLW9KO&Q
.3dA@;H7?CCcL)LaAfaRR7[Q+@I#d_W+6,9^S:eY_b#D.Y7#A\M@699SfN8L=b_Y
;QOX1Ic^UTHNK-6FC-#90133>gO(S]K:;Q#;TV0_WG:E@NGLIfaDQ_>EY@WX):JC
6S6XX88c/S3YMU\/ZQ?4YT&a2.0@+9Fg51;X[9efRK2#4MAME_57,H[&c-&Q7=Fg
TF^5e)b&R69:^@1Xb-6-&)fKTX>LF4HDW-&ETHNH=G;a-V-Z;]O7Z4:]=dT/03^=
7_]UCD8/JNYa1UbTD)H8g?.bPgC7L_6=#=?8&GX\B(?U/cG-c2-R)C7?Z)U?7V<@
:5;Hd1?):^8Y<-Y[.]J]+COE31#.#fWRgV:gdF[@Z.?]PA^THUQLOOJAIedQ-&V4
WR/Z[4c]d-T7CFI^>CD..#a>(ccMUB-@8^Q=@8PL)(HI#G.5=AJQUY@K5587TIZU
5O8#NgOY+c3P-.Y#EI87<e=6eSOZM&.X\7.XCcZOa4&H?QX85)BYJQ:9c\H=Yd\7
H>GNJ<(]@ZBTK-d6G\\d,adE^[eZ2=]=aVR742]Mb7,@>d]+VRAG-Z;M[Y(Ag^N&
e68<C5gAgMf0d3\fZV&I6I<f<9THfe0gH#U;Q2DIR@7d9B.;K(41;8TT(^3?F8fC
b_@30X5=IVS_2+PX?BIEc=dOGD)cO@b#/(E.7,d944?U4+1QZ+D:.eLab2WDR>b4
[(@\IJ2YY\[?(KVT>Q_R.A(?/ZJKdT9R;\6VP6Ebe.L5;g(-T&UHC<(ZSFd//9;E
JOV?8H2Z3R\/VH:P6&_>?G6Y^8TN?HBVEPAUOLdM/D8.#Ag[>6OYM/=6OZNG5J4+
>#TB\a/]=_XENHV=[3>X)\9c4JN43e4R6b95Pbf#G@e_P<SSA-.^ONS#0N8\.1Te
I=8;N)U+QTIG6gK:Q,UDXJO8\,>:]c3aD>96B[0,eB/RQ:\;=HKX1ZVVD8)CSgSS
OGEU[-bVdH(T+6KX,=(BS)_Z.;g9/:;4M5eNP1=QT(_1Y]^^dSLQ1B#A:Yc7g(U=
X;XQPKPG;JSTJ.YBZRQ6:U+NcFc82:+ME3M/F,U^6]>g;[SQFSgB.YT4/>(TLDVF
1fc[cgN&RY?EF,LF)c4KH2Q@<F48IDUeOMDJIP^[4#c:QeX4G)H<XC67@UL[U#WV
bVMJ1P(CI?O[ZQ2:O.-MAT=Ye3/IJ.[TVYPeM]L]G(D>65AD+U)3?^Z6Y8Zb_9@>
E&C1X.B.HHI41B>8.c5<6Zfb.CB)61S6LTI@J68]AJ_Rd5VWgTJYX4<f)fd)#1]6
>SY1JDEZ,@0&:G5J4)ITO5__FI>g/BY@I<\YFB5>g#5a\.=#gac>2eg0>2/,U.0?
R\;7R)H8bN=7e_Y3Q9LfZb:+YIQ5FAY>9?B:UaNZN\A^K@S+VY>):<6+^36_dIT7
Y&A)#cR#06D93O1>f:g7QA16OgWK0K51Q/cL<T>1#0)CRN\(KYOca2g,Xegde^C&
fTgZH.R5&VBc:aS?28+?f?W:U0IPK_#Q[IeFP><E&FM[?Sd2UDb&-T3C5YSMG1+W
U-_O@Lff;_,UIZ]Q4M9B[JC>P\0([R8Z8>-19&&4P>&cBH(aQX#8=Yfa:]&PH(cN
+@EHTMP#dWe2JJZ-)I]B2CE^I]Z4cIDb6309<?.^NG<9D&4GW:I?C30eW9<9ICAg
W,/-Y9(&8R-,c]\Jd]X)#ZPg__#_/H2bKWYD2HI+]5FD]<#3[f2gV1V&\VKS\@<T
b@4RAJ4Nc#MSgKf\OU8YRU9Re0LH_baXG3J@GJf?6IL)6Z]V5FN,2#I66;L]O=O2
HND-7)O1b[2L\[-W&b73_:_#-aRg&5eFOAgYe0;d?K#([)S&2AM)fA85_A&F2U&F
3P+F2=HDd2Efc2BIXbQTQFZbJgBYJ^A@;ZOVK3)QME;CL)@ZE]_(6,MW+#La2fg9
I12b/;PSC).S@+P&df@g;N\MP[@7C:bEAEJT(C-McQTG#XBgS8T4C+4];d_;Pb(E
D/cK>;VU#NC9B95Keed9_bZMX5;H-75V:?b2f@6e&55PUN_)O&T+GAY\DT^g2TZA
L0dd_E]^W07^Aa[=^@aaB)&E<eBFR=)cdOf^<ZSL8[d^T\>M_/(eCCHK&\K;(/\>
/E:b[]JCQL#ZH)6F-X#A8\4)-T7cKE\D9gFD4VAO#U^/PDe>4W/b2CT]M2<\GLVY
U9W5-MQ=?]5E^EbTKFe\H<4bU2P>Lc<DSfP[Q-+#&7[&a(+0F_F;KEf.0_8TL/O?
F+S2Wa[567VX#AF<#g>LLfD[@a^&G8/C.ZAH^#:OG>XM/9GGW]+=d.aSgA_FfAOW
c;-a=_DfXGH,\0X>;/(YKIbZT#VZ8)g/G]9J\URFSDa[:dF/Y7DO#EC@U+V]4G36
[ad9,Lc<HK(c1CaY&gRASC?dGGR7GKH&2TN\]_MHdA9Mcg;C.Z)XG>4/^ZY?@c?M
^#FJEX3A5T9g:d/1EeKeVA5_g7W2DbE:T+5gFeX+9,(1f,-g@=&+Og(X\4BBXAaX
QQ9AE_bE?YDPS<eK4/PP,c;]A?fO0+b6_;@f,@,X/.bNO,PB5XaD[c@c;3TL<1+T
3/65[b9MK7CP)[Lf4gRDS8HIP5<X;OBf\Gc1B;FM4C9FEVXJ&#-<(JQ][U9cO4C5
.OB0JXA,U)1SC_(g+K#(>6LS=L[5B4VgY@T](e^B#c/2fL5P4/6]c-SBVTg;Wc&7
FO[dEQ1X>9CLU3(_B?S8)a2=8c&)#.(V?+RF4@1EHbT.<5=:/V1I(b,@PTRE\609
IZgdT)/)4IR3PU(^RS__f@<W>14FBTCcS=A1#W4;5IV4[G0f47NLcU^3=3C?4SH?
3O.8,X<?SFNcSL8OEd\Ed>G_J]9211+X<-3GE47Q.AU^[.AeC88H<Qa<@9B0=W_;
b)<d_94C:;-.CP&0gH0,X]:5=;ZRdEB@MMXF\R.BOcZ3QB,R]ZI,>(1L6^\cMH?K
U/V2,\>JEEV.F)K5aa6=?bR2\dRW53MF?daf?N597_c)#McaUeHE878?/\^cVV(B
3F8,d8@#_;EYP3&&QF29S.^54<#e[HLFJ/KT:RI+6,c?\\_&Z&D@MT2Mg#07Y)?<
0e8g3Z13ADTUb^&\.2TUUAO2,K(eKd.P\R>e60@1/MV29S130)f]-82+;G3NH#/2
QB#3<,:L#F[eGbX\4R=@2H]&4&R@fg/CCfZf(.+49L/f-__SN]YB_Ma]2Z8,H5#@
B^?Q=Q/DCd#dR#&O47&M(ScF26N>(_Le8N?XP]/++N@<IbV;_>2NXQCdXZXa/aY/
)5A.C3a#:S4J_5[UQ@D),XTIV9fD8d[T>7O9Caa^H-(I@#9LZ0\IFB#FM+ESQJf3
-BTO6c_4S.e@2LW^ZLFHT2^b&)I+3V3Z^1?IIN+D2LAOVWCK7=BJ(dR3Qa)+V\a(
f(S^WA,^#//aWe@:QQM;9\S:G-D&-c]g_<a)[80K3;gYHF,+WL.FbdId5QEbC03:
IV<4;E+Wd=03AP),1IJ&_8AFN?JcXO\?R\()d)E7O3dV6W)I0F.7HDG<ESCMWP&_
[37YB](0=78+;VVc>Ma4<b(S]G@)7U[39fcA:J84?8:HAY]APQ77WKZbP>ZBc2&[
Z2EZd:U509ZbNB:LOX&170GE0N^1S55J5Q&bbdO:EL:+DIZaP5(]dNQA20g+L\NM
bfNa]2J#Ec@U.]f-20P/EFXBM9]WMY/B,F;L6,aN8&d(M-UT7OSg,@8D@84@cf8]
+F_<X#REGDgMQF1<F>>ddQAZ+d5M4(]>?G0=WHGXR8<D5aQ+ACf](IF12dJeVXN[
Q4(b=VF@^X5ebMg[4[IY5BR]#dFd0C17NDK3?Gc+ERCRQ@0Cbd_]/)65d\92P6O2
5GK2B>(CI3gG.MbAP0T?NSZ=T_YK+3)NO]<G44M6CY6,O_&I:[2P38\[aZ>dR,Z0
eDPC=@(-+OP^0+R[Te>@N-L8]a=O,ZC2]ZR9_8JJ_6_UZRYNZ8c&gPS96XLC\a]0
:E(.Z5I0W9S>\:LG\_;V2UEeQcG>;L^?Z\[52:3AJ\FL/6AKd<A^0JY(.LUFB+V.
1LM+[Sc&A);Hd6:;3OU6IHVSR=eX&=CY^?NHT49Nb:B0B?9X:-S:58,R=b<@JKJ)
;&C3T]cTJM[\4=Q\>O&;17:UA.HW]aH(aR@[8(V0B6f;dTIeYC:H)/6/\)_&)_[O
1/:eV^G&7\?L=TH&)/9eB13T5_a3>aW>GS]6:J0T:KfM>gGBGN\&\f_(LZ5Z4K3>
B)PL[T84BgaCONVBV8^6D[Y8=fZZ#&3+9#\7E:@aPg0Q]E5..-)/=AVdUBEY+1O;
J=:65Ke_MV4Q6G:K<_6Rc>)D2g2YN)PG7O^XXWXV?95)DL;TZcA5R<>&KRHIJ6X(
b/Z^_D[M\GTXGCb9,9-^)@@_\9,e=)eR([@8=G(Rb)E2?O5d^c>AI?_JPC0&(cgY
JP>MY@QLE[)@/@5[390AK^^>GX(1b@]S528:?11GT\XP>bBG@J:U72(#>L0WV1cI
B:WRdW:8a&aDfd77SeD85,(^JGC>Y&1R3b/Wa/:&>@bW^d?NS]:7]3(6)0J@8BB_
W#.dAJ74M,D(O2-g#:=JE/E-1PV.]IL+UGZd+[<@96^E_B;Qa6>c(?T(,V5a#C[#
NTE@F3<1LIR7,1e7gAWE3@L[R-+M+G\(,<d__^LWOJPAD.,>,:],MZ#e[D@F.D@\
a<HHN8CO1Y8]P-)gLfeQ0-CW<07/)+P7^@4:ACDf1gG=TI&P9^.#bJIQG-R?cJJV
\]R?6[2=>/,WcOa0QO5X3X9K_DE#\5/PF&3JJN64fE)8TCaLb]&gZ=XcXRM<d9dA
H?7Yg:&)LWT/+aYXCc(Je2D;O5=VKGC@>AY3_O#>)9P9ZA@<8=218\#OPG#H28\U
c04N-UF=0]85950?1WJHb&7C/e2NM;9T<aAYV;</EX;NB59Q7fOKAOW)b]_L(2FF
3C9D+b[/@M;/8FH&/aMHWT(&QG)fQ6Bg\+aWB>Ef-fNWJ^RC&gTW:P9cc:U[1Y?1
1CZAO>D]f_SUa3FMIN]baXZTW;>Xee;X47^a0(VK#eT6&69<,^5N6f?GU]N/e^L]
2-1Mc@9cA1;9ZTN(7><D[YT19Hg9aDXR[KbU7DK[fG3Z-N)&?-Sc7Y00IBZ=3]9_
c[XZ&\89_VMFS^ac;)O]JJX:K-3)?A7BZ\=HM4OA<EBE>:^Ua1fg9c@A5B;IFAU1
(gO-A1(:0G+4EQMJbPH&H>a2-6Q7GZCP,QEd4:BP)#aO?X]J^B19T-C#7V]NJNSU
_>S25NS3=5cH-gJcV-d<;:@Aa/T+&cCF?.@b5(PO2d?9U3+O.bU\&UIVD-.eU6>/
K#J<d)0_A[[^2_DV_CCb/7YfU571X)V7e[^;a0Y<]_SN_bQ7SbO8YU)@45+fX8#M
2Y3)UWTO?1=f,KEaYOQ](G12&MD@AQ02<N@_1^KU[W/L:(MZT^FI+NI^O;<Se<b1
&]VIOfg_A2b7@d_^/Wg6g8CX46OQ@Y[&W98]Ne3A(eb2B8LIQ6A#Rd;UP]GS+38:
BNN<3:MF7^X-^YME3Ge-?&OY_<6W<5#9B-d[eYbU03B1FW1GcP6CCG(D]O\YJ;^O
FRZ4feUC1Xb^[MG6P]5b?0LGF.:E75#b>9\^4gRLTSTHd/5T_8F;A9cgQ2LX-9U@
<EMGO;QgC1VC)G73YVNfa,;cMf0L96BKSfNfd;aCd&H<2RGG+(51&Z.[dD;I]bSV
+3L?2^Z6(c/@EU?\\J\^S[8+WJ.#M8<\.;G^/0SVF;(EJ?cX7cOG)@c#dP@aQW>A
3:Y-@P:02-SbK509RE>HCZ+P[J+UFP\c#-+Z9N._?U&^/Wb],L?BdgF.=_dP=AOK
HB7C.=PL>JX2^L/K=F(8bb[=<+;N-A&JdV@ab#?FFJMbUPO\JW<<VU\2;gMDd[1<
4PeGP3[VU5(2RF6Z?H:87Q:P)9-gF,=V#9NgU^+GbU),BH4IT+]71f<IdU(_1K2I
TPa8:-MBNUT11MDTUU]&C5#cX1fg7,J9J^3@adIM@099aaT&].NGK7dRA^K\+]=a
XaESJ[K,[W?M;UaIb11Z?A0+)#]@Q)N\9#K5WTC#EMVZ@1Ne4_Dg<@>P:L\V@DWc
)B3H#5^aKbLa;WZRQJL>,/&\5KL^bYGf(/5V/()A+A6)K1GR2_K(<e;^X5[H=97P
,P<59K_XMD:EJLO;>Y/1>#&C@REU[[/O/daGS,UDII451,EeB_(4MP^cG[<[K8;N
CccD8[+)D1g:#FgB:c:XQ5LVJ7:D+P/KLV=3Y5BRYY&Qe[2:L9,;@HPTZN0JB7Kg
<.Wc;6+cCXAJ->MaG1g(O,+DT&c/cIe3I4+DCY5dQ/I37#9[7I+HFME2J(D,eJWT
&UMWFWC4X37B2++[PUB7;T-#TK;a\3F[4e27U;daFKd>AY+D4dC6N0)+-Ba3FX/(
_R7\U@U#-6(Z8J)XXN(;AQW=gX)Z4TL5PH\bYT1>LbYYR(99\;Be)g^<<=X@@(Va
LN1-C@c\F9+GYWM\0ZEQGF=V>a,1DB^^I7=?:@],JP#?C277S;..<@P#L56ZN4]-
3>A-]UVEa7<F<6g\^5?_@@gY:WLaLT=X[f]S;E54\\FfBN&IGC#J@5gD1;/[dI,0
AMLMOQ8^_ASUY&N10)M:=bXd_cGFX>)5H_+<H.6,a>NL8TFdHF-?.-:IHGW2?aCX
;NOY\_#bI?VF3e8PHdC4ePAO&A\@A/(J/K/_#bQd93#c7&LN._eKdG+KKT>Q2OZZ
H-3>+-Qe-?bZ2E7SEL@R0&Ybb_O\(KCgE,Rfe??K;K<T\dK3&X0,R>+S0cF:eITI
EGRPa\+TJ_85:9e\g4QL8]-YCY2E?1D&gOTRR8dF;E.E0MD4A^4,00eg[M#A6=M^
^S4gS93+(EA0NT(^X_U(ge2TB[+P-MMHL,(V7ZeD^G@.EW?#R^D78_N\dD(VHN0W
?_R@,,(fR1PaANf=g91g14Z[@VZ908P>0DH-,<3,>>I6Jb-++R:_2,I0J]P<:3]d
S)T6,^CW[\X<SV06)V/V;X.g?[eg[DY7:8FM9WO1W44)Z5VOUcAbK,=9g97FANL0
XO8-D;d=F#5f-I@1@#L^_<W#1XeXV]#.cI5E\MaG8(33@I7E,OYN/VQ5[4H0b5MF
:#=Y?g8<0VJ_15^YI_@Z+RQL1O3-cHb(Ae0CT:D@.I2?afO7Kg+Q?@T.&A/3#<I[
D(8^ACQQE,SAMYG3b@dGZY>8:1EHD2cbT:9+0KP8=&9OMAA02HB6\b+XN[=Z1c@4
+f#P8(N[F8/gI9\IP9TbALOFbJ0d@33I\d[6_/]2V0A.VJPW#\fOYA+G,OJaaTG(
0BE[dce3?2#.T4Q_:<?71BF8.P<<GU/6ROA?;1=/KJ+1OgDP3Jf=DJ=)cZ;I\\Cf
NFIb#Ga]_[(3L_g83ddCaa#d79C9B/F/R3SGC^.@4[BIM<g(O.\NZ?@?<+)0H/3B
V,7T,_:f/3-U#,[U:3<.TIcdLHPf8?P&,N6^N6EGaX4b+?]Zd=8e&9NLg2[2Mb7X
d9]H:<+OTR&f_Q_9CL0c,.M4:[>c2/0MM&_YE2f[=:Ze3(2P=X+C,YZ>ZS[<Oa(H
e;.K(;>S3MZD8B4?gXgD)S1[AdcE-L1W.3A68?G5ZQeS8+bV?3\9KJ/dN2<H,TZ/
.a3_:_-V^Q[RDE3,W0C>=#O\;[-d;Y7:5gf_:WV5&M\6@bO^g+KF4GE6JBbRd]:C
K]>[@-U[17A#>C;F<\Jf^(/Ve.F1@].Y>0f+#,(=B9=Pc+^R?S0.OTf01WU8CO:b
FYdCR:_#&fHPHWV211Sc#>]EKP5aP.<ZXZ>R6;CE(2RaDeO_U?8+2(J0MAH&_)UK
-K(K:\Wa>?Y),+=(9Ae7E>(<U\/PCRO)7Y1_1SG28]UFZa^bbbH47f3D1T].-X7=
=WHC^75:6E=U>G4>@Ae:GZ4?Ma+J?PO]cd06XF;@[WdQ)R1NEdZ?Hb/@]6IEH_:/
-&TB/KNYTR8J_+bX-3Kc(5NR2==KDG0+/P]1U+VZ87OMa6@_QB4/\)#OG2RIV;R9
:OCK-UR+[S[^JO[9<DMCc4Scc_b-]C2H33L+4.W)XBA0S2Y@Y#H?(F5JY,K=YLIX
c<[9bPXV@[U+ZPK>P_GGC0EV@)C2#98_/+E::_#L)JXDb>WKSMO1eK;]DOHDS.cK
:0C::_NV6[I<PTJ@\1be1g)a97:dBB3(CAK+X^7cCMHL#W;a&Bg8Q]S^;M13B:9g
8G=Fg4Z-c?[7RC-L(R&()64WIe<-S][Q&4HC+(aVU8NGeDE-J;.f/b_\1#-^QRA(
-8CQY#.OdR)H4:8/.d1B]gf#DW)NQcEJ0&8L=>;UC[SE;R0EJ+HF7AJX&B[6cMIX
f:P49e?.710/\4dIdKa6,;T@1I5\aW_8WOIO,3.CK_.O9S>+X[0fcbL;LS)<-_69
EDQK^3WC3-e;gI?Y)MR@FDa/VDOJf+BJ578^gQGC_89ITX/UC,3TQEUbF2H-25;:
I_AbV.VK,AV\7L&WCbXHd5A<#VbWO+V6Y(2FJ99]XD:4&]GIIf]5_cN3T>CZI6J:
3KM8-;(-ZP=4\B\aIfKA@YMWg/JTRg9<<LSNRKa9JgDHQe#X>-e)K=beUfZ7P[DV
E7^,:A-I-BYXMUIR\/SWNXE\P:D5^>#73M9Rd9eCX+MWVMT-KfTG[,A^de@Y.LTf
_c]YT-eSX,cOYQ_WCaX.,N^SWA&5X<D+#?8VV0b@?[0X#f,BGWaX:RB_\Z8O4^44
e1/bX=MULL1):8D=U(42e[V1LO[6FaVK1NSE\T1K2c&ZQ=_L9V_3dH,DYM[T0W3a
O)EU)_KK6.cJHBQD?\\b7J@e(Q7UDeLWC_EY\465P\U0E^YEZ-U\,CUd;P]D;VHc
?FZYXQDUaP;KYZCeg#8O;5RB#.448&Pb]E3/aKS0fUT>aRYU&J85cO-5f@L^@;DE
BbSgg2\<KGTZgU(U#Xee>c#3S0N?ec[\D+[S?8(MV#g5K):gbb(YPZZIP,@;=/X^
4^8AD(+33DGW2aSD927V<I6;RA#9TC66:ERS55/Zc8Y:+3e;aRD#1M-35Y)a//C[
JKaSg-\+G[)Q3:@Z/Y?V,WB_PO:c62=&^:@&FBZa@Ba\7_#eb\KMU+ZHEQ#RJQB@
9YFfM>ACfA/d3#^TAS4T4_ZZK/ONf+OLKJ#I^#Z#P]X&eW)3DM4_H)2).?d#:M[G
a3YV+cUe,Z<,.Y]TUXVF40XXc0EPIb.b6^EK9V\63/aKJgB[3=BP3+@#P@XV&GU=
Z;)W9#fNdg)4c#EX42F.\cRAC5&0R>+YgEMQ1;YcKc9=GBVY[@dcP\.2((P2.=,6
eR837f-_0-dJa6PC_T&03B)N-KJ<,I080X</?E&DK@g2#DWRbB/Uf:#_I>\N#VU,
(L7PZF@g4+P)\3]9(&D1KQ>R1eX3+V>,Q#H1W1=+LbTaM)K[ASEd0(VHJ&<gd105
X<+,&(JJQTNW>-OHgS;cgE+?:cZgZ0PHDZ;O6[J(fMg-Y2-d.D/?K.@IVS#I2;F5
0WIS3a2?CM4AbA5PA.0+]]:-K7VaDE.=9)Z8_b.=32&df\?FedLW8+e6D\#a7@6R
=\S7CMI\+,a\A4QF=2Ue)+G:e5>X:aZ+Wc^T>cf5JeDY3eT)]1KgGUZ6AF8MOXI[
9BcXfLX3[@Z.LSg\.909g8eV,a,99)6.99FeN:+Y8/YDcJeJ=fQaN7_30UVW9FTF
>Fe-UM-6d)=f@/6T[VIfP5T)41aJMKP_fKF.U/O>0/?6e8IP<?Ye19+d1H/4d;\Z
eb2]E5^>NL;^0N40-McQD,ITH=CA<K96T1F;[eVUK&1K77&T&I(9WZE[]0>U;]PK
59FQPQ6dO^8CP8H;7@)EB??XcQ&<G<X[G5#P(,@KK;N,e?2[;?2/-/>eHMQDf/9@
WED:K\>MZ;FdXT+,Q4IGN-V6.40IU+M\eNG)];,-WK\6>G(Z/FL=\^JWQ[5U<XW?
O(2HbI._Ve_7HD.c5I_6;QJH2\/VBb822IA&_LT]Y7305Q,JU79)aY4Z0C)<#fLO
V71L5c:ec(W,ZQF54eF,Sg>KTZNEQ?.802NSc_+V>>^SeOa5,C3VD;835UcE/>->
3QQEeR&@=@2KaE^=]@5e/ZgE8Y\A-92b_MW@K/+4OV&aKe=G2QSZI&AA=\WL]H[H
E-fCg-4>;UI;#UTe0)@XB1>[ZdQ,1(13RRa+B>8e;A0:MZ?bbLY4&b/Ab84Q^UPg
:8/H3T+J0/YcUV3)KET:GaOgDI:D>7/4#=\&GIH>JEYW1Ze^?DD\5GF0^HZ7)#=T
WF7fR+(6\FN\.CRfg?@</c3U,P0\7TN1P/E@,VA1J3K2AD5R9O?LP>NcTUg@VL1Q
PK:?QS3bK6d9c@@b_f?WAD0O6F.ZP8MDFRR,-7]-)E^.Lg8PQ[T4+.?QCLD66Jg&
X/(gVV/cWSD<TM8BcCTF\9)O&MJ#6AO=QOE0QM?@ZSW&P?=G79\]-PN)1GY>_+Va
)9QH/&I7=PH(64/eNT+,__\<ZRSGKW)EREMDae/M7^Jb^)FKE4[?<-F)=)+8]Q+F
33f:HX3:U;edHVa/;^&3+fV7BPcN6]>=1Y+V;J&<2@J,+2LHHK/fR]=>&bfLBb5-
;>S.MFQDaY^6:Tb(G1#</Ha7^O9V..f:=gMHH\c51WKNH^IaM)_@TbAQ[f.J3YaG
(:RgeO1X:QQd-5#J)V&KD@L==Rc+C7]GTNSO]bKH7#-76Uf^T9S5eddI7JF.X=FW
JAafA8<DO>DBJ<?C:HPY0Y_L(OO(8(+:3d9,aMMCM.N/L9Y+N(\6&<X08.b0(O9b
=ZeAY8#-1WG^5,b>O<5bVNHK)_S/@Q()NP@RUSYS>;M^02acB9JAddGTWNa&JE>:
:P\@cME2#[-f^@:DTOUQa>,-TI/YCg4?&]2AU0]BR)UV]2#e_6/0:Z,D4P7S2SQ&
<034)8]JC/./;[ac/EE]/TPe>9?.JP9a)FG@H9997\UU+(eA,]0A8a,/-2C8Vg=H
6gINJGdEW7;[GeGQR\+]MC,8IF,IM8aWee[-P.aa-a;KD]9b+0]U<=]+dfEbJI+D
5d2IN943b>7B,J0N)C)5FX8W1e5MW]K)FR&_8859&23ISe\DNT+YKEDH4;W>2QN@
/=IRAdB/cSa_MSFQg)]8AW\gbIFgTI[E\_QAQV/IAIeH1\@@4LReA@&V?9O--85P
[H/\CZcJ&QC[gMNV23A4V(4f;8,39>@F?^c_<_N6G3Ie<0,,=(<f&01gX012M2V)
Ic=E5gDYb8R3f^+&gX)]2)B_87b4:eDM>b:cXS4Be[UbS\U)a)OXS[Z&&<>P1W=[
&I\ZQQUDG,6aRX,A:=;_PQ+EaZZ<6cde@/7(O6eL:4F0D=(EZ-E]=>HSL=0G]]S8
9&:T_7?d76=4V?G8bP^WZ8ETTK#M;.Rf2eAQ2W>EC]3@WH?B#X;-RY=Sf;V])dQZ
,UEK\:0;(Ac8bKZ(SWW]O_Z-1XK85EH.9[R/F+#@I,J7f^S2X_H1IEWQKUJ8&H\/
X<aD0_+fWWKfAD<R_4Y@8e34@Z(]Q366WaYO+47QH-CBfUN\F(=aedT94MF]+cg5
f#bC2?(XY.d^MT4gL,W6WTRWZS<WXB+Z9MTMd0=>E6^M8f^J+7W4&#_^S]<.WT1c
(969;XF3\3K&,4G-?AR&a\V\bef\_/cUKL\[6[?D,Z9I..99&3>T_6I[C=TX<8+c
#GeP#7J]BV6BD96Ca..[3)3&ageY2dd0BUQ-U??eRFbZ+Fe_T(:]X<>-.S.<g,^V
5\g#:NZPHg,10Z5[SbI>f&VA]K^-8I>;SVI;\0).>+[:)VWbARRb8M9N6NU,XO-E
,:_W5@=<ZT97]II15=(#cLCa8^9N&-?]B<<adRW=eZ./SaT@T/ZI#D0W4IB0&4MC
N-,8OH<(RLf>6>.RfFe(JfTdC5@WU-CX02<Y<e36U&g\VfA?<H/)6)^1cf65RFVA
PaI^&-W&,;V?-#T&@.T9<a86JVZK(H0TYILe92.K=71OCe,F5CISbc1EIY#e]S?E
K3&G#QBf^)==)L=f0?gT83:b;#/>5>bf.:-0;@IXSBG3U-3,+_8b8&c09bYUO[Pe
E]g01[9O5L@L4)]<E]Qd<TJIb?>4MJQ>bX^3F_A,+Z]/SF^6B5N8=[UaT1D^dU,K
I6KJ8J^]<;SBK@:?>E]ggMH\RXP8JDXZN9[G][Y[gPHg9FEN5_g)<1c3([+H]Z#6
JaR&M#]deeE6:\ZLCX>@cR9-&ACCg4@YeI^0G50]5)[GQ)\LIX3@d1a.#b@]1ZG.
)f]_-@S7=N(RJ7D:0>WPWQ]2aX3Ke,Z62S2a1C5cd=[BSC<C:9?NGV)e;C]d.Na^
M8L(d-5K^SAT1&gIO/Zd]YH\(N1Pf42Wb:eLT07SQ[->>P3P+P\9^b)R6PUEf?2A
e>@Sg]HLO9(2ET5aX2Z,3O-HA7O-IQ0MfA:OP/.[]Og;UL,\JAR[571^?&]>:1JR
bdEP4<L^+[I0UXQ4BT(9XW9W0CPcb]P>,cBXKbRZ1&#=)C8JX47?LcGfJ>NUK)>:
MSUE]\.Tf//)K6IBIb)(>X4?Ja[5eW/7J>&H.+&R=Y;PUZ#6W)X/;#;A1?^S?+UG
=ZGKA3d\G1c8+_&)^KJ\<IIM#A9N&6#]f[;bN5[;PGH]=#/TeI1/e4YAW>8,.^^U
a&..8g6_LB?.?)B6.a4(=b>B)0<W39(5G;7]Y>?VH)/47<@6\;;AdL\])CS(+]3W
]L6JJV\__QQfe8Ce&>>c\GC#a@8@3=SaE+MF-T[;B:-([_-1BKO-L(>0GM<XXMT<
70d\^)(G7VbfH/317#.^8Ca)R;)JeW7F_/TYOUS]W1+L8Y_;F?fS4NX&EeP_EJ1:
/>)YbRF:,57NE(?Yg<Y#dAT^BHNf4K6:>EDO-?efG(C8_,F)RQ06276e37;LR>2Q
Dfc.L38CWZbK^US1)4=:0N5+P+^aV0XbL5=]bg\&.IC0>)[@5VSbF3)[(V81A\-(
JZP3/)ZI4d,aQ)-TCIJ81R&;f=L9BIVHFP4[HBO5f=I@3d109M?a[XQ^;LQ2WR8E
G380R?B,@@?&,#eQ3\=P@V;,J.?BO=:\/U8T2?],.8aMZTDV-/3LB<+6RbO/TM0+
V1E].#CCbM(9gT\T6YI;\VaDG\C6Y[:2G;)B<T0C,dfJ9bRg()e:B>1=7T,6\Vg2
\cLF#?P;2Z:MEFR>.Z5aJ;[agO6MbYegQS^D2_]@RLC<]^,Z#_OL6WQ.c&<dL\KS
NT\SC2R4RX0VK4,W8R-A2=Vde,+e[@/6T?-G4dFJJ?c)=^FX5U9DbB.d4EJ8Z1?5
b?=+3YW7LFE,1NU<JNO[A4KDf:Ne60T.=6=]G)79\MII<G28K>T;MKf()cI0eLUY
IKJa>>A3#&^O9N[4RAK7H1BHIIKH#2?27M0^5;.LAZ8;@#I=P)+X4(Y2N5JJ<A<g
30Ng;::N<1/]b7?W-GOPHg<eD9c#03?VAfagN4I5VS/\A5fU<ESI044FMGN=?FX]
d_]\-\M+<.I]0$
`endprotected


`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















