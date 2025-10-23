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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
kZ9ZuKd4gZ3mSRR2kxW3MQmx48kGh8FDmgYAIFbsMM/l2Ov52ytAWELniXHKtxc8
spEb+Wfc7yX7I98gIQow8OiLEH/0MWjpzQz9Dm5QXCxNF3CH8TdT6ow//QspNp4c
OEBLc/g8p9a+L0fZSP1WWu0BDGVpu2wrevwHn4DLpa9hNzFlRu7Gjw==
//pragma protect end_key_block
//pragma protect digest_block
QA2dX26IovFUQyPmszCJIVdJkNw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
sGtSOCBCOnxpnEKrSkRWnlkGtFc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MESSAGE_MANAGER_SV
