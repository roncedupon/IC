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

`ifndef GUARD_SVT_MESSAGE_MANAGER_SV
`define GUARD_SVT_MESSAGE_MANAGER_SV

`ifndef __SVDOC__
// SVDOC can't handle this many parameters to a macro...

/**
 * Macro to get the indicated message manager to report the provided message.
 */
`define SVT_MESSAGE_MANAGER_FORMAT_MESSAGE(msginout,arg1=0,arg2=0,arg3=0,arg4=0,arg5=0,arg6=0,arg7=0,arg8=0,arg9=0,arg10=0,arg11=0,arg12=0,arg13=0,arg14=0,arg15=0,arg16=0,arg17=0,arg18=0,arg19=0,arg20=0) \
  begin \
    /* Use a local string, with the assignment and format calculations done using this local string. */ \
    /* Fill the string in a separate statement, as otherwise compilers seem to make assumptions about */ \
    /* whats in the string and get themselves in trouble. */ \
    string format_msg; \
    int format_cnt; \
    format_msg = msginout; \
    format_cnt = svt_message_manager::calc_format_count(format_msg); \
 \
    if (format_cnt == 1) begin \
      format_msg = $sformatf(format_msg, arg1); \
    end else if (format_cnt == 2) begin \
      format_msg = $sformatf(format_msg, arg1, arg2); \
    end else if (format_cnt == 3) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3); \
    end else if (format_cnt == 4) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4); \
    end else if (format_cnt == 5) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5); \
    end else if (format_cnt == 6) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6); \
    end else if (format_cnt == 7) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7); \
    end else if (format_cnt == 8) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8); \
    end else if (format_cnt == 9) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9); \
    end else if (format_cnt == 10) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10); \
    end else if (format_cnt == 11) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11); \
    end else if (format_cnt == 12) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12); \
    end else if (format_cnt == 13) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13); \
    end else if (format_cnt == 14) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14); \
    end else if (format_cnt == 15) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15); \
    end else if (format_cnt == 16) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16); \
    end else if (format_cnt == 17) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17); \
    end else if (format_cnt == 18) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18); \
    end else if (format_cnt == 19) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19); \
    end else if (format_cnt == 20) begin \
      format_msg = $sformatf(format_msg, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20); \
    end \
 \
    msginout = format_msg; \
  end

/**
 * Macro to get the indicated message manager to report the provided message.
 */
`define SVT_MESSAGE_MANAGER_REPORT_MESSAGE(prefmgrid,defmgrid,clvrb,clsev,format,arg1=0,arg2=0,arg3=0,arg4=0,arg5=0,arg6=0,arg7=0,arg8=0,arg9=0,arg10=0,arg11=0,arg12=0,arg13=0,arg14=0,arg15=0,arg16=0,arg17=0,arg18=0,arg19=0,arg20=0) \
  do begin \
    string report_msg; \
    report_msg = format; \
 \
    `SVT_MESSAGE_MANAGER_FORMAT_MESSAGE(report_msg,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20) \
 \
    svt_message_manager::facilitate_report_message(prefmgrid,defmgrid,clvrb,clsev,report_msg); \
  end while (0)

/**
 * Macro to get the indicated message manager to report the provided message.
 */
`define SVT_MESSAGE_MANAGER_REPORT_ID_MESSAGE(prefmgrid,defmgrid,clvrb,clsev,format,msgid,arg1=0,arg2=0,arg3=0,arg4=0,arg5=0,arg6=0,arg7=0,arg8=0,arg9=0,arg10=0,arg11=0,arg12=0,arg13=0,arg14=0,arg15=0,arg16=0,arg17=0,arg18=0,arg19=0,arg20=0) \
  do begin \
    string report_msg; \
    report_msg = format; \
 \
    `SVT_MESSAGE_MANAGER_FORMAT_MESSAGE(report_msg,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20) \
 \
    svt_message_manager::facilitate_report_message(prefmgrid,defmgrid,clvrb,clsev,report_msg,msgid); \
  end while (0)

`endif // __SVDOC__

/**
 * Macro used to get the verbosity for the associated message manager.
 */
`define SVT_MESSAGE_MANAGER_GET_CLIENT_VERBOSITY_LEVEL(prefmgrid,defmgrid) \
  svt_message_manager::facilitate_get_client_verbosity_level(prefmgrid,defmgrid)

/** Simple defines to make it easier to write portable FATAL/ERROR/WARNING requests. */
`ifdef SVT_VMM_TECHNOLOGY
`define SVT_MESSAGE_MANAGER_FATAL_SEVERITY -1
`define SVT_MESSAGE_MANAGER_ERROR_SEVERITY -1
`define SVT_MESSAGE_MANAGER_NOTE_SEVERITY  -1
`else
`define SVT_MESSAGE_MANAGER_FATAL_SEVERITY `SVT_XVM_UC(FATAL)
`define SVT_MESSAGE_MANAGER_ERROR_SEVERITY `SVT_XVM_UC(ERROR)
`define SVT_MESSAGE_MANAGER_NOTE_SEVERITY  `SVT_XVM_UC(WARNING)
`endif

// =============================================================================
/**
 * This class provides access to the methodology specific reporting facility.
 * The class provides SVC specific interpretations of the reporting capabilities,
 * and provides support for SVC specific methods.
 */
class svt_message_manager;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log has been provided to the class. */
  local static vmm_log shared_log = new("svt_message_manager", "CLASS");
`else
  /** Shared reporter used if no reporter has been provided to the class. */
  local static `SVT_XVM(report_object) shared_reporter = `SVT_XVM(root)::get();
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** Name given to the message manager at construction. */
  protected string name = "";

  /**
   * Verbosity level of the associated reporter/log object.  This value is set to
   * the client's default severity when the class is constructed, and then it is
   * updated when the client's verbosity changes.
   */
  int m_client_verbosity = -1;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** The log associated with this message manager resource. Public so it can be set after message manager creation. */
  vmm_log log;
`else
  /** The reporter associated with this message manager resource. Public so it can be set after message manager creation. */
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Static default svt_message_manager which can be used when no preferred svt_message_manager is
   * available.
   */ 
