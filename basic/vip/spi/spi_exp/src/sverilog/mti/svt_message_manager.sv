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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cQVB1g0nIld6lrwVR+T7Jvc8xp+X3foIYYvzVagnTobnhjJnN/jsS1jRERhN8jZO
OBgTTnrgdfXeg8il2uIAWhAR+bXvlDE1MOeD+SoR0vCIN9SV4RBFe+AZ3qkbLRHJ
ovEQX8M89lyoSeV6nEP6dXs+7Xm4ayZ9DMFvEq/vJZg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26842     )
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
NlyjnBdReGn2jk7jPaqNzg==
`pragma protect end_protected

`endif // GUARD_SVT_MESSAGE_MANAGER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bR13JaN8x9o8IuPb/Wpn6vmhJv6P5Z52orV6/Cf/n80COwZrYSMagvcNopzunjrj
xJEWZhzqdk8EpAhNj6EhWscrL5DnjHc2LnBO+YWMNX6doNnI8QRgu9WCy4f6WM7Y
o8NqypJ1z2s+Dtm0S7V9ERAL3L1wr/ytUwi4Coyw2po=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26925     )
IvAGhQ6XK19hx2nqUL6DY3pX+jC1Fz0q83gR+0eGoobVf0qiNFYRZMdHtoxl7UMF
2iiuW5ZAvuhIsMMF1EgUc5tob3Mu6XJT4/LTCidBMoDQB8cDcPOdN7yc3pTEF9r2
`pragma protect end_protected
