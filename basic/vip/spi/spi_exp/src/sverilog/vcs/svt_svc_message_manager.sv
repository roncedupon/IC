//=======================================================================
// COPYRIGHT (C) 2013-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SVC_MESSAGE_MANAGER_SV
`define GUARD_SVT_SVC_MESSAGE_MANAGER_SV

`ifndef __SVDOC__
// SVDOC can't handle this many parameters to a macro...

/**
 * This macro basically just deals with the optional id value and then redirects things to the svt_message_manager macro.
 * This macro basically just drops the optional id value if it is encountered. It also only passes along the 0th arg and
 * the first 19 of 20 'other' args if no optional id value is encountered.
 */
`define SVT_SVC_MESSAGE_MANAGER_REPORT_MESSAGE(dbglvl,id_or_format,format_or_arg0=0,arg1=0,arg2=0,arg3=0,arg4=0,arg5=0,arg6=0,arg7=0,arg8=0,arg9=0,arg10=0,arg11=0,arg12=0,arg13=0,arg14=0,arg15=0,arg16=0,arg17=0,arg18=0,arg19=0,arg20=0) \
  do begin \
    bit has_obj_id; \
    has_obj_id = !svt_message_manager::is_string_var($typename(id_or_format)); \
    if (has_obj_id) begin \
      int message_id; \
      string f_or_arg0_str; \
      message_id = id_or_format; \
      f_or_arg0_str = $sformatf("%0s", format_or_arg0); \
      /* No SVC clients current rely on this feature, and its expensive, so skip it */ \
      /* If and when clients need it, they should just call sformatf at the source */ \
      /* svt_message_manager::replace_percent_m(f_or_arg0_str, DISPLAY_NAME); */ \
      `SVT_MESSAGE_MANAGER_REPORT_ID_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,f_or_arg0_str,message_id,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20); \
    end else begin \
      string id_or_f_str; \
      id_or_f_str = $sformatf("%0s", id_or_format); \
      /* No SVC clients current rely on this feature, and its expensive, so skip it */ \
      /* If and when clients need it, they should just call sformatf at the source */ \
      /* svt_message_manager::replace_percent_m(id_or_f_str, DISPLAY_NAME); */ \
`ifdef QUESTA \
      /* Questa works way too hard to try and look for format mismatches during compilation, etc. For */ \
      /* example it appears to assume 'has_obj_id' is '0', and execute the compile checking as if all */ \
      /* messages are non-ID messages. Which means ID messages are checked relative to the non-ID block. */ \
      /* This results in the ID 'format' argument being processed as the second $sformatf field. For some */ \
      /* reason Questa actually sees the argument placeholders (e.g., %0d) in this second $sformatf field, */ \
      /* and complains if there aren't subsequent arguments for all of the format argument placeholders. */ \
      /* To get past this we send the 'format_or_arg0' value into the macro selectively based */ \
      /* on the 'has_obj_id' setting. This is enough to get Questa to skip the type checking. */ \
      `SVT_MESSAGE_MANAGER_REPORT_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,id_or_f_str,(has_obj_id)?0:format_or_arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19); \
`else \
      `SVT_MESSAGE_MANAGER_REPORT_MESSAGE(DISPLAY_NAME,`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME,dbglvl,-1,id_or_f_str,format_or_arg0,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19); \
`endif \
    end \
  end while (0)

`endif

`define SVT_SVC_MESSAGE_MANAGER_LOG_ERR           0  // ERROR - big problem.
`define SVT_SVC_MESSAGE_MANAGER_LOG_WARN          1  // WARNINGS - some kind of problem.
`define SVT_SVC_MESSAGE_MANAGER_LOG_NOTE          2  // Notice - something that may be an issue, but not illegal
`define SVT_SVC_MESSAGE_MANAGER_LOG_INFO          3  // Informational
`define SVT_SVC_MESSAGE_MANAGER_LOG_TRANSACT      4  // Transaction level
`define SVT_SVC_MESSAGE_MANAGER_LOG_FRAME         5  // Frame level messages
`define SVT_SVC_MESSAGE_MANAGER_LOG_DWORD         6  // DWORD / PRIM debug-level messages
`define SVT_SVC_MESSAGE_MANAGER_LOG_DEBUG         7  // debug-level messages

`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_TIMESTAMP   32'h0000_0100 /* Don't display the timestamp */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_LOG_LEVEL   32'h0000_0200 /* Don't display the Log Level */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_PREFIX      32'h0000_0300 /* Neither Timestamp nor Log Level are displayed */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_NO_NEWLINE     32'h0000_0400 /* Neither Timestamp nor Log Level are displayed */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_TRANSACTION    32'h0000_0800 /* This is a transaction msglog, write to trace file, ignoring log level */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_START_BUFFER   32'h0000_2000 /* Start Buffered Message */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_FLUSH_BUFFER   32'h0000_4000 /* Flush Buffered Message */
`define SVT_SVC_MESSAGE_MANAGER_LOG_OPT_MASK           32'h0000_FF00

`define SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME "shared_svc_msg_mgr"

`ifndef SVT_INCLUDE_SVC_MESSAGING
`define SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
`endif

`ifdef SVT_SVC_MESSAGE_MANAGER_USE_SVC_MESSAGING_EXCLUSIVELY
`define SVT_SVC_MESSAGE_MANAGER_USE_SVC_FOR_LINE_OPT
`endif

// Unset the macro if enabled for unit testing so that the additional methods
// are tested
`ifdef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
`undef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
`endif

// =============================================================================
/**
 * This class provides access to the methodology specific reporting facility.
 * The class provides SVC specific interpretations of the reporting capabilities,
 * and provides support for SVC specific methods.
 */
class svt_svc_message_manager extends svt_message_manager;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Used to build up messages across report_message calls. */
  protected string buffered_message = "";

  /** Used to watch for client_verbosity (i.e., without OPT bits) conflicts between buffered messages. */
  protected int buffered_client_verbosity = -1;

  /** Used to watch for client_severity conflicts between buffered messages. */
  protected int buffered_client_severity = -1;

  /** Used to watch for message_id conflicts between buffered messages. */
  protected int buffered_message_id = -1;

  /** Retains the source filename for buffered messages. */
  protected string buffered_filename = "";

  /** Retains the source line number for buffered messages. */
  protected int buffered_line = 0;

  /**
   * Used to indicate that the manager is currently buffering a message. Note that we cannot rely on
   * the len method on the buffered_message field as we may be buffering but currently have an empty
   * message.
   */
  protected bit buffer_is_active = 0;

  /**
   * Indicates whether we are at the beginning of a new line in the output. This is initialized to 0 to
   * that the first line of any output buffer appears on the same line as the prefix.
   */
  protected bit buffered_line_begin = 0;

  /** Flag to indicate whether or not to extract method from SVC message
   * string.  This can be set by individual titles in extensions of 
   * this class.
   */
`ifdef SVT_SVC_MESSAGE_MANAGER_EXTRACT_MESSAGE_ID
  protected bit svc_message_manager_extract_message_id = 1;
`else
  protected bit svc_message_manager_extract_message_id = 0;
`endif
  

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Static default svt_svc_message_manager which can be used when no preferred svt_svc_message_manager is
   * available.
   */
`ifdef SVT_VMM_TECHNOLOGY
  static svt_svc_message_manager shared_svc_msg_mgr = new(`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME);