`ifdef SVT_VMM_TECHNOLOGY
   static svt_message_manager shared_msg_mgr = new("shared_msg_mgr");
`else
   static svt_message_manager shared_msg_mgr = new("shared_msg_mgr", `SVT_XVM(root)::get());
`endif

  /**
   * Static svt_message_manager associative array which can be used to access
   * preferred svt_message_manager instances.
   */
  static svt_message_manager preferred_msg_mgr[string];

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new Message Manager instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param log The log associated with this message manager resource.
   */
  extern function new(string name = "", vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new Message Log instance.
   *
   * @param name Name associated with the message manager, used to add the message manager to the preferred_msg_mgr array.
   * @param reporter The reporter associated with this message manager resource.
   */
  extern function new(string name = "", `SVT_XVM(report_object) reporter = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Utility method for getting the name of the message manager.
   *
   * @return The name associated with this message manager.
   */
  extern virtual function string get_name();

  //----------------------------------------------------------------------------
  /**
   * Method used to report information to the transcript.
   *
   * @param client_verbosity Client specified verbosity which defines the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void report_message(int client_verbosity, int client_severity, string message, int message_id = -1,
                                              string filename = "", int line = 0);

  //----------------------------------------------------------------------------
  /**
   * Method used to get the current client specified verbosity level. Useful for controlling output generation.
   *
   * @return The current client specified verbosity level associated with this message manager.
   */
  extern virtual function int get_client_verbosity_level();

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
  /**
   * Utility method that can be used to decide if the client verbosity can be supported.
   *
   * @param client_verbosity Client specified verbosity value that is to be evaluated.
   *
   * @return Indicates whether the client_verbosity corresponds to a support verbosity level (1) or not (0).
   */
  extern function bit is_supported_client_verbosity(int client_verbosity);

  //----------------------------------------------------------------------------
  /**
   * Utility method which calculates how many format specifiers (e.g., %s) are included in the string.
   *
   * @param message The string to be processed.
   *
   * @return Indicates how many format specifiers were found.
   */
  extern static function int calc_format_count(string message);

  //----------------------------------------------------------------------------
  /**
   * Utility method that can be used to recognize a string argument.
   *
   * @param var_typename The '$typename' value for the argument.
   *
   * @return Indicates whether the var_typename reflects the variable is of type string (1) or not (0).
   */
  extern static function bit is_string_var(string var_typename);

  //----------------------------------------------------------------------------
  /**
   * Utility method that can be used to replace all '%m' references in the string with an alternative string.
   *
   * @param message Reference to the message including the '%m' values to be replaced.
   * @param percent_m_replacement Ths string that is supposed to replace all of the '%m' values in message.
   */
  extern static function void replace_percent_m(ref string message, input string percent_m_replacement);

  //----------------------------------------------------------------------------
  /**
   * Method used to report information to the transcript through a local message manager.
   * 
   * If the supplied message manager is non-null then this method dispatches the
   * message through that. If the the supplied message manager is null then a message
   * manager is first obtained using find_message_manager, and then the message is
   * dispatched through that.
   * 
   * The message manager used is returned through the return value of the function.  This
   * can then be used to update the local reference so that the lookup does not need to
   * be performed again.
   *
   * @param msg_mgr Reference to the local message manager
   * @param pref_mgr_id ID of the preferred message manager
   * @param def_mgr_id ID of the default message manager
   * @param client_verbosity Client specified verbosity which defines the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern static function svt_message_manager localized_report_message(svt_message_manager msg_mgr, string pref_mgr_id, string def_mgr_id, int client_verbosity, int client_severity, string message, int message_id = -1, string filename = "", int line = 0);

  //----------------------------------------------------------------------------
  /**
   * Utility method which can be used to find the most appropriate message manager based on the pref_mgr_id and def_mgr_id.
   *
   * @param pref_mgr_id Used to find the preferred message manager.
   * @param def_mgr_id Used to find default message manager if cannot find message manager for pref_mgr_id.
   *
   * @return Handle to the message manager which was found.
   */
  extern static function svt_message_manager find_message_manager(string pref_mgr_id, string def_mgr_id);

  //----------------------------------------------------------------------------
  /**
   * Static method used to find the right message manager and report information to the transcript.
   *
   * @param pref_mgr_id Used to find the preferred message manager to report the message.
   * @param def_mgr_id Used to find default message manager if cannot find message manager for pref_mgr_id.
   * @param client_verbosity Client specified verbosity which defines the output level.
   * @param client_severity Client specified severity which helps define the output level.
   * @param message Text to be reported.
   * @param message_id Optional ID associated with the text to be reported.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern static function void facilitate_report_message(string pref_mgr_id, string def_mgr_id, int client_verbosity, int client_severity, string message, int message_id = -1,
                                                        string filename = "", int line = 0);

  //----------------------------------------------------------------------------
  /**
   * Static method used to get the current message level. Useful for controlling output generation.
   *
   * @param pref_mgr_id Used to find the preferred message manager to retrieve the client verbosity level from.
   * @param def_mgr_id Used to find default message manager if cannot find message manager for pref_mgr_id.
   *
   * @return The current client specified verbosity level associated with the indicated message manager.
   */
  extern static function int facilitate_get_client_verbosity_level(string pref_mgr_id, string def_mgr_id);

  //----------------------------------------------------------------------------
  /**
   * Utility method that can be used to decide if the client verbosity can be supported.
   *
   * @param client_verbosity Client specified verbosity value that is to be evaluated.
   *
   * @return Indicates whether the client_verbosity corresponds to a support verbosity level (1) or not (0).
   */
  extern static function bit facilitate_is_supported_client_verbosity(string pref_mgr_id, string def_mgr_id, int client_verbosity);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Establishes a constantly running thread that watches for changes in the verbosity
   * level of the reporter/log associated with this message manager.
   */
  extern function void watch_for_verbosity_changes();

  //----------------------------------------------------------------------------
  /**
   * Converts the methodology verbosity into the client's representation
   */
  extern function int convert_client_verbosity();

`endif

  // ---------------------------------------------------------------------------

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
ZP+DB1EDS@#?TNT=G[a=U5_NUW(5G-,V:<6a0+)HC?6B,?HMC76,4(#0^PS(/f__
XI^Y(#c<F]FK3H;)[eMY1T?HX8dc]QA:AAH&=e1OEf[VY=ge-]\LDS5>3#bQFf_b
2Z#OZ8]I4J8-9d.4#e9.]&#^T79LY[eV6-&O3f>)V#B\:Bc_7\JTU-[)4HU/6cL,
7VGO7D\XCX&UQ00M?P@HS-c9MM#=WC_KEBDc1>MLGRBSX-L(LKY5[(&60ZIK=YQ3
B>ZB0TBM_JgMOPB2GO.,I+N,(\758CNcMMHN5TZZ.)P?Y/.a4ef5P:DYG9D>Af@(
]@VMV>5aT[XWOD;9:RSLfe@XbZD;6H./[N;:T=d46Y?Tb&Y=T/b>Q\D[0@(0KXY9
ELd2b8#VQ+R&QZ>9g4HgD1]28T1.e]Q7GZ9A9Gf]#U/TTa2W)=g>]1E:@&V8Sd#K
?8-+)V59dadP,L>>,FNOcceTc0A[FK&GYY9.[IY&X14e77IMc=]2K7fV]9)4VAS,
3e;bFMB?)3>1M.N--<&5Re2,M957)cc82A9GJ.7bZ#\RMZa?YgLBM5MI(f8OG;Z:
SO[=4IV-I0(UbgXXH(&##,AS?.5-d2Pc<bJ7;Ca]4e\K7g9&aZ/5aBP.D2Z6EL8F
a_WEgZcTKGb3A\F&#6ONJ@7/]V(eX2c>+;87ALg2K7.+WbMe-@NQI+P=4QGgdO/_
D>_)+NR@5+(][AJ=HQDd^e3J7QY->];;P&]b4VcZ0&2ff:U&gJJBb:)N1)^7aC2U
I3)&3dX5X0YHFDL+Z5S3fPKda/P).5F<L1HYGZEb(P+B9^KW+H;UT24:[.@<_b:.
:_3)1E3P&O&UZU/L6D>UQSAUc.?RP(PR:1E4M+Q..V-(^8^??Mb?+ae,(JLEP)LK
C_fL5(e,&LCY6Q+9K51@UXA+K+5U(<FJN=8QM6+(ebI@YeQGM::<#d#DG@^BPFcH
8A+H&3HfB4[.T&MQQDC.c7)PFIM@ebFTQ:M;E<EE_Q/EX-M=\W:5QR3#Bc+H355S
]+P/BC6976C]8<GK^(a4TbTV95Z[=U-SJ;Y?SS:eRbe/c\YDEf+=>V06?[^<9#7G
gU#QUAIC?I.gfVI\AF3bB^P_e/>C-R/:CS<9E?/=[=bDT]Xb@\)L+-P>Za/MK_EF
6^f<,MU&X/.Q#XYBKXYC?gUUW(^FCETP8F(]A0([<Gd#.(&=5&QD>+fe?TaU6U\+
X2\CbBXWNF&__8^UX&TOa>MWGRH.BE-gAY#-2N<XJD5Y<[Ia:5NUU_Bd\<J_2P6c
]W1RA?\.;EFf<^LQ:Fg?Ma,L0U4V^df\:0J]>LHUb^d1[a([D_T>GBEI=;D&ZabJ
g@7P&deHf@L:]cFf/=Z.+UIP(N(J4-bNKV]QR5[#,(YI)3Ng/,8RNOFaNU&^/XDF
576Wec_.R<Mg?O8+?[;?[f^K9XGY;IJM)9UaAeC]:M7Hf>)DZ,XQ)cBBGU>/IaK\
TLd86bA)a2G1,IN-@UM85X)(CDFAaPGU6PMH]L^;6f3a>^6)1WV/N]c[J[_UT/4D
.;A_?a8UR1_ZA><S>#>+>J)]MCEO>;Hfa5\ZI#FN_I2(f[(3J42//H=/fFV;Q5E_
H>g//Y8=K69Sb#a_2VTF^6_OUe57g.)VDJdeE<RRBT/EN[)357^4++_OPHX8ZU;7
M7d&A:4#0N5\/5NeJeZ3^JMe)BK]aTWZ?bc-13M7W:G9>U]S9[?T-X2U-8ZD@C.C
#HbH@6g1<+]:S@g_>CggZ#gH?9:PXSU<14X7bGJ03SEG.f@N9+Pf5Q;.^+F@@7W?
H,&Vb+JU/L<d1LKdVR]RT+J1\&c:89b,P)4@NN_+I1OSQ-KaVAVH)Fg].32C/_U6
S:<F/5<K4fW?MbAL9f>N@-8Z>7Y(;FLL&=:K,fV_0XSX_U=^F-L^>F)BN_;K7Jc[
96PXXF3D:_UPGM)01aG^LMXTK9>:E\_OHYGQaW^\.1ZW\d\70L(1D&\Y8OM8[G\:
f[.f8CPB32X0RR\RV277W0.d0.6&25]Kb:D_F2GB-GHT.\.\/RQW@a[&;VTP=X&S
SS.>If\a;-BR0CFQA49<#/@RH=8IDO?5f4OVY\Af?.F>W5XS2S-5gdB11LN#<?3\
F5cD:ECa<G^P[DQF#g<BVgd.5\ZA,EGY7@M7[E\_R([ACMAZ&-ZHL2(F.W@H.#\E
gJN,_]OF+VecM#I9OJC6J2QUg:Og5FZA3W+c;BXLI98TdV<U<M()TPNARC(3Y_S5
K.\BbWf:8AVYR@Q;-#W.f;4WL2=>-BWE5+ggP_8S,RLeM1Wa,YQ.Dd]e\&@R5T4/
g3,:&E>JPPBPE6,P\G@94CNXB1<-NQd=VA,35_)gg50^BV^<?RP>3D&J\KGK3TBA
gdJ1_Z(8KAD_P><5:2\4_-WPe^XUZ_(MX=-Dd@J;[Y4A/fbLb=;=,f\J(O:20_+:
F?,D[NULT0&O:.CFJ5Q5D0_g_IWd72IG^Y[AY(^PK.H.BHZHE4;()F:b[QBXdP.C
dF1^@IeGcA0&77_6KG_W7YM+HM<cHOV327L]JZfV[9PcWAb=ESe(fDeZYAC\@J0]
5g_J]N:WUS.CQR<&AJRH0^S_QbH2WCE(_:6X=K[ELTg@3WY>HHL3;d/BK9KaWffN
U\59G22>/S61f.-ReMS7I9]P&;P=9K\Ba>^D,[,a=LXS;F.T5gLD:7=_[4<bO:8+
MLOW+G#1,ZHEN-+\C)-eY\B:gY\XcS+UZGVbGK0\(E8>b9D2:)GdT,UYE?V<C^ZS
2@6_8>]f^(aG>;W?e;;83d-HAHJVIcQCIJ+&\P+J.01,_,P;3SW^9AgFP]:cA,=J
T_S#D\6I/HA9RbbM>/eP^VRCS27]D)9IZBg)4a=E#K@-f34cMOYS0b:=<EWTS@;,
@X+3;672f90,YOY(-X^-_edQdaPH&)5+.H9X\YQ)9-((\03?aADU#)-WaMR&K&/^
gT]gHNNJ=f-]IIBL9#/#[eeVXV<1B\5]K@GcZ1fZ=VKDW/]()(=IO]7\],WWbV_L
OSJS#-g.ICBfMC@W]3(#=LHHK/XHMXM>]@<9:+bL0V)M]//T79;^L\8W)EcG3a[&
@6&W>Y&P2BfbW3F#>FR.3H53>G6;_M68Y8FS0(/OR@2H0<J87>:N1/RYf2OYB:[7
NS-\a>G(OVD=:JF<.3IC5d2FJVM;8:50E.c9[5[V[/,R=]#]<T3YP-5Lc\R\>5M@
fQ@4E4U]A+S4A-)R6K]BPDY[5G>9V-YHBfLL&dbbba)(bB8UC2e,JCJRW\;/IQg+
I=9?8/RXK.cJ(YL\)>ARLN&50XWX@)3O/FYA@ef0.M/b&da0E<d[VCB6:NcDI8-4
XEELTg[D_GR(CN_)O\^:8Bd(A.4A-H8[0S8\DYeZF>daJKUE6-KEJf>]d=MUIgL^
;LEQ7efH(&>M.IIbH?8d=7M&#D;1NZ+E7,>C4[)TV99-BYP20T>g0,)eVBNPK&6(
M&V?5eNdOAgO1\MS,XGG:WO(NW/L=0,XPae9:@50bS3ZIWMKLGS92?A23Z0bV?BP
eJNOU:MCF();P376=VTf]/N)29R\7FCA=^RO7#03L/N94^g&0Sg5Y^00L)@O]JYE
GJ_0+VO0XXAcEJ\M>/5-2ZRXA-6D1JPS9bf&#@+OMSQY6XgI--I=EAB\J_bN84:[
MSDDAN>@:72A:^+b;d/D8]D?\#dVbREc>=/?1>)_KHfY4,N.K4B&:,[D0@TD[+I^
GWNK/QWc-]KT2&b80\5.RTH?,&IL;VGCV;_))M5@c8bH1:TAb0(Z6;AUbJ9-[US/
Qc9]Tg,XF8G/NDY3\9-/BGPA^>W)0,UP_4]\TDF;Q:8c_(Cd+EHF@(V[TL-L1TB?
07E.g67U(I6[X2^->CC=F@S/gX9;JV;)>Yc/-5/YUG_G],A5cBQ,3HN0TW7O?=JO
UK^(bT=OW8]?faDc/<R35TK-S@)c(9SI7VSCg0Be+0WIB]f/B=ZecG0?;<^1&?)Y
L_1ZM=-QHKK?1Lb0[GQfS,@9S<)[0AEMY(?Ha@&DL;Ma)e[U43\a^R?0B)H:fT>F
UbO,4QgP/D^T8Ia=VU,bR/JZQ9I.V2;_0T@44R/aEFRg4C-T]/KE_BHBLT.S/QT@
U3NH\P&XN5IY6)D19YZ[VJ7\VScQ2,/U4L.Id-R.2C&UA43]_^IO^C#QE)M9UVf1
>[Y;PaI]6RfE6/H>V3WB6NgH67^6RA6.T_Ia5f<(=LM5Y.-;)I.OVfgGWXWd;&SO
Vg\bX@dTF/b\:YKa9&FF:,ODE:VUaQUK75HQbL0CJTZY<J)fBE67NbLf6O.ZaUE[
9IWKYF[RWK6ebIHK7Mc5I6E6,>^@VCaW]-;V.aF4gREC]6#]^c#f+d+X;NIa-9]J
2QUe?+XXeVP<.KKSXc[<4[R4[(;+,#XQf1d(KHZKB&&S(Z2O.cG)F>,9PK6\C7:X
?HTfW.&=Z3&^MDQ/+_K,K)S@RA8?,AL/Q1a[8U5R+]=@YVUIOGIRfA&2[eM465S]
OH;V>#9&1KeGOT(S^@LD2=b0dV27;dZ2G+8T/H>aIPOKZC7-gf7/CgaZT&MB.X@P
6S+@#U1c>d_D777^NUX:V^[;-]P_@aDg(@IDO[75-E.5f]0J^0Rgc&4SE9/U>J,B
N&>;3&AQ<HI&O:TL0dM0XOG7EgSNOW1I8<JLSVY[U917ONX^SFU#?1CW(-R.-PX@
(7(/RI3&/=OC?CP=@b>dUW(Bd7e\@\:M\6KDDPB\#I#]Q,E[Q0L+aT5H.JSD#T2R
OK1WR=E/V:@MS],N0NMIKbYQ+X>I3<OAZcgA\5QTE:IM9NN)TU7\YGP=T\S<9_M<
a^6(LND;FH^>O:6K<:0fB.@N8W,5V)I<]YP=<U7:7L<>G^3SD+7O=2e<FZ@[P8)+
>YC7B8\Y;aNd&N5V\CgR7OEPV5\=4[55BXEZ;,&#g1+@=e1)\^T>@3FR5#@4B3V9
D8QK6P2IR45;CR<0WI]__V^D8.H[-+7PZbEg,I^W+@F<OaP:N>V98C@C^HWEHV1#
^Dg&cG1&<Q1A9EXHcX\#IbBT1DZM,?F@O;;7K:7ES6]e6YdERN(H\)f\_)\+;AeB
X(>14c\#7:8EbOT/R@@D)SQKJNTF\Q(OUcRCB.dKS9bGM#+:)P.W^BPXF(D&<<^,
G+fFB4?/[)K-F);BF7)c71COM(OK783@P?10WR&P#.\7)A)KNFUS\aK-IGe+18:?
eUbb^-a13QQ5f2?XXUL3,Fd&:?6dD:gSHfLOW6XG5/PY9/A8P.>gE0D(dX0g=b8e
\W)c;dG/L(Y:3@)W+JF7g#]6ZB?NLVBLJ;?F#BI:_QbKK^DVF9#9#2CH+9;VJ90T
6I0FAE=8B:cU[X\W?K>-ZG&=+3A+CHPC41He=WU@.W1??.WWF8aS\[(D60dK\QL]
AUOPfZ&IN@:M:@DM]@71FD1LAdI^aE=ZVCO.R:f=-MZAR37Vca<J/dXHZO1D>8EA
bQ]JGNBabg;()W.C_10aP6Ee(]<;0JC+WCg(D\J7b(IY]U].1B:0Z/LR;#CeWZEE
YPMB/1U?V/I^:O-fCW+eI0W@Md4@43:3Z)W9Y0#O\:-]0a/ZNe;/^MM-B]3ISfRG
:(Wd3e3HT]\)N3PN.JgY4gG45AIHE,)VK42HU(K@CVTQdF>BT)R8;^8;N[2bC=B\
OF]6FEPg1#3?[?_LO7C10EI)3DNYdDbGS#Z=PDaSA=LODTV9dH-d1Fb?]\eBfE5#
cO[(:I\Q+]95Od267b8HJWQ7g_R?(#CX4#Gg=EW.+9:cR<;^5:bY_?B@4W551CYd
(_)=R,(Ug69<4UA:S4T.WJ/G7Cb=H=-:EDIab^Eg+cd7GJ/YX))CQaR54=a0-#gP
(W:ZAScIHd)S<)MQ6PU(KZVI^>4A\[\T8gW5+ZKP(.-;bcAb96OZVGK;&)]d83/R
gUU@RHfWT^V)CK@Rc<&EI\?@aBP5RHA8VKYAfgOFQ4H(CNSHFAg04+W,)3JC19gY
O5XKWM>O_;CYfDVK-]L7I(1g>089^IK@4C97HC.\8C>;KQRHAX(dV));AOKMecYW
)R___I]S,E#?;A\LH3c@QdQ]=72QMWIN-A-=G/8NAH_Y;Lf-YJ27UIf(e=?9C(-e
a=,EbeAW^\)R@D6[289Q#<E50I#_eQ]=0?N>#cRL_^]8fC(3SWT&9L?P=X@VZ=[@
e=.D#9bUAHGSE=1T,2087CYGXAU)RJ?PUCf6QKXM\_BPV-,@1<aX)]6CG_W-baDb
U09<L;N;B^P/dFHWY?^<@SWAMD@V>91?K\GLZ^O:PV^ZK5S(.#XGBDU0[f+>(/>H
gXP(NN24GfCWaDDEZ1#M<gR/2L^V).;de5Oa47G3=:<c#<^A;S>ac[gW=CQW2&[6
bJY4R]YY5+@NTd<ZF6Z39:WW&bCNe0=6.:3PMRUBUIHN\VI_/M@BB6E+;<7f.(eR
Xf@&_XD=Y,50+,+XTRHR+d\UL=WV5cW64BLUACDdKKfWc1BX9MJ]K]MF=2P@c@<(
A/P;cCYNMJ^L=:SUFNC,6L=N)9ba0PPQfZCW>.Y9Q=X58a\e.<MOEQ4L-f\IB=gT
M3b_&)EHe.2dV/:R)&F1EOZX#>.#U=](,=VOc5;gWI,&LRG9WTD4de/FURX-2IR1
P.>aP^R2S.WQKA2J6.8@+NXB@>AJg[)=0Ia;R29dRL\JCaR./4^Od\Gb,T;CDAGQ
R5c4E-.J/6?&Z=:MLQcQ]2HVTMP4g3V>FIEYJ602gKK]DT@UFfT0=Y/KKYcCg(@-
]OUeeJHf+PgH#Ia(?3P]B._fcgaQCC?A7W(1<B[Fe.,F=50FB63.M\=@C,XW+H?F
gXR<6#PP;HCfW,dUQP2dC-O>5\NDR<PPG#DK+\gDMN:#5;60-UL=d+3UCb9(.e(^
<E/C#EZXT-^[U==..ET3Yf9.6L]QJ.b.M[FDSW98<VS9F8V2I/4IeOfFB./EeR:a
]2g5NQ48@Pf82W\Q>9FUSB\8aQ5/Y6O#J.OR<dD>U7;16A\VDP,DD;L?^F^_&7L6
+L3_KJJ;=NY++L2@RG4&Z\ENK;7cRZ]4?T87CH+0>Z.,9P\A<TQ4_@8cH>XN\1#\
DgMF0J^J8GGF9;4:ffWK_<W<]G]DKVc?>97G-a_\F[4C^X>/?@,6XY:A08&8(^7E
,FWG/SOeO&+NSR+2[W<>8+0/PUe2AT05_^OB7?BQ2NBQV@XKO.I&LYH^M&\dS;CL
#]Yd_+8T19J_c\gFOPKXFgFQ^]Q\:_8JW0UZN:a^IG&D\#6>P5e=.g.MA5-0/]cJ
Z(?\4<RaFGa=LE:=+6_;I6a4ESgW(\fM(.Ga>LEW;71Wf9<9I6Z#JbWD?:8G,U;2
CXIKD5dOP(6(F31C,:Zf90Zg:Y^g,POVH&1LDdU^(MX(>7X_6)TN6O:(CfdZ9/04
7JMN5W61_-L?SEFMDb_L.HRG>JRX#I./9JUK7]6W#Hbe(aFHeZc<I3?c]OG\IW2]
S5YD(ZeT>&W3S<a)E_U4_7O<Gg7CRC>gO)^:@WB&WCHdBAcQ/7gXd@0&P^H\T7\R
IGfHQ&L(g>UUO#ae\&5B#HJR,S:ae,:A>/I7@BF7,>_cT/3VMW-R5J]Y09g@@9M-
,aLcGBIO7DTYb9fcdNNLf<eb,^cGcZOQ9O-e+N\FCU:>:&]3&4Q+ICbV--3UL(dV
SI@^J9QQ1=M/,2>MfJA>6f335eXELX8)2Zb[-MCE3C2;:J[W^OM(;R?8EPR_U@d\
4eYA4[7V@)EJ1,.TNJYWeg?c5;EbUII99+C=J>.ff,Ub)S4?+/1bY<a[CcVf4WU2
@=JL\2><]b1_Q:)b2@Y3]fHV_Z,9Ac<c41Q5I\ZYQ4K9I)OC()+<.:Cb=?-?G2.L
e9ST/F.)@Q,4,N:;.#=9/YbQBRV:S4_Bc,1If8IG5a36fLNV?)8gXaAEUgO&_SHf
&M2;Z<]6;3.a,PE+[7KVDRc#T]bX-D7K>BAE/>bWMb72W>]Z+Y26AI(FTVGEbV>3
#H.>Y295.Wf_QPbOV;2/O3SI@g/QH?JS1IYN/)._X3;,.B:@Mae4DT@Wf@5O5;M6
S+LJ4)/JUeb;]Na]B0]^DfR9c:bKBBc??a]Q&).;NUcNgB\DEb;.TR>c1I0S(@@I
6?+cUQd>^>:dPK0W=X_d^4eMIV/<P0+[dGfXP^f3PT-ID<F&1&e\S232F9&?B&#7
YeI;N-RWMAVba+e_2;.Qg:DXX&/&^dKHR<N80.SEfX\/;/;4A=2_D=&W@N\<AW\C
B^3Fe9\SD4AAG+a?6;G<C#5GESf[.N4N42Ff0<JD6JFCc(65\cDdP:<\7H@B_+OZ
RZbc_)Z6gN,C\Z/&/I7f3FK</9bKIB8:1.H:#Fb\N5A4\+XE6g3<N-8eL@<:D>Og
5?a5T>UHAAVS4-TJYA<:gZZ9U7H2OD.aCY9RDD.-SZ,U_P.Tb8PHaME;f??aW/O#
3PIa+1VT91<DAZL,d##]2_6dg)JPbS)a62@[@@Ig?05[aJg3;3M/gVQV5@+1XCB@
.Dc0(2AA582??c9G6Y@\)).#RG;C)c5DS]H83G4<=1>X=YD,V-ZHA2G3NcUMN?.U
OP[V;]4P]e,3H\Y]^1D7ND,_^788]#[8O1\CNNVHUMcfaVAAOY#C:d7>X[P5EDed
Z[RJf#N3HMN6@3F(+4Ta/^,D(95P6SNFY1<bPUH(Zb5)41XDW]U.ERb2WcbG,c+b
2&.TL>-,WF^gS+>IdCd_WC>6g,PRERO2#LG+&aMQAc1.KF8c^]c<\.Y<GPCN<G=4
5/SJbAEH6-ANP,Ke;JM5E=J<0/7ec>5G2>@Mc:DF+]35(VcKOV-[O9JU.BbKa]5U
4KcGMSa)SE>3VJI^?.Y0B8TTf32&42M;X0]?RFJ7+5TP+,>?9C;3/;^)O&GXf-NM
-NQf?fc1c&(?YTVeT-]&41E,^57U8>aUNPF/TO\&=MQN(GGWeF_PY=_,D;FBa6P0
=MY4TF4E^-c_?WGDJ@2@B3:=YdLEJ4K:M<W6AQJ?dfa/16R/.HI_VYZX>/a+2g48
/YS/>=e4GdEW8e1.3X@PU=Q@K(VT#I]:70)7V-IbG4#@8=N:.ePZ^A0EW&T>K78Y
a,<X<&C:@J.RFYZ<=e]H8a_6FD470WL:F?5Z=+?[#)S@H\=a[f3(&+^\dOVFW8O=
ZaV3)7)W_c(TZP66#]Zc[)M;#(_W3YVA(,>.2#Kd,eT4\9P\I5=g@4Sc-EVF[-U3
#e,cP,R3H&?5U2NfLgJ?dOg+)W#;76\Y6e-&NSO:(.3[a<\12:H)gUfN6OM7#X4e
]QKCdD2(83O_BIV=\]dM0K=KMDEQS6.c30MSHB);IeWI0Z;5dX:d]J5Y;c97W:42
\4a(UN3Nb0e)ePLf\PKWeWD3g]51D8#A)X,S42L8fAfSR6/.PV0C&CS;J-_]Q(XD
H/aA-C;3HE5XZ^[g90g/[[7Y::8&G-UeY[Z:4VScI51Q/L<3S<;6FM_3W#&QS.B=
eGBM5-1>bVd929eBZ#^C6T.Qg(9>#SXZ=T1SdeR_WN+0TeLA+)PN]4&C=XgVe>7;
;F71@)C/Jf)c(>N3:0?,N^T85e:MIT7,QSG3c&20]GeJ<JMVQ?-,]F?BY/3S0(EC
1&92J(D<1\;:Q9+,8dW4\NI+M/)WJ[Fd.aX=+1>4?Ja/I5=3FOVEfF41Ng5H:,\:
G45V?9/9F(\7efE@?F&@ad2[VUAYS<Ze@IFW4aaT&P;OX5@LR/,]->EAT=]-7T;N
<Y)gL#:BUR=N]f4cBg06XJ-7_gDO0NVTLJ_LSDI->ELe+Z1gJ5,]?WY?@7fRZ2>3
I_0./Y@(XeYUY\AZaNDL@2EWK^X/S@[:1LWN@YNNW@JG7a9B]MOYUeKg9R5NZ@8\
PX/UJa<F=C?4,&)>D9KX)D))(4YS2(<Yg?2&PbC@_;0MN3.T+ge54Y]]W#0?UT5U
?)ZcL9G23A9=9eOg7-AcEdFY])G7TI>B4bcRFY2C(cOd=^AR&>Q-,<?0#OP^7Vfd
e5fXe_b5e:@V;Y8U(2&S<8W4cJg+9Q#A/5?=))EEWeCCK6UJ@g4AS&S?HZO6>:<P
=8EPb#S+f>EQ;fK31./A910W-\dJ^1S4eOd2:,FWQK(I0OL#eI@NI]2U1OYbRY<>
PQ/UBa^S5JA]=+M-66QGcgd1P=2(V&\aNTM5XP.P07X8W^C_019);<Hg#IXe:,GM
8CR[&8;P0cI15O_#1KXDdRA\;9@2E^Z@O1B_Ga4?N]P6GdRffSF3CfHX<C@ef5>U
_U9e9;Pc:?;ZMZ<#K40VeUJd2?.e.08fF1FJ<;1Pe-e01bdK6bC,M6C)<Jfg>80[
1,?W14B+S:1a(6Y1b6&QP[2BV:+3S&a-O.[8U^2ZQ64OUZGPde1?>:OCD-=O^<7(
03>0L,Z(+,:F2W4H)eA/^F180:6:K7K;SM[F>/e=Q=[F7RNPBO.<WfIcBD_5RG[6
TO1cJ29aYQJC[=L:<aJbI)TgG.)61IX;_ecI7#5JV5E>L)0M/(dK]ZXWVR\1XL2L
VP/.,M;+M&&Nc/a7(F05M1D&b;?)f?aV0K88R9,X37BPY^KY0GRF\KX:,/VTBZ4O
8\7;4?-[(.TY=He)89SO<I[9>.9T[K_WNc;Ke9)J8&gR9ZDHV7^Cb9)0g#:2SbN>
(/B.=8\O9H1#\Q(#T7JRYfD9WFfHR9ZR.+RHNYZY:J7X:#GAf,JJ-CJ^5G_)#\=W
UJVNeJTUd&=QKVG^8#^c.)E30A4XMUUUL::H7PH+#ZUX,2g\JU9KFB5K@(a(C?X5
0^C/(Q?1C-(O,JdNM87THEddG,1ZK^1R/OVJI&a974WUC=.HM7F@2WDB@?[.H(,6
3(#3^-<T9D.;;\fXYP;fDL6\0fIC^G[cGP&J/RgN\/7#B@=ffYcY+S+D[XKg\MF/
M]L]He./Rd9BM/e2K6K?D2-/8VNVCD;D6f<A@M5M8O@9^NIa6?AbED4?]+#g;gM=
9,Z[S5DVZ_EVAR?S2,LN)c/GbMZg7;a+5D2cO;MHIH2/1.Q7e[\HP,0]R,Se<^6^
Mf>5X0dPIN29V/PYOeXVeL662gG1H,C&(3DWSXZEZSH^TYXL2a?UM2b<c3)H4K,,
(UQH+G6?3#P/<=/,WRR;LRGE=g1=MW[Za,B#=X2I9eXZ(;,0-8Z6&GJ&<[Y1ag\I
[gY,R6#NU]1?J?Tc5IHH1YJ/MXRTNE9MEWEYGd#77\Mf/7C;^W/I-EXA>UMG;I:8
+f+c;>@^gTB+3@Y;VV/bQ#/K1Jb14g5QbS9?^71(+#Be]QAOW.YQ/a6A(^4,N^NZ
@N+UD2N5f?C<]9>IB8_-6BPRg5f7>/APSJ0-K<WL@C(LWL/46W)OI3a8^ECDD<XM
bcOCfS.-OXLI]RA2#>N+._V/6Qf=bFF?#N=>JX4ODU;>(CQL17LQQA3@fMY&YcU&
&[d8IbYP6<PCQ;MI\U^HAbRg@>PeYOPD-&cR+:\TeY<R_EHcK87?f7#17aW7HEB?
PNPYMA2HL4IWG0=g;9SK8L.RaR9U/VeX]629gO:I6C,fQ&Q-69YXT@8=62ZFMd7\
f^/#UeYK4N&a5LE\EFG0c?PJ3N(MP&&[:WPQfaAb9[,A/_>]fB:403(=-9OFSaGK
,J@PT]&5eP\94(eJE1(QgYb)F:M&Y6O1gc@V[J@H^>V.aPBS3]g4-AQ&ba]aZA4(
^K3L>\M.UI<JHeWJf:ONLagOc/be=1QL<^)]:L?Cf](85P#?+fDDHA].ZY(C[HNK
9?Yed-QeQ\V-8T^aSV6<4b;VCB_G5+\9^\866HJ@G.,fE^&W.a]<&>98JD>?99VN
]X31#7,S1T)T/S(G;K^X]8PfFIB-S3c>,X/^094CO#[[,/2D);A6O_(84S6:EgV;
TV3@<5Z59^RSgeBHR8HX54=L)>WJSU5Caf8@PZGB[^@@b(CWJa[M7<)FHVPL?O,D
L2^LT8:YSA2;B4;B)N,^IAGV1_+Hf83@b807@b<,DBN@/agQ;cME;M6JHJEPO2a9
D55KG6=PK3I@PBJWMecMB7BSbQGO9KEfAU9g0RG#&(c+))bRWa:=/2c64Bb0=_KF
IVP(ab.-C3F5K_:J<F<C;SPKP<3-/E+dO[&5Q#R38Xe,K<(Y6SG<CPaZWRHK=LAX
FZa.>8#_dT<M[]dX<7SAHI\6?;Ff;J-8K_R@f<OCDGdNM^A\F42ZA#K4^7-C1Ffc
IC,+46R(eZ)E<W41>LcUJ2I?DC9KBJCW2?)#Zf6@KW1]/K@LUDeFB@J?:CT0d;E,
VZ^ZcW3<]9NGKAD<O58LcaKE>8_4d_SP8Je.>S&BW.)+1<+&H#=5#-5I__+#/Y3X
+=AYW:>K-7e6?&6WP>1@7CRA=13US0D5S6e>aXDPG#+LZ(8+S_5BA71_WTC)U7Fa
P6L(+XeZL5B).;N[S;P;0b[T(E#Q:G08C24<2EZXEVHCd.)VFdB,R(HLT&;c_6\/
A-LdeSbDT7d=VLVf4?f02RKXF/4K/g)^&3HYEeM&YfbK=KCS#3f6T.B(^ADSZPYY
Rb0CaJ,O5\e(d\bN4;Wd0-V5(#^E<=aN;RK=?^,RL-@a2gC(4I-HO5=_LFW\Y:g+
P@E<RT^EPVO6QHC:.B:<,A@0PKN]dL?8ANbBFGGeM@TKA<=A6Ya6WFT8E57M(6SU
K6-Ne(5BKX40a>4U-[a#)aa?<ZY4&V^E[CZ(:Lc8B1cP=JPBU.0P0+GS\LdV;eCI
(P6B#7MBGQ^SD6fXI@+-7Y389#f>U=gC(cDPCH6+93A^P.K=WAK]P0(bJ8LJeED4
FcQ,Aaf7Ib(g=.]ZDN>?UE^E37aEX/;@^]P09;g_Q.V[R#S=:A2LEDJ+=<;(JbXA
_#W7W7S,ZC>#E<6:X:_EHEBO>EX?gSgb-d[cYg)7C679g8Y8GN(2,[)YCDJ;7c7O
_W_G)W0?;aU]?_)W:[>BCLWV3R_F:PVVX)1LcVX@Y2^?OYFDZ5U@V>[KP3?=&&3>
GF]e_XLdEbU[>cQH;XIc_(Q,U/fIFIOCL8]@)N9_@W.=]+P^[HAQL@Q9JL0bYFV(
aWHFP.//ac+a,86L,NO_&gN124BHc#HWGM?;VO]<#I9C)J:I358YLWe@8C;P&)T/
B(^eKI;3MQ#0-8(MM.)97W&6F3]3[QD>g4;LNf;3fC/6c>0K5+\.6T4^]_-0BM=_
#6CI&:TLDd7ZMNc]cBKa@3S6?7Q[NFcP5e2(9E&-P14R6EZS_5&1.a5PfI&H:2(#
AbC5X7740U5L@RPAK<)Q[Me>76YWDfZa;7VaQ3cZbH-U\CNTe_RKQ#10Oe>_ES].
2.7Bc_-Ibb,SKdU8]VbK^VIIEGaX^<Ibf@08AR^&2+4(/.CQ115;-XQOQdLYH/6g
\Cf:#;/e\;:Hc5_+CKLR.LKY&6@15NME4BFBQ,&K3LFMB9,-LAd917Y;<SN.XFD(
R?2CQGT3GP\F>H#g],U6Sb@68gfA1Z0&7DR<6N54UM^@XIeTL.1YR4;]J.QbJ4]Y
89#\g.V4P0M\\-gFYSOGW[@8W+2BGZ.AY>HX18]gKb>b7Ga=_BYJNZIOQ?de5#e9
5EIL^SUD)>eYDKJ,1Fea:J78MU8LQMA0bZ3RP31TM\XaXdbaJH&I>F>_:Q&2K.15
E+=I420cP:=T8:HM07T>44/d^8:7>ge&H+gb2.TSR1D#,cXScH?WMXX4N>)Og@Ac
7\NA,YbOa;18Jbe>Xb4SM[AFc#b(:,3(D).C5^gd3I+Q54R-gIX\J8Z7&dFE##SN
1/5@M@O:C3;CG&WfQ&e^d_S<e5\67e/QK>,Z55&KX99bP6SY?71Ug5+TP/,53f.@
USMK=:4VO+5K[@C\.\;66,PfX,^4:c+@Ne_9,<BQ,8WPKabZF=MHD0][RH2g=DL.
#>?/@eK1#HSFG64.dYV,_\)^,&Oc4_374^0e1KS\D:1,L-fX@YN;a\ge_YdLJ;YB
9Ceb5YdPJW6=F-McQS&)RK2USQcFAaUVE<=Yfd(f;:gZ=#VOHbcYS?/:+>ac3UeU
gJ>4+E9c)-.+=A&5(P2_T7R@:H5@59bAUWG,YgDD.b-29eO?40228.I8-VGL0BW6
H3FUT;PH/WQ9W_X3Z?R0JZ2QF(bKXJPAE\0RF9F>/B#(N3PE<[ES+[L=7X)B3R&J
033.GODO))dTH>#b,8:Ac6N]HKW9?R[QQeW/GCBPb)588\6H##2Ff>Uf?LOXdC]4
XGDg#@PE+;L?g/EEe0+QS&NaJ;0/fRf)^VX4IW[1S],=#FQ)[/(:L#Z-F(=EC+2Y
B08Ug(Q^W#L,T:.cRE+VaG3W1cDQF;+cOXI.SQG-dC#0\MP@<B,OLEf)&-@7/Ld6
X0f_=U)UTX8?c?AL+Y3H[QR7)Z30?6#&d)1LaOMIFES/>7C@N>2TL+eaPRLLWc@1
+d/b<,?T<R]W?;@^+>Y2TVG>eREVK)[^>@I./&HK<-e)OV[S<MNOcfMKM@EEP35F
^DYHF(:KU&_2d)V@>U^9=306E42W7gb[FS0[-XPb2]L,CgU>g.TTF8.=d0&.EGI0
MPG#KN8_&6Cc=Rfb9M^MNBUKLDOL)=OH;]6>S=ScaR>+aPV4EK6g075\LQSf@)c?
OgfZ1g6<Q)H56_I/>D8YH+-9S1H>YVTSQ:T5A#B)YP#[)bCeNY]P\AJUdD],/cCF
I^.-NR/@#Y8H;/>Y3,SQMc))&NbaDcb_I=\UY,8C1[;:JWA(EIRM:DG2TTOQ32JC
#TWY.BVXB,LH5C\:./d&Ee-Y,43FgZ0Fc(eEfJ9BT24=^9Q8e7NDYU/Pb-E3D_]?
>Q#AZaP:ZJBD6b7=:E3QB[<K^R7N58&/L&@3Na,XK,Kg(SGc6ONVA982c+\/#4PZ
d<:N/fUQJC9F^L7Q+FU,4<#T-2+#/#KaU2L,c06H4H;70d&3[cP2HaFFSJ]9Gf4=
_U8-FS:e5^0P,-]S0J9P<JBIReTB+eacOYCJ?e]G/C5VGC/6WfbU\c;#]aHbULM3
86BG;,7>@]IV)XJ8f)3a_,d[5c+JI=_L=<_+6?(a#448\4];e9WI_f6?RIe44c=G
c,cJX-HC-P:XW67B/]b-7D&E<TP/R#B#LQ8#WZa57+W)VOB]5H\9@28&L001Tg.J
I9U;S^8Cg-<gHJAcCd;Z&8&23eP6aR3aY821[,LQG3d)+<_OgSe-T\S,VT8MF5/J
LQ:J=\AS.H=U1@SY]@7c3a5H,(+;_[0K&dJJNP]RM>TAZG@87@bB<e>7;4egGHX8
W^9/EPHRa-I&a#\IQ2].UJ=1SFEUPJZcKIO]TND)-aX.W+:>F@?6#_E.Pd9.:a[U
AC7#;CZKGVYOJ=Nf5-,be)fBLS]0@BY&_1K(QY7Q+DO9/NG=1g4ER+4V9fE/RW(7
T]fVY4aAfbbALFJY2<>)M4MYBQJdE^]B>>#7(Q5#\84LG)=]^gE^-&\3N&<AZ9#-
bC,@5T92PP?2P=_[;^CCD@@HS)BdK(UZ99_P)9EWe1=FdFg>N<Q7adB7(:O</3XQ
1I,]-ScLcM727gBSWJY?bR.2GG>(c55KH^@#6Q66XWNb=:XUEN#Q<6(V_HLIbd04
94]Qf+)^e,>aLK((S5CZ,\OH@P<3[Z<TOA>O22=HO</87(>AYAGUM7G[d+4&@DGf
;J,=6Y@4Bfe3O<:?O,<>c#V]/W?6G7J2,27&2\C7/e#DX)EP\b;P30W=52Q?O7:S
:;;\OV;JI336M=0W,&-^#G>J;K,PB)P[BZ>([R,=C^BfBQeAG8EBWaZDMg&_=?ST
W5MEaZ?/[VF8,I#NBZ-5d(C^Y\M,D3TIP]cZ)TLaZW0QG\\<9c&C=MRHEIaa143<
E-\FG0COfdZE[ZR90I))e7(<^#@bV8H]b7#H+^2]4[Z]RGSI(g<YO])J,V58]JYH
TM)^dDTR?5N)gHdf[L9<cNDMCD]fU]+C(Qc&VV^,]gFA-CDC-?YAZGN][CbUbb>Q
6B5>+ZB#5])cOJZVK6WECJa1\(2&WaLS)B(319N6C#aDeY8<](1#-LU2KTL=b4RN
&a)(>(YFVYS8B++L4Q(KGS<=M-9MD-LP;&E>W1[8aUE1,G&F)LNf(Z]deA8CYOBa
Ua>S4PK>0EWdR#UETJLD?aOH]1J7(/eg)@=^;[Ja18eE1C@TF;M?V)LfI2W&1>gc
CS.;e-=aQ^LC7#K,dU>D/edR:6J@Z+-5YZ[bA[=.b/L\L_OLRCST=IY>d>)Y[T^Y
D)IP]@?,XWPf\1KAHC_R@<8ba6:DYB,UG/[:aI1S;D)S>gSQGU9:Vcg-T[]7H3DC
:@@9OU9V.CG[:PB2ZE)JbRMf_ZM==#(<N5Gd5/gP:9W./8-NPG<[P642WF_f^VK[
DWHP+?F.2IPO2[/@U^5A?7AGX=0OC>=[O+g<bK..]e3O1bee9MR#YQQ6;5XR;W-,
3b60\9;1@d<G\DZI,KUd)68eNB0=M4UQ8K[_T5SU19D5CbGMKJ;D&DSe(ceU9@RI
?PCHUCY0&I?@SC<;7<S@AD&^C<?CJ:#.>adTPB2g?T_Z==31-g>gG;)I]1e2LT>3
=9?LZBd)N3F,=H.V_fUK+F(g(/Y9fT<:1C;WZH,eU[=K9e]b@#C[e5;RE2.P5I-7
dD_L<<+T=gd1[19g>F96+E[HCbD/S-5c,2OQI;Og-,A<=:Xag:K-CeQ3(=54U/1,
c+BIQ6;.>e&V_K/DS2eLKY:JKELCH56aV3+L)SNW--D]bc1BW[BK2fKONQg,>-eL
#e/K4&V+4<P61L1_16]5?7;//XH#OJa^<488)C&=A)H+:-9KPT,92:e<\Cb4P(V5
B965\I8X.HGfFNK<WIJIZ64AFb]-0PYPJY&[^&Q^e#X&[cV#1WLL(UNf[[5#Q<8e
Z=-DXG7LK7Z@..3De=CP.R&fRX84V@U;-1g&3:F4aQUcQQB5+#a>:+VLNC8=PRcV
(KWV>bK^/d,SD&XUcbZ1cNG&LE2,JFN-(W,aIO?S\NOL2fFbU+HaHS)Xb.&9NAD1
E9.EI-2V7_]XQ,V)XD/5<;(RL#V09]A#?8UD5/Vd3J;-P@>D\^.^P36//3)0DcDe
:6cZ5&VJ#e_OCI\@U=&7BB^RFZR]=:1LAA.IT(#3KceZ?6-K4+7dUOOZW6#[b)c8
(3)I,26I>f52Ea#Sb>Q@Z2(=YQC=Wd^e\XgBNEMP3J<IBbC)QU)[U)b?TY=YCeQ?
]2Ae)d#f)TE^Od6JFDV3Va_D\N7@1+00ZF/#4(fLAS9WdbcUaJcTfX.E<)YRYYO[
Ig3J.8_4+DJWE?9XSPT&EeJ+[A._?B#dO-IU:KJ\,2^,b&9+FW8&//NG600XP_#g
CW[]>Z4KO6K3QAbSM2N//Va_^HD/L797T/OZ,1^C:=Qb2;S)&H/1NDEG&.)I/7W;
ee9;@eTPB8U^C,-Rf>;40_43-)EAb3/3M^AbHQ=E+32EBW&IG@7F?XCP7e\93&AH
P;[N\VB<KHcCeT5b,]4eeEVJE\226fQT.EgI[>5N8&GeCHG4cZ_@:Q3LX3=7YN:g
S)aPYFg-LH4QW3OQ6Jb2XfX+H_8FOU+(?((GPS7,2>>Q.NG].I=e^GPX2,LA?+TK
(R4L&DTb+?KYK>BHD3)BHN&Q3M_W#1)9J0DIcSQ#CI):H-gaU4DG-[f,NWa(5^?>
Q-+,]FX;QM5A==89P;?]L)Ag4D]IKJ\-J?=GV[V2=a?]JQgSQB2YLF&(\(52)JXR
/\\V/B.8FRBWfd2W:G_:L7Q\O&KPJ-]=UeU\-(<MNNdbKK#>#U<,S09MHGNQ(Gg<
,81Z)]^+f(I;\]?H/g#WJ6Q#NKcaJLM0dSb&FF3XNM0PX=KLDGT<a5#+>gC:^+;V
2Y77&S1Ydc21-CC>K].S4R,9e@&4()WS3\9=0MMG2O?=II08>/MaW1F-3R@Y+P+T
QN#bAYUI55167.MLRQLa5\)SZCgG>A/?b#V<C31=B4SQFB(0Q?--X&&<]d[RZ)[S
G;X+e;<a&W@I:AK,1<dLFc00D58cXB8L\,)_&:Yf1]b=[T_9IgbH3,:,^b2M\52]
CL1De+[J_d:Y;02aKIed-YSV=+PXdV=M::We>b2&^f[>QNX]ZS0M3IFCVB@gVfWb
a2H>LY04SSc9-dWRI5\Y-#11.c#f(e+B#?4DK/70IAZZ,[7MR48S[W,T6Q4U.cH,
PfG0N)f3P[,cO\\2;X]45XN[6XLc.G2K#cL@SC)Y@0>8HP8L4d23HR>((^caS),P
G=8C?IKZ^FJ:)A@26)=@4X[cK66&fB#).^b^d6IHGR(WU+S8a2b=D\4:&29NG1-[
GZ:MTE?f7O2^X/6<X\#4A?:bW)4P+242>+9WZ]:eMC+IN?T;]RU7I/[@5S\c(2XH
N06T[WbGaEQ-Bf32T8cg7VfX@YXaL#V-(YE:_4&_,+A(3NPVJIC,OS9PD#6(O\BE
S;#.5^b:II[\VGXDe0(JN-=RcUR=^O2X<89GUdMgC.L-[H4d<]6D.^HQ1(4P@U/D
FaMb?d]IXdR1>5O5TGH)c57-ZUOdD>bD(>VgZI8FV+e^2;cfY4C_0Me8UE,3&HO+
8:5Y7e.efV]G(7,eCgOJIIWXDeXdBF1S^@OG>B;:?7<;8W6>N_]a4&;;>T>(_QR0
<,[D#I6]29OQ&GH0W1=RZDa;9SE9N,^-cR;(9@I+RS\@<S,eO5,HB\<&gW[H?1+e
K>?7BDEb;a,/\A9ca^VC5Q3?.(Ie#ZH:SY2>d;>A2IBT[+2B2bBI>LfX&Yc;GH,1
4-6/,#+FH/CUgCJF<cM436Zd4+G(HD&<HDG,3A3:G#gB=2A:(VLCQDfb=3F49Jb\
/&RE2BfH-UZPe@.HFb<UE8d?)FSJLE2&eWNEY61^QO<Zdc;6__g/fCdcUeQ_daef
UF#fJJTgP2<TOVcb[:4V>VB&=&/+WJLY.CQBfI7@W5PYcM[[R/FS2cC4A\)TF+gZ
2;Z4L@a[&_HACg;/FM^)8>(^IS8_(#RUDG8NJ@67ONUOKL\PH@FFZ7(U3T4F0Q:F
)fb_<,Z]U#(S?B[PP8Y\9?4@7;CN,3X^O\/O7Xc=#4I?\>26/D3H^2=]]=f/a7PB
e4:b-R?0=&<fV5N>:S,J-X/MPISYT7M(@9.<-7Ic#fM6_EZA;S:\@>]g<;X+Ra6g
Z)KXYb)G7VF6U\QC)abT]HF@Uf&K],eJ7X3Y<0B=0>\gNA\7FDfSGMD1J3Kb\/(#
I?1]:9&ef,30J&IPAf\T1NagP?),QdgbW1+9J:6(<@B?J8b+f3164X[5CPWJaL0H
e=d0)CPR@T7[b()#Kf?B:O[./F1IT@NF3MaO@TK3[4\4/.CJ8Q5B0a9Ef;+0g5=^
Rg#NgC2?XdbAMZ[BcUBcTbXQbgGe+HC3,f88JG/TUCW3dR3WIHX5K5^BI#4.R;1F
d;6_2<NIC:D@98/<#7R(C18aQD3Q;C/a51dcSf;Z>O)?;0^FWYPZS@Y#RA]>A=cg
cK,>=^OCSc=H/Z+GUDWVEEN4\K(U8(-MYT8[<4_K6dEDeUW@e+1]E3M:B\D_+_]a
5/YgSb+KR&/JGT<39OcPD@#9<JO^>K8TNRC/:KBN\[R@C@FXG[WEE,/\>GMQ]\>^
&,).JGIF+@-]0&UdETfI#8RCVA)FI?SUSJOK?P#KJE9Fg5bPKM0/LD[H9B?O8A=P
7KY2,T\fXI[(^3C2<E),]:QgbMC=_2-J4@IP-@>Y41\dO/4N9CN1FVAUHa9VPLM1
L9W>YIP9HEW;5b_R(P21dbYO?>)TI#1C=L0C#L/P0TXLKJ6\g4?WY#4>e[(LJ81P
01J\W?N,eJ_(:&(+=GM[A2GcIZ]@D\Z>.5(T.&NZdWeAD?WIKFQ=7<9@H/4cfXHQ
NVb7f8K(8aQb?Bd,XU9<#F/_B2-WaI.BLP87f>EB9C?<#Pe\L01e@d//Kgb8feL6
.B;F#2T8G00=/C5&V23N90GEg-W=D5YF#V2O>G)d^5Y2VF^]U#4V\L?#+(b&bR7:
4NV\\RUfCgCT9YXF5JW4<7TS@WGMPC-G1BH_&G<;+:ecZ&Q_8>HNVOL)b+f2G[fX
3CSf;0G[N7c>QaRY>]9GI25M^6=QN;1P7SRM+1UF9CF\PJ4>L&N==DWC\-AH#\\V
aVeg2H8=6C[.2c?89:f5HWbMMK@g.2OO^1IG2dKX)5NcBdPP1L-W9K/;Z+,O)7-U
./0d01GU9<W[AJF):=M]P<GGK>MZG8R::,X64OH.VLg\b0^,ODRfUVLK85_N[BbG
Q:e#9>;1QK#AIOa>::cgEbSY_P263UPP1EgP.9gNWL<S6HDbLE1CNaBS[VPOd,9g
_4J5d6VL1b)Ua-57<8O#eD+GLS?b0@O5ME<^F53H\I0?0US[Ua8EC^\Q?[-[JU5c
3DB8<?&d:D+X1Bd2/V4=B3_&WX0\YcAX]W[-4dbdC(&6YV+7f19CRA&Fg/^NC3JL
;(?Rdbfe2CQ,OH8RMB-1JF3-D_V1G58HIb3FLK)ES1TbZbJ,:\(C-_@S8NUCd(IL
7JUGQ&:/B,gN)D1HC_+=JCGJQ0Ue/dfE<1fS5>LgH4;:D3=(;V3P:gHa;^;RcA<g
^)TT(<RZQMLW#.4\8XYX7K),[7O#WM/>>8.&S#5MDb=G_3_9>>cBH.ORT>Jdf1AU
V.+_)gf68<a_d_Y(+f]^>5ZJ::dCX;2_Wg85#T9C-MR\KZ?KUd4_IJ[(3BO(JW+)
EXUIP66_<4;>cOW^QH=>Tg]WQM@-PD8I[dP>T01[9-;K;3>FT=Z8@2RTCAI\UWa>
_Z;2g2B-H,aY;9I4PYM>]Z3N/.cN^3]LO3[I@5A=Kg5/.<K0]\:06B@[2+..,b67
/=Y,TAcc^U[=fVYWbK9J#e4]#\T_Z&FVWGg?,;(HUN\a-F8Pg?Jf,0aDR#X:MW3W
^B)DXYFE8I,Z/S1&SJD/YKBU:BPfXe;1Q[ZNZ?.-gOWIQTb4<EB1H-RZ,\dWS>O7
D_-L=:_-e=:89T]][MPE^,2Q>dU,Q++]PE[.bC(M<6#,_S#KU7J#N[(SZ>gEa.]B
TBNS(4>K[KSEPf7RaUeE6E25TNb5]fGQ63-C#D3a9dL_T)=6//MBaAYF7;f#.Ffe
d:Xaf_PNfDNI?9W+W55=M+:M?,1;e->.#TW,JW3Hbf=,2ZC74C3FCW;7M#4R:K?Y
\:;P6+\5?6O_WJ#IW3ZFWbAfe6bE-SgQ2-W;+#dD[.[B\A7#Ybf7#AOU(U7->]G)
(_R4>e.bOb>?65Ue[\S\IIQ)EWdAG</)9NIfOeLH^Md-.=YQ<TET41YfHfecI.^>
ZV[81/aJ[cMc8MfPgR1[0,/]>>F6\?SMeYMDV<W=(e.]aSfPdbB-0GRAA-g]#81X
OJ1eLcL/+&eC@Fd[bAfH9[:^ebWVa@=_QaNH<[2aPVTU>,U_:WQW5=gCI84]3VfV
@eI@Uc9<Y0XDPD^DLA[HED+^+Y;UdW^6IFd)9M>HRe0.]JXE[OeX:bEA;:J;F74L
@/X>cGK3Z3R7-bD#CXAQ(TX0N@.1cA-:E58.Y0OU:a?(CE_>L]34S]@HZab8Sb-R
cYWPQV7c\]E@=#bG&\eg;,/Og4;W,Ye>\VcZgV88>2WQBB\G^f31>dHDW#Q,&:;V
TGV.TZ]Z[P2H,2YO:LP&(Vg;G2RV1Tb+</Z4CM0RZ90_b;f&f):7AgLbZc3Td=I6
eXQ]^:\b;D?^;&>VC[dZHKba(+;cbXCf2S:QCU(YB/XMS=N?<YJ35X(T9gG]3?S5
2W+_<;TNF0HMV1W,P>Pa-=eZX;?H(:>(aeJ,F8._.DDde>I#@FeY:J0;9]7_0>c^
O#T>RRZ82[/7IE=2g2A&<Q)M[(=/W+82@a8a+F[<R(,#()2K+&.@[N]>6P7^=,J@
L7W((6@9@f<N]_ED>_Xe+@<5<eUYe@GA(DNWMbVd43-Dgae,SG4=TETM1]V^WA(=
.T&N>dB7\@Mb6MYF(E:0-OaQ;/8U2.MFX(O8I?@<;NL8L+#Ng6J\/]=3X6[M;K[Q
d(X.cGHI8.64CUYEB9Dg]^Q&M<J:--YfQ9S)TTVE_&LSaCe]AV=g9Ug;c74#KVCW
5)daDZ;EPgPLb(I<UC1R:<XV=gR)7UfF]W15EGLY^X/;5W2IZCJWdHCBZ@#(Bd8R
_/gJ4f8;]<<?IJY5HYTGK:F=F=SYgff7<e_9aM(3S#@S(=F6EGVMK3PJ3)R//9<#
7A<BNXLV.6fN#d1b3=[@X6C<a#XXNCE8TE#UTS+>U7B+TZF]/.UfeRI_GHK3I;?,
2);g8[MUcb_=E+7<[;V&JFda+bVRL&b[=<[579bd4B-N&-e6]+B7W<Y9(OAZ:Dc;
A-3Hd=c-g<@+#(/AOU27^ecAWEOS:WP\AI=01B=EZd_Lc)#A.E7_T7?RIVTM:M9^
YTaHUY6:E[Q7&5=[DRA/F2>R583fJ&RF652G_TMf<8OOT8/NO>D6I2-aa:PB-AI3
Nc8eC-9(L0S<SEaH2F&2ZMS[c5^PVVX,#GCdIY^#L69>bH38C?H:K#:eH;7dNg^d
S@dg#PQ]HWXTbH;J4Jd7F\1OQH^5<&LS>5ZVGaOXS&Me2EQ7-Q0IRdKI=^c=cg6P
RT?54SK-55gf[<ZD?SM=d6A5AbE@;Hf>b;D?SUW0_F6BNeJHG?#=7#@B8R8#Ce15
:9MN53,?a))bA])U,cBNSLIX:)0GKOOKF+[TM2A8d3f>T\J?L]2Mc)EJ,8HKcY.N
A)_d5#XYT&YTYF8?aN]GHD18Qe:QTegE#XL/[VVLT<_#CJW@APJ#-_80J,9O;[He
WI1L(.a+(FS,(dGQ<OJ0cM(bL-aafW7;>-Kg7X?B\+8c[JHGU2e_/ed(D)DQRaa9
dJJMX@[O/cHNfZXZ2\/#5&(XG@7a9CAg.G@VgS\GGOLB?D,@1X[_]Ud:GaOWMbB\
\VgHTUH0D>N/Fd<07g3AfW61&((BPgXa2<93U/b&[]H=W3G<-33-=1Ze\e5/U(d5
dITa;?08]T6PN1LS4MQ<FFE/J+OSKb=B.08(9/YTGgd4A\],1_ZIG=4N]8R7LJg)
0EM?P@OO38&&VHZKSAMCYMJC\^d@MT]eS5Q9\#GcUQRU4(KAM\-(&RDf^Y?6>9ZE
@OH_edO0C5,5gLK6d=N:/9Ua[T6HC67GF.b>FeO_TAMP;>8PK?e7Da,^)U]U;N\c
O1_S0]IZ\@T3/+e-/@AgP<?+A=AD@6^\I8:N#U5Zf]M=bd>#=\e0Cc?A(eE3HYd/
CbYQ;fOCcLgKHE>XOX+&04;@XR0\S[2&F:@2IC8(Q(S3-FcWO?RdP/941(W6OKSD
MP7cS07;HK>ZUAgHTfWM7f[+Kd<=S3/.JB85UH0G.>5[+dMQB7^M<809))dJD=9g
<IUa\aY>P=\CV?6<F@]aMP7gWE0Eg396:K0]\<_SF?4e(9YYQ#:@PRH>)4@/<J#V
><H(aI=>)ADKW8U&A9X):K,C@R:f>9BO+_>^/bBQcEL_(H62ZQCXTN,c\?0U27PN
X2X9YRKQ+),([eV4<84X5-HI&[TBRU+CK[G8.#=IG=D2RHV/7[[e5K2[e:\?BCW6
9^G1(]7B/605-dFJY9B)=GLEa^F;Ba@L+gPYQ9F^,gV@U^9H=?+FePDQA1IRc\cc
)aKgb(CM4N4KB1g=L?+9R:G5FLXgDd1E&GH34dR?JNc^K#)HKa&ICJ;V&+ZUA-NT
2-J0_Q&RQOeM]7;NPN35-fd3ULcTSQ2B1Kfg/0>g3d+TPVVPF@f)THL]?<XV.W:,
HK(UTWWWdaP1XAYD5+BSDe=f+?\4[2]K]Z2W_K#<7HBb48(,U/[T\;dC;#8L&Eg\
.14N.f4>Q#IWP]8=A<K5G729FY5dfA,Q_B/B\?K3)O^5GCZ4aX(GW0PKUPP&6d;)
=/3:/@WIXO&<<VdUPBIgI_K;@W#EeSe#BK\^a>#;1)^F#X<f&2/C]=0cgB2=1C[0
[QC,R(cNSdTXT@R=[E.#?a1c2;#]SRVHBDPP-Z(aNL[MCeDQ9P.bX]W)BVKEUGQe
4bIO@68d2Y2#4A\EH_JHIA]/,:HHR&Lb^/\^^4/5bOe]Lc<bX:GB>2,Dbe2^K1Jc
3aUfR,aS8Bd&(BYQ?OOJ)TcY8=];0:D@Ob0;?dGPU[W(>M5_RXdbNGB3IF2^F4D]
\8c;d:/3OK(GKbYSD7\Jd=NCKMZ5Eb&g)+ZHK]If^fA3ZVU\90)8:G1MR2._]^@\
cP7,B?O[=IJ=:.>DB2bY+YL4;4)4ZKO@]SJaRL77Q+VJ(5RVCD^STZ,#BNA<3G#+
F)@aNC(aIPNV35Xa#[cI,]HLD?][^^=,A&K//2cTd<NQ(57OHf9D_XN?IXcT,)J:
cI_0EL1C>CK[O1D]P2PbV8/g-E\>_RV;4.#9@D>#=/0]C9Wf;_8>DL,-;?10/9EE
O[+9#6MJM(DCW3C?HTG2AAe27Ua\?ZOIKc76,VA(4@C@DX/d3@gI=?]]-K#SdC<P
fEZ-CP,UT(V<:-4X<bgBO^69+3>WbU+L@/-F?aR&5632Kb3M/eE>J\W:W5XBb7Wa
c.M74DHgT;:Jda4b;<2XQQDB>I:5GXee9(CP;O?QWbY_VK_GKfN\dI)ZX)W=:?aS
HQ<&Db)NBR[K>+dU13EATN\V0N@O[,5BTf/(6:Og@#T5f,EA(=CKNKLLbFS0DJ?X
^3_d2C&Z0)B1V&;>4KV3-;]U&ef+7UNbeFU43HJ3A6MZO@ZSZ1S#10X>GGA;LLJS
a=6ED8ONf<?:I.NL&N52D>9+>X=ZCE[fb4PA)cR93eNVV(<aTS0>:R6;LU/LNP(_
0\&<=,_eeTJf+D?9MC;Y,P?.0924-G7?O]OaY&)3;\1e4YbQe1ZSg-6g#+P=(<XB
8#5caDFCBU)BgPDecD\G(>a\EdN.QK\A9dUFGAUf@]/]&[cfS>;G7A7DT_<J/@5D
\451JP0AT24fc+2^X;0Ye8.H5B_=eG>6]HM]INQ4Y^BHfD5+B^-AZNIdM(SY8GD=
X-g6WKIgV\#L,:T>#8CI^Dc]Ca<LVcE4&6cc0J^W9d]V+O@PF##-3&_8.;F[9J>U
O1/?]1]KK6O.H6-ge?=;LS(7XM/ZN,U9IgK7Z[CW-?b@-#6=aeD#)gY[5HaRKVP1
c7b1ZF[dE(Y(W0SUR]YF3;:Z26_3L3<GGO1F41OIP#186\D[D877O)bM26\9EBKK
bYVX<\Lg88?#0Q[S>4df_CN=/<2(.=bL>UbEQ>&=E[J#><I,.4_9fU=gJ1IZHUD9
3O5,\GEFfgTEMHIMbV<9XU-=>Ie-M&)&S8G,4(VN^[3D]0<CbF3OR&g2fO&7J8FF
.YO]7GL4M4gG1/Q?4)^2XRdWb)K(3XAb3X#(_gaQCS3=gXXC]H3NUO.b<UT0fWCG
_F-a7Ya][ab&^),&Ea^V-]d]7d9VY9(ec9E]4b+5GUb;I>D>_d6&b2cGSWPZ42,E
2e;CU8[0DL#1dK66C0PaWX;8@]W^)7FG@=Vd1@Y/-6^QI7/g[I(BWa^/Q=<C#0S&
6.P8A7\T-db4>GU4K)^D-?cH(IN4XG#9<,LMW4SAHLZIO=U00Je)9833HX-L:T@Q
O:_AEBJa@d9a9?9/34_L#5B,<O?)MWR9<4]01EY[S\<PLUd@MB#gVL)X;fJV895X
BFC/X3S^#584B\]Z?gL._?MX+\-FO/O4B&O0/UZfaK#H,R],Bg.)4R=@DfM_C,M:
_/g]Ja=cZ[L0f\,W6:WGeOgc72-Lb?DVQ41APNAR.<\_bXL2+.VZZUgNV^HW1QeC
BgI>)HS+ANO7MFY:9?2EAA(;@9NV64f4L,?SDQ46IG)<M3(-?,fTJg)J&f+<1C>\
H6H_/Xc,-JOMJ348VH&KB5^c);EEDRcIdbbLM=M5534X./W/73Q9WNO7.U,Y+)]#
YM:7T?._-P.ZDc&a^3IP>B2f<[+SfDc=ZZ93VB+gV>.gd&[RG&?S^_2W_DTVX,^a
KGXF],_W+9d\L]N#_M.[(:D6@WD7:V><EY&H)a3.4W&/YW:D9S5YQV^5++7DYc(B
WIUIZVgOV2CO=2/W/G-\V6/V0;+afMQ[]:Q^W;8egBH:P(Ke(Q=I-Q)^KR)Q#S7J
e2^+K)=d;]1P/=_9_2IRT_@]RTc??Q,UZ7+&MR[?1<4D/->2RPVM81OWAJC4IgDe
S,2UO1L@R]?N((T7LAcD]_Scb@FWVBY@2H9<eQEZTg3eNXC;JgJb)#/DSP][A#DC
RZ4R+E82Od[3cN2e5_GTS-f_564^YT/-;T_0;04P^<H5H-M&NAF@M71fCM[K:(G7
^MS;a83F(,V5K=R-K@-K=OWeED#>?Na29YC7B)J##6@UP/^bbN05]L8-DCd-,;Z:
WUe]eY\]YSQ6_+S-(BeSA\VZJ^Gfe:]@fD:WM0Sg++N&QBUN#aa9MQ1[AT]YcBK_
REC]<X>HUfeQA<ca,1_QK9LA3#?/U,G0^e.95bIV(bMNTIdb><fgV86VcgNCgYIf
2@b]]JX//]=00W+K;W<d;aT?(O]4-QcL&\JR6=9/76^/59KUa?/&@-.,-^DAJGFe
e/[?-cNdJbFV?]N2M(gK4bUYc<7<6PJ8>U+J&1=[V@6>8(K+cGI0MIZ#eJ_O,(\\
=QQJ1I8_]J+G<O+Gde^EcXG=1&=]L7^<#a/><[0O15FP>MLbX=9RKGe@N]Cgf>ME
KM[3/f&<R4T]4/<C(JK@Ha.+;IT--aT\aWOW_0=4N?K>^gX=)1bT.1T1HcadH:OV
-fWTg3?HQC+@/A>^.?>@I]cgV^FD5V_B1>#G4N>;G[[0;<JMac,EY-Q.WD(CDb^^
N?,TVZ__dE>fA\)H28ZE^70O=,GbHU#RW:DGQJ&eL]@61>D0CZ3KRESQb&fc/H.R
YK]G-OLIL;>TZ(d^]R.BQeYCK#](U;-+DT7A/84DU?P&a/OW97X:Kb3^@C02cMIP
HA-8.+KdARI>bTS^&H8;AMSCg_QdbI\C,[Ta;e#-Q5#MY.H)74fN2e,HN#EgE0c[
ZU1O-O.af0f1HI6<BQ@P=gOQCI&UY^Ic3AOcFVLN7X3YFb9ac:57c8OgY].5C0OS
8E5);8c:>_fV>.T#5P\K0TIIQF8a&.<gSa0Ze[QR;Cd3e,/g(ba()QUZ[G(+V.F)
YNY7Z_8Z7V@UNEBb^.8\NA]g>8eMMW-1e+?,4GU/8g_+VJ8=HW:3M+FEEJD^X/f^
5K[8A9@?;Ic]?d]0U&gL6#^eQ_AFd(+b](G#RcVVIK5MK>FJ@EI--/(8\_]JOXDH
UA@[T[,/CIENGJDMB8(/59F5S)gS:Y>2G,,D;R>\?Vf_[[Q4O+_W,[e:e[gZ6O^&
:3E_a7_?1B?527=&G]>]bM)LR7HIT0?P2QH]O\:.O9[KWP:.@QD9Yg\db3F8bc2=
TBN5cXO/#eG\&&COg_K[dDM0Y2\DY^aW0;Pc#Q(d[OC)LK7;0e[aJK<0VOaH>@+I
OGaJ9(6<b1?;Fd]B(F<Z\K)U#KB3d:FGfB^fZ_@)I@fBUfPOV^ETfK9C=&><YX4&
(H[Q]LHB>UZ7LDEF3>XE@&X+beJC:OYHd3-:E>5OeKd(OE3(IYA?6;^:8-(Y&TF<
]E1J>J=J4bM.6[LJ),R2JFU5JFO/86SE>(gBbKINUMPOZTAWSAYF.QCf8GS3Y]WF
,(Ke=+@\8KE=97R(9_#S:R3U_8V1:?7d2)X)/Z/W[0eZaVOXMX+daK3V[X24e_4:
@),H&ZZMG&86IM:\fOL:2bJG;;Y+WeX+#c[QF(bIKATd5=:c05FcHS900\=2c;CA
/@R@d[O-8UT#NKFHEL87:^-^Sc>YaFX)E_N_EKdJ\#82>:Lf/(TA1IbMaNT3G\Df
?L8Z3S-2(V#[:7>X?NOCBaLVXVg1:QMd8\I/N16RWU9HKb.TT&T@d+d/VS:C>B6Y
H><](9RR?<8-2/GY=1(T24Uc<&dU6dgd]8Y+P5Dd>Df+E?T:4-(\;BN\=\2^a1@L
?=<<D09Z.P<f^\LP8cc.B7F4d+7D?af(g.6L\O>N[AcHc@=_CYCc9fMe=K@,;0>@
+93QObdUUK(>.4gfH]UD?W]R,L/S=M?(?QC-)(GDD>J;<6DLXQd045G?c+^-WbCQ
Je4#[+ZZ;V3,VGb371/GSLKRPA/XT^1V?K62IXD^:,E=USBU)>/<Ub<L:=D)g?I4
P-aZ#-K5M)=V<NL>BJDG>XNcQB?Z0cQ>@ccT]RTL?5OT(F85=R/U?N#158V>,?A-
PX>2#=4QT:L1eS)GV8BA?)+d4a?EN56gc=;QO8Ya]XP^aH0]^2]Q?+\cbD(gHPQ6
5\W,&aZ]W1WbNdc;W,\8BB?K_5>8]a.;Z_8QN#)([c^8UY:MDXaI9L)cgQe/(4fc
U3NG8CX[2MG6eRbgS@Z<2]TVcX=#_F@A6_JR0P<(8ZG8KPKC];3g^NDd3\EPbSE<
+.+@0YF6;)-]<P&I]b@GY8dd9da.=<-X^C&+?WNO]VVSSAZLe]EJNcTQbc)\+SK^
#X7,ZbL1-ad.g3,Y&2>f#=GV^Jg.99ZZX7,^cAXc9:]2X?NC#^]0QR-EdBKGQHFW
H.?Z/CF>_TQ2/1I&QL=HE1AM._?Y@;V1Ce[[DRSTZD=J&c4b>=#.eR:CcUc:#[2_
Ob=GPJJ#6>:MYaNWW-2EB=G#T9N_)a)8S0&H43Q>.2\<;M^QCVQ;PfJU?:=We2SX
=HP43_c@-THFL)=WZ>VO@G,Y9SR(V(g(M_.V2>We)].fcADIb-9@OP58MPC/^P_2
:]K7VU+bX21)[I@:<C9W=,.)D5ab??a1Z:-3AV:,eI17bBPfIGf_)+2dU[<_#<:_
K4)NdHG1]e7_9>AC=OW,)GVFF,PG\bPZB4#?5#T&8.eE]TZ&F<;(?D7H\gDZO5/f
b/1M?d>fQLU=.ZX(D2IaJ<6[9+2;6&9Y#<R/#^c1?d(>K,A,1P:3O6CCL974(V60
G9TVP>BaHN,,U^.FHYVZf0[_-,#K=4R6J9fFQ8KXOcY6f)Mdd[WL2&Q].A=7BXO8
Ba&37N3U@@V[W71,H:<X-G[/aaI4aNSINCG44PbXb:aY?]O=];3dP8HK8BcF/\1M
KI6LA[Y/H;AZ]YWQEPIW^CAC&48#JIfZ)T()NVd85@UW.AdbdfD#,#N\3]:K)<EK
<9FN&T+6[/W-Y6Rd6a(0AR6f@D5Ne?-JR7L[OZ=H(UJ,_-Kc]->24/\J[VOfA&G:
O<JE\F:S2;]63bW.?M:SZ4U0=MHAgK<9T5bK>?N,Rb5SVJ9XF0.GAF;9Z-CUCJ>^
P&#BLZ9/+Y:2KV1\U:[XL_.K1QV0c6@KeL:0L\(I:#;V.Ga3Q3\PR]F_d+RgDXZa
6P8@X)#ZFSaa2R/fQ((N;_cG.J<YP.:M,YUJO(eS^A(,eQH4TDd[6ZP,ZT;3eVH[
R2K)H#7b/QYKK#^FcF(7,5:7K0.a]E;>cB9Y9Y0;]17.Gb+KM\gGd:BA4ZFdK_OL
9Y-.:5,+>K]<+X1Q8DH</J=5S;=C^7O40,LRI5f8Q2OI_2bH[4/.ce;31/@)VDA]
gQ/1S&=I<]XfD>UEU0BDQBd;X#W&P[U_]F_B+30KSCA:@<OO1LM^,e)=I\V><J<R
DBb^QD3)@^4HUF9MH1(_<8e=INM:>@g,R/#F.a7,0(&>cM-=\bK.MZFF,=1I6_,V
.^gV22^Ve>8SUb\I^@6J8OSH&[K.@/+B(DcY-H?ffP&2Y&/PQB(3]02PS3+GX4[[
Gd+\bZgY]=FcfP?fE+XGFHQ35>d<).RU::,CA/cZOC;W.1K(R7+aFT)Xe<RO;NY;
:RVSQVE(2E9fITWWEg_U##ccEf>2[c,AUaSfW,b4I=9gdFL45Q))A,:?T<c2@5;g
ge0g-\13bK7Fe_ANJL5MIJaGgY\AE^)QX2e=cQ#LJNAX<ZQ7+0\22f+9K/=4=0-#
8QC16LGd@7cCHO_bZ@X[<N.7<1d,<#>-MVE\Q<b4?BPdF&6]8K>I[3+?5]>dGD.7
?b3.2+OdQ)6g>6/^NMH4;659A82N],,2=,6.QGSD7:SPgC9MG)PbT#O4TR1d)Y>_
<cMRS]KLN?H@4(:MC7HH66Z8-AMHOg4775\.C39(b@C+<bQg3+g7@+P3T@BVQG;T
6/2@4(E5ODg.;HA-fK><.+@\X_e[GD^6T?J?DEeB8M_.G4E9M>&Le\9^F^&<a(]E
PV58J)=,0C81L&.KV(FG=\LI&GWV\RJZaYHZ-3#=@X_faHQ5dX-BCa7;JUcX\2M0
DL3E)4=c?g[_bRb.-@b&-Z_0@Od3?H7S:66R_-aYPcEb<IY.]bM>d#\CD?=GcK.K
CR-3C+686CD>33&,BeCa\S?ONF/B<XYS.LXU1I][6E@Z4RZ2^=?WP3Df/Of3AZ)R
Zf:(57g,X):QHYU1LSI+1F9/4T6@TTS7c<5VY]IfSdMSQ9.eAfNDbC0L2Xgaa<N&
EDYY=2WTFZ6^R#MXS5A,K^IG[7Y8agD?JU],MUT==I\62BJFBJ=T2?ETC+__P53_
.6=:YU.=>gT&6?#c\]UA@4T0C[N/];P(O_)RME/CN4;6^VX=7OBB.bgJ5-EfObRc
f<c9[O;7&3Sb.0):LXZBM3NY2PGI:/&^+aA=dYWdG9^eCS\KeO3Q4E#X&@=<[?SE
]F9:YWKN4MG3<E,[FU0QJ54K3TN4eJ]V;21;APY08N(&BI,S(P)Q=EX;W-c>C\]a
G6O9U=1JEcYW-(N[Z7IWMeXYbH<G)S76S(5bJ-@Lf.-5FK9e<.M(d]@1F,9)<4:&
^)D;CeL7E<]^WW[_C&Y52a?eKB/_<C.,XNcM<XWPR#e>dOBBYMKaeZJHBFW9_SFe
ZQb@ZXR,KaA2XE8?VG_8ITDA)QI/WIO,e]?R.+\bd\B[>gJ9G(B\<?_TK0K)2Q22
?]ER2a7]_-TVUI:F,I5@XaS\cT,P:L(5^;#HdCe+\YRYOWL;/(TW(R\&PT6:0)[=
<)M,/4]^eJ4ZI1D7S.8b@(:X&44:CUJS<:(dbX#c:G03J,HCYWQL+1JbF[#(GHIX
1AAUNWaSS4KZgCF2c72UG4=W=EeI+)UcAe[1M@8&0MEO_,8WNY=7&2bX1S1VZTW_
\=>.d=\:LW)A+U5&RYM<(B#/g(T,V@V:DTFC9GM\9],D.f^YG_PG&OK&d@Y-fc_E
DQ7N\&7P4L73QLP2<N;0T,3T&dTN[1MRBQ8?IdXBN>]25ARLJ0RSQ2(TWcDbQZ22
fc0#1ed?fc=VSIA/)B4;U+IbOCTU?<c8]L/R,f0;^>2F1\K?a6.2/4/U&7:;gSH-
#MPEU,@W6BUJVFTf#,;?C&YP(E51J@K1SL-A@.D+L]TFYW\<Z+LdfS>?e77^3:c+
Aa>\V(Jg^0^.d3BIU2\?D<Ug;C#Y[VVdW.LN:R^M:Y0,+IOJS;]A]eAg.]Z-g19a
/?05<U:_85/Tf(eL@DV6H50FfYf=6A5U2CHQc+C+ZR3/)g/RbU#<&ZO9QL;C--IZ
AcZ6f@,&CNc=A0H8DD:K=\[Y0_+0\7PgEH6Vb7=1Z1U[72Ng3\eS9PFGH(N-(/6C
c1R2bT^bSZPX<<T1E+8I\JG\;Na]758),[F4?\0&T+:R_DCa-,.5d,VXI@]TTbX:
G<GVNE:EfBL?)F75NRX>L,CU(8@5g80<@^52&(aFE4Be+N.-/ND>#:A5Z=bNA],W
(\-@:eZJT[PeR.N[M,\P\JVV;)UMa^ZT9=(DU\Nd9Y6:CJ=WQ^2>G9RADN<QJfXI
@N3[ZVW)aYQ.OP\eIPE=?7^,>;DGD=V,K14Ogb8G@3e].SOGg-+Rc-.GY+V#&M-C
L[D9Q^g,RF[9FfP&Y.I4TS+&7)UefYe-.^Q2O<Bc/e-?I]_PA/^]8JGLU-;PQ&=<
:a)fC;/S:IN<W[UB.4F0LbUY=c(+Tg;S-=cA^]Z]CV=H?WD6]HF>1[@\PM\PI;40
Q[/]4#>?R6B.WH-U<F\#2JXRW^S.&TA)CAJ/[JHO:J84+b3)28/d4ZO;dTg8L)]R
9]f)YIQ<OdfZ=:3YVe,Q+HL/Z1,eQ4Q85&#JZTG\#;1C^Y\;#OScLT7#K^EJZ\9\
.I>?@W90d>):L8ADQ#g,#=?FH-\-Xc<NfUB9UQO3ZN86aU]+R9aR@Kd0W2TDTAWZ
R-G-b@)9=&^A7V:J[L,_TD6<)3O>?MTe-+)BcE1=IC:LYU\=f63K+,\+\4\2VJD>
:A38DW<F<7JO6B)SS2HQf?=C(ZORc3a.P.>GS3MI)1J(RUPQ7N^PO9&gQQOHRP4<
G9.4\EbFNNQV)c44_0VZ<+7cC:.2&2&JOR_97O4ZE1gXXf4b(=20IQ699->G-g>U
H&cb,I;,0d8N[8.VO7a7J78I_([>Pd>UcPDZ&d2ag6WbF>BPa40O-[>YW8@&gJT?
#K&D9\LZ/9ALY88:VU?J4Jc96F8G^]1RUG/:MZa\eSF^c8)0=-fV(P,_;c-f,P[<
H4aN0d=AC01N+9:B=/0XcF.81f3.&1R/KWP&8Y\NHb4RC&)4HSHb1Wbf\T&DD+\K
#8RYD,KCQ&[B;\MHDZL0&XTQT>X^e,#f>?S0S&A)O[8,#2<)()R7,;QGe66PEVS>
Va[:Ce#0/Ng=PTOA922.P>];NN]gY[X?120MeDVf:RE[A)/BFV4V64+3E9^gaYIJ
AcbZ,5HH?@[cL9T\.,&[KMcK25&#F+J&EWUG0;B8]W+AM-\7ALY0.P:6+J\W]/4M
>>e@cZaS_5:a2g>K5gP22PL]6B19PDB\HX(B88)_V>2WLdVO5N>H7N?dgA.S=761
dT&WLBD^Y]W<(&[]5<&cJ)?<@J7I.8;16d4MR^GG#DfD#./DdIHd<N-E8Z&++9d,
5/:-O(Fa<,I3DfOQ9a1HSADH;1gYL(K81/fd:PWBeIO[7[)8[GbJ\JF5?f=@;ZXM
_/cd?BMc)=MDR@]\I=931(:=gKMNH5KD5R0WR];N-L5(MN;1[45]6JfGH3/<2Ff7
]AO6WJ@?_AD/Q?1]4\Gba^883cIO.@W-7M?@3O_6eWR(ZAgQfTBPGffbZK[JA=gR
bKL<S64;-PaL2T=#??M3#50c/]4)dL)bN&9a)LXS:1N>]0EJO10DR2QJLf0]YMC_
?O/RaH8ea)D3IAHCJCb.(@-\.SQd+T[75J-Y[BVFT/K(>:;A?:IV/SA8@Y;#\P)g
I?>F3D//[<\eF(agdGf+P^39N9WZ5IM;]69]@:GHg3]OQ_-[)8]501&\A3H#=[;D
IS0YbQBI:=4Z:9M0JL>:SX5DX]NAG/K:Y1^VSR).YZ_,KLeV./;FC<0HdYbMZTa7
JMA7WT(dYDT>UB;]SfMO&[P<,/>@U9VPBDaA1\Sf+-1W,gFT[:fY40b:@<XKJE<^
BFbS<^K^+<#f+Q+88TS9])&Sc)dM9?]+Mca/:3Yd4/9fBg.aRd>ZAEY_.XX-J-f4
)P5;+]76La,a^BLYWNg?<L0eFXAI4G:P0-E6787RF(+Z_S>eVSHKbfa4d<<ES:@^
J(>c21HAV@>(a=Wb4OP?b@S8UUQ):Z6P7ZTTMKG,BeK]c]:/\=NARIZ)NO#g/G/d
DaS]@JCCH/=W/=8@AB&-A0:)/6e?;I&&Ba-f]1L3KL9_GKe],dN.Z3Z_9I;FFc/=
.CW/6MYa[4F[eLKT]CM4<#<5=g\g\_dV;:1aC8;H_^aUP6XR_>J7AWB-^Fg7^bGH
X_Yg24[(/PdB-Q=V-+[H#(:EcbMb<N=?DAeR7W37f++f;U.^0VbaU1#Z,I?cIK+-
&cJ,0^(D<^bE0NZ4D6&DEDffC;eD=]S_0M83ZQG-TN0LL:Q,;+PbR7V\K<=&LaI&
^&Kb=GY/b)8CW0GW&\=XELD,ecUXVF/EBY@-B?Q;+6b/YbR^S]5-CE\I,)MJ.?.6
Z:JD7\JYKaZ5HaK:b_^X]GIB^/c6&IS/__DRaZS3S.C_-Y5>#[W53+J\_fH\cQU(
5YW#0O@a30G8J[\FO=8E/N)D9JbTSDF;d8b<OUf+E)<ZQ-=#2^:O7/@/<[ZU4[F5
G]I^-8<77-RMQ6E<Y/#DQ]DYC0]X4bOGbXLW4W<FC:dGWEB6+P?Yaf?RY_WRBEA(
[0S[dXT=&ZVU_]F<NX;5&f0W,_W<DF;,A0d6=0B0I86\-7(?>=;ee]FPATH]A7^d
e7[#F0)^YR#H<J\f(@JIL7HKUgg-3QRY9RP1)NWg0G0.&OZ,Xa78IXc&YX5_e&W;
6LA,LFXGN:2NN-Qe92T,21;0?-=^I&Q>,S)X5PZD\bgT/8&?^EG#(.KIe#DVBQ\0
V@^Z[Z,EK9FV3PaYU;:=OTXOYLI,0_63QHBGJLOf?da;R2LUD_cH?9F4G#9NgM^#
#\b]5/K5cLg0;OdZ57C0UU<.(=-1[[OE7[&EL1:[g#MJV_</:4b[1V#?:6VU.]@a
\8V:XKV1a\LgW&(7Y@CWO5HSNW5E\_YZS,QNMZUS&caJUG.ZAU;W9[/S:Zc)H_d3
ad@Y(^N\1UGd;2\4MQ3T_\NHL--2A7ZfZDe:R@TM]8.NF?AIeMPfD_BB5OZT^)YI
5\:XX?g[4CJEO4=dFVA_8ELcJ?@W<6QA2&^#:#K5SO8RZHJg5XRKFMGdGG=\ad=?
g;OePU9F\C/dDM>E^/TA_=R5Uc^JffCSC@@b4ST+-9d#8aC>GVP,f/5-&MXQ/HbM
GNA^H^ZQAAK7@5^eR.0J^T0)#(_WC+A9EACTb0T.E0]aM&:EEbb=^\9FB<02G3Ed
].^1IfH62c.b,^5=22b&YDZ\NIOJI?,703T2,#32I5G;H@S,Q8CE#MY:3)+X<-&Z
P/F.fb+))NEPUKcU[@PC71-dSMDc9_^\)=0U1?TJ?_8VG.,YZ+c&ee3P]eNbcIPQ
MH6:SGb2,H[I6=K6C,Jc2b2>T,#5/0.fJg9HWOI>Ng1R3gd4^W=6#EO?\9&;(;,d
Za^0,OZ#2Ma4HUYWW?,)Z,UBA]:D6Qa6-RRYgOSKcTLg=a1_EgMe&1CKD_AAR,X(
?0<.\,f[QH=L.04>;2IAd+B89=^cP&EMHYVca@UXHTD5G>NWBDIK-BR3<,:5\g-M
E\#Z_+Bf\FIfUPXD0<Ib:W@.#7I>.73e?9Z/S)+,LZT2BG1eE2HOPLG@H442>bB?
#]cZ7_MLdQA=7ab]C5+B54W4?^\4D(]9UOfT@S)&fU^3G-fTAH-9P.@29U6IGSTT
3^0a?fET2)5\dSbPe2.CFY&5;4M;)7IZ4=C?2==[M823(\f4b.)6A;d_-/1<LF&@
M+ec1_F[9VD+ZB1@PPQfB#W.GTXAY=]^-E4YOS^U,9\MdTS4+CIJ]+0b\I_Z(Eb=
:XUWf?V0;P+8\b46B;0Ye1]V;6;X<@+3Y\H<CX+REe_c@21&bYdaVCC@EZV9K5O4
7R@V9a>.310+W#M<UL.K;KO+,ZB,6PI\Q-e1SG_;:,2ZT3@Nb74.H-UI,A<TZg6T
dfJW4?IY==V)Qd^E47cb2N+SSWQ?HOCGc;JB/7O/L0VF/[@6F<d6R&#aBbaSIgY7
GA>=a74,VGEZT2?g]d&5g.^.KI(gU#A8P\])#_#4L65VN&&W,RP3BBD[:NV,J;-N
XaMcPeg(BKeKZ35P1?gS]TD)(T_/gY^6,ECH6+XUF]Ic_VeFeeK@eUNIg4cZNHJY
:5/,B3YX^=NI>?>\WAV:;;3+^GBWV?^>]f#4@]Gb5f2GRMS^KGPfg5NXIT&f5,./
6AVEe@4,)_7\I^KCI0G,IM3L9A#&;YBM5=,)4AOED]74Z2gI?-KMA\>degI4=?F(
AW51Hf/5QLB,@F#-;\cOg7HI6?T#3FLUQ#G-##;0SO<)[5fBgXbNLd@SW>3fGH&L
L22LW=E(;)3-67:6F>.EVW-OS(C@UY6)M2F6MY;/G@5>VW9;M1\,,<WG&W,R3-BG
a<>&\eL3eSGcH(Sg#g5E\1Xf[eHZ?A</I/U^/@LEP,KE0OX<3E[IOHFKT&6X,LA6
(_62<G<<3L(QX1J7T3#aI3-I:SVbXDLV\cRdU7NRU>GAPGZY&/bAg<Xg.ObTCe&?
@+(0.LD,:0&M95ZJ]W\+B&_:(:#<-,H(HUNZ<g4-WaX(/b<bGRF,A5UC6YB&FgaQ
G.WX(BFGAKD&^U/Q<aScIR7KSZ0X2;agTGEG:bI[EF0(;&WIEG@@+8>(WOVb),C6
Z>0A4)S>,,2c?6=+DO^[^dg1)?a(AD06@$
`endprotected


`endif // GUARD_SVT_MESSAGE_MANAGER_SV
