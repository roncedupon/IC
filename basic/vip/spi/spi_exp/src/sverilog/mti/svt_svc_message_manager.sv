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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JXQ2jU2htrp7sq0Q5Zssz+EMATrJ23umW2d3mFSdqGR70zOl+BPwwDi52YEJoARg
tCFhkzLmD+yXX9Hj9gLXh1S+QorBzioAP4dfE/6fh3Yf93BOkzwwKiRtBiafrjNG
srYJXJ0qH4AQ6ZnSd51sO4YI3wGz+CDEoT4Ojv2jKGM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19558     )
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
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QX+9THrI2qeDgUabcW4cmpOXEGTCj9JF0m/qJ+LH932YTeW65hInuIaO0SSznxG9
I6+M70wfxnACCucGTyVSLM5VZVHiRCXj+6k5Zhy+f0fUvBr6X2jv//grHtWG7ZJT
HR8t+IATlTwR7lS9EbX5Bv5CLO/3Rtn7EYVW2IjHDKc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19641     )
1TCdu5yhYFaJ76uC5kru+3ZYw+MQUgR8rcQmrLYgVbUyd3LkGf1T1B34nuRYKP5o
K9J1TcZWyLncjLVoSurl9FBOSiXstCDvM5NrFjJGmXraGJjRTx/pwHVlANW7Pm+Z
`pragma protect end_protected
