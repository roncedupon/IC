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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NomQ2sZYoRjnRVwcoBcwtwwS5CCGfb4KXrWJipYrwqSw3xEcnCnhGORVDyJEO+9C
8VtJhafzLR8xPX3aHo2w12kHBj4SHWjWuJRwzP+6w27poBPSegIpgsEVRHzjieOU
Qj9nJteYb9izJgvYg6S3GdA7EkWa5vB0pHCI9lOTkGYivKwjwy46GA==
//pragma protect end_key_block
//pragma protect digest_block
iU7ttzxqARahvlsOijIimNetXU4=
//pragma protect end_digest_block
//pragma protect data_block
NbMTpUrjXASAGWgrq9Ywh8UcIT2ftBx9ggGfu1Tn72ew7ygTnn31+LX2a9KxlT0y
QFVKoej9kM25l/VgeJRI9NOB+6Lo3nl6c/NAedVM1Y4/0eOz6FqwhhR9U8Q0MQGt
ZVRvTmUnow2DOR7/W6Gtu4zEQHFOd3w1AWlvwOtO2DOH2W9o1ntEw6JIn7NEf4BR
dFfvxELhjWQRfvCcOYIu5M5efr6/ZjO7g0OHzJ67kMetEAgiQRrlkqr9L9LzmhOi
x06uSU7/QuLl+Zu6SiPpdFWo13+KRy1t10Mho/3OGZQV3Txc2hwJmp2xHPyzGqS9
1ifIIw6HDdCcdele1vugFDfJ6Rb/PU7UzoaVS4pBQrB3+iCwL6FspARtErupN6S5
fBz2pvnw76vN3jL3yXzB4AfcBBkxA5canSS3L05g97u5CBByrQl1ecFyb5Mhk3UQ
Bx9ruHoFaQRo66wWPOnnC0qG/U9QAXgBFxL80emebICWzc+PAakTKNy8mY54yds7
aw43orhMuY2SjxYiN8Hv+YhZBdzcV2ZGuzpG1SPRMysR/irKXUJDQQMP66SbNCFX
bhctaazGqqwDzkACJkWfcP8upmOXWoSW2Dj4MjCPmqsB09GY3eEiWwFPL2owsnIt
wYdKDP2NBNZQVgLz3POf88do44APtHhg3QexWbZawc1DqXNdh5iNyAfzaJRI6fb4
/wPvcOn0gjAcrO80+UoCZRIfo/2Hon02dHU3gh92FMmB3DX4Rx6fTSzIA49Py4rz
N8ITsjgrKPkjR4C2APzuTPHMKAW/9c7+fAD7mUwPccYAF7lNTrGeMFviaWpHmXDM
JVm6XUdkYPQFkmzZTnh/W4cOsub034otGckc2J0QQmf/ywujecYZnGTJh17zpA1t
RmZbvXnV9Nj45sTVbWFZnCmh7LX4rsrvxuRAPWLBtBIH4nx3KhgWeTsqJPiNg+nJ
StHsAhUkY5wknz73sKkoJAedc8deKCXXk4nwd1o8RSt7NcD42oPHBYFlhF7qdmlc
ovmNu4Lst08Mqg1twlCs+PAxLg7IWCr91c+SRiBNu2Gw1Z5Y2esydSVGg8/Xe4sb
3y2Mq9MmiNYts0Ny3r+B2k7jpYaNSxNXB5Oeg2nKvgbSaOxkYz3G2XiwWw/tPfiu
5PTpHv9niGkItt9oSi3rPEwlxqRgZC8RVg8O/c9lzApnJFBLZBfT2GagOYVeJnNu
AfCGmbGTyTtOpd2A+Kiekw7B88NahVQ+pdYOzLb+lDXy8gUDcDakVF2VgXk2xb70
OkdvhKIdOSUCOMtmub1/JEzleJTzGoLb9Db9WEEJGIlJhATvvK96NWqpXHX8TnL1
sc2TNNdQuBbsdFX68iCOE4aIvXilLR2X3pUIW1nCpZEd4Ld9hSwpipmGunCg7S6K
/OdGSUallNjLnmWxoVF997brZDLNOZhnABieRJMNg62QUn4b/P6cVUUUSW39mZ8R
ssuiFDGxN83CZTZDiPZXy6ZMGzd1RxNT+jI4iurSuapftGDbOeo+3h6RIDHjwy3I
38j32qzPg+n+N78io2GF+LK8OB0x7DdVBHhMPqDrldZuDUpuD82q5KyJMNp97V/F
s7yumGKo3DPuNDYKwhBB5/EOOqaMR9SbvnfI2kL77/mO/z6pJkn7pcrW8WIyp/Jo
CnaBBFQspAz5RcMU8afHKukrY127ybxrxcaVUrQvECnBXmPGwpslOaslt3jBsSFa
w5wuXWfIqVQ+uZMsRGrtH+2odliGgj8VCWmfaeHWI0wJzIuDh6jivRT4/hJVYWTo
mriOoFDQTGazkWcnV62gn81W6qd94/5iUWOLKHUA9+MVJL0jbnhg9+weby5ACKEF
oZH4dFr+ON/yziqjwkWLFklm/anyegvXaZDftOoy/W9Yg41AdpQ/+wawu8mPixdg
tFc6sE24e7B6IVGG9P2Jm2nZ1c2E31OW0JDRJ1OffiQjEiJkvYXqX7eypGcfmvmw
PzCbPCrkqon1d2BM8wWYDETOu1UB5WoUknePBD4n2HY9YqmMuEr57iyW/iT8h5K7
C4iLHauDXoCVSKJmqOiRvFtM52N7edQOILcoeD3op929ZmgPPJDiMZuljYwmM8/Y
HbDfTlJLfk+icUN364JgwqGpIGQ7R9Wtz1MjWoMoJ0fxjXHElV6WDU6pL+RY4N+j
Sxj0KviKOk/tIhoi7Pcl+wfMi9Y3/kLC3nV91bTy+XFdfQFdsU//LGYCB07nDgbM
HZS3+aWGMtjoqmZ8iP70iHZ4Jx+la3PwpXW7eFvCa0PL+Kl/YAa4eA+P6uZPkmNi
XDeQCSjfzBHBiRb+/jV30wtl5cPsmqXSxgtTVvx0+9YHhkO39FVWCqA1d2uIKuA/
iNqDUvTFytkh1KTIWvTZYgunVTvwAu6pk7i+aXcagFNJLfrArJLytSH81dq0F3FX
1WUsyyCDqgiTEiMB5BZKMdgHxdF+thdGXxdfGsVmOwAZGBQnGW4PRxdy71JzRvZs
YA96g+EluNtKXG/0L+Em19PQkwUgk0CSmw9o8I52w4bmmcJlZHGZPqo3r2SR77zX
BY5l4ZnyU7SBHrcgQHjhNBlGsPkvrR0psnbfqCkujkhfGTPeovBV4no+4E10U2Nd
s/tr7v5lL07aWQWCaZ1EH5GPQK5IqcNAfRXaArSSfZh0/65cW3ReQYzMHP8Pmk69
TH4jTU7kW+fHTvkJdWoHJn+FHwVT7FXDCSvwanclakcVQvMb30IjIzEot9P/Zdhe
wGZtT8z96qIF8kZ/W3NYXYUJzW2go28InadICAtlU3trG1AOLsjNmJqjkumnJmpL
y3nnNzECuoxPu2D0KfinKAZIQZxvLBJPMVvbbs7W7CR3Y85BmJP7z6rsWvNulCpS
lbgK46YwISTbTplZlLA/ct+9qOx8w7fKaOwOmqXt2IooBR6nBEEBRAEXFhDJG7d3
kOQjW5Uw3zLkAAGF1lZu0qKHq/SS0orej07DNVUCKtCOrXlnku6btH4HvfZeghtZ
8fe4wxAACMzISaUGjhHARcgqG2+NXYkf4D0q6zeP8CF1f6ta00OKd1y95dLMxxG1
x9Nz+h+dqJGDsO0lUgSe5zJdSp6EpZnTtqLwO8ePVgm0a2GQNKZ3JQjTSN0uYE8X
vEXV3h67lACu7kRaBpAMX9vb7ZbIVYVJx6XevSonjtalNb9YZ/X5/MZSE5+uuW/7
ycvhphjl0Ykmn2Oyjs13KDRJzsuaNjZWKvZ3LuCo/wUJ0b7IPtrwx7v9Cni6YsOG
ZNQkEtuRRokkSdOdEZiRGzMpE8u+BVSTyhCEoH8kvCysE70Km2qJObQm2HD0wfHL
1SYDPPCCrGhmlRjn7aCvGzPiJb4zkPud4T2mYRySxdMjISYCr+cq/TEMdyA6DXMg
lgLFVDNSfKdCFt9giMmyTw9BkyZnf5B5gBAw7BzUGAVGC2VHsLzezkE59EmXtmBQ
2SGyyFReMHnTnKEykisx+oAWaKXC9JAW/6cbNmWXMPFpxPY4RTaHPsXfKQ78OWvl
pK0/ajSn0xhOijuxWwVjzzK/vvEW9iIH0OWmIbiwVKT37hPrmRyaCdbnckkOTIPn
sUhdBt4IoNfITkrwfyxn3R16r/I+l6n0a7C8F7vq7kaG2tPkTKd+Ypcm+GIrFiqm
fzwfznn5bdRlz4At39mIl+6dI/bVE1/W1Ol0E8aTkvfAKzFBH0ocHiV1UQ2omjzu
6Wkaae2Pw8g9w9kRGzTilbrLouBcdjyjwf9rX0SMYAM8BP4/bg4c/OKj3sHC43Uv
F6IojNj9qWdxen5rPQy9W107IMylJoaG1NCjWvYt+MAKmc2+zgimGB7bsqQITrd9
pXeps5U37u0CWHK7CqYkJNGtVHFKx6IpihpYmRsvy5ZGHIapmCPjN55omEa4TXdf
FKhOoOHr9e5XGLZNWYg17iILGJuYt0XUyjnhXgPeUNVjyrjbWptuISjf9RDy3QcK
zLlA4fJ8LmvcuVhQaIH8CKSPaYS8DHoTBtNdrndrTKfqLE2kVtG39hxsgcmmxg8x
DzSOSh2jDix7CIbeCQXZXo/OgD8XOownOmnf8uYspakNkamRAcOagJwGROu1grBR
kiZ5IuJwLszT1+Dl+YtmIpwR4bWz8ScPOvtCtG2orBW77u1If+oYCte9ZjpkUJ3D
Km7FVFvRQ7sOiYqmm73BZsPSEIfVgERiaVdGgzUy0HGOqlKo8DG9XRuMBfQRc/OI
rvXDbAzTS2Mgkqle2Oax26cmcMwewl0nbr1cCBLgt4xbJ4vdJwXyXcvAHhpfChnP
enUVF+U7cLgdhse4qPxdLr+GoJLwKmDXyU0joRzg7enClbmKFwUEvR6lXP/ikWJ/
5GWfHOPkhMnkR/ERh+miYwurXbxOoQ2+UlVuKz2YWYWrvjEkT1dvUjzh22eQ251j
r7FvGD6y1SyvIVK7vOVgA1l0cuNSZzVfxDzQnjeH7MFvSAk/TmGo+iACOhu5CipJ
3FPhLhYrGW6qTyHH+Nc/DA79sut5HuIYpJNLooTBHPBVgKiTTJfmcNwDVFWeUf+Z
ENpmPQq4ZL1nSwXXtbo3jRaSMmr6+BaWnvfKnXzPiy7PQnridWM2Wu/h9lfnJMRG
y1P1S89aW5IiEESH22QbsRof/W5/izD6gRjuLi1Qz7vzWCgvDrxr1GlK6HxLMRHc
8pZI+AfukZdDK/AD9Y3Yl2QSUQiJEv64Dynfmpx3D1b2au/TkEtlrgLov0uNfKQc
MYLJXdmuPkaeNZHJ6o1oZWukOkra0bq40g4R246YLAC1+9ruJCuf908i3bObDJ+N
2JhUyvS0XdIcfnwpZZ6e+05ExfRAc4/TP3RX56Xi1BShBUb3HM+MFABF2XseKriu
FRQfO1axzg8Llw3k903lJ6J3qg5+7XSA6QkevD7e7DZr3mBFfGOvC1YaKoFkzUI8
CHxRMcixipJg9Cq+52ojKlsC60NV/KB4YQdfPlP/4gKwOCl0fVf4GZtciB5wiL6p
cN7AqEwdvtOcT2vo74eAIWuYO7ahARodxxX60EHzadLHbIrYxFr1S6GdKAD0qRmq
zXsX/y1+vIoHh4T5x1QLuzNAPYdvg/tODIfiAq87G1vY+sXeXuUOPbisNM1JA720
693qxVK+Z62T8+DA2/Aes9n6/0LTlUSt9bw2LN3z3ir6XaVzBDn9ItMnmHxU4npY
cr8Ytf+u9uU3T7YkUrulZ/QHxQ4gbKRZv0liB/HuwK0lh+gQp14xzhr8NF+NKJj/
M1o/cc7MhqUHml/u8bEixall6g9AufAKT/3k67C2+7ZoFffDOYyg1e+XkpxZgBrx
AYIo23d7g6luDp57a5EreLgjEf7HwyDlmFYiFeS5Bla9K+Kd09itJKSIZNHvDw1W
hjuZJYbLH220/VXz/uFI6ndfhviza75DLW7EoVsQEtFi1JRITdjMr7NfwtKxuTWh
C1xK2v7/13vfJflMx6RHD56FhI6Ha8uFJfD057+PSJmIKqwmSakkXwj/EgJMbtuo
wwy9v3f1N/5ykggCDm63Vs+cCq2ix1Uwe5DQdx9NmS4xexOje4qT9WSoxHo4P3QO
s/ZKGjQLiqBLDY7g9j3G/1uKQFw5Nja+U/8BUn9RrMvLfrq7h1Pv7Et1XIiG2YS9
vmlkYmcfK35URy0nCR+QTeEz7RQfYQvIFtiAUEmiMdhTNyD/K0wAxXb8JXGVuhNy
t9T3/rFVUwmGWf1CN8bsw1Re0LniNMtphEkA4Bbj+87xpFPK5zN9VqEXbKZMP5cX
+c5f9NkvQ7mXaX0h96YyNICg+PuK0ylXlPffEjfNUco7xf/qSU+RivwXHPUBd7H4
rDeUzyd6lWmu6vl0PLr3cSKNK3K7+4FLINZJ4c4NQcG9iDxx+gLRuqcKGmfTA2NT
r5P2zwZESIM3aAGyb4aKlV/bbo0EwM8wK0aCedkhPR5bJc3lRh1j+1Chv2nZ1ch/
3vsdk2TCRUYoJCXZumVSpOGcitG782rhsQmQn1EiFG6W/I+hzS4PNEgSRbvrJhW8
GPe4Lm6wh3xvCFkiPMQfY7Djyr4g7rCnroDqSTl27EGpQxnYjNE0fWmfYjlV8sFs
VNT1VdXcjBy3slXZJHBgNW5Xknx0su01hDbYUucZ4gQRNor+6xDxHZTrhVZhAz3+
IJeDpWePLr9q0bScmZTMNjxeY5B4NPoqK4QURiS9gdoVN7K/2LZdOXMWrct3Cupl
pMiQR1boSTdfaJHhuBLXRDiw8z/93IuXrh6k5Mpr6qlKb2aXrgxxv9iJhhj+tHVD
tfHq4JJtYrRmYeRLfPr+e4uCzbLJYEPZYTxIkpKyfVFKPKSpKIH8NIfflB/X95nj
SRiQB2rcobWkMw9weg3WTocBBNn8uaqWDx+6FPLBkXE+RgLeAbemGb1jE29temnp
LFiD0/G20sdPurH5eIj5RzapBMz+2TlzjnXa39pSAk6FWAI8kwY0P0VZHPkhOUTj
jda1c+sZc7R47MaJ93OBXdl4hhvrbe2FFM61Hy+/5KPDZkcEXINEz71ctN0Xdwxl
4u80BGwDxUKaxJ4U4jhZumO+KxT3Z9mPBfH0W511zNx80gtfEpRwsJOVdIdTevXZ
HRgjjZmcuWpadNmgbXwJJk83nSt8W5fayj9r8m9jQ2lPq7Yxg4m5neBOBbMnL0sT
QjW2FUjGeLHV3d0j4OEbQ/d8Rx5X4jKqp+lA3siksLesXoFPYdo0/++q6Pbr0h1q
uS7+S+kd1kqfPVYmFOmCEEE53pljlgUY0XdBzBgTLQu8hcPhk08a3O4GYnYXrg1P
hUjowquAlRdlDhCigyK8NzjzKgiZUV7j5ho8EfbIqkvWSxzHLtvjPfeY7qGxFLAU
J7ygSnjEjnPya0SwUShA3XIlL6t53tf66YStK4WRewlGSsV4cToMHA+b/GEofN2i
3cKsIKoFH0/Q2MXloIthnkgHlb9tB1wWjWG32hKMVKSYUN9910haiCxiNBkYP/SU
EPu9od+Zyc0xEnNF7aQLWNo2rwv9VaGGbLUTODMR6L3mgCMZ4+KEO4crskyNxVKY
sJZn0QJ7DJrTyMPtIG+d1Cn17kxbDAut16ScO1u4Zdf/ftNFoVbPtcTcnW0gammA
U5cQPKlmw5q9SqAdWqj0DN334KWqthrUM5ajlTbP6++u2yq6clXMcgcwFmBuE1Ky
gsggRlTuZsxiJckfRWBqvStKu5OIqvR0QS8rNttfSUWxDG3vsirA52tnhu/4HV1T
vzjRKfNRkf9OFDvZ4mzQU2zjgr0mZUhyFAWFIt24jpzzid7oVcw6uGySIxUomyuW
+G2ff4757SISMTKPwW90C15FGXBMAuBmGzd01528Z8VNgzPuYjf//TeDZMcgO2L9
iuxmeTz8HbD3xZkH1UAGveAar76YlpdLL5k58if8hiNaHMi5JPlugeUYFq8MY1Vl
5TCsvSITfeEXOz8pEAB5snEPHcBL15DvQoKPrh3UIFQcGuH97Rvnet+itoSfuvU6
UtNDX6C6ZltNTBpCtpxU9EcRmRxB70U3FtiDLYqUMoOHopNsOIjaUEQdmP4miaMZ
52FfZCw4WgwAWxayNLu8j43eMEDUPr1sVUgARmMkwmJgYueAIWVdhuzEho0j6baH
rxh1bNpGnYpZGWaFq8CgJXhYyMtyKbJkLPJpqK7j1mEhi5n9CLwi3NoeAsjxdnR4
HVYl6jmCYwddIOkY8SrvJSw2PtTV9zVXTpioe0MtHIPJDz0jXITaaoKVMiWJfdGX
Y6KBROTQH/uSCqo+J71jRjOzOVTfgzQRjYPKkBcgy37Zuy8HKp2ahwcY2P62e9EB
jggsJSql6CMtaQpN7EHF7m9TPSVa5VpT9GTNs63eRsliex/aSGRhP5NOIFu8JmJ2
1SlWlE05YcT5STWCQJY7J8tIhZOnbP2hGdNhHSCwk1s8oF5l4THyzDcgFkgWoM4S
NlAfJsmgQoE4ntyz7q8NkU88jNNp7uXXRb+gqhg2FZv2eg4CPtz9GvxryyXJ63rI
DjeoTAuBWEKcpQ9NBqrDsUqyKfLw3dh289tJYJcFjUvfM02hR+op6KFGJgiauYe8
hX9Uyh63Ig9Tr0m6/LIohXC22kjjhWSy42c8CQa67j6rGG4yKeb2Jb/7rjuFhacQ
WBTRdDKvU1c4yahfsWV9wjmiMutGjCaxwQVhJrjEISxEy4kbNDrsL3XTjCrKnqrp
wRcGuHc+gdVu/qyKMIseivJOruQYJQthL3Z0+tNOG2p1LhrvkYyLA//BatnJyaEk
lWYmfubySDijrv3PEu3fSH21WN9L2cq8X3DTaGtTM5NyWfrpz+fIJm90FVzEyZAe
BrKVoG/P2WETgEsh5UJgGVQDvo4+Csbzu1NMV1LCgAe4Oe+EiuWAdfPM16nD0c6s
8nmQ3ElDDxnIxGvO19R6TCYLw3LpDavxfYACZYXk8xng463sYD+R49hS4SBK0pba
b2ipmaRXNDCshBVc+cn5BZiEJZULrB40uYbIOCOD0ZnG2gQYNw7BdUDSTJi9lcWi
lMbAibHREIaINdST30hThkNSf43noD0OqAuwc9Jvr4PAT7KC97YtkgXXwxtgerqf
28ArsTp/l3/lWyUEl0nzBQM9EEkf+jVPipXziEu1CmSomzIxku2qXP7GOvcu0b5L
CmiIWZeWdCk/9rEr+o8207dV/8U4IvqHVTSZ9snBXiXFRbexhGZ62kkSErmkcQrF
X8TS9AvCugR4fZHzikaAzk81eNiNigtF5nnupuYAvIOPnYB3dP3sk+HCTFaS4v6P
f4NODaujV8HdO1kigdVTCfwClR2YvG4QCVyLJaePwdtn5J4carFPx2RrFLRj0SpZ
AjZIXaYZ4qci6P+RagtFqlRJrBHGm+Qug5XtDes7W6ukjeEWovIvDNoq1zi7MImQ
Y4DSD/PnnkqhFox83NDYcUYvUAA1RLxWoaO418IQmcUqm9r2bFVkSQzbgCmhO5W6
xehWVxp+JAuIeHIv4RLRVDC1Y7NEJ2XKnX9vdG3Zk82VtjrA7fvrEEi0ERprBM4E
+QbhOYBLVd01h09b7kbPkgrpUsiKh5/81uLB/J1O3VOu2wFQGtwwrrcF20Jw0WEa
nxrtDhwICELA5eJZlvXVaRUljkn9YEQzp2LKQpMMiPBIihjMVvFrT3NnNioRSdMZ
r+QdxhjTmN4cQ9X+62ivkWSa5boHm0wmUthIQ4hP+yUvAEe8iszSTIpqJT01lLxN
NFbE2KV0Wom8R9ZQ0gNCUWvuEGIT7g/h91q5uECXU7iq1BsZiCxvYRClbloFrYAZ
DpEJ9dmYUCluseMiNRRdI45VE/cCV3oObvgy4/kDJwiqAK3MqqcvbAkwMzeAlKxJ
RQY0igtP+iToysIvbDHCs7bw0FkfQuT48DfABG2dYriHytWGeHcVwZflVPPo/gSR
SilruSQc2AnHj7WC9myv8Rp50lJVw39poW9yLbTdD9+z9T9YMkqooM/FX7SaP4+n
oMVApiXe/bS0EWHfZh8scP/52KGS2YeNBtlBvKzYvi5F4/eoQq224YoWpryi7ghI
gJXmKgFbdbSh5WAxD9TNLldyTL0J7E7yr0jnkol8VaKTvd0FeV/RmgDcxgwYJDSj
fuIKY8xIPUsgpQ41aLcMc09OBm6fs5bLHwg1rxHPj2kGaERCNBxmTGOwmjLyN6sD
HzSo9jhjCWnC2ZP9+RySzRmQFj/bzaBie3SpGSgEo5DALOUNhKlCR2jkzp9JSf+/
AbAVtQrK6ozNiTfqWG/zMLkg2BJtBsqDPiMLtxYZJmth4CZ4FKwsWmbP9ZTz9K5o
fs6iVYT5P60+v5QqwCglWAYbjBUwFzyZrqgeVDi7qtP54uCplb5G01HUYUbuwgKi
BTLBymtijieP7aWKkjm+i2y3mff7uyaI7123WgzHhVP2L6cknDDjZTArmq+0Q+XN
Ty+7hmYyuO0zaBmJKf4cJz5tC1z60PNq3mUFEWnJeuEvcpl5wQPxIbVwqVvFLiH9
LixtV03gaBWQTW6ttLYifEF05sDkCYxKsayAGb8/kcv/BDHh6HAurdVvm/m2evqA
Id9N3GyuHgJdmsqMgaiig3caKJdLavgT7vzc6qDjQVUDF2tAxuVsDKKbdQVyvTN5
q6fiUThP7SvbxRSupbiDBmsPmcFIz54txuWgR6ezMthEeMQmaiC5FXMJwUxBQCBo
Sz2oigDnklwucena4rKiRVcZRNJH3+1JppmrloYDl+SuuzkMNl3CBITiCLjU53Zm
1wqOhiBYrfTr5MVcOYMz80zkn9vXD3rPnzbGY+NukB+Hh3SimSPDbwaqaBsLg8f4
a+Wwnvr9jJBKEAixjYd18sPEPiESnxbhPxDhiZOoQ4zRw31kYjmZ11Fgp1MBb/7k
JKhGXQMcC/aYT7SI+uXG0NintNRuCcfDlv7/yhREUentfuBdduB/vDbSeb6h5RPg
Hk7BmgbU2/6B+4OtajAlG+p1ZhnR7cUsywKpTv1izqVCgHTLoojrZXjD6ZjAxmkn
DY/D5QQUP3keIt3q6jUdt/KI7N7fBZfqY2IMdeFDjbzO0MvJv/tPr9XikfLoqj1d
IIM8G68Q1K42GM6TZWHIc1w/fvD2mCY84lAX0b01o73ANwn1sdY0HXJz5GsZNoEk
tZMCYFcv0L9uBgdulEkrESRysZZRj7PsMKx2itHVeOdlMql9sZPuRtk1VClfKPwB
Z+dDSifCJmAjFfJOT/Xw0N0TYgtQQNM9lJmz4LZuXvtRA1GP9U1Fd/BHT5Aveaj1
HZ0TGpPsKn6p1ox6qtzgEPffxgNGWjx4tYjqTwE7K3rDkriOgh8JhwvNFanYbo3Q
XT+qKTUOFw6+YNeCBlJgVEpLsDA+0qsLGWW7cOB/9gv0h7u3c7s3HPmZV1/S5NGy
JN7KMHGhbfAYRhlu+MofRsMhpj1BPZfoYfW5PBS707kiTZ0UpM2RBSlTy9TW5HEf
T0PQeuobWzR8VA3WqN8lwE7z3Cj+nOE2ZgvpemGAmmedmeSUmo8DxIGkBNvY0LhY
Tjdnts/GOivm2W77L9c0uEASCXMMgdLI3ZBjcpsS9ZA7fO/V32/uZ9ZSkMYxCaks
XTyDLqT6XcEq92K8QRg9p+kdHtefp8xdoNrClD6KUUGxhHPD10ndKGsY74AUNNCa
6GB1/Ssen10ThnBvDk8MLXJXdUFdCImRdUxVupB8rrNpxoMRZJJuhtQr7WohFDvt
0osh2ZzOwiSosT0CjpolnNuxY3WeYZp1oI9bJDYEW0TfmOjXPDySeLsuLbfOqM6s
ncpG1l0EBfvDhPpkgIt0c4Lu0DTk1iKbXigIxuj8EEMeg+QMdqVzPTwE2sutxOd6
5SKNfKoQavyhZKfxJG0nAecy/DHX1B6tOaTTYHuyFqhi1SNghZFPgbAdox/D01Qv
HGUFH6jiqY62sMeDUwO3phVUg45V7iMgikahwHWqtTGcYBREfBf6yQIItJtPVvER
2PCPRN8Epb3PS0MeisY4n+Doc7e5j0f3SAHONuMFg3qunUn82cct/qn44GS9f4WT
T58OU70yJ0OEVtkMx1DrgqWiyB7r+7J0l+YyC+KGZ1tk55BslnYZqllEXuR4m7WR
Mw9nWDRejXC2CQ4ncqtPhE6dxuGjjuCnEZh3ULYnn94Uc6QNtizRqW2XHU1P/myK
apX2bX2JvQHgK8oo5GM1bD8HMvg4yCT/r/aLOe7YC3xV4UHA13OgR5NhCT1Ix24W
/DrklsOuuNFFeRUD62YBeQkm3QXwxpvDsdHrf6y59mK6p4qG9kgPjEWo1DUhBjF7
lVKPgJ/KxEVWmdAu5S5tZHBuJ3C+6KXE/KT6qlEq8vnmu6ON1lzc6Nzxy0IFw31K
8sTu/F5nA+7sInIKsHR7PjAL4gqXGSK/CyD2C57qGT0hJvKVcgSoZfODSSp1rMid
N/y7jSC3AYYE4xPWCQVg47zPlBH/hf7jDIMpTGMGw/y1ADvx3SkIjT9i3GbebKj1
uiAqzzXn+md1yA840g4dl4BDtTZED9iQUXlbuZF3ugv7bgAKCltvEjEQ4rzAvhmk
zc9ZvssX5rSuildW775DKogS80O7NliNMyAqqw7olQugyZ7eQk/50iljTREf1Omf
3NKcwPKgEXVaUq3MgLLNpJH8ai/prg/7yOGrl9EssGsZmovD4kQ5waqtMDlI3l3p
TftxnCfU0MUOjB0534wA+GanC+KNXarJD3htfjGJW90kTR0dvbt/5fYOtxUt8llv
m4tv+HkQoskrj9P5w45wNUJHh8EwWi8fTtKHPrcq0Q5qXfGlEg56jBKmPjJSFkbo
8yIC1NkEm4zhWa1NVf4hY+XnE750scDp76ccCSiEyxcFJypuGwVXz2/G8lrDIfkv
OotpV3Y+HpiIQ9eHDQ+M18HEUPnMneRXUbQatsajcumlJeQufci8oNoq8CMU6OTC
CDqSwaGVhuMFWd9mMmgQHvbBEvXFT0POqQ1nvaXda7BwqYFayaD6FV6glnVLaLiP
uG0MMdjpvPG6dNNOtmJLLcjo4BlILme+Zd1Haw5KjRHmhhq5JR4T5nEoC7XJmjI2
R30TaD08r2YyNE6/RKl5QBBPBpibrd1cEtRx5XqYLUTgQUGUA1eHRYXP7L43B2hF
kd0j6ueSdvyk6A5C1JrboNWdiDz16Di7VGPQF88jXN2ByR2YBplTWHrGwqUS8ZDb
/u2XQelexTMAezUXd8NvWm5tpjkNGsGWUoBmJYwwNxawcNEyOm7uuqvg2rW7dbgy
TZeKCZFN83ZznLBpj+KFa8sATcLn3W/Dlp+ev/Pfswk5x/T3o8IwMxbO2yX7XeY1
zw/RG0vz1M0pWY+fL68ZqBpV2RpCEH/CPbOXSEFTBv5BGuzVVHOG7Yf7lGzs9Dmz
v/8LOtsTTi+/wcSNr9erniiedwv6qlZIZ402Zdb9oz/+LkpP709Q/NsPBKs/Sn2f
DAdc53Y5R0zzLoiJi+RKg0uaZdH1j0FAYvOgj2TfjbofsUACV0darZvXuuMEL0LZ
/6bTt0QvCzXRGJ0JkJEqGE08EgUHSnLFRHUvEGrrdMCUt73JvsIKoUxLtdd3/Yqw
G8BnZbQMk6TObTNDb+0Zn8vlFjMx07ZJgm00EGfp49ggrwfgq1VNKbfxHSxLPT71
KLFyjyqw4sbQE3P7hsJ9AVtHizgOVbVqU0CbM1TstvXZzvXSAVi9l/CRAghl/gwM
xaEKNcCYjgrprReRBXD7gtdBGkjXfWax7IlhdMYp6AlU4z7BYSFopLyYXN1oaCTO
RjYdMri62sOiv1XT++Ud/kgev1VQ4gjn83aLE9H8HkP6V8jZEjCTnqYlixWXcWLF
82OhCgWkln+GYfAg9okH3/rusuptVZlfQwu/9VGdwjySHDSfAEbO9Z+0S753aixO
gAic4YcfiLoRka6bSSabBmKCwBRvI27L4Q7uYSBRED5Bg5kUv/c39BWwIxK1d5tO
1xC5sIe9yQKKbes4RGwWVBwWnx9Zad6s5y82cB4uaQKvWKalyGXfJPG5IKhLXKPg
1CMTfBV3Zxo5US845XSBXdqPzOAicuRX3/D4Fzz7/669ydjTFV2W//cTpv3Rox9Q
O9Z9pPExfqBSnM6ri6vXDviKTH7PJZm/Wv5FpW8p/cvWcmT6dZ/agPJOoUuA502g
b+oeKBmiDZCv2KWG+95bne+7nVbk6I+r9zstV1FIOcnM3OdnF2IgJcrEnaETf1fl
eYTlj/ZqHnqow++m85rFZ837VXRSDxkGIB1Uwo0ghU6Fq19srSyxKkUBrqhG44a7
mINmPTdm7wCIPXtRBsf7JD13rqYfB+y97zViums+XlZausQ4jDcpdr9Q7ZJKW3Dh
iNekNgiYfsWywnGAJ0Aa1qTn89j4Agqu6LXKXAqK6Rxu324lzeZAgQ1zL0Wxgjfu
E5g/oc/XUcXTI5oX/6HfOoTtb6F5F/lDPId2yIXoN8uDFEvfgksngic6ZTxtBpGl
BmJQ7cuyOlL93mVf9ZKApSeOBMCFzjSGcE9MkWfbPNnP+SJHfwNFpQbgjfipxLni
IoINus7iA48UDQ6mnTAcDgf/9uTh/y4EiDpPnS9jRJjSqv2GDmTUr0FsehTdY6Tk
dh9rihSyMSiTxqwLtImiUkF18+XS2q492XO5s5rOZzy2lt0IOm0LG0GY3A1WcwpX
Bp+GRNQ9qRkaZ2wFsb2B67m0p3zxKkdPAAvKk2xmlagNEehT0Fk1G70jF1mmxHkL
iIe/Eulx+TVDIJqz3fOARJMhpa0tQcbIIrjxgUdHjNL5wR/VLSqFZ5vbSajl36c5
h+/DsLxLIUOZUymWQXRBZVuYKgnRRTGQS7Q+0IhSYvYusx00Ub7ksr/2QZCVK96a
fBbtpbLkDDA+BBkM1Hs+oY733ZplYREty6eYGJuDsISjlsI9Uuq3fTmWEzc0xAHh
r766eRW8eD/5LMbtIs3R8wPIkbMY/pmPjOG9xe+QWIdFy66m/ZEOFRSzoXAlzqiY
TP94E2Hi/HXBJjvCflvFDTwfmEObGMJyoXQoaQy8fB4hLG92KP+uurneeBYM7s0d
Pau+PQygrnFM99wf90vPc2ZaWsat25oVu4W/Z6zjoVfgSzMHQ0NQvfyUz43pa0Mf
A8/IDhwIWbkrJ0Vt23H8XEdbj3c7NY47XSV4dsaxU1S5QTWNeQxLnD6D03fGHBRz
Chm6j7sUPRr4kJnngdZn++FxoN0JYk9Zh2T6EqBF5ckUV/ZVUfBQ+XgB6HPIC4J9
omZlA8WfzOD5b944SaQgL3A6JVAOiAAN3vBqtIY/4MUc0fJ88XlZigRYGpWClXpS
mUu5lJFzUwUkNNDZMm8BsruXHvjD40P4cu9hDaU4+RnWDrikCphxoDCPdNxlRGlW
shbDMBDBPavPyqb/guUdNkm5yHKrS2lCd9eL531wVRk+3c54cCIH/QXRtNpDsydJ
S8H8N2xzLiKgpB6xkaaK74r5Uqj9ebgu72rb/rijlgA4WMZfDbMdN2nJzYkXWWEj
q/iC9c9FVLhVAviFIgdy/HeI2tJY+U5IoMfrZ8hf/CRmIzs55xufIX/65crTSquu
AuRYo0OkPwcugTjHNXbI5GrfGvAjTTr16K4EjtHMPiD5fy3fSKITczvBnJHrYBI3
B5NPe5YBI7c0KrtEeREL52H3A9c7IAp2rMjO5QIpT1XDiWYv1ehMe8NskSfsA3z/
QG2MEJB/qSh7f2KUWjqGwYgZzgGr/2uolB99nnpC6dV8HrmuhCzCFPzmdi1mwrCV
TX7j7gWyTWS2ZJw+/t7qINF77UYMr9YcD1k61vCJ4U2OUQxTF1QofQOkhtboWlK7
lq41wDxcyiQ5SHQbcejddo9R8k5xT25ByXgAOYISbjdhv5haRK+spJUCK4Tl4ytq
fNePVmT/74xOxPrO28prxAxiFn7FYPtUioRuDrNeoWKc3toLv3jnNM/Eqfzuyo+b
37qHuH7NQajM1xI8F6sHqJQTiFF6CBDPLkJlNmQSpTzl4UswKvnAig99fHS0WlzA
YzkzOEs9P9s8d/MgG/fQHo1nBGBH/ltYve/HZyFO8TB2Kd1Q3rwE1TZgY+Ig1NDb
a1e7uiYnacYydJPEynxnSiDQAZLgLbb0V7IiTujK/9FgWX98HSZZZZu97vEKL/W2
QoHghr3IASXTbJFZJfe6b7fcov6Aoy8LJayDkmnj7oiOKNMS9ApUAna+Ffh0HJqj
We9GSG9wFDpEiXZUVXE6rVEwJLENGsopmMSl53FHdwMPxru4qGXwTZe3MeHtdBBa
znLtLMPjISyFErA7nzWZXpfO15YPhaKCDKvMoO3PD5FOXdWr2RzAAEJzKMGGwPL0
nR9vCMBgDcprxF9x0lZNZrBDg8j30+uvHcDetEdARe9ROTKEzcCF617mvFrgvcZN
2rBpkHZ82ag416bASpoQCJKPrR8zFhIsO/ByXGUq79AcafYi66xbgcn9gI2137i7
deqNvQ1cko0gdG7f7Ae9gF5leoJMSBvbi+806veSHk6oZFCKc9Hf66UPC4UOvP6v
ekwLIrmb6APsTwUgN/iQBE+ppvdr8jdxUQTkFjuKnFUKTx/+/RomfZsa1/WejnCn
L24P4IMPeXMk0goJYPN+uzhZV2rddlXvZyeB42uEpCOkWQ0jzLFbB/3AwcaWW0HA
sxM9GJ3IpXN3qBa6v2TJI3wshswYReO3JTTf4xugTGYb7XIF8FL1vbBq3+KnLupO
Zm89F8HhC8IU+EPZFV+VFw2Tm0A+jkrw/eBaGF+xfNWAxV75ZN2XpEKgduVz5WEo
b+uFOwFGJLM+NwxpE21ixmGMKn7IU1ibGvD7PC4xkiCmZjTCDNStl0SdCqZ5rTvV
ntRj3LTpdMdyBcKSjQtJg+Wi/02TPzG6IfpKTpp7I5tX14PVWWlnmYvaUVAI8iJd
yJqqYxi2temxKu6A6OXFhC3bPCAhvmOlL+ViEoQ8CeptY1qIdJf1nqUQixwhC9MJ
a2X1+VMUA8CT6n49M2Lmki60NCbK6tovKAv40gmRodZrg04kDzDjosSqp8mPkBcu
tm8oBnhNZIkVVz8mCL4icXwILc75UGy+iob452//uU66k4BPewRJDzsWdgICQeoh
2wHTwOIqoNzDM8IEYWuRi6pHZVf89lr8p+JxhXzzT7JbnJGx7Ig1kWJEOpKjj71p
oM8enEphHTV/wopbck7Z8v/n5VW8zSG15iYTkRt+8CTfWEfOo7GuPRmuSfq/p8dt
p8v5Lywkvd+UOdJ7+09pduXzL9rDob4SkZRyNbCOljkzkkrSCdC5gsyxL9iOCR06
gW7gHvojdv1glAdjm081rr8/ClMw1C/Lkbv52ugYu+GhqgsIc9HQG7zWjrbPTw1f
8hCArH+QWSttZMfJniguxXqaNEbeV0D/+1rtHlF5HN0Ej/zEMZXoR9Csz+S3AUrm
iuh40/cDMxa3zqt/Qd2qnI4qNSX1iY6MXabsJBIXrRpUNcSGjqcvIkWyjHa6fe4t
f3YT1SAhj6DMjqM4WJI0/Yea0Ly777T2POwDs4TyTAfWHZlXg1e3G+CjAnrrvg5/
+GZRnrzHSXmb/ZFpd45S2ifP+jecosAMcW8N80TAxph4i7uqHSqc+DmdQomgt/hf
6dlxYMPA79C2I4xrze1sxrUWRyssEnaVGC5AsRbASt809z+aoCzbi/kS4Y7i1NBH
lsnqsYH4L+a/3Mj4AHyH525ctrvJ2kEzK7WRbEYbv7PAZQGEP4UYK4kb5td+ozVo
97PNRMP9kJkTx3K7TI25Gw8neE9F5q+Cb51Oq5VtXR83K6KazzmRwQjV4iKlQNH0
xJjcWqXW98TRA0qlBX0cQyyuSGm69qwnaO6siS3xyfigqiulFQZFwy7gatoggc+o
A8TPs5HjJnjshB7z/RI44WUHOrimXdS9X+1dEXAD7jGOmn8aLOGq9hTo4xW6TKMO
xZZtyksHpTOA5+s/PR+6QQZUpaZKE5tU8gAqdt4xwUcdY69orwOGMpdcxZ5c3pOH
eSpDOSnA2BGn95jstPX343QcxUoYaOz1bGrL3lH8Htsj8Kc/JET/4wyqh/qkz0A4
739u/8PxxUMkiwVB8vPt0H+7IdC5C3+rBtKYMdmXnvSzFQugcdIJsilqwjAOEw65
JJpH8skSdg7QYXDQ6FxMpsYEonUMZH/Ei6+GnYWbzMYZ9H4qncLWbHyRw2oILXt9
6ykDygs683hBpdk75fuStFoP4WWG5OjcL1NZ4KZnTgqHP4iG7f7HmNjJOJoOTlip
1Q992rvdSULEDqnDJTaOHYsASF6okG1CyHvXmYivYVZGqR9z33fZBm8u/LcREs9R
PVaVHGQQrv8J3AToDbKenkDdmxspBF0ULkQaXZuAGcUlXX86Qqywj0D7I/OMAnIA
CpujH7eClTx13M2CVWczS8OwY3TwidVBHag5cyvodL9yu2fAVO0TXwtHkyPjlCgr
xxI5R2gsoH+Ue5AdX2Z/FJz7A1zYSmi+BWl546+7iK54FN3EbtYUpo4Wx+MEUInG
2ZvsmfQ0G4BBow2lHUeKlo0IjG6gdqluP4mRUeSPuyHf1HL883QrckRmeDBwcpSE
7ANYcWJKDosTPzCV3L9GW4IuUVbloQx7cmALb7RSOpTA+np2na9dY9cfSeIiHp9v
xIB31FrQnj2iCu1wH1IQiUtKzhmcF5GyTebYhXuOjAMklZek/XAdwWMGCdan0jhb
Og9/QG5TQ6joRpL2mc6XS7GaIQmKgwT3uqPytVu4haAqM93P1YoYZEDexRmUVFqk
oMGrYqH1AAt0MLYmf2FuEXHw8LrGPxVGMzE/kPC7ohTPnZG/6Lcre0EeQPUEaOx5
cZ2Z0ihJPbjvc590WNKwfOGLUpQLGAxoiw5O7BeqCbI69QlfvtVflyqB066ixRFU
ClI/IweeQYJJUx9bMO3VWq8Zv4VOChXT7nITc625g5na/XlNzmtMRg1N983ewMKe
xhMKpP8Kte4G6ig0Wevj7i+Cd0vMbTeA+Q23mxAOazM/KS7uzZaVr6HxnB+RXczQ
reLdbdnyY7QapsYsu56gOlNm16x3g/SJte5VLUCA3Byga5uP0fvR4kf5D6a0qEj0
s1o8DXFM05wj2GCTrfXcdY3Yx4dk6ALagMWl86tSED6QyQgm3woraA4UM8s8t/Io
QXcabWUlrMmc+HVksRaQSyOfDuZEhmqWWjmtlbpaTuygx3TOGxYrvBQhtjdgmNd4
NkVZ6PQi5cErEim3fe4OygfsbCYylGM7Z+UGgGAer8P0/sQ+rs1iA8tEBVX/iTaQ
bZ+uDHvFSsel5OHD+dyl2I5OmLfD3txHVq8zMwdekcXy+duz1Sq+1bggddcrPohF
xL5GZsM5x3pYmXFVvCOg+T6et9F+gbIJUSCFBMPYdGJzFKGkJaxzqfNTZ23nEP7J
cSnLul3CNK/RLURJ6VJOEAYElJOXuOIRH0tplricYuVCFfFi2CHfqIn265nZVs9V
Zd+yJaOF6y44PT/LYno9eLYoVCUFOa1sWZ645ZoCIhZ1SP1Hpnenl5bEOVpARx00
4NG8uMmAtUhYkifK3VzJYtv4Dl6xfl6jVfDKMS/doP1k9EHkf4DscSbJtk0lXppw
PXDKl4Pe2EwGtiL4DEQX+FshNvtlhYdk2sUMbHMbL2JUzUruy2EnXlrg71gsHYTA
T6vHFxauYPphM783UxVvZVCn3iLsz4Kdp5vP6ppjH7DBCYyA0I45AaOG5xyTAUp/
bqxWqDUQDJGrQDe1bdz4P1HdhxlDzHGg6DuydpdjBn0qtEoG+FQG1lV1JSTXLTHW
Y7SMfUQu1JUSzhwtxFGunjyw5vt62TvaFhu35Gsjr5L+ESACx3Tqy10Z+4Gofau3
OFIP8Qcah6LABDUzgylAJeU8Cj0S7KklUctg9mRsJ1jcmK70AAar+3d2PI3da+86
wNgKMEIjekn5QG/ax8wlBWw5gOyZekAwwiTUdOmLeUlq2nnChx49ah0BvzO+nU6J
WBzCJ/jwcdpuiC4mz1QZ3nBF9bjFDayWXUQ/px5O0cy8msDv7RfDH1UXXQkGCgrH
WN3yXsGOMO0Ao17l+vJAMAUbjVZNQleCIKlaIsW1KgIkHh0CWj294LItX97w54qt
JBR52JDnDDohp8XFzm8ZLhW+Or2u9qQE1AI1cmNFXNqx8prFrVD3jsEf/+gPmkcb
lQIc9Vm3J+se4LLyWTlu2Gqn88Xj89V8ePgghxN6OIjlfbbd4kJ/DCem/+Gt4z4z
/wK7T8cu1VbWaqDratt+ZLUUtfHzpSQPUO/057rXBUkOkG5E1i4QwOgHItyiko07
H0iLx5nQIARdnMSZGohQzNxbei4G3G0kVuXxqriM9TPSpvzId6fMnH6odudP+GJk
L87vnFEQFECa2bbY/gl/Ptu0mBglUFySgQoeNMU7ozEwC8DpOAKmWg5kEq+LgEWU
QJXIIPoym4puwPoLGLUoM0TynEhSMFhMkH6JQSzi6k5CDuH05NwNKRXht5aOoWBM
uTvkmwMrHwjQ/2YPCJhLLJnS1HdXRy1W3rRbntOjPfYqfgzU/6BEVEkDFmCsR80K
WQTKsQ1cjySOVidSK13k5qQE2vgdOPxK0l+16J0WgIoI9QKzDC7s3M5lCJoEl743
1DoSqt5fW+e1Y2wKJnAj7P2Q3sXZTNa1tdpG7ScMEudS5dJ/StxIzSQc8oHeNEQr
kxtZJ4UW8DO+4FXCy0xWSIvin3+I4qOHgL4IF4SoCXy4wN1V6DT9rgdwzf2k6q08
7YP6jofWFLJHvc8OsGvsdDtp/kXNXUpXQynAMTBkUobfJHLrRDUJOymoQGuiOoXK
BhH+Td7xT0qHdmpISS4uAiwr+CJahhnt0tOUYdBBmXGRhBglUIxECfADpYifxaIj
pzK5Wd0jmS2DYfDjrepMPhdzXpPJzfdNMDxCcrI0Cs1rDIrEiPEC6J/y9heKPXAy
kSeQ+qJ0g552hX7QhG+OlLs9G7Hh6QdmXsC3g695pgUCFd5TcxuFzOHlxp6NUCzE
nwM1I+JUuZLXKwwfCeqiIj/6u06R1lXhd8mi1QUbq47bnS45dRO2nrK+jQun6ndK
UH3rcD+NgOii1f/cj93mUJ1agSheCJd9/xQZUYmtc0OxCJL9eGtdiPRKnKVIrvV6
1P4rmqcZGNna843ep8g3kChzAJO4XU7HSic9b97kzKOSH+51YrJIkZeSyM8pzzPq
s48QZbA/XJncWb4mByQkY/jYdYN1WXrvlz8BbihImKk0YB5WzAXqoeN4M1+9t9Es
v9w3OQzw4NfLdgrckanLePyzX7chIa8e/U3MV/PNxoHTH6JVtNL9dmtrRCsmzh+X
pXO5IMbslGvmNFlj7e4uX4fl5rMnm04zh6FUDwAA6rbNaoT+w6oyIJro7Os5IzvB
Ac1HhsYjCDS+osmxEStRD81gJ4bPLKWKDyn8+tKq3ukOTgGkOFNGJZAZTyxa2ARP
kjQjcS8wP29SzNtIwo3BlQ4BLMjCP4i2gxrYesaRKwvQB6PH/Ip6apKmc7P3pl+4
HCB8CtVwNPcLQrXg4iX1ZyqCXR8YBz9gFRxEK3mAPKbdJ8hWtUFZeuKc5YSdJmMY
6VMHQ4D9VrSKFgz+qibC0+dV4rIBPDEK6z+0eBWFOinVOBvlhlEtRPI2dtSYPuhO
qOQ+dyqv2+ZbB6dZjWQl+VcIjWgbG0BOrNySiP37j/NjfNMSs4aYQ2wg6w6G0nRU
idyJvBUk+XGQ1049vcRWYH4nGI5/9KhATqn6sFEdgx4tOWZW6Jd2meuklpkrgWss
LBtVrpX7XCqBKIpNUwa0OYJ8Yrxt0rc845NbNmNgW+hvRdlTieOabxJwpURoYa6g
y4lHycv8N7BeC4rtT2M6GaH1MHHc47CZEjEWXrqr/lHXCQEwA5hbmxlBo4h/bmni
rHht3blCjC76OdPrBkRKpTdqml31KdYk1Idkf0L7blOdXeQirU0AXlI9Rcq9t5l6
WYgpKVwEVgKSshzt0Br7xaBQ/zYHWpfrmEGvRa4+vKx5i3KIlVt4e8Wi/jiAibFk
OQeBP+v0jXpRcuZKARC+DLs5p1irkWS64SjhISTzhQizacmJhbbDGvfXA2D15ToG
vNm6WJSLr1O0gomRC0LJov/9yuK4FcuYBrX6QskE4pymyvVY+978d+FgOHLLjbKd
YhAN3G/WOd79oxGVlCS/6m7UNKsYheoB/95W6pn9O0egdXV+hqW6eZ+H5sKjWo1y
rjiLi5mqExCbQsqTSdlA03z8h/4tt2g2Gs97NnCX1sNgQnVxEi+fYI61GsGEmDjd
EbOGbPre2+GDk/iwgkj4ohRotE00f/tEhB9TVDsnCZgFs5v714rG+pG1qkj9sRbG
YmV/qFaz1tcAfRmWQJWhvL/rBeHRXiZcowCLzwzUrnZPeYgPb45y3zNMv6eZZhwY
30HVWpaqR3J/uMaSZuIfS1mbQqiTjif+rNA1ny/OXb/B2F+po4WfTNeU+E/8DBJ4
OyGlkhThESWX6c9yqpSVh9xJvW9yma/a97y4B5gBl2PGBC/rW97XUqyyqGuI4u0s
o/rdnSidAWJWxYKfNESbHdh8bYcsPI1teUKf4pJyX9/Re3nxcYZLDkbXSqxkg/sL
+Lq61JJj/XiXaVx2E3UCh6l8NqhwNp23USkxlS3QByjOfDAfFXSKov9neGnqdmhZ
ocnCdNKY22PQq/XgF6qvwT2cYBp8UZb7xzKAufaykmAcDaZD2hhFFkPy3GGv/aqc
UW6zu7BNR5WLu5y+2fBq6dP3amtyvcrEhRnJyHwGhO9xusvmBkG6s6MVO9BI8UpD
xPObXtxOmkb56imfetM3NnhTKG6Rx9XF4BXGK/1njJHARhC7zffyiPmZ4ioOZ4d1
z4Tq2KxLMds80cbpItx6mvtoHpKOi5kxIt2eOcb3XIWzt8e6K7Qhazhnb0bCnjDl
kS6YrplOHvpWwivgEEmuH5Kh/xSjXrjgr1DTINd5wuhiJ9qvZ1gts+vLDx4GJKS9
NkP+xGTRPxT7F0P+FNmJuUjT8v8kjRQT8JcXp8SqfFC+YTvSZv5MSnBE1QPRWcTq
4lyieie8c2Frr15r/XRdX+2sCrZnZcQsrmbrZ1kJkEPKvBGXoXX88xdd58T3vv6x
CeP6I7AbUCsE+QujYpGh8P8PMqQaGoU8Zsepq4Wiy96rqrJJ/JbXgKFnuDpeiu84
hQXb9tlotN+P+G/4mC+Dga9JVwvNusAT2X56+9t0UoQnBYHE40Ii9x4J+BCM1ddq
vWSyG8dSQ6IfrH9BVlWTwfLehj4b156DFHiGo/XplE76hosPr5iaGyDIexr69Lr1
2swwRPbjhUs/q1V/dDlw3elFkuAG9gkdJAPBVwFlZtRKruVItkivnkoYnov6AgKM
IhWU9610G+uqvn0lFMncbi+sNyBRCzK8XAdfRWVSLg9fK2P+tPxKIOihHqxjh+Bs
6qulRbWRmfpwyG4rCBgyXKZJzlEgT3kckw6u/N9o0POHqTLnS5f0Q3EZ1DwQRpi2
aB2dQEsF23ZesEBdOXhsMxPCVG9Y7ZNclKhvirTcxyevLgqTYs2WFk5iCMXbhC3D
ksOfNExCLAaAq2Mafxi3ZfLI7LXA/0C58rmN7W8iNBgNiafR52gaAX/7My/K/tkg
U3YeQL0D7VRhmI2PT7z5XLusZVBX9roK1GAnNgtTWt46c6xYkkR6EOF2AyAJrTEu
UhLO5OgTXvq/dhtG8v7MPiUekLOzSU851ut9CSkysAt72l1BX4efKpblAuWh1ByO
Iy0iWw39RSV54rXkzbtDX8U9EeRYcOyZ6s5NgRYqeP5hPjISxpSMHkg4p6BTsSSC
mJsfFCVdgzkUjqXu6Am96XOtPEgZrgUxA/jUNieBPaYU/oy72J0QWXU947zUPlJC
7CYgv0GfWHnVk9syHRryWOCyH7AMK3lOD1qMLpqxlNkvoEr1XGaQ+IVF6eASGthU
q+4aqzJ/l+SiUulg7v0g0WfEYKSlYMJCM7gtTlY5+tJX9rg2HbYkWRzkEqxu6XUO
sp8WsGaGW8wL0fL0qs6d8DnEbg2f0I+Qzx9to/ZN40hHC/K+6xiPq99hkbSD2xoF
MTn/+hSg7+2s0+rytlIKs1KAK6F98PpmrMFnJZHrDKqVQFnsrGaRE7gxt+hKUELh
YVv/HFBX/AYPvdvPhM9AfTRU1c9QJXkcrC+lz9lNTm8e58pyb2McssO6cmb6D83F
u4Dr1HMhHhP3UZjW0v4ZNbi6QSjzj9UxNdVvTC4zkojyjhYKhDhcuYL21dhTLWai
NZMRRwz1TCmjPFE7VBcIHdwFo+dUqoUWSlB6EINGYN3g6BBH+X8rHn7hsKe88vhR
SXhGSRiHLbKb1zr/KRYms/aQfnUK8i430aH7xiTxzaCZKUJ7kcwBlQkNUqF8Sp3Y
ilGFjsmhcue5yi1i7o4guu0F6nNXuNdvl+Hgj2edO0bzBZ1YD/kzoodvmwNgIQlr
pXXRIjZhROSj/23yDgHinfY5MG+MafUH9tlp23xcGBsVJaZLZrs9j4Lt8ta8Z3MB
GrYJN/k1BA1E2Du/DHZHPCK1YC5RqCz3TehovoMjVdhIDn4MNSTtw4GBlL3KBATd
ZI5jE3GfHdzXyhIlDYocgq6c/NiKHDWGnO1ScRiMqlTShppZ0eCBMzYkUpM4etyp
kd1cXJcD6whJouBjoD6oHpWtBA1ZhdTOpVEACi+mc6sNLtaoi+nOm9m4QIdQZsQY
udbf0AuSjuKMvX1x09RjYbEcOOnDGzNRFCkaNLOYbJE7uabupbOjkCiW0G8buZs5
XzTDy2dsv+stIAoG6/eqWMyreuSaUbfhbAQEy3jhIaVZczN1UZOZPNRDSKeKIUed
UQIkeRea3l5RO3M+nk6Os1AMWmvkjvhr0J5pCiDNl6O2PsTTk9CDn/tlDAqLZJl/
yDnd5E3YzTtNHQzLht6b9pisaJw1rqQAaes5rLJtDTapAA0C2Hfg1vEsIhn8b01o
suOPyfBBqLzRhA55c28p512cv+/mDlhrvfKF9qzv7YVUNyVrP6OCEjHwu+LSUFol
0FSemid4zQpn1rPQbXzn3+chMK2qI2Ce/Jiv4sKU5Tzv+iKE12UZTpBxha0x3JEj
fWxEx4JLKZC0FtN4ryAFNW518HRexNJujikLd9FZKspQTHSpAuZ4yK1WI9VAoWpv
vURHkLc2DlgUBRwiPmsRYntZFc5QLwWum+9+zxwrKnpu9gBJn7XN/4noe96T3456
xNe1hDvOShWoWAz2wznOU4S6mrDQvNFGSNhiFmIWk42su61eg/34vOpziKfU5wuv
/P4gL6wP7VENk2yVJwh9rdYHNAWw4/4bRzqNV8sqe777ZQmpOvcGTxHTO7VLgM1C
1xf6Gp7XI1J6w+7F2dStcz18yetvF0/vLlegqylTmXQBfpINW95jcwmKBpQsRAgc
O0ONv2ktTnz/5rXEkZfFfprkyHyAcVnjshOygtYKE20ZxK1ATBqwHnFC5gx1xV1J
JgrEulGMfG+h4uKCI6pCXyc6lX4R2fHTlk+jYMPsP2IKEewNWT9Pm7wzv4/aXn3X
vUCASiJnaqXopA6Z8FEwt6SttiXkreRqVkNBIT0lyNtWn4TFqiRAQItkyT0PPsD2
9bQZ2vdDLFFdIVTE6T+3wFkf74BZFFREvqSoIYLsf5/U8s/a6VJYDCQyz4VRpgHU
139lizt93EalT7GQLL8fD+/RFAe11V45MpLlE4C9daXqwg3aXin2YSreP/rvxXPv
TYv3AnzzbQ2wWYtyMcbBxCJwPGDT6DcG1dbYlea4+W/bnGV8koHw5vEJPmlXK1nq
MeFTm5Y+qaT/WLzO7ixCL+2xY6tmNRvQa+eF6IXdHAAvsVVc7gqFzzMbEnfFqN3D
gPIQTwbXEvrsuaxythlpzlZXQ0DiV1xP5vhhnKFlpox63VBnqnOMCnOtqy+X5ue0
U5Ecd6a7qtrXvnPr1aRgSTRach5h7HWddpN/KEvN2riCp0sDgSs5FjrBM+EtM5wP
Qs++dCLXsZt7rIyjOoq5ubLJINPZt6ThyxxofB05nu28spQpVrUc/uykI2KcsPwB
xEXSbkqG9HIh5szinRVhh6fSGkgoSj9iSpZ3s/CC7tkhBo/QQPhg7MZd1tYY3+Ej
qMg42eEEX+QyVbaIWQ3l7UfEd7q0JXyzG9jatDdZdM6QIwC5QOT8qsKPHSXrwo2g
rXHYKRJLE+6RPruysvXU//OgV6CFk9DgseLWO3AZhBzRj0n7ZUn5V08hHvMCAIDD
hxBDr2yVqkP6iwI3+I73zOF6nnz9rvd3u4t5TrzvXR6r6CIgo++jp8Bb+xM9H0+2
k938ZsWVaTRJWMMgloDIuXJV0oRGdGJucMExd98IAXiqBhWqJmkD0mRdZHvdjpdn
A+jemIB2byMWiimD351Kw6NeP9TdU8D+Kbq31eVoOoBAHItcatS/mGgeNZ0rRBwy
ry8TDQ4MSF6An5yRuFooLLl5KgXswsFt+BjtLlOFUaX/KFX0ywxtkq0AmxDU5N+O
hlTUiQLU7XqbC/LjFH27fNCnDbvSnFQNlNtYAohmREFg0y52YeL2hjSLSAGgfv4Y
ZmWV088nrCjY1TF2qCbXCbo8F2AHYyqlKb6beHKlqcmt7iF7XrgkYkqKRIOHdAjf
qQV80/fbv/EbHuSCQpCscYMlDa43qc4R6YY7LwLG2XViSRHy2Qhj0PbVo8vjik/p
UJcB9oNnrnarhEZUWnmSFT51j5SpyzDWvkY6c/iWr2UqVN5b0cAtnyI4ZXvmOIu/
Ij9qzP4d2xUfPNhzHixEd8xK8z+r2B5wfHy2vKEjLmTTFwlyu3pR53zpJyld7YEt

//pragma protect end_data_block
//pragma protect digest_block
XUS+bmqRJbUS083SmZPgd7aIPSE=
//pragma protect end_digest_block
//pragma protect end_protected

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