`else
  static svt_svc_message_manager shared_svc_msg_mgr = new(`SVT_SVC_MESSAGE_MANAGER_SHARED_MSG_MGR_NAME, `SVT_XVM(root)::get());
`endif

  /**
   * Identifies svt_svc_message_manager which has an active message buffered. Message managers setting
   * up their own buffers must make sure active buffers are cleared before initiating their own buffer
   * activities.
   */
  static svt_svc_message_manager active_svc_msg_mgr = null;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new SVC Message Manager instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param log The log associated with this message manager resource.
   */
  extern function new(string name = "", vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new SVC Message Manager instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param reporter The reporter associated with this message manager resource.
   */
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to report information to the transcript.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void report_message(int client_verbosity, int client_severity, string message, int message_id = -1,
                                              string filename = "", int line = 0);

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
  //----------------------------------------------------------------------------
  /**
   * Method used to get the current client specified verbosity level. Useful for controlling output generation.
   *
   * @return The current client specified verbosity level associated with this message manager.
   */
  extern virtual function int get_client_verbosity_level();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to get the current client specified verbosity via a local message manager.
   * 
   * If the supplied message manager is non-null then this method obtains the verbosity
   * level through that. If the supplied message manager is null then a message
   * manager is first obtained using find_message_manager, and then the verbosity level is
   * obtained through that.
   * 
   * The message manager that is used is returned through the provided msg_mgr argument, which
   * is a ref argument. This can then be used to update the local reference so that the lookup
   * does not need to be performed again.
   *
   * @param msg_mgr Reference to the local message manager
   * @param pref_mgr_id ID of the preferred message manager
   * @param def_mgr_id ID of the default message manager
   * @return The current client specified verbosity level associated with the local message manager.
   */
  extern static function int localized_get_client_verbosity_level(ref svt_svc_message_manager msg_mgr, input string pref_mgr_id, string def_mgr_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to convert from client technology verbosity/severity to methodology verbosity/severity.
   *
   * @param client_verbosity Client specified verbosity value that is to be converted.
   * @param client_severity Client specified severity value that is to be converted.
   * @param methodology_verbosity The methodology verbosity value corresponding to the client provided technology verbosity.
   * @param methodology_severity The methodology severity value corresponding to the client provided technology severity.
   * @param include_prefix Indicates whether the resulting message should include a prefix.
   * @param include_newline Indicates whether the resulting message should be preceded by a carriage return.
   */
  extern virtual function void get_methodology_verbosity(int client_verbosity, int client_severity,
                                                         ref int methodology_verbosity, ref int methodology_severity,
                                                         ref bit include_prefix, ref bit include_newline);

  //----------------------------------------------------------------------------
  /**
   * Method used to convert from methodology verbosity/severity to client technology verbosity/severity.
   *
   * @param methodology_verbosity Methodology verbosity value that is to be converted.
   * @param methodology_severity Methodology severity value that is to be converted.
   * @param client_verbosity The client verbosity value corresponding to the methodology verbosity.
   * @param client_severity The client severity value corresponding to the methodology severity.
   */
  extern virtual function void get_client_verbosity(int methodology_verbosity, int methodology_severity, ref int client_verbosity, ref int client_severity);

  //----------------------------------------------------------------------------
  /**
   * Method used to remove client specific text or add methodology specific text to an 'in process' display message.
   *
   * @param client_message Client provided message which is to be converted to a methodology message.
   *
   * @return Message after it has been converted to the current methodology.
   */
  extern virtual function string get_methodology_message(string client_message);

  //----------------------------------------------------------------------------
  /**
   * Method used to remove client specific text or add methodology specific text to an 'in process' display message,
   * and also to pull out the messageID if provided in the message.
   *
   * @param client_message Client provided message which is to be converted to a methodology message.
   * @param message_id The ID extracted from the client message.
   * @param message The final message extracted from the client message.
   */
  extern virtual function void get_methodology_id_and_message(string client_message, ref string message_id, ref string message);

  //----------------------------------------------------------------------------
  /** Utility used to flush the current buffer contents. */
  extern virtual function void flush_buffer();

  //----------------------------------------------------------------------------
  /**
   * Method used to push a message to the transcript immediately.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void flush_message(int client_verbosity, int client_severity, string message, int message_id,
                                             string filename = "", int line = 0);

  //----------------------------------------------------------------------------
  /**
   * Utility method that can be used to decide if the client verbosity can be supported.
   *
   * @param client_verbosity Client specified verbosity value that is to be evaluated.
   *
   * @return Indicates whether the client_verbosity corresponds to a support verbosity level (1) or not (0).
   */
  extern static function bit is_supported_client_verbosity(int client_verbosity);

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
  //----------------------------------------------------------------------------
  /**
   * Method used to redirect a message back to the $msglog utility.
   *
   * @param client_verbosity Client specified verbosity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   */
  extern virtual function void msglog(int client_verbosity, string message, int message_id = -1);
`endif

  // ---------------------------------------------------------------------------

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
49IV\>)?I]FbeAb+6N+ffeDf8>G1IXX&Q-GJX2SKc5C<CIWZ:9bY2(,.A[R12YOL
\.@E(1UN?0gX7KO:YA7M&d>KC8#\_P3NWeGe&&FTA2EU4J2e7b0R_UO7FLWTXC?G
B3&KMYACgN81>JM#aKQUX-VW0</8U>L\c4C5TOC\eZ+C[g6@M?0S)faOSbcJOR_)
Q;J/0M0fSSU3J\.aQ1@YIF>AgHG95+6WZa2_Hg02W)c/Xe^UI9fD;5B6->3Y(0dS
1CI0))QU8_N<:^R-WWE_g?We3;8\e/,,JL]2PSV>:LK(b9^4+JA]9?7Sc(YVEPN,
=OL]RPE.ZNE6a2aC&B(&7NBLNP_AU;0bAK0@<IQ>PP+LLEQ\0V]6GERa2fTUWIJY
=O/:U(>B=WE8CfAW6b/JR2f]4ZKNcPEae#,23V9UD@,6dUde[-_24]_C^a<J7A[>
#Qf58.(C+83IH>SK;Y)X5PfE_7=,:+@LUR:,#[-CGb[<1C=3aK4UN#_C6&WaYR)\
>?1H]V1P4EIbAP2A7N#CCVG\<H.X5N8^#T#9\9DE[]>S][]deZb,8FK6Ef&33I#J
_dfVg@6b2.2F_>@fGMeU@H/&K4DY9?gEcKc38A8:22&4GW=Y#FENA+Hc&^27:042
_,A1)^.0]6^@bZ,P]RY;[7?88F)MMND0Ya,I=-NBV+F+XSX)Mf/[0#4ff8eJ5^<6
J.#&Y13XR(ICWKga8,Q@@=S5D_5&f^^6.+343HYT6JB9L4+@Y,.5U?fW/Ud.)a^4
B5@Y4Q1LETSGa&]0GV\JW2M#4:fXGcfeXY6JE?<;5g9\f?2[=WUU@EA=&(?.5,WW
,VIA]NgCVJ6.Q7SZ.NaCaB?g4JJ39=/8>ZdI+]0+d81NPAOSG0M@UcUJ)fAPVG@a
DNQW0[cI1=V8^P#I<XAJ(JSZX[V2^V3_.>0PXc0>VPN.<H?f)E_>OB\<>F_Bc[eg
5Q+Y_COaC4/98VO#0U)HC58SOYL&4EFWSGW(f)W@Z(GU6=NV#JI9<TXXK;88a1)O
We4?c>._\aZN8FE2a0Be[/G+EYN5N]N8P82Nf;3JVE44#W\b1DaC0..aE,N#W=cW
R0)=RU==LFG57)3R0Z-H,fcS(d1&FV//3J@&#387O6df=CFH??A?6\5WF6e8-]E0
NW/XAZ=f7fT,=adT0#1;Y#,IU4IbI9c&Y8G)c:28C\K[N/@Y&c\1&QW?GMRGYY\B
3e2IND-gM1/KAV:_);[<-+DW9[N4^^=UEZ;Yf7V[:G<:X8a08_(#GOILBF&:DfG5
:&(,aR?3@g32F63;#A6:JC)3GYW=5@)a\,?Lf?6^:+F,C^)9#T6JBQSS,Q]E95,@
ca1F3d^#C.SV^U8eOR00T@(&SWCB0.3e#(c;(KGU-WfY1KZS,T-]&-aZ<SC:@O&+
4^D_4P2FgGLCA4+B2+SI99Gc][J9X:3V)9M5>OEe6cV;,Kb>^g_:M1HI+6b6AGF#
d#/39A+,E>d,]0<gJ</f.S25BZ)5T>.bLA5g3&_60JRCaf1B#c5+))D[1Sb>)<&c
]MK3T)(NbDe0V@2(M681eC<DfK(TKI^X0RR55/CEaF3;?&5b<09MI(d]ZY,#\fbD
dX&V0)^4GB9#/[9(bUDJX](g5=Ped[GV(515CH.6S63]8d6\E475Ca2E-6FPUfC3
bM1]BdF<fC\0^^P?<)J?RZcVdIU@^Ob<BQ7[82WEY>&H@eAN(+g1(&4CU7IH<EP:
0+/X_]5e])<Cc539,LC79LV?cG]V)NT9_^O\36R>=EG2/M?c^LUGQ->BBPa6,+M1
:1X:@WZMTG1.P18R:DMH@8BUZMbW(fe2@NDGMW4=T16>b@1gL8^\4JCR=dZSZF>Q
d2IO\B(UfQeWC@C/ZdX0G:e5.BB5N@&?>e;=J4]-9gB7AS^Ba7S_UF\D=\GO0>8>
SP3]ISSZ:a(=)c#gPZ^YEa;8[:aHP^\D?51^ZOfN/cV>)HHI;[IE+ZH2:c_bCbM@
,Be8fX5M,GPf3S0<3>7YMg&9f4&_&VLR@dW^WN_Q(2#28M4K>,U6VJ+G?TEIF@<)
\X/]1@?9??YeA&;/1HR=P<E9Q.T51g;NPR8F]g=^<N^N-8PLT3QMTCC@)_7Te/&R
2PCR#gOX>.(X88>J2?_G_)0gd#;2+GRD7ab_F_W[=36K?K88Z9A+\(-WRL8Y6-<T
G0Z:Q2eRBgSDA]Y4c[/-^8LFfU3@/ZN>GTR^MEg)-a2;YS)QeD(PIM^#T1d42@Y1
b&8U;-SALJ+e<LcS+=^H7UJC,8]?4-LbL&&;R^H^,gf6_8Z_:JVY@F10=J?)g;e)
J0+HNgXg10>L(.Gb.8fLR_IC+=JCaaPa/P/VUPJRXe,_E9=JD^@D@5Y+G3RC9L<\
\9Qd[DO:1P\_;JEN(/\L&6C1T\LKUVJUI4R+DVYKU],TaM1RVW,B\U?5VR>e/;=F
+cERHB?cJfY&bEUNf2AB]d4/b@dABFIP>D7WI>;/A6H3e#1f7G=(Jb\#&85P:>P4
J6QWSX(VU]I9IMKa_T?A+Z#OBYdC6Q>Z#e1cHPJAV0GL1@6PYL9-:5[AT1_4_0>]
3JJ.(SO<-<]a-&>&Y.f3B:Yc0ZdR_EQLSV.Q:#TTJW3E=1N?:#-X3aH@#6IC[fF&
dbd/:IM/[E\B_[=8HTYJK.59PH<.,(ZH0<G_;H,M0=e2_E1#M+&IO#/cUC<Hf;a(
H58Od:P3cI-9()#OPaG&9ET[b.C][OXSgX8T/@Ng03S]X?cO1T_.:Rc,(?b1(Z#+
L#RZE:=Q1dgHV5)7WN&H7M:4fL+H)+e#=-.5=dgR^6J_W.K[,a2Id@2J(WRMH.6P
-1d#e3a6009/1H:NGgQP<]]Be@e9LFZC-A1\L3;@V\PWA)1(GWK/XS01G@a(?ZWX
gE<;8#\(@;N7>]PWUXC^WT/1YPb\O-]A>^:5U(.<X0R>&V#Db=#G:?C0R7gIZJ9:
Ob;6>eeP,D6M2,dQ&#.1[WQ/+C@QDO^eC3DVF]0GQdN]3;^7VOY]dZCQYdNDWW3N
\0I4BP8&U5WG[C-9@?_Nc+e)]Z_DgK<(8MV+cLQfJEc@)WM=;PGgZYWXa@R^WM2K
K&0g8?A-GPU\Ld\Ya71C3-b0LROeCE27,\9]KQ3<V\b6Z>5C[]?LAR,.SS83afJE
G+G:7>U-=JCD?J:#eP^:^3Ef=W;^cT?K\&X8;82UBS?H:A&4DW=@)#.9V+7c>32,
;M^VNO3PBY4fI>R>S05D?E+4bG4C&L==6=E3+0+8dbG2>;dKSR<PeNLK#_:B3<a^
-?F\^9]bA4R6A;L5BZ]I1I_5JD39cWc9#=ME&N1&_C/P7E1?Jd5A=e1-1R082M2P
.&>A_O@dI\O)Y.U@V39+bS[1KgE\/g:YgO<96(12g]FN80d<8d87/^-VI1WcCKVD
gB6Pd5KZc[Z2P5H>g-8(ZF4c;Heb:G_7,J:Fcb84(]NO>Z.K5S663d1GMR/g=T;N
IWdJ/1cY(6X8b74W=C?Je.)?K2#X_>0)UJA#O4d-(IFGXEBJ;@WV>Yf(:YUFO]_8
+a^=CI5BQ8BMV45;77GH;(TIfOP>]<(0O/KL0](7H[1LS:E2J_?E4L#<2<00+K1J
<X;ICT;T<<7,.E:,:9cNe?e39b@:?,eaHZF&\GQP8YcA/)B?fS_8@f7H[M+:I.TA
K(Mf5^FGVPUbB:fMGa2F[V3LdPK2(^_&[+ZP8I_ecY_7(5M;0O]?+G)a2QF.22f_
YQB=/&#EPAa^()dYAObWC_@_V=FecVK5fVM5I)--[8DP#F1SXHU0_0Q\E16N6cD2
(eU;-IC9^1ZQLM,FM(JM#0dJ2@/MX,4-LSG]&0K-1_R7L-H69ZPe5?Q-S7VWc1Y.
0P>A6C:U.1X]JB&H=B.e>[[>15>?([NPW,9;d2\+aWGMDASYK/c8NU\UG?@REY\e
)(<02NgeKg^/^_#]I#g.TbNc,-I<D]IegVZJ2:\)fdddfdR6GF<D9(@DRAe#5=YQ
6RO7)cgM^2-.b>UK-9gCUVLe1\(e]WN:4#TGW+360/VVEg00XW@5a[[TDQ+]-<Pb
[ZR,-<JLXHES,e(@X:_K;b[WQ8)PHL@gVYOaTSbC^L8;==?,W;<A]B#HL&WKSg&0
;#(6V0(6OaK=X18XF6JccU>93@JN5.f_Q]?G>-[->0La_#_7#=22EJ@O6eg+-bc<
FJ\gKT]KO)#3P]39+\&_b3UCA1[@-L-17be^<d@Fb>Q8I3VKIB[OZ[_F01\5Z;2]
g@d1QHI)VXFC=&EL\L5Nc#[c=g)HSfS+@c><VA=^0/JJ(=LO<G@4Me]BB7_92;W7
b4,OQ18:O2=g+H9KIEecaFfbVIQE]R5\9aP<K4bHSf\YL,H<_g-EXbKP;7Ub)AO2
+K0NGLUU+V0V</D[<;g5V7D?OR++M.<PZE4E)T2\(A9BIe?D\Z6D;gI^VB_2-0\G
2E_a_+)UE=@faHX/9T.26b6R18N\1O09J?600[1##f(PUNQ2IU3>PKcbU=6KdGL\
5YJ9bHHF,C.UVPF^1)_6R,d&@<[LEHD,\S8;QWZc@J-513[?T=@D7c\[HIAZ5[UM
.PO;R4B&gHU&6b3U\=V@BJ>NFY;J#R1A\^QgL)B9&07:6?GTRZOXESb\fB.A5>@V
P\LRJ2>]]ANd^@K@EfJ\_TV9G,7Bd=e)CHeFJ447A@LK@L;+?;OH_T=_Xc.bV0A>
88dE&]SP/2HfCCJ@A:/@PUVUHL5e1:34)4S6_NUO@NICBBB3PUeAe3/_Y>ZJX(P&
@0dFSLS[@WWJZL#QCf4KeUMAYcW8HHVAbK61bg4\\MOC/>F3VCJc[J=S).C>6?1^
aVIgbHVfADg1^+UI1ca-C/H2B)DRK8/TIeNICZTZ#^2/1<W4EUN,;RGM.fKM0;a4
]N7OUGN1WJggVTW4=^2Z2V\bc.K,Uc7&8WJE76UfCW2#e#0H>/_c)?7JP=S.-NAU
,5dXW\2FVZU4C.BXMgDFEa/W(6Q1/^2]YH3;+7X/NAO_L0e0CNLVg[O?95]D;&1J
Z&g:SKUWU\T+ZEZ)DbUc<=c#-551V5bA<NOI3<HMAbW,JP_G?.265CY.8He;-D(Q
,VeT?I#IdTHd\DAgc<6D?gQF377?eWP?8+^34419GHRA=#7\cG/S9636>Hf?/D^Q
/2D[U(NbcD9:_B(GSX(OUeVf?)CX0UDXW5WA&Q35(\6LR6/XV4T<4J5cg1Oe=Yf0
1)H.eQAJ(I_CcYLbageP8S_U1(Z]Y3E2S\TDV2(8.8R>@WaET8P@PEd.:bQYee]a
G733Q6c1\b(KHYLCH)O1gO\VIXWAL^N^8OKT@GU,]6<<L@P)[ff\JT2g\?Q/RaF9
<Ued-aFcW1H_SN)CdLDR++SHcBe-f5Q=N,Y(eef<Yc6SgH;HL]<)Ug=+[+O@+77O
XgSG\_a#=CPBf-317JFaIVB-Z5)_(18Eg^DJHA.RdeY(=]<RF0F+#,[T\gKfDfIX
1\5G<fR6HZUH06FagF9:S8QM=EW_\#=a)URdG-)/,>7HGU7AAdQ+(]AHJa:M?)HG
1W^^=?<a\OHVD#QHC?]Z0,g17EGCPWW?5YRO^[(DFJV?LEcV@G)Q]DJ3AQL20WZP
JG-&Xb1CZJbZe\6;gEa#4]1EN..a#4cD_B)I;/W(H17WMTV2//J.bR@)\LQ)WRdE
H1F(d;B6=;a?F^KJ<(WL?RTDPd]g>).LU0W9aPPf\HZ<C5L49[JH6f04SK]WK[>+
33VTdfcEa<3W3)UgGcAJPFI8(&#N0g?gVBNWH=>\Z<;+5=g5X3,gMa2O5&FI23U8
.W@I<O6ZaTPZ_;.8VJK75FgA:Ra)ggD^&:,Of@1S7YW2H)&,g];>gE\]O@^F.E>W
fJ,N;ACb<T9[0^;.JF:Te?a-a+Y3,0VIGI/\U<]C=e6/XJTQ^TK?98>LOV34&dR_
Y&:E4X.<H&SH5H[V\;.E;_,2=JHWS#c@^UN^574a_b1JG>K5H#?f+GS5R8NTW:_L
K?(&#W:Af-?4V7AZ;ASVWWH0O<[WI9bE6PL#KWZ55RASF6\ggE^K+5O:&2MV#TZE
Z-F?d<L\S2,AU/V3bE2+JN_Lg@MV>cNgRWcZ>UQ/5a]V0MT@aJ6VVG]_cP^^2Q<N
S9.GUB+Sg[]W^]LDE<b43TYC(Z+N[)\@EQ?d_gWGe;_CUYIb=GR-Z.=D7WMZ)IQ]
7bJMeLPcM3U]+.9:>C>)[.)8G,4\/0FEA<128a@WYY4/2VZWE_E45bV0\TBPCGMF
<1/]ecHVD(3>;IXWTRI8QDSJ3JHDX:.AF2/a+([a3eBa,U@]+?2262KZ+U+\>7AY
.9Y][MHDT=O8)S91,@:3U;Y=+8^Y0)#2S)aL7IVGC/4b2\eFR45S+ZG(,J:Oe))Y
7-4D,PV-0G-K+IaW2KdB\P#R5,>R=CKA1YEcM/1=J62G_,IT8+N37b5Xb^U7M@G:
.3Z6TM=MP.(H26C)bM(bFb1&@UCL30M41BSE<AfD[K[.6OLI2K6.U?UeG.:YVd,/
,&I=;+d_NNFE\RE#-1\>=]K7WA)1FMCG-Y^;U^K\8P3KH(,]NQ73(&?LWEXN^#;G
G0ce+0-H[ZYQJ_5>Cd=ATTU[EF]=]199WB3^Rc.HT;#_>Edgd?]RQ_9efRUcBNTO
:ZG6;:JZ8@[(R,7e(eI]C9&#/.eG[MBX<T9I^A#Z8<KE9:R9-UZK#7LFAPaA(.\V
9,YVH75S&SU8Q@Gb+A<NHdaV4\UQIC:bB40P.YJbd/]+W)7GYGK.VA;cJY;HTZ^Y
J-;3F@RW(?YTI#@W<Y[d\\/Ja+O,X?>:aa9UeeD>6HgbXTN9U]BEUWO9DNI^/1:5
0<X(Aa6RL&AWQ@I>C,c;V-BP<Q_X[@)(OQK9CZ?e)X5f1^_?(g]^(R9Kb_VCG=4M
12>(D-MW?I&D@OT)LQX0W22g8)TEK1J[4I5V/)D9Y-DK0fU=.C:/G@]-b.YPWD]b
=]aRL#@3?P/M#Idcc;77SZ?R4S2JINc,N_:<Ad.R3X#+3]BeB&)g>N=.S2\1)@J>
E/c-MV_c:^R<a=cA:Z_J4KQg#Q51,RR/=O(7C@H@->1:^].(,>NT)JZ,)YH]IY2C
fI3F4cd&9HCMLg:O8/NTKNI8gB4NYS(VD&UC\+Q1f&+e6bcCDR?OI[g/DBd&A/1:
7f/CMKHHBT#NW(:bYc\JW^VVHTLb<La,K9]^27^N:=9ZQUB;<F;Q5f@42XS<@W/#
D:Gcb\e-@a[V.\LI)&f0Y?E2LWTd6\1Za;;I@Z0]1P9@S?]F-B[cX0ITYS2^\445
1FTY-c&eVb8V1KgJ>]MY0MeQRAEU#8(V9[]@K:932E&c9fU0)=]Og\=Y[,PJ6g3(
LVWW+^/c>eB>febUQe>g.1#8OYNV#L7aWB<M[)Ed-H.;<P]\^SB8^6NOBB-07>_K
FYQGRUMGc]eD6N_VX/;eEGKdIeXRJIVT(;IS8<^EEX,Z&E3b^X(;Z3K,06GSZb+V
,T_Je,-#3bdgSV+5N^M_2R2V/J20=4U)E4J^c91H1J.]f\=@TG/J021NG;CNU4JU
@A2SJ;EK85TKaaK.WgQI-GILa7K4GY8P7Md_S<.>7U]W,EfJCJE\;>MP7SL<]/Hc
++F.(UQ8O]F2B7Vb2BD.NN;5]gHY>d7a>RR+>-WIe]dP>_()BGa]]KgG;(BNQDQa
D=e9()PV(.2SF+D4:PA+?NIP(a^N]>=E:-I7aa((@.;KgUa)?RV=GCdY?M>2:?R@
@Y.6<MR[GU@cC]fg##Z@J:->(/7_.BG==W?7TZP]0?2a?eQ-,0I)+<gAIJ2=Y&<c
ea/ea#Sg3M,GSK#G(8_(COIM;P-b0=467JZI#BWJV1728b@ZV/L)5#1JbYQ7<\&#
^LgGG/+T@(Wa1T>]JIM:OTF]5ZaMH3)84[9@33>\03;H?N<ZEB/eQFG.V)Dc2g1G
MCJ]bb9UP+/QZeM18=[YIaL@f7;K6UP-=L>/#1NWB7(:#eJ:c&C<P^?^XE\S0_I^
@+S5XDDDQZKT9?Wf)4V:I-NSe>JXY(W,3OG5UNS,,5U7.UE4Fb,d6:6KAG/8K8P?
QXDdU_DXPM>G^#K4^eRQc@WH\d5;KR6c@Q0&fTW,1e7^g64,O2]d^eUN4AG]JHQG
QY8:)9DA0]Z;&A;3\EQ:CFG(:/]RbT;&PE5F;IK00,CbfNK<_dB1R\_2]D)TM(8J
cb,+PXf+5f;6b)HPJINF_1^L869B@3UDVa#&^\[#(FK./85?#<JfN;R]2Q/:f>X<
K-VOD676KYN/^eC+\a?,RM8cDW5@:Fe?()R@F2:.XZF]AY;3eVXVR9C72gA;7bHG
N9;>a0BLC^OM9?NQOV)9A[50]WR27-36B_KY_=?PMX#8-?#^<Z6@;&1ID<?MR#Z3
&ZJZb^GHc0FW:\.4R(8HN00\.7)&IAF_.@#V+>f&/@Ed\GaG7W?=Q7gU\_KG06Ce
;V7bQdc3@V:Q\EOX+EY9O0T7Q58]T6X._D;F3+)4Q:)\_cQH?dQ515/S0cYM&C)S
K_):5@@#d[6Q6.\9d;6FHM,XT:L(b6[dP]5?AN7<R_BTZTO-bKH_eW)]g1fd8SKN
Sf4OI<;(],9FR-@faB4/<a-W_&XF&Pb\ULG6=9Z^OM@&.6:@.]F8VS\6>W)@R/)R
87d^g>gb&#KLD_>Q(;82<.Ub<._:P6Lca+gX\4T]1]MSS4V:C1eLF5+P_aYI@1FT
U@C9;QCf^g^2d_@=;fW,A9Fa0<:T:bA.VW#OBQ?-)Jf^DFFYV8C74Ea]eIK&HFEB
/_0b5;ET0LV.,bLgKNI_YD:N>76:#TAB^@eXQK[OHe]=IL3-B/7W1.c7W6#Y-f-/
6_++7/=gK4b&Q&+D=57\fQYL25TFb/,JMH>\;#^?b3?3a5[QeT_aW]3?/VI>)2Fd
SM/BZJ6gO2-.;X50:NL.49:N8..5dK8GLgEdRYcb)dY>CD[4BQ1Cea4G[_]HT8I#
83ZER,<88F]M(OeH.G8.BD5737MQ9d?gA.(A#cP_aHEPU:Q8;/=LZU4@+?6^L;7?
I<2Z\a<Tg5Q6VC]DCg:3FLWFf4>G3e1J<PR/9ZU]W/Y)?([0[6XV@agE@c^.-O#A
Ic07-ebDYGD:^_M#IB6c,]c_/XF(278^SH/3Y(D<[D6HJ4F=1+Sa\/d](TJ/IRMa
;FPgH7>B-,:gcH#_R3f:/RT\6HBJV37efV,f9D>#Dg;^3-[Bg\N9QOGWV++<E^E.
UYJ4[TVE;)KaAP+?:@=58Dd,N/JHMc,OSJeV-LdRQ1cc,O4Y\B2,&b/fc9UU-FE0
7V&F0UeSO/e@d,K/5fB1F5bAOQWF&ZOSX\RT><8O[(5,LZ@H=FVUK2AcB@c;OCIL
@b0e\f/D:#T&Hf2a>.7Y-JB_DF[00[H=5a;W2ggHSL-eI<6)AQUCFdT/b#dC\6e0
[WHI4O?T;RCHgRRF=^0Sb2#V+^HP)+.U#-.]MD0Wd.WN23F-<D4=W4&ON2.6,G#_
D8J[IB6bWJda6a3aX.aD+T]3BFWN>=LO[8/Tf@.bW>_=]e0?#eI_g1^.e.Y(A/JT
8_(_[=4;<?<AUeb#-?)GD2PZ:](WAK_XW]T#/GRE/=NH@7b)W6(&b7+=_ZafU/^<
KeHRR4H>TeB-/LT>RE<fb-[_TY(?WIU#@.N109S>H@2(R]&:S+VGX.F1bcg??K_@
18fH8=QRM;A12NL99R:e+?[GO72eAAL1FG[&NTbde:@-5#:Yc#9]Y3fd@<F.XJDF
.G>6[91:8V<NII72g,--BddV@W^IYB/a(>E/AA@OBP-:2[b0J,NN8(3-1X(gC-RH
ZGW<fd(K[RdT:S(eU?/E0[>@3Y;7/]M+21=7LcY_<.:86U4AMS/9QbOeRfNSPe?6
]eKMe301IIKc#4b:9JDH_Ma@+>de9MXbSaaB,SG?eYcKI=8&ZQNW\)WE]d-3KRYN
57A1eS&@+,[]AQ3d18.,W9L)5f?:.e\d-R?HF7(QU=c..YLOUG9]LO-IZPFH)^)b
&_g48=N@RdH0N-HDHf2(?>.b+TP.>A4:,4OL:W6VYKMDC^a7=5&;^#]R<L4g&DMd
AW\aZXaU1OLg>G2@=Jd+bfUD:3cG8Bc4J??f]VXLG\E.@U@OT\W<7^FZg>?85&&Z
3E7[Vf3;;F8>@;;IJS489CX3Af,ZFUZgB6/>DRPM&MB(O\aU.(G7SA,@MY,3I23M
7e-b_M8>@(WfMTG^fH;5GS@[1MO?[3]+JJY_39HEGK;4a6#^b.Q\W(S/[[H,fTeP
1dSe\UDUe,XU+97L?]b]+&@\==&8/(?P2SfB9+R@X==gGT6+J)6FLfQbM->F2,Ie
g:E/MY:MWd[X871>@K?Z;:cX[.e-+?;(?-16H9T1^eH@aaQ5WCLX1e;NFFfLLS[b
;2[b5C>\LPZ<QJ7A,c5VcDW+\aVO02Lc4KfC?1W;<K#5ZKg?@&I;O14H(5V<G;X]
#8G97_G_I;PF_XH1V.[[KC3Eae7:>60@,36:FaM3a&O2FA0QXEd<DT7b>@0(LMRO
5I4#QZQVc:NfN^1Qga4N((DT_bT=]P8<d[QLG<J)J?@fPG>MI4/T-,J-L8f1.CH?
e+EePaC,Z>_f<]4QWA9/C2[P\FU,aY:eZ_&#2)6C\X[>@e[;8JI?WY[\^^.0d^6:
d7FKBCd(LT0Y-9[MJc;dd@3cJH7S\NEOBT);7Z=CZJ8)B+B;<;V>2KU[@_eb>P4C
(1.RbWcWc]([V&G)Y-Y&.)U1F1)X_5I>-(aW1(fg?7UW(IGMA1;P,Qa.#:(VcQD_
;[T4(DdD(<eJUf;R02^MLeKY1Z>UL14@?8Hgf&Q9/>&:&GgeE;)8:HYTECE&);=Z
gE;&UA/g4c9bHK)QHTCG>,2AT4M1+K(N^#/Ig9IKR1H&4MXHTGNQ6?.##F[.HP3E
;OZQcDCSQ+ZVU,TO]5/,;-EW9SEef-SH\RCf-:;]8_<f-9=EO]fc.EQfB<:Z@HC1
VBJF#C\,.D4R6T;cJQ6MG6a#.R.@IeV8L;(/EXY(9c_^Z-3b]a9PM-AM#Ga^,AY1
Y+(BVbc@g>?_+^R=eC?FQT+@9+\O2#Fa\>)_dbJEG0Xg1-Dc1#d^,>^VQ?,^1\Y:
H)#YJ^5b\J-M[MP8ZQ)<T&C0G-R@VQUYcbQ6EKT&NB>7bG)3cF(E_Z>#,efB;]bg
8D;V<8L@0(<O;AGeZY2#;8/A@35GLQc)G(#3G>]3WF;I+5P.\H#9U-EcZ6GLADYU
G;@dD2\aEQ3KTX\I#)3f@&4fS;Hb\2HTFCc?ME+bNE/OGKB+=#5UY+Z>.)Z5P[fW
XAM0)=4(QZDKT.Ac3&H=G(2BQ5?eRJ,Bg5O^Q:CU.HUUHLGRY\SVb];+S1;&@Pd,
@5H_6[K>PIFCGNG<^K>+Ua5JP8Q5?V.>95..^WJ,+cRFP6e:>,W^=@6[0W/LF[(-
aHA6X0P[Z\_Q)=5:X8R]PJZYG[F@O4<W0#U3,RDK#,5+,+e@21)(#Y]>gAO5:9:7
3XX;_BQcSJ=Uf>546b5+CgY=B),_ZDL/LWATH6Yc&:5^KEO)48JZ?VQ1./S.Y?^]
S_DQg4MN+PFEE.[a8+48KLFY@/I_P78K166b=Aac&@D9(9<8Z2W6UEC0)73aBKb_
90SP=A0G6Q;H@L\TI90GAGZ1g3[]MX<4R5L=@0_Na@=.T\J:+T,&(eWB<WIDM2#C
&2<.19+C4J7QdU<HZ>I7?<6Je73D5&e5:C?&?>;_FVMHJ3M;VKL;I5/:>L7)J^K1
>Z[0N6MV9^?,+d_4M[<7>&3+^4IYe;6Zd:=.F;E3THe+W4KBaF#R7TIB1)F1fOVR
2aMD)7@DWe?G-b8RT+>1TJfP](FKKVOa(R8Q;>F2?D3((\#/C6197<]L6?^,E;E\
ScSKZYSNR90#Yc8Z^fgbGe;^Of@(F->IBI:F+RU]gV[:d?RSd@g.,;_K/acTR9b)
7GPgRPS@/]].U)2?RA&QT^J@f<Id]PU,I:XY@#9F2#-B(.V:8\V,8M-c+2MD]6A)
KegbQPEeX\(J2ffCPC13LR.ZGXd172dIOdH=7\H,(0A_5R:J:AY+H&:.<TRdQ;+c
W670)#[b\_+e[bI5_VUE0]XG<E^CLC];&^?1a=+=HC=:EdQOT3U@Q1+R#9TcUfX_
ZI_(7b@N-P&@D\SaFf9@Z/fBQ[4(Wde#S)^6?MGb<(Z^CdTG7EN3fe8eeI-b3.2H
_CUa8=:;NJ6&H_(?G\3c1;7e43P]7d/(W\SWP(U;^5ZcR1P5I;Vgb/><PAFJCQ((
/DN1TRUFN608I7<fN/c4NKCI+?WT\]b>D\TFU2)(0.B1[P<0DF,_^Cc&c[(K6[F]
)VX@b6P9c7.U>W^??)J9;2C=9^1W7Z@IY7fVa9&RRb=6bFcCZVQ#1@+FZW8MH<DV
Zgc52.g0B\gDSK7CA2)Sg@D.>S34^59R=,HGYUN6C5L=RZR9>]5-&?5]/PONC&bZ
O]A2>3<X3XMSb;@cE#JG6W>3XM7g]b&;0J29M./?/3DXGLI?eZ86SA#PN^GS-4IG
\39T_DdC&&2\g];91P/M74Dc1<&dBH\[I#MbQ4+cNFK^&eXG:<RFWe]a)1.==EMF
?MSeeL@DX3RcHS1V=JMHOEb9>cDF#CK0\gF@,2_,9?Qb4OX>5SGbBI19[/c-a<fT
QB4dOC5f1X&g&8V&gA=gcZBORTI6YV=+QI#;,P#@G.#6egSOceaF9E=ad?_/8\)g
b1/^+RA=X9[aS3H0Od-0/LU5,3D0C3Kg/d71#LbVO4S;@.\CRM[6,B^8U,W>dP3B
?)B5UEQS8g^P(EUd>bRF+Y,[fM_29:QW.)CGZd>)SUE5J:K;.HWVWVW\/f\N1&PT
JD=]8;0[R1_LF05\gI+I28f1aX&P5aX4AX33P#;YG3)T;U#J#[\\KG/G[@N8[-(E
?+g=I@)5/0?=-Xd>WY&U_XQ_12Y\[Q?UD9;)]V[^:J+[MUV?dT2L7+_;a(KEY\aE
.WGQMS0HVBWM[61,eH/a3O2;bUBTfM<WTUKc)9J;H@:O1FTdR6HXG=Uf-=?e9V@P
#N@#.b9UE#/Z\gR+>#;E:/f[V-6?]:L-e#T]F<Bca^9EKe6=gNNXXAb_9Z\[OYZJ
<3c35=f&>MIZZ/]+d)gT#6eUT3>d@D7WY\FdYHbW/1LR2)49PVFR:)?I=(4HF4,B
U4WZ8X0U1?K]EJEgA^WER?<[gFQQa^&,=EfXd=O7GTI<:/T&)72R1-9/FA0M5RK)
Lb>/;:0R1<;0D;,[;QZ:QfFdaCZ@D+0PH-c;[H[RWPA-HP56>e+<fdE\=Hc\69M]
DgCdN<9:M.PJC<Ia5#UBOcW#^g\X2>>&+:fCAf1f5De#\))T[444BTbZQ7BC7L?_
IA?dA=K^1)68@WV]L/C;?8bJ=9C68FZ:8b9,OJ^92IK2RCRgG@/g4AU?4e=BEX]6
4QbH8J,TD/a#GY8;:&Q+HS]5&>1#L71V:J?;/c8H\GWU>ECRNDda:?_X^+RBVSf+
N#OeeQI][+8bd:G;2F8PPb4Y<HbC9;.4773aA8aP981R1KQSa=GM07B78[LYG[c-
S,&@NS^bgd?<EL&0-,_cPFAa-.5?_=QF>4,22?4B>1HW25]CMS98;d.-?XZ?CB#J
;fC9^<7/bCJ5PRE#?)/GIA6H5\D;>LIRTKgXR]be??(J;,M2g:=&2a:++:1g@3V/
2JO-U^R75M51:1QD[3<^NN:e+Jb]U]Q55R4CfeO^-d1SJZ3;7L\ZRMe5a:K=Fa5-
eG?AS<INIgPfXJ8-25\0W7GLSM[eZ57LWE,SdeFD2E&3#a(dabd[Y8TU_B;Xf^)4
f9^_c&5,K(][K+R7798<KX&N^.V8@Vg(D,CQ-a1Of04P\Z5NGZa&0_^S,_8P&F+?
99Q]ZAaV_N.VFKJF95]^6J(M&Qa_a(MC[\;V_1Z_X4CG^OcK/R5:[JVQ.SEc8C[K
>[750aDK:QebBLUe_<S?<)-O2]_aDII6?.GF_?0cZC,Q>ecR1I022:>SYZTOBB;A
:Zg)aD)&SI?4Ca&GAYF-FW1XTIJZDe/Z\9O]PY]L5TR)^]A?7c++1^Z(8Gd1=SKP
_PM/eZ8baP>8Z2#e9\N\Z+-8[>-5Q(_VM0JZJ3HCc]4O)?&4)&23-\:&OgKg,b6P
19.F.I6^+gZ[5GZ&W2=_II?:SIG)6WE6CSZE6K[f).]f8UAICW]B;P@(c.O-KZBV
bM:EIQLV/_?fe+SGHJ>@2,1e=9XS:D#5;?.5K^#I,#e9F-3gIN]?X@a]+\H2ac]H
8?4#6FA,94YQ:<AUOEQKQ?2Zd3[c/7I7]8Z[/-eDa#8PWEC:K>B;-M^.Z7dg=^Z2
SWMRB[YS+3>[7LWC-/0(+[/SC#)I+/W5IJ.7R\2.DPS]6N&eD5H:egI=9W0Pb?LR
IS5QC58/c#Fg]aXX,PCG^GVQ:;TVGL2gbU6<bdTP0&?ROZ8TUb>1>D5BSc=e0T,,
c--1)@(@[O^_UMHe3]f=MH38:+82Ue97f])CO<(MY;1:H#VHQ.T(D#Gc?(_/++\:
Gdf20#U&M<L+Fe-UJfBHM?<HXdN?-8Q.@CK.U8Se-gR\C.UH:f>/[Z#+]7#>1)Xd
BOd\V^\b45C.LZ@<:U4.+2Hgb-5]H.DALK5+75F?ZM+1F;J)\WQ_cN5)?3^N-:gf
[f_,f_R0.JTb0?ZNBZe28C(4E,)SG.0abEDe@+N0JY)cB1].aFU_=5aEC1UD>L8Y
4;GDX9R>0LV#=X73^JQ2OI.EIEFDYD2<0RT.,bdK4J5^EN8LF#4?X[5QcM()8MAY
gW:I3EV#FD:PY/:CN^4dPQN3P/H>R:SH@&g1I,XaRb8E1YX&,I1ZQ3:P[>HF)=S,
UBX7ae)f;1I7LQVWa7N+D]R)F0--YR+a2YI-F^.Q<[3UEJDR,VdO[/MQTa>?_;5K
]?\V(QF7SRAAfL>=EP=d&Sf.egVIB[E.+]9P=K+5EPC^;MALRA7G=:61f=64LA;,
)E/6c8PMQD)6N_S,EHVBdAP2^?[Ud.M7V[MaOZ&69CR3Z2fNP+<IfO[6D(H6>^PA
OF)E-9O2eI9)AOFB2#?6XY^T):@S=<N_[#>?I8MHdM3Z/5Nb(.47L+KHQR2&S+WQ
=:Y,WRW&D<+.IW.@L/9:VM4:6Zb+SRE70)]/8_+M[?)G:I+?5KPF<CTHcN\_bb_6
S>NQA37NBHQOOeggD_.Z,<cK9<P^]D>^6NUX0AR),f@)T-LROIgC-GEOR?f1NPEa
H,YDWN0>2a78Q(/JZ+F&If]S_aFb(c(_N6Z-ZT2HM:fANBDC@bFdUbMB-eG@4UCN
ISCC@6:V^cT4V8D=/4a]aNZT2<:-c0CAI7;d7(K:0aOC^ABIK#e&4S4^7CIZW44G
HSa,>\aS_BR]&877H[fY04:URKc_#9;28(Y)dQO^(W9U^VPNP8dJde58M5?HKD^]
+c?JH>9@5KGYPeR0IF;0]D5NHa6Ag61)--X#BEU>.7=AUN-<EcPPd@d>FVHF-L9(
fC2dFXf0=Y2N&#2>/6NbZT-=#-X,JCCLIM::-:8R>_Hdf?&>+A2#G758I5:)MCD<
IG>MYG/e5.+<F;X>egDF8c<:,RWaIf++^=:3,d1Q(\J&BMPXcZFb>f7+-G4Uc4P7
>g1K(eC\LPY:HgTC[VD0QU,=cS:T@^G97AfY@#W46^5&VCAZUBF\#E2Z,TYY@QL,
I.F-A(QJQ3O44\^c;Q_a>_HMD8-MDgNa6RfIGa@2a9\&X9#^#YC[J7PCO.UbQ>;S
ZW5aA&).3-=QC(D/]K@9A[_6V>R,FFZ\4)K8<RcY<Z).D3a4^)E8(1b.(-e>Qd+Z
WW0FN\TGcZ?PZ\].4A0A+LS72K(dU]4]O+/5E<]cU5?O-VcNP[^XN?>ECL>K5[?F
.7dD8:B(<+JUFYF3AOfV:3-d0a?SK(:<+S<cAB1.BSS[W(V,C[85PS4[3R,9GYWZ
UL:_agUIS[D#FQg5S^<FfDON5J(K9R-9/V0f600ADXd1J/\_+(/:UJV:4Tg(f:Ia
Z/gc/]gNb8[LWED;#7M:C[01:d;I4UNF8X5Sf+9C.g#N]6fJXTd6N#=J9>-C-]T5
0_3+JJ?WDC5-D@.N?O[=O=YR6?-SD-)&d4X<U0UB80-]D?JEf=EM1b64H=d_]?c:
b=d0Q<3e+H\f#4O:^A>?[e>.9BZR]+C9JXY=/C9JO(f>PaB9Q(-D]4V5:G_JW(XO
Q0Q4\]]@&()^GS<&??^-WA]S\HG[N?O/+KbcG7HL3<TFE#(V;Z6#IRN08[LZ?G:R
=1P#[a9::1[10ZWB9eGZYT4Y)Y,6@J(/2cfaU:F,PaBY@P&E\d0-@3]K+&CNX5Qe
c.O.HC]c#(2bW_>4<c/6OPI-b5@M&deZ>A--(UU3BK.(<H&_d1J.+f7>(b<HPBPE
S,P+U+TXZb])&_G9M@f3+Id2Q=(93XFVCT+KIVf4>&#T6gV_OR=3bV1J=a/-X?S@
YW_@f63IgRXgV?Y^_1NfKMYAA9:<BKG34P5d+f3+ON#eN@27S2^<O0&#VHABcg._
2F&@.b@8BI4LBFL@gH#,<<[GY2RXEg]8T[a#=/JJ+HC^g/.WO?7;HH8QR)f:CCN(
;=+@\e3@Y[cbX#)H\<.(XU]gb.E<KI8U&U5XW@[8E]/g\T:M_)AggCAb_M/,OM;5
B5(/T<93c12bd#b449S,ae]8S@9+TBQe:6RN+I2Q,^?.<e#M6-NJP&B17fZTUH[0
/3EOJREE#Q1WdWKSOF;H#5UGWUX:)3+2gUA.<[c6MIcN#ES,ZEA+\?[44&39E/BS
,(aAJJI#FJ)aRWc(\5D0:T4d2b^SD6/^@5;&GZ#4Z]IHM_Be&C^Y)@2V0J@OL^Bc
[BE5WJM@7DfVUA_RYcP.N<6?]KTOMQM6:3DYY4(T)T1b0H1-a>Y60_)TQE2,AZ+Z
TbeV,g<d^]B(P?>c<DP31\89LKT(/+LKFf6@@[FMX_D[\NfgC=f9R]&[NHgg5ac;
-aWf<XEHZ:PFXOdW1979g_VdZN^f^cDX5bI8I?:BQZ6dO@7F;d:8;)bB>5g57,JO
F;0L\@,.VHBRR7][g,M.^T:f\H48:EQNMI\e;a5A5aDK8HQ1a7+YR>:;G/g>K,?L
/8eUf@UHb=(PJTXSSQ5[T#-:dB1_M1:afDO)bBe\b.QDTd^X;C<F@;fOA1SZ1cI[
b/PeSff<MYD)d;9ZX7Ke>KK]1YVR/_bZXbYe@0+eV#&0K6Tb_aBI5)bX<F/3JA)L
XB-D6IOeC0H3fUBTIV-TD#=/<.YcP.M:K+d1M(AV.E[T]d#1f<Z2>ZS-_1WT8.a3
88>,RGR7_[PFXX:)_cJXD1OL5KF-GD[24G9#;>;..cB8gGcD644=4U>bECd+USC5
a:Z0.J,H:E@XBD>F54O^CKE]:IMDV(7M=#BFaR1fU5<]G+VaKa[RJJW<:Q=VOa//
P3RW]7)EfU^(?Nd6YM>c=2D>fD;d\(b[#K.C,HHcFK[;7U#3H<1U:IbCE=O+?2AF
J?I6Yc@-,MXST_X\ZL?P,,df<EI.V.EZ)M/T/NbLgT)E>99Ec3#9W8=]S_La]+(=
EK7S./X\5&+KF\(0N+;eUU?<H>)/Q]&A\E&_a+&Kd_229WHW/RYQSeJS71&<8,_a
I</2DTQDID1b2MEMb@LR6_2S#N2TPGY):^b&N.;@4A#Sb]=[=Q.S(0#7Q=IPI0(,
f2N\50+,UXI0W:PcVf0d[O-1=L@S3\eDf[JO-X\?UB=fT;_JBacWWO\W6+Pb8^F)
KP).CJe9c(aN.&bVB3dJU<B>K.(:P]Z-1=L=-<)d,WH_C/,J+VY9&WeLOW1#VG-?
/MS^8[^e,We4O>6JULf:JaXQ<NI)X5dNE#31]JW>+WdgM0W)6?c)4K&@^8DE)N7Z
(\^T\)?0fb023>]IQf??02HDbW/Y#4gA&)<-Qg@P727.402c=FHH8bfb,1a^FY:e
4ZD7(JgU7X=TZfP(_9N]N)c6-RLb,e)d>KMZJOJE;Y(\YDR@Y[PRcbeIE\J5HQEP
T#(aZUAP84&6?[a\c4E@X;M&M/fOXaQa<aH+N9?Ub6.HTQ@2Q)8[(J,Nc;)Ze4X]
IENI3)c>9Md/C^OI4=2?-5<)b&1TS?4L]>7\QaW#SQ(U60KH/MAGX89&;bU1g.7H
AB?PD]eeQdbB0Y<N@J#3MKEM@]/5V8_b,GL,<P>0@GF2P?D&S3=U_d2[0FVa^0K2
WS+gg3eAF?WKgB@XGMZO5808J&_<G6ebRD@b8N(2<f\b_-;7?VJ[MQ[4>BCL<G5d
)dLBQ9eL:XEC91(0W#:SZ2P+HS6eDR+I#5HU_eCdJV_f]-URNbLWZDC^d]:+,LSa
V,VH3>)Z[40257cI&([d77K=0EJL8,3:VA-+,JHF<J\6XDd#2+Y7gFaF2WF&^/A_
2@XFN\+ROJKGIfJ0VW]^2_+KBgc;4;\-@;GX;]/1/IOfT::I_<3,N^HQ?3LbR\\L
/JX8+PSZ&I(2WN8/1O,QAH;^SGU28[V[OW\.,T_QJ(0YUPffa)XJAITI?1R:0-9B
YJP3B8,BG)]>##2\J=D+SbB(KIQ84(Q^b&ZKaL=UM#N5(K:W-=d<(T,^aNBF@E?G
/T&_D&@L[+g1-B@PaUcd2N@Va:N9LG;?\>a3X;LCQRH/Q+d\N#)>6)N]5&8=CX5-
A<+Z,/bbYAXFUKA+L<Y#K8QU&V82G<4VOKdYT8e4YG.1AJ)b00&g<8:_&IJIAS.>
6>6MV7ETIc5(\+;3-acZ]3IRM613C0T(>[XUe@2=MWaN-Xa>ZD.2Be5J_.,90#/-
D+I^OQYS,<\UQfOfC/P5I(B4)8UX3G>COVQ3=?7OX=YJ99[2=9GF4.L\;QXM/NX.
=,H:62HQ75BZ;eA6F\TA64/.:JP4<05,=WW-bg+d&J3GOTAA=KQ9Y5E_=L>DE-6>
L[eNe]fZ<4(1gDNS[;8-#9]ZTM@)Wg@1+],VafA?M9)^27H_Ze@18Z2TV:cUKa?(
3#>FZ0(J?(7B0&_&S=</a^-MD],2,M6V0H>ZG;:PG;9ePgN^^@P^5\&e\-SCYB7U
(M-1FE3(UAeGN;@SCI04=1O?VGR#<Qc^YT&9?@;/g;2a&<VXUYD_A^A&eS;AU5CM
(G;b#LI;<4PCa2:BN9YOXTE3DL&V0D3[+:0WCV1\3(Z<aEM+CL-/)d6<)fJ4PO2T
U,:eQ3O_R\E2HbNf48UE/5D^W)-72<JF;1E=VK>Oba/&&1N.,CK:M&QScUfS9:EB
;TFK)4_MYdF4gP)&8:1-c,bY+5&9WW@dQF>X>[8NM#)^RCZ4(T)Ne-FF(XD,)66O
X(7KP&2Ha[g/,b6SCW/<\]G+:[Xf0\>.f8L)LLF[1?Y+B63[]YG:L(?7(>]8M<XJ
bD@X:P&:&A??69g[2[=D_F-1U:g=G(2_H=RMKZ5bS&=WHNT55MeU;MBdWe[5(61O
[=)WOWKACPOg4QIDK>+SG?#)NWF[X6#C-Ac(N)b,bE]c,UB-R9KB_7FS=Mb2Y?YH
FYND05T(3AZ7,3gF&&<,14D[f#IDX5TM>(8I\G,c,Xd/M]c3;A9ZWY8]5]X.TDKE
.YIdNAN@GH8@Tf;d^I_Db+<MJMS&g\Kad5,ecX3e1bd9/W;;.Sf+]GKSBddZ>@8L
B4@AZ]_Lc-6b.7R9D+dB85H4ADU:b@f6P-g0c^f43A.NRZg\NL?28RB41I777HI?
a?M3/;b)+TaXI]XbXDBdKQc01-H#9bVP.\;4V?1G&-;D0Q^HOCP?Y^/.M#;LVG5F
J59ff33@DA+@<ROa)b<c>bROEe.>Q/TKPa&G@g6QE8+f0/Nd,Ke7VOPL[.M.fZDC
VQLD,KeGS,fD7/(R^Gd=+?Zbb<E._2.2>_F_e=Z.2[+-S\^56/9DBNJKeQ]c2MD8
aYcLST-_(f>DO@R7A)]<I1&AeF4?KfHA]P0R9^#3g9<XNF\&dE_R9&6:2CA0]bgE
YJ5Y\DAVTJWZ-B,S9c]##\4X5@P]_)7T:^OAKLb2N4HD\ZA:<f>Z>1CcALPL.2HF
00Dc<Sa6bIR.cAN6WW6b3b2Z-LB3^dS2RcQ?6.3ZIB0]9_.+fg]#EIKB[8&DWH03
R7ZSeCc^LfC/T=[aVRDaTPVM])^a5^OO=>2.;SI7[>?aOY<+]Q90T]\/S0Q_@OT7
5.BX#--@8eOFN^ER[@4_<7Q8)Q8Z]FP^TbP-KXV91ebI@/?M2V<I<T-I9A/EI-4,
-O^P1]AAJI9W2f6Bd+D^9YGd:I+FWR7R0702#GaWUdJeY9/g:1AV-HOCK9<5D-:e
[:\8M^RVX8S@Rd&AbCXabGWL]_ND_EI@H(MN+LUgDINNe:@-?/#&#8&(QG?L9NF]
1Vg=:RTM7>T@4=SEQeA8)H+)-e+N9;Q>eXgSI4HGSW]H<baUfAe;e:Q#>3;B5g(Q
>[XBT-[DAX;S-M<5C471KZ4GOI,[]dLcC3N+EFYd>@I1Cb4L//;CIeNF06cE]_a3
)3c[E]]W6ZgY88I0=5b]M,KL[8:1X5f]-Q-Gd1D56-CHEPY+8P1[2\LJ4gC<=Lf(
>;_B?U9L;]eYU:4/ON>MeIZ,d.Ac4H[aS[UBaK\:U0L37>Kbb=c1YGG-L1^>QEdO
:0NPS]>3Qd^9[CD/6#)I47WN[D/)+GcFG,DX1_IGJgTX8C7:eGGf]D<F9@]W7B#,
E4:4],GW>4A]R,9=IIM#RGZO/G7SU4FK7)DP=RERICZ:Z9_X-_8_K]Fe2\XQ5Ma0
4cZ^+:T4YPPP#RD.D:TE0fHO/c2VAWS+H4N+GB4;+G+fB\MWJ2RZ-ZEa;f)&)ISE
eI(2BZ#0_T^[3XdFOd@@::J#D<Of^=)^-;E91e^K17JOed=4;N6WMMF,^7/WLP/6
QFbA==[cS797::aMBIWS==^DdFN]R)=KM:N]N1TWDNBV7SYRg@@(@cY(<>MUcXXd
5E>SAOT9fWTH2<e\/G9IBO62.Z?(B>/+:32a26aR)2_PXCGR?[)9>NHDg>KJ1CYJ
\Mg1[D#J^N2/3f[ZEe6fa,O.5844>d<T5\Ud]7QFF\X\8\Z.</5ZEAEfaaM&XGFd
Kb9?_YNVRS>_=?ETZ>K)82\)^T2b\1ZSB8L673+KQ7>LQ\BIHM#+.g#b9R9UTZ_1
We0gMFN+21Ge4YE_#_>@AAIX:f^HC:G7ZIF]T.M);?)FF)/RZ#J=J&b^(1F,2KO;
4YOS(F9+ITR>9EA)PZf^-<5](.TU/LU28[bMfC<5:FIKcF,\fL18<g<C_8NO4L4,
+8J4CJ:XUWcRH?b<GGOWAH/8RUKZ6CIcIL#38A7F3^UW@FDBQ8XV:XE6c8->G7[>
?C?RF4QM1^5&B@@Uc=.AG[/K,A^J;d[KH,_11Y8Sf4[PS_G#QT:UAMf)ff2@I&)4
2fCeN)FW_NIFMVPX7a-?0Ua[=ZZCP6IE+-29fEOb(Lc]Z)Ag7JgZ[0ae5R\]<[N6
e<3\27UBVTHN,4[9c>c;O@a2>Q.K\<@EY@/\A&,_0NF0Q9;9HOAE2P,6IG)LBTEB
JaZKd.)?9X5CS.TT>1#-6(bDbR\+e:7-+W\Y5ND5GXSAIffOI&ccVNO&=/^=]8?e
5QgKU#7@Z93=3WU=(\1,A^-@L0+=EGb3<TUQ_@H7YT;N;,f9?OTNc<3,:=Z.=Z.M
BT1,X3GeVF4W)e26KYHUM@F?>W9-;22.31KX9-SBO8J#c4UV2@R3E+0IPRZD<N:7
0_5].1+DV=e0e?T6)I\=74GX\-Ta.1N^YGN-\acPKeGG8+V_2_41B.7W3>IDL,Ia
8,9KX6.]]1;\Q=K#c,4\_73cUa3I8E:U:8PQJU#N85J89ZHNPFZ33KKQ7=/BWX;P
.JMUNY3.[<1d0ZEO<\F7]PX43,.,>#gX;b;#4I<eNX=2FRL2TS,(H\]BJS=_LQS]
@TT527)C0P51BNf+&AN<X0fVf89#TI(Wf53UZ?aScMW/@SS0\7._1S0VbeK.R7OV
-fQ2ICCD@cQf66ZL8Lf\c&I\735.\HVd/>)>>6[=O/dYXZEGF[ON]f/H/T[?^fJM
&SH7DY#3Z_@d@?;PDN:CL566<9[59T:5U,J[</c;=FN/=<[4UQSXP;?30P-OZJ+L
FPF3D8YK^FW_KS/I6fbe2fa&E.5AMII,O>M520e(HR8g5Ecdf&I7(-KFR)>/a23O
0Q4e/)@]E,N#bQ1&6)XbOgg@O_@Md@L8b@QTF>FGe]:KCK_eYA55=:G#R0/TUTgE
GN>7ZMbJDQIB#K^Vb8Y2\B2(H38/e7#BP.1aA364W)#fN&IgO_]:+LDJVeEcMcY:
T-bW,#[@f]MRMN8I^d5@W)>HV;VA=7#_^Hd^>1+1_(Z9_9Y/4.?GI6f3109Ie58T
MW&P^RGDMDA^(:K/5d6_bHc,+0<[VZdI0_.J3@VNP>CHYWFI&E^&3R+3)FXONX+\
=?3P6[NGaGLM;WbJ>OI38#J>a&GgJS(6N\#E,_&(U]E[\Q6B7b/PA(=>1FT<&P<d
]/=^:NM22/GRg(gJ14/ZU,2H^1?fDS&]#@\=J&>+1Y1Y[g;8V.0GAJ,:U+39dL&-
[)@<40D95ND0b\,a>RX-S[eZ<E@34AW)G\VKP&RG;[54>OL1]-RcI/Y=TA;cSH>L
e?Oe5U5b^c_X\dCC]]LRJAMaK:g\0gS.#BL&:.D(XUW<]TI8Ud-MgPZNTO(gI[OF
_G^c/SS=[^2JQ_M#25S#NHR@FHXWcASZWUMD6?Z\(C/dP,<LHX\<I@@X22:FQga_
K6,^d7OVULI:<<T,Y68^eKE@;<MNK\.8YR;-9]S&/>dT0LMd25FJBCX_A/?38b^2
SB[0T+:gR)TN::B1QQD2[7Z+_/bX+V9d1GW64<N&T[E)e?/C8@[F#;5S(.Ddc,@4
D(X:WA[0@<):@OY/\.@T3F&K=C7KaY&CAEL)^cP==#R:Pg>+Q^[+0,:&DQ[9Jd^_
2;]Sc+CW,\I3_)7KY(JF]7)7.L0H\Yg&RZdQCK01fI40SK<+CHWEXD@:BYG([?d^
PHX[16[TTX42.6+M(dVDY]D\WPYJ&XH7G:Y6@?R^&,K2+K/C=c@=O+/9-9A(g),\
#W/X]:YSA.;TCd=3+SeW369d/;VXUK^6:SEb834.?ENca1Xb7[3YMQbcb;30>=]E
C[M5S.E;]f1D#XEV;f-aeDRU[.+DaS]HN,(8(YN1-:Q,=K]\VL>PNG(_VH=O9+-g
HIOKdePACGUK5cB]PJ#C&R8<^/S(H26b(gfb6>DcD>[)<^M[0M/_,,32TNVH>7/W
Ld_eV@I^<#bB-Y2U<d=J-MQ-=U2\I_/#\<P6F^Je^-:7[(fU]3d>/R3a5=.SagD^
[Z&Q]FOK>3+B(_@e#DIb8+cC/C7JSF/RIP#[A[L_2NdC<7Y^1R1M2ZM+>Aea(L=6
IL</(J.&ddTX4A3RH\7[>?>3S1Fc4&#/0KKQBe/FAT[KLRXWHI@_B3PZ16NgZ5&9
07BG[[@,0I\O##Y=9SI]&<J5eJ+RVM:,E-f^/F406GS/EG7,_SGIa+W3:IcFPLU2
SJbTFX,TDMAY?NZQ:_<[JXI^^6F?C4#<I<a78aCeM;d5L1[bN+OG.KW0Q2+X,3c<
3E^bGSac(5B,JYD/>?_(;279CD52?SYZT2ab5E5D/CRa/f(Q0X4<\8<S[]B_S9WT
[H&_GaXB7>Ob:(AN+Cee\MY=C_SR=b=gEadBZYKPF0d,1(Vd#;0&[[)&WO;E_\Fa
7G.TC;,2VY?F.2d\1EDbPf54;-E_aN]9SIL)3:WF0]d@C^Dd=c/fQ#Ob7Z#,)DJC
>d..J>J^,5T;aWGI&8N68/G-F8;FZ#e8fD:-C_YA>IDEPdBcDaJDAP5Ab1K2A2\@
bP-QXU8G)RGZD_Dbf::QF8KC5W3^/e9(TM3=X2bZfA6IQ37Dg+OK_=Q#W,Rc&O(.
)FPW#Pf]^Lf=OXH;H<JWVR@<2_+,<aM3HL[)7;0M[-#-/V-1f08MK=DAO)(BHeNg
&I>9;K+&&B/^TQXY8dSf3>P\T:P(M\1GAeQUAMC&b[KL@e9SgY)D0]6P=A(-B+8d
+[=4YJRF\eJd(S+<e_6(1UUP@O;&>.J0_==5=e>d8b#YCT#5\Rc9,Fb:T93(5Q&G
1ZGES;M;;HbM)MB4#J?6C=CJZ/QBL>A2<<Y&b\0G)XE9A3<Xg]Kb-;EJ3V5+K#Wb
ISVgdT))V+#c;.(FI^KGfYc2^c>Q8\G?0J]7VDT98R7)OX[=746IU&7:=QV2]X1;
=&5K=I/YF::P[<6:D9/OB8<6727>+AW+A5>QHb6\.:1d-ZEf>K.dJ3AQ@YVY[11\
OMV2_d>cW@_&)OD]>C?9WNdbL;_ce^gaM.dYG7;_E:T@E&[eAVE5T,N@1+OFS&_0
K4)7.O0>7Rf>V8US&;FWNd_a))G/5[#P\<2>CCX:B:\R+BL&UPSaOP<5c7\(8W]_
/<D\eY<J#KF:#E.]>cBY.V5S1UMKSLS_.9403NdPYV8)?P:J2Vd>)(64P;3KMQHR
EdOUg5YF7a1b#_GL@]QS^[/agPM==1gDP;K,4;<g)P2=HG,E9?D0:CL/,a1/Ba2J
a[LD5OW[cGd5\@^,,Hd0Y5#.RgA_;D+d>:?afWa69e0W&1L3?f;.-2gJ;_b3gdG4
6S^4UT;85.Q^R)JKaGCT:GObJ2GBX+M8Vd\5SWC#9cH8>dG=@#266_GI?9G6NXRS
L:WLTLZF5>@7\I?3.e>F67A?U2Q@793V.2YdFb8Y[50AF8ca#XaALQGY[PYPR>?f
dQ&0=>8:+LL;[(;HUU0D+^dN0FOR.f&[YQZ67VaQ:@7=7AXTdNe0.bH_S]@\IA:Z
2/7-9LEc2cZ]]a,N4U47L/927R)P[?RdN2VPC>)F32F3Fc;+8a>.;-\SR<K1ZAG9
g63C_KSBd13cUW2F3H7+:5&6d,G(OeP_MNMV@QK1:]8K0bN3&_=]-?/:g=OVR)VJ
B(eOQ_62::(LL>=32CA5JPP7?fG:05<-NAK9WD8?FP2aB)SSG<4EAIE&J0+->fea
C6NIV11=+P;LP<^+@.Z&@c2T-004KcW7BL?#)0T>?\H,Zc]WNgUZS0MZM?<^#e(+
Eb@I>7A])HOKcL^V_8A[<1^TKO9.F8=_)f>0#\UA.b;O35KW([M;9a(aIKf,W]#H
3KKEB/ITOXJY5Y#R<S-5A#ZACW)D4#a9+=:JbDREcHNJ8O)=_?<]FHV[[WN;V\f>
8LT4U>WWM&0(FI7JeN=c]b(=SYc30f4QW._EXO4>ba\,.[2Pc;BF9e02]LCL,;)W
;T3b>6eP4E_S\>E+[,PA)>6+#Af1;NTARVZ:?97KM&WQ08Q#SE8II:R8;F9#F@.2
W;&QHbSXMEGW&8))90PZ\2f;#]gZCA-dX&?>AI3e@0b1G=K+BP_06(K_=]:L?KO;
5-\HQbO5@7-S3^e)&_S,dJ]9T2\)H\;//(c7@f8&/.M5>6<HLFJ8G;2)ZJbY3Zg\
;>&SZ.;<38F4^#2,KU2T\08&4g^OLC.I8gQSg6aID^Tdb..<WG\:,-DR8<a90E[U
[(Z>;D;fQQ5>G4e><>)\?CWZ\74;/8P8Y=J/dC)@OS]:U)d_1?4W^gI&FOJWaN;-
1D(>a4_Nf90LIKN_WVa-]1>H1U2PWK3cK4=WafD20cB:E6^,=]DV8OXC8dVI?g1C
Z9P+?cW4Z:UPZD2#GMQ3f>/O;e8DI>TbgRcOSAN>3I0eD/aK)XB[6GQa.&.dbZcW
P0=/Lg-RAFUU/2&,aQ5adM=W2TFD:dN-_/fV(<1>E@OV>TB5R)[(3VSe9+ZB3_#M
FELYf+-[M7N(G&(,If_6;C:X4Q.]1]AJg_C\<VP8)YW)d]b<5^_1S;Oc]LN&SB3d
LF._PQQGKGM9Oe0#=Y9,DU^bTV2g)?/WH\?g\7VNc#:-JOV+:6>/MH)R1,O-Na[\
_MCOYZ#[EWI&]XV5cOFSZTEA197Ve-8OaH]1gQ-\?PbQD,V,1LQ3XDTVgNdeCG^V
F>)G?O)MIO_.W?UX5d,bWHJP[d273FL-H.F8)M(GG&;Na.=:[bNcI@fNVAW8Q#ce
S1D1SRE\g>(TEJJZS_&^LTc>SG#SW_(/[1Y)5>:-aR[N-]A(A]8&&cR)G=\EFK1X
]B2DR#/JE=aZBXGV84,S-B=4NE@6E+B,)0+8H#\/I7G5CX0VZ2^U7SM-G1I(VR_I
460,M5AN0A::O@<,bOQf;O9)Q&cIg8f3cfVI]-(C2@.^TSZ+G\4N5/GH30DN01bg
/>;R/XDUC/)7&HJRfP@f3BaEF-V/8A#/bXMW+,#PdfC=c(P3/Ug4ebGHL$
`endprotected


///////////
// NOTE: After encountering encryption problems with this on some simulator versions, leaving this unencrypted
///////////

`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVT_MESSAGING_EXCLUSIVELY
//------------------------------------------------------------------------------
function void svt_svc_message_manager::msglog(int client_verbosity, string message, int message_id = -1);
`ifdef VIP_INTERNAL_BUILD
`ifndef SVT_SVC_MESSAGE_MANAGER_USE_SVC_MESSAGING_EXCLUSIVELY
    // If not relying on SVC messaging, should never have to reroute messages to $msglog
`ifdef VCS
    $stack;
`endif
    `svt_warning("msglog", $sformatf("Message manager '%0s' rerouting message '%0s' to $msglog.", this.get_name(), message));
`endif
`endif
  if (message_id == -1) begin
`ifndef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
    $msglog(client_verbosity, message);
`endif
  end else begin
    // Need to type the message_id based on the simulator we are working in.
    // Styled after the original SVC message IDs, which are module parameters.
`ifdef VCS
    bit [31:0] sim_message_id = message_id;
`elsif QUESTA
    reg [31:0] sim_message_id = message_id;
`elsif INCA
    logic [31:0] sim_message_id = message_id;
`endif
`ifndef SVT_SVC_MESSAGE_MANAGER_UNIT_TESTING
    $msglog(client_verbosity, sim_message_id, message);
`endif
  end
endfunction
`endif

`endif // GUARD_SVT_SVC_MESSAGE_MANAGER_SV
