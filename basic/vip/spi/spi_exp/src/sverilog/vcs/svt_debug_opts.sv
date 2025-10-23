//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_SV
`define GUARD_SVT_DEBUG_OPTS_SV

// -------------------------------------------------------------------------
// SVT Debug constants
// -------------------------------------------------------------------------
`define SVT_DEBUG_OPTS_FILENAME "svt_debug.out"
`define SVT_DEBUG_OPTS_TRANSCRIPT_FILENAME "svt_debug.transcript"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

typedef class svt_debug_opts_carrier;

// =============================================================================
/**
 * The svt_debug_opts class is a singleton class that contains the automated
 * debug options requested by users.  Options are provided through the use of
 * runtime plusarg +svt_debug_opts are used to control the behavior of this feature.
 * 
 * The +svt_debug_opts plusarg accepts a string value with the following format:
 * inst:<string>,type:<string>,feature:<string>,start_time:<longint>,end_time:<longint>,verbosity:<string>
 * 
 * - inst Instance name of the VIP to apply the debug options to.  Regular expressions
 *   can be used to identify multiple VIP instances.  If no value is supplied then the
 *   debug options are applied to all VIP instances.
 * 
 * - type Class type to apply the debug options to.
 * 
 * - feature Sub-feature name to apply the debug options to.  Regular expressions
 *   can be used to identify multiple features.  Suites must define which features to
 *   enable through this option, and implement the controls necessary to honor this.
 * 
 * - start_time Time when the debug verbosity settings are applied.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity is not removed and remains in effect until the end of the
 *   simulation.
 * 
 * - end_time Time when the debug verbosity settings are removed.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity remains in effect until the end of the simulation.
 * 
 * - verbosity Verbosity setting that is applied at the start_time.
 * .
 */
class svt_debug_opts;

  /**
   * Struct to represent debug properties that have been enabled through the auto-debug
   * infrastructure.
   */
  typedef struct {
    string package_name;
    string timeunit_value;
  } package_timeunit_struct;

  /**
   * Struct to represent phase names and start times
   */
  typedef struct {
    string name;
    realtime value;
  } phase_start_time_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Static log instance */
  static vmm_log log = new("svt_debug_opts", "Log for svt_debug_opts");
`else
  /** All messages routed through `SVT_XVM(top) */
  `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_debug_opts_reporter");
`endif

`protected
1DdD3-+ZE#S:AY+23S9\],\#1g_K=@6(IKOJBNTG[5f=_&,H,E,H-)3)?1]93ea-
+WS4O2B^0L6.3QDfK;G_.[:=:E8K\G;B[];7@&:Y89&W>63E.LcVZ]QJC[)&A3T2
Aa_-KXKY0a(.,$
`endprotected


  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** Flag that gets set if the +svt_debug_opts switch is supplied */
  local bit enable_debug = 0;

  /** Singleton handle */
  static local svt_debug_opts m_inst = new();

  /** The string supplied via the +svt_debug_opts runtime switch */
  local string plusarg_value;

  /** The string supplied via the +svt_debug_opts_force_cb_types runtime switch */
  local string force_cb_types_plusarg_value;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_inst = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_type = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional feature name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_feature = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional start time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_start_time = 0;

  /** Optional end time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_end_time = -1;

  /** Optional verbosity supplied via the +svt_debug_opts runtime switch */
`ifndef SVT_VMM_TECHNOLOGY
  local int plusarg_verbosity = `SVT_XVM_UC(HIGH);
`else
  local int plusarg_verbosity = vmm_log::DEBUG_SEV;
`endif

  /** Verbosity value saved before the auto-debug features modify this. */
  local int original_verbosity = -1;

  /** File handle for logging auto-debug information */
  local int out_fh;

  /**
   * File handle for logging VIP transcript data when auto-debug is enabled.  Each VIP that
   * is enabled for debug will route all messages into this file.
   */
  local int transcript_fh;

  /**
   * Storage array for debug characteristics associated with each SVT VIP in the simulation
   */
  local svt_debug_vip_descriptor vip_descr[string];

  /**
   * Storage queue for pre-formatted header information
   */
  local string header[$];

  /**
   * Storage queue for timeunits associated with each package
   */
  local package_timeunit_struct package_timeunit[$];

  /**
   * Storage queue for the start time for each phase
   */
  local phase_start_time_struct phase_start_time[$];

  /**
   * Flag which indicates that the header has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME.  The header section of the file contains simulator and
   * simulation mode information, VIP version information, and package timeunits.
   */
  local bit log_global_settings_done = 0;

  /**
   * Flag which indicates that VIP instance data has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. Each VIP intance is recorded, along with whether
   * it is enabled for debug.  All VIP instances that are enabled for debug also list
   * every configuration property that is modified to enable debug features.
   */
  local bit log_instance_info_done = 0;

  /**
   * Flag which indicates that final information has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. This section displays the start time of every phase.
   */
  local bit log_phase_times_done = 0;

  /**
   * List of object types which have been identified as types whose callbacks should
   * be force saved to fsdb when debug_opts enabled.
   */
  static local int force_cb_save_to_fsdb_type[string];

  /**
   * Flag to determine if callback execution should proceed for an individual callback
   */
  local bit is_playback_callback_available[string];

  /**
   * Mailbox to hold pattern data carrier objects associated with callbacks which are
   * used during playback.  The associative array is indexed by a string value
   * representing the callback name.  The callback name supplied is qualified with the
   * full path to the component that owns it, and so it is guaranteed to be unique.
   */
  local mailbox#(svt_debug_opts_carrier) callback_pdc[string];

  /**
   * associative array to hold pattern data carrier objects associated with callbacks
   * which are received from mailbox but values are not updated in the task 
   * update_object_prop_vals in svt_debug_opts_carrier. the associative array is 
   * indexed by a string value representing the callback name.  the callback name 
   * supplied is qualified with the full path to the component that owns it, and so
   * it is guaranteed to be unique.
   */
  svt_debug_opts_carrier playback_callback_intermediate_data_carrier[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the data class.
   * 
   * Note: Should not be called directly.  Clients should instead call the static
   *       get() method to obtain a handle to the singleton.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_debug_opts singleton instance
   */
  extern static function svt_debug_opts get();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the plusarg value supplied via +svt_debug_opts and parses this into
   * internal control properties.
   */
  extern function void parse_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the debug_opts plusarg values supplied via keywords other than
   * +svt_debug_opts, as adjuncts to the +svt_debug_opts options. Only executed
   * if debug_opts have been enabled.
   */
  extern function void parse_secondary_plusargs();

  // ---------------------------------------------------------------------------
  /** 
   * Routine that tests whether the supplied instance name or type name matches the
   * values supplied through the +svt_debug_opts plusarg.  This method returns 0
   * if the supplied inst_name is a sub-component of a component that has been enabled
   * for debug.  The #is_parent_debug_enabled() method can be used to determine if
   * this condition was true.
   * 
   * This method also populates the #vip_descr storage array with the status of this
   * VIP instance.
   *
   * If empty inst_name and type_name values are provided this method returns the
   * an indication of whether debug is enabled for anything in the system.
   *
   * @param inst_name Instance name to check against
   * @param type_name Type name to check against
   * @return 1 if the supplied instance name was enabled for debug
   */
  extern function bit is_debug_enabled(string inst_name, string type_name);

  // ---------------------------------------------------------------------------
  /** 
   * Routine that returns true if the supplied instance name refers to a component
   * that is a sub-component of a component that has been enabled for debug.
   * 
   * @param inst_name Instance name to check against
   * @return 1 if the supplied instance name is a sub-component of a debug enabled component
   */
  extern function bit is_parent_debug_enabled(string inst_name);

  // ---------------------------------------------------------------------------
  /** 
   * Splits the leaf path from the top level instance if the component is enabled
   * for debug.
   * 
   * @param leaf_inst Full path name of a sub-component
   * @param top_level_inst Full path of the top-level component is returned
   * @param leaf_path Leaf path from the top level component is returned
   * @return 1 if the component is a sub-component of a debug enabled component.
   */
  extern function bit split_leaf_path_from_top_level(string leaf_inst, output string top_level_inst, output string leaf_path);

  // ---------------------------------------------------------------------------
  /** 
   * Marks the VIP descriptor entry for this instance as a top level component.
   * 
   * @param inst_name Instance name to update
   */
  extern function void set_top_level_component(string inst_name);

`ifdef SVT_FSDB_ENABLE
  // ----------------------------------------------------------------------------
  /**
   * Creates a new svt_vip_writer and sets it up for use by this VIP instance.
   *
   * @param instance_name The name of the instance with which the writer is associated.
   *
   * @param protocol_name The name of the protocol with which the objects being written
   * are associated.
   *
   * @param protocol_version The version of the protocol.
   *
   * @param suite_name The name of the suite with which the protocol is associated.
   * This is only required for suites that support PA-style extension definitions
   * with multiple sub-protocols.
   *
   * @return The svt_vip_writer which has been created and registered with this VIP instance.
   */
  extern function svt_vip_writer create_writer(string instance_name, string protocol_name, string protocol_version, 
                                        string suite_name = "");

  // ---------------------------------------------------------------------------
  /** 
   * Creates an instance of the VIP writer and adds it to the VIP descriptor entry
   * 
   * @param inst_name Instance name to update
   * @param writer Writer class to be set
   */
  extern function void set_writer(string inst_name, svt_vip_writer writer);
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Returns the VIP writer reference for the supplied instance
   * 
   * @param inst_name Instance name to update
   */
  extern function svt_vip_writer get_writer(string inst_name);

  // ---------------------------------------------------------------------------
  /**
   * Routine that tests whether the supplied feature name matches the value
   * supplied through the +svt_debug_opts plusarg.
   * 
   * @param feature Instance name to check against
   * @return 1 if the supplied feature name was matched
   */
  extern function bit is_feature_match(string feature);

  // ---------------------------------------------------------------------------
  /**
   * Obtains the start_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Start time value obtained
   */
  extern function longint get_start_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the end_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return End time value obtained
   */
  extern function longint get_end_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the verbosity value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Verbosity value obtained
   */
  extern function int get_verbosity();

  /**
   * Obtains the file handle for the transcript file that contains VIP messages.
   * 
   * @return file handle
   */
  extern function int get_transcript_fh();

  // ---------------------------------------------------------------------------
  /**
   * Sets the global reporter to the debug verbosity
   */
  extern function void start_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Restores the global reporter's original verboisity
   */
  extern function void end_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Records a line of header information.  The following data is pushed to this method:
   * - Methodology and simulator information
   * - SVT and VIP version information
   * .
   * 
   * @param line Single line of formatted header information
   */
  extern function void record_header_line(string line);

  // ---------------------------------------------------------------------------
  /**
   * Records the timeunits that have been compiled for each package
   * 
   * @param package_name Name of the package for the supplied timeunit value
   * @param timeunit_value Timeunit value for the supplied package name
   */
  extern function void record_package_timeunit(string package_name, string timeunit_value);

  // ---------------------------------------------------------------------------
  /**
   * Stores the debug feature that is enabled through the auto-debug utility
   * 
   * @param inst Instance name that the debug property is associated with
   * @param prop_name Property name being recorded
   * @param prop_val Property value being recorded, expressed as a 1024 bit quantity.
   * @param status Status that indicates whether the feature was succesfully enabled
   */
  extern function void record_debug_property(string inst, string prop_name, bit [1023:0] prop_val, bit status);

  // ---------------------------------------------------------------------------
  /**
   * Records the start time for each phase
   * 
   * @param name Full context for the phase
   */
  extern function void record_phase_start_time(string name);

  // ---------------------------------------------------------------------------
  /** Logs the recorded general header information */
  extern function void log_global_settings();

  // ---------------------------------------------------------------------------
  /** Logs the recorded VIP header information */
  extern function void log_instance_info();

  // ---------------------------------------------------------------------------
  /** Logs the last debug information and closes the file handle */
  extern function void log_phase_times();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * This method can be used in VMM when the main hierarchy has been established and the file handles, etc.,
   * have been propagated, but new log objects are added to the mix. This basically just propagates the settings.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param new_log The log object to be updated.
   */
  extern function void propagate_messaging(string inst_name, string type_name, vmm_log new_log);
`else
  //----------------------------------------------------------------------------
  /**
   * Used to update the reporter messaging to go to a log file based on the debug_opts verbosity settings.
   *
   * @param set_reporter The report object to be updated with the new verbosity.
   */
  extern function void set_messaging(`SVT_XVM(report_object) set_reporter);

  //----------------------------------------------------------------------------
  /**
   * Used to restore reporter messaging to its original verbosity, and to redirect it to the display.
   *
   * @param restore_reporter The report object to be updated.
   * @param restore_verbosity The verbosity which is to be restored.
   */
  extern function void restore_messaging(`SVT_XVM(report_object) restore_reporter, int restore_verbosity);

  //----------------------------------------------------------------------------
  /**
   * Used to track the debug_opts start/end settings and update the messaging as needed.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param track_reporter The report object to be updated at the start and end times.
   * @param original_verbosity Verbosity value saved prior to modification by the auto-debug features.
   * Ignored if the start time has not occurred yet.
   */
  extern function void track_messaging(string inst_name, string type_name, `SVT_XVM(report_object) track_reporter, int original_verbosity);
`endif

  //----------------------------------------------------------------------------
  /**
   * Records various aspects of the VIP in the FSDB as scope attributes
   * 
   * @param inst Hierarchical name to the VIP instance
   * @param if_path Path to the interface instance
   */
  extern function void record_vip_info(string inst, string if_path);

  //----------------------------------------------------------------------------
  /**
   * Function used to add a callback method name or a list of object types to the
   * list of types identified as types whose callbacks should be force saved to
   * fsdb when debug_opts enabled.
   * 
   * @param add_type Callback method name or object type to be force logged
   */
  extern static function void add_force_cb_save_to_fsdb_type(string add_type);

  //----------------------------------------------------------------------------
  /**
   * Function used to see if any of the specified callback method names or object
   * types as callback arguments that have been identified as being needed to be
   * force saved to fsdb when debug_opts enabled.
   * 
   * @param cb_name Callback method name to force logging for
   * @param obj_type Queue of object types to force logging for
   */
  extern static function bit has_force_cb_save_to_fsdb_type(string cb_name, string obj_type[$] = '{});

  //----------------------------------------------------------------------------
  /**
   * Enables callback playback for the supplied callback name.  When playback for
   * a callback is not enabled the get_playback_callback_data_carrier() method will
   * return in zero time with a null reference for the pattern data carrier.
   * 
   * @param cb_name Full path to the callback in question
   */
  extern function void set_is_playback_callback_available(string cb_name);

  //----------------------------------------------------------------------------
  /**
   * Function used to obtain the patten data carrier object associated with a specific
   * callback name.  During playback these values are supplied via the
   * Playback Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   */
  extern function svt_debug_opts_carrier get_playback_callback_data_carrier(string cb_name);

  //----------------------------------------------------------------------------
  /**
   * Task used to push the pattern data carrier associated with a specific callback
   * name to the mailbox.  During playback these are are supplied by the Playback
   * Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   * @param pdc Pattern Data Carrier object associated with the latest callback execution
   */
  extern task put_playback_callback_data_carrier(string cb_name, svt_debug_opts_carrier pdc);

`protected
VKTd7-;2=WKW4#@CX>M8U2.ET,\_>&[&3&c_>:#X&?^-e\U<FXBV7):)9LPN@\ZU
3G3)^]VE&b#D0QGQdQe0G@P3R2SQ+:<V5cLdb^.\I8.C)P=[c6HC>HB?L<.QCJX)
JX30[Y6GF7,e#+T&B7ZDVeM,)eM,RgW8BS^>B_[=GZM]1WGa#,O1#W[f7-8+#/HT
R;)).5IPOK<S)Y-ZJR+Yd.+a;0\5E?5=6F7TfXJf9Tb?M&V_A3Aa+bd<\+2+<Wfb
N8[-cc,AOQbS.$
`endprotected


endclass: svt_debug_opts

`protected
GWO=aP4Y=;b7eg1.5WHZd>Y^G5570^>IE_b1gDVbV1X+8HU@9):/-)4Og7b.^)9#
Sccb9FV(TOGZDM;LWS<eKI14+ZC@.\+0bHCS48&g4Aed3,(37EREbVcHP:/3CL2-
J+)]Z0:bJWafR&I--9aLE13@)3Rg=@XD0/0@:Ac<S\2OF4K/HHMRGCgG_E]bb_9W
EJbO^,+ff>^e6IXRW8+bd/X?a_a#6Bc#>&KcR((+\[&I9)NA:-1^405\_1TDB=DA
e_C#>K24@H)4<W=ZYX;abQ^SZHX_4b>9-FV5;F7/@Q(2c1TG/Y7cA(O#K62P]1E,
PIHG\05ZfM,[W@V8d[RX[T:MTQMV];L8Y3RdYPU?I?ae0,LG:F5ac@W_HWc2PK+>
]5#Z-YLg=-REA&P1Y>Z^YfRJSQb+)+9bZKP+O59RbfA>UEXSLf>Q<DU0U>g45X+9
3^NAV5>S[DbE_d#(34^:EOa0_B1KYJ9#fT]AYgD7E;7#[3GRE8NSJUC#.U6-T;9g
3RAZ]E=_1S3Ya-05AXT[,_5\.,T-(W20/+:1&;,SG1;MfSa\f/AY,-U\>W1cSUfA
YA;LSa&7ba_?]e2\\;4T-,e=66B07J?N8FCM-^0P0fgJLWf35JWXQfaXV4L4b\9)
D8JOcAH16g^HW736UN/7.,bdCbQ?AD?J=]:g^;]/4X^;O,7X#O&)AJ0IHMDIIg9<
A7AH&GeI_#G/KG,Pc#LDKH?Q8-1G6ES/(Z45dOZ+7[?=2[#d7)PB.S-9F)C(_G76
K?d,\VRNV,f<c.<X)>.-S22H3DOB;SKER[NY3Q>Q&/Kc;5)[9Da#c7LFFe71P2L&
PR(YM8MLC/LOd0=)BO&DQY\K:KLE-0cN3aSZ9\Wea1R=/UUAVYVUUV.POg4/e,I@
DM</.>9-L8?#QE(>+R.dX+W775.eQ=;[KB7Ve_AS8)A][^SV1\RNH/T<Nd3VB-9[
KS2LP/80C4#-QL>/B0[&Be&EcLUa\gK1g9g;ITZQRZ=NQIV\Xc=J8FK4NA].JS6T
QPdRc;De?IB)bE4=^I=TdT@/Sb+&VYgDAE-_+>D5gC@YDG;9(1VaKZXT+F8F&\QT
Y@JCYP8,/_g[J@K>OURE1aECd,7;a\1A;Z=#H\V\WJC<3=MU][JU_gMO4[_=g\J7
4WGC-]YX3^M79I^9>T[U9b/;,T=bV9AbN6g&;O9.S55E(GT+-+K]X_:BaGM+Q;F[
NG#b(F3;Y1Y-8^.d@;e7P2&a&fb/L+&(E^dd\>MYS;Q=9@R^dA1_)cBMfMO-=cCc
Q<VRZ^CfF9MPJAGbM][>->IXfGRUb15T@K?(6#gVg^H#;J<&1QKJRALYEdfE5W9Q
]SUgd[eA[)U<&T)LcV2=4ed,K3=bE6U\\.N6..?+ZcYb^ge)9I]8HGA,X<BgHgZ-
P0C)5@AJ:&DPR]_/3I<7B0?K<BXdC]d<d&:Bfbd[bRBI8(W&_eG>2.9I2QSeL-N@
L9;N.X1TG=/de.^0Xf-#];gaY^NK5RZ_D@L&<&X3PbDQ1>4DU?<JHGW,+f9EU<_A
e<cHdG5-K;c[>1(=Vd^>Y]YYMAIK<2.A\X8(7K+D3>Kd[PEeRQL<.HBP(&RIXF9-
/=E2+Ag9T().UZ]/=-,+5)0#5JL7Ra\Oe40fc6I+PgPLYdI7cU9&TcDWF&(Gd@B#
-6@)#@a]d8c[\.R?Aa#=79]QMNS:\VCB/P(]HEg5\)P)T&C(;I>Sf:^&?S]L]97H
X6a+152\a1+EAdg0/\;,T3MGUA/GN&Kd3V[7W8MG)0#3G1204&U2>Tee1Jb4GBW0
Nd/5]TfUDU4<APGJ+@CBeaO22;GP_,AX1C&4_X5&9;fDe,Tb+<P5A\@=2G22&MO(
GAf3<YB_J1C6(e;(OUEN]1JWS53OS0b&DDb73PegEXE33-\>F3R;TcNF3O[5TKJA
>,=S/DR0:(U&=6..gBKU4eZX<+9LT.9?R\,)E@]RK@M-B#=<:GcREI.[>&F\47+c
()VOfS_-45fg#b1Y&fW)P\dD]Qc#=V=SKOMUD-;VLA-c=((gJB37=1ZCDWYU@K)Q
:KVZ#<,#+?T2c4Ve=3c#F]N;Y3G0/<&g+9\:_[+018VOUa1[ZU6\FGWIIE7b/X5d
dgF8@3Q4LN=Jb:/e;[CG+:1\a^R6P6/8N;#E.B9HFU4X^--5_;^I/Kf#+<Z#P(>9
HI#K46<fb=L7W,QXE_MKdJ4/Y?Cc)\\@RfM[0V:9aGg)[@&,X0X#\cEN.INFCc1F
;Tcf1=5L3R?BEDV;J1H]C.O64e:4NO2^H;DH&9880.T:&#P4P?1P/add<?D03G\#
@\(HN-O7V4X+R8<KA2N(0E1;-3.CKN^;4-+dZ7E,GA1@./bOWJ2D1XdfE+E,GU@e
VM+7b_8X([G>XTRQHb-?gO0DB6?<XJdE<M-L3Pa0ZIb7R^LWGR4EMe,T8LG+KR\J
D;-.VUPQNBC^+AX3cQX[R>55UDI2M:,74N3&>Q^e6:e&@L+EFb_\Tf>B1])_BN#C
d@0F,@dT6c=3P<0-SgSR<0K[@JN:R79=,J98?C[SPDJ0<DY[ETCHGJ8KC^SCbR:B
0SGQ?]PF^SQ^YaMKNVL?+C</5g_Y01A2EaS@\]K25gWTaK#3&eI<edQ6(&Sd[[7c
C)YU+9A.LC##P)#]SX>]BM+ZP1:0(5Z(f:2#D)]/T=_2f@8ER<,8g:5MNcef66g4
bZ7[JF]OT/0)R+-_6GS?BSH:)S9?fS<81bV&M84=d,0O@Kf>EEFIAQH80Z(e(Q(_
6=WZ&e6HD)eD7A]gD;#3<UCJG:d+@MCZJ[JI]4<L[\LXcM<2]^HfCKV/a6#F0e<g
])0bW:P:]<E7+KGWRCe>X)?:S^.@+:eDK^f66=5^<QgT=.L3FZ)ZV,2d/DgT[,:5
0RVHZdC&&a8[JDe@L-K_eg=#EZD-F0N09UD-B/?1bfa>?N?]WJaKaT&A,8^U)((S
9g6eX8+44:O4_+SL?+/1+:VfdbTB[&BB+,Cdb@UQQSdeZe)4E-JfCMPBE<;dPcW+
?@T6D6ZFg=3]HN+)Y=?V5=?JR&QI(>B#QN4,(aVL7OA?YX:LVMZ.A6FI+?BMRW8[
&,YJ@;Ta)=5)\+F\/8a&,69@A_6,<J;8ND1(YQ;>-S<9KZO93802YFEUE^^Ig9dB
9#\\?Y0&Y-&L40>\[Y<I8\[@+_YcfWa,CF5e-TM_2Y?QE#-T<d1GC(B#^SX3U.H7
UBOOB,acN]UbN:=W-1\J:LS?B7AW1Me(a9^aASf]A^=BX3_CX1;0IB)7a9OT.Uff
.Z/e0I:DK8IBDSRLfQEJ.PVWJIE>K]E91c+=Z-3(P<GfP+C,XZQ[NKL?.7-eF.ID
86<5HZ.)cWT>IfJDUR]WB]/?IQL#^dI?LF3A-[R1#D850[S2RG?1MQOc4e\;]IK(
B;I;a5-)/g>X3I#SLfYDbA,Z7QHNQZFfNKY>SU>cX4eG48YF22GSG=_7:aHB-J\1
.UHN,6[SN?1@A)/GeZY#YKNNWDg9Q:+S[a\4VH)]-Og4ZLgeL;IW^6:cKg0gM\e)
/Q3&JR-^2D_,+8:Of]T40b&?[A#+R[(cc1^SA2@f9ZGAS,?@+b,g>T]bADbB;4@[
;GDaNJI]<U->d[_9-X5ZOd<\T3:B7O)c#JD3:?d6:[/U#R1W9)5916]B]JOf3DeY
d=^<XX\)9YH8XQFP]V,?COZRcbG,JeI;M3LFK8+QHaL1ZRH<g62fX\Q?#;UGXS,R
9\Ibg4,Y8dUCebZQ4\P+O]#?OH42OHOGEJa.186?0)X7\b?#6aU2#LC[QZ0?7f_H
M&W,[OV\JK\C1g^N_I0P=.Z^VI?7^6VcUbG9.<b\24]@)cbFQ;KcT6#]P3?\7RX4
Y=<\.,EJ_Z8.0PF:2Ig;-)dKW8D>005C<_BY>#<IZ;._?O0)5]27Q6F3CY;1GS+M
c)<bJDU)AZKUPIEgM?[-?T=X(fV0Q_:37UXEPC)-YfE\JI>G]U@b]:>88Z4/EO(/
HeQ1=(ZdbI1:eg6OLaLc(]80g8:c,)_FMO,6D9XP7b.AS1[_1W?CDYa1aOT(QT@6
EQ3FA>M_.DP--+;Y4I-X2KIZ6INCHE6cOXRBPG>\e[H/4B[[&fX,+?TGAXY<A0F2
71THe:E0[2/KESRAYE<#X?M1GH>^6ZV^<N-QFS>J1XNDfeegW[R=f:5e#.Ad1B@U
f7A?O]37dIFW?EaN7d&Y@(cE8&XcAEY_ef1Ef&ZZ;.^-^]Ae=.Rg^0C:f-dc@<@J
cE3R3)1K^#G^I]MLQIJJ=I:CS+FbLZG1/63&16JgFHL^98PHLJa+_Bg&/-FP^d@F
R1#6XN44Y4fHX1>)52-^6&TV6F1W:8.?=^JgOd?HKbFV6;d.Pd[)TY5&C=5TDC;c
X9/>ZYeFUeJ500^bLe<028SJ#U@1427BQD#8cEW\I.BGb0U[:]8XbG13-W41CO;.
XE9WPHe0ZU15MWGFT/4dd_;Wff#&g<bY]6@E2WA(HUA64-BMJ#U#.2WHdgb:&?K7
^MEgW@g\.VX+[W>X]e3TcW&NT<NPSLZ(RcJZ1KE02aI1F1.24^+#AM7^@QTJXP#6
GJ^O8/SK-Z9g#;GA?8PF2LT)[gfc.d:]Y2#VT,+7>JI1C7]d-bdc1f0]M<^(=HJQ
J9_1g@6;U,_e/8N_3E3GX&H&bATTT;Eb)ef1:X5XY-Z_@:=IJ[&SJ#;SA9@_Z=A@
?J1F6P=[b\#,aZPF]C7S6LM+S[#9#+<-IU#3&E\-=?;@M@,HCRMff/XCN+dIO@8:
EaI@a=A&@2_(f)d1GQIc[ggef^PIBaW+U;C?C],-g#0<9ZCT+AX?LB^DZ8@&#1/Z
@eTZM4Df/=2WL3NK@c7Y3&,0.^0+D=If,JM?a+(Df4HQGFMT<7)>HQb5acI#J2UT
L21>UGF8b\.SHeebA0J]V<JK@#Ve10L4S4TQ9;.G=D8WGc/=AGWX@=0OI/_.G@,S
WaO+7N<a@bdMcgRZG<2(P,&I9(JN\&XR&R3c\);<AJ-(/R,W?7EfRbW;.VCb&TdD
M>F-g\O<)^/CCRB--PY\WM]f1,&d+::aHDO>CZ5a1a7(eFZVQ>(C0[[c0W>9X0<N
Vg-\Y3&?O]TMQa?:^AV407A?&BCcQU;1:c#N,U>\R8ELPZeRF3#fdPIQd->6ROdU
]17f6J(?,=N8Y7VIX\#<]\LCAW_@cUMDc/@HM(f69dIL-H9Bb;N/.]S75g<TfgH.
fWMeN)3Ad+91E8=-O?=>=J2fc0G)TeLSEX<?5dY^2O@(/J)=#&\FSJdODQJ)?^KL
=)Fd>^IG@MNK25)ZW0L)M:P\KYE3ATJRe[^H3NMMTITAC^eZV0.4O#cc1?ED\O2R
2E-)(1CEJKXeWOeZIM5+@c,GH\,JMP^TYg:JZ\C1.N=:)C/RAI]GTHXC-)H+>f61
K76\H,Y+?O^[J(4FQ;dIBT3^#@4K?O5CU9ECV]>fc#eS\T[Q]=1T6I(L^U7#bcT<
U5Z09C,S\WffR75D-4f?;G)@F).M2VI0PD88G&,(VTe<f1;9QLJ\RD_@Gc=fcCg6
1L-bD=PK@M.WMI#8C4TUf=M\OG1G^22EP@W^IW6<K/@+):LW7Ib@-EN;TSB9#,^_
]V^]E9E_H(G@M)RT&)a.#V=7,9ME)]0)T530=(ICMNRHR5(QS(IQN6WU4SfAS8/f
dd,eUE>#QV^QBK0I6HN.J1<].eF3X;:,],_9J]96,Ud^/2KI>&^:J)cEG]8aA_3;
-L3]F^#(;a6acba@e(^AGYCbe-[F<L90>Tc<_2897eOY#Z@\5H\T9&?c^IR;\a9b
BIE+e_&#fbeJJ6Y<#E(.:[MX8PfX-BN@<,32SaN:,&R9(9.7(6Wd]b,c7Q,5A2H+
/8U_ZQZ9V>GVB2TJc9_>:&18A<<BP5:gCeAG:P:[YK[a.4B#-T:7T.A3cKD^NK-\
2NWBQ^+X(+1QHf3KVf@CWAP/NN2?1#+9>&C2G/5dJ.&b--?FgVT^/=(PF^/)B943
X:_1&ZdF5@eR/Gf>W\443gUP<//V>g?AD+b\UbOe+Hg?NJ+/f#7J/G5APIOCE\B;
LSc9FTYZ>,MV=e1S.H<c8P,aWQ.e:3Y(.K5-A1<7O]VJJN\IP&?+6b\gFVRE4YaK
#7?Vd8SeQYbJ(71AUNFDJ8d(cNb(YJT80WeO/=T?YBH/RGgX)XQB3dHS<EAGb;.Z
2+^;J(M[Z/\7PTH6S2A4R3f5fYC0:;=3a4Q6>]@_/.NaYUYP0>#4W66(ROZR9RV.
XWMZfAO#^Z]OL&1.3DOa+[S0HVB1&IJ1K&7=:J7Z:cTW82.:=>S/-JSZd(a4Ga&8
B@DT;BRgO6N0CO5&eCSNfF(&Z^M\5V-LZgF\41(A-O+G2#U,+VUD85]\b8/AY=cS
CLEHdV5SZJ+gC<b>Je@+1J[#6>>U1V05KSIGF6^]Uf<[D-#eESK>JdGHO,+4;0P<
K2[8bHUcNaZ&T;)0aH8QK\(a(1a2^R(L@JBb+W--?O?N_RfE,SYY?Z24K9Y83#\0
<PJJDO\(JV=Z:AOYS+,AD(]02H^;+_69JWKAaf]>[_7Wf=[+4+PGe5L&TQe-TZTY
V9.+Od31]3<^2_-+-C:e/S+3cL38IH^R(B/W\2(g/315c#L(;4HZZG/Q+cI8@ED1
@2HP#eC,BFb,[Q0/?=^3DM@F>3&\=?CH+a:HC:K7/[.J.&<(M&&3YSC?Z6,AIa-S
)DKD2fS@H75F^dC4DAI[Q8Z:I,bGEU>1>BM>g7M0?E<V@(05)efCG#DaK54-.S45
R360a]O^R&]M-55&[M1G\g;51^[RD2@,8(A@gFHd/]U-X3?(&g1cAg\QC03GL316
8=2KN/TGA3YS)SFZ,Fb^UTWO(0;NELW4R4GXWPQQ:I/<]fb^&WEbRH-:2R<VQB<e
CM-C^A6]O(Y<S:BR6Zc6PLObg/Vb25L.8I=Q_R;L.P-._c#]591X7QJ.fWa0V4&)
:E3G1@4VBGeagO2KJK[1PX1,8(I_W8M<+Ka4+YgXO81(+1._edT:7R0K2V<cV;LT
cI3KWNRB[UJ=eTC(Ha9H-4N;9#FU9)Gaa#XG)ge8FI#917>&Q/5+Z.R.V]?S8KZT
WddE(5,U+Ee.;@Zfg2D_Re>YKGF]X_NM5E?d873/ZNCRg/^c(,8[K]?//V/OUXe5
TY9cWN_A3Y:=Y@P,>H<N/fC9U-^OE:4I[,9.f8)0[?BDOP.U):U_AVSF5JJ#E88U
7A\&LL459e-?J)ag/4_SS[1)4([T>7gd-9X54g?9QaS6BX)2L;DMXb@66N.S1eN5
+&SWHXHRE2V1N5)DWLNB+BKCJH9?_#CCN\9SeT)HCU#fW32]#147H9K^3F_WR]dN
b+?1f6QEN#cX\Y3Yg^M97Q5<;=?W3UHO#813W.FLNN)b(;MKEBd)5CV8=HQ4)+Lf
Q_;HJUK6OFCU=KF\-ACN4:=).D:RQ=T[(NOeeB<_8GG7Dg(KEQ\Yf5F[3&U;OZb<
d-/c\0,.,AIcf30dO]J=VHYd#e(:5BPB&,<eHZDS:3_(C24C4JgD:#R8B,@W=>;2
O5X<Q4HT&L;4G<PPa+b,=3+Vb(PGNMeb):<]W:e20MVc#6BO-_?fT6Dc#1.:0Bf9
[a)H3>[?=Yb+>GKX4d;2)J;=9NQ6P.W#_0gZZ<M0PX.=94;g>@(LWGJAD?[WMQ+^
:8dJ\CH^gd5=(e(d1;:^=ER/g9M9@195A/]Pae)KWG+:HA-4WF[)YWbE,43_E201
5E=YCIJ-B>C.VQMUR:2B-W.US-F>a+g2=W2\^^G5[R-_C)+eJ+,@=D/-WBD#O[4]
S3c2G[LC;Z^.Q:<#_^(8<98(b89,e204SVb@Y5@Y/cFgWBA\NbW#Xg9,fNSHCNE3
e?VXVQ6/R^.K<;d&I88831)EKY,2S4F>gPJ/-_QLY.5?8_-66O4C5McETRCEgWGN
A;d;,1WYMg;;c[;M:B^1JX4_?)fC;22PSVA:/+_^b#.7#4C6RHY49cJ2/NaHJ<62
CH&A=e;G78;^1>PLbN4e>8^6df_A=EO0L34+W3F3MM,7;[4OJ\7H+g<392WF_RaV
=29IMd>H>D>QRK.-d-;2AJ>DYW1L]-;,M&egFU5KQ73S745\NJZFB488:7;>41.Y
>=;Q1ac2W]/+0[d&.:L7P=gFX20_A0E:62=e3e\_VHDDIUB[f2(]N=Q;6Ia7)Kc_
QL&g45J9,382/=RQQ9J>)e++aAV-H.(UVRO-0T)>MV)MAJa7Cc/7M633=^g<QB3\
N>E-+d<F;H7c6)B1\e<:<(L5.A).N(g8RM)K&eORJCgL[U)(_e#BQ71S=+B\F?UQ
;TNGVVER#EQAZ4E(]:;5T1>;:;2\L5?6Ca^Lf1^/FRK?KQ-,FReE1.E0&<PI/g_e
)_aU]28Y\&Wf#+R6)UbLU^E#MA-&078T4fZQ:BB[]X+_)LAMbPdS^)8=^IENBE,a
CT8S_VBf#B4f_-/_d1/e:)@f\9#7.CG:3b-R9UXWAF8Y35V?D8UAA3AQNL4T-QK_
LfLO]MKXT00a+06N6Y3OG19;=,50C(4KDUS33Sd_^WPGTA4UI+/\(3\9eAC4b:T2
c]Yf30:E+2/8-FII(RO/LN)&Z:AZbNSIf0fVJR<-KNYL#L8Q;]2Pbg>L#/6Ob&+\
-W=I(aeLHdY;.N3Qf,7+C\ZdY&1P\N(3;gUUQ8(8?:@bY=dDMLOL9g[FIcWO4&I&
0,BN)R55e1#O2:#M1B++dH_2J(a?ACVLVe&MLLZO[eF)\=8Sb(H_TQL1<[-Y(=L_
T,d^=^Sef9<SH55/IeOIQK^\gW.O3T?BK.Id0Hf9B0g(:5K?+R>S<G/Ie=RZ_ZM7
?TJeZB#-We7BadF;.fCcJO..E4T:_eX&dRCIP[JEM\,FcB=:0D8aWHGVCeZD1TTM
;FZ;K7\2_3@E2W6QC?JJ;4383))(Be+dJ3NJ9bVTc]V^[-]NQ9P5[ZZ)_eWG>5@f
Id:FBaY-VE9Ee5f\G7V2YE)I=3GY8e-K0CUNb3R^U]?g7LBB\f^B-?NX2_=29b_J
3dVdF23CP&I2RTV#Xag358aSYJYKM9R=W#6).Q>H8B+^F,=Ua(\5PD+A3Z>IB2aE
=bDVb@5FM6U_@If?(08TQ12[>8&a8Q)\>.<Ne9f8V[/_:4H4CcZFKYfU)52O3KR-
G)&FL;OR>NZ#\LbaNbeK7bH_GV8K&#FHKU=C6]51V7RXRXVFN51a99Q\#_edA@_g
gWAg(CbgdEPfNff12[]\g3B=N1DaTT6?27&8&2N?SK][0L48R0,^N&M\8:#Z3^1A
,ZNL?1L=M9Dg@EH#[#H(gWN7YJ4VZU(6GX,JR\X@7R+CLJ(TGRG28d3B:S3S:>CN
H;]-^KPZ9Lb]85NA4T.;TM-Y[/1:A=8X/(M=D\)-eTN+VX?6ad-=]gWaVGg\ZY97
FOUZ0=dWeKe:LO8#aL?OeB#G]2-#UARAQ8/MF710YB5bK]UTAg0aZAESD0OA3YGf
0U:1)=#RP<?+T7/JQ]HM=6AIKbW<?#O\(B/J\5g/T1+g4ZBe[<13?#GRG/<b&9L&
e]FZ7-W._e<(;@Kd8[5a2X;4F<fYG8)H+cV00:(H324\:a,G@]O)B7W/;??U_@XM
6g?T+Ta-XW0<GPCD]5LbC-5V@-DFCaROZH7_5[d,448UMM6S=1gJ0cdVE&2:Z4?C
A&:?5RfNYS)B[N54KFgA5:#TKRJC-Q(7f)9ga6W(SX_Ud\-E-NCHARALZQd(:Fgc
FQgJ].U@4]N9^__VDI/)=WX3a4XYd]Xf0M2:B;KE5If2U]NK@fI1P(g)1=ITfWJZ
:gSU1Gb4QI6609IRf/gA;U3A;[>41V2K7V>2>TF3C#DV[T_+B2#3C-APN<\6GH4I
B3.FY&;9C)U:eZ]V&-<bPecPU-0=eM7:>W1+dgJg&e]8V(SI3VFWN\_5IgMTGD:M
f/2WMM?4Sb[fGJRXD:;SB[c)SZEP:#/J]EaY#C_[OXXP]823cTHdE=QMI5BUD5@(
#KPR\cfgMQbgXb5D1Ga/DbTcI6d[eD-g]C90:4JGBI;-,5?=QVMJbXEe^M0W2A6\
XZV5eS=2K=4SS[D)fP)W:a8eA5+?<1d-UgOHd7VM9]8C@-NRBT(LS<,=S.cdF3gK
01C=?aU^Oc>J]-RdeG7Z&fIW?.,ec7;]FQ.9&O<7^ba#HW:\5T-]FR(<C;.W](TA
CMI2_RCX1:Gf6RDYGX>#F<K8V;TC(a\QM.EA/ZUJP;M]RBAXJY&0e+3]ef\CS?>_
V7YF;dR2Q_;M-N\BEbEd02Ka[]1Ue?^;6[-^1+)#f4FMLeeXF2Qed2XNfW(_]0fZ
<+;B,X[58Z26YZK2gF64dW8[BK7UR]A4]A956=_W(R8Db?c\0D1N0Q1M@,g7J\\X
M8H:B3\6ZbG15EX)#]9>CNR?d0B)]AAag;^0BSS1>BgT4O<9=LS58>A@UFCM[+E(
LWOP9:?4U?N_N#OUWZPGTR27VI,/g7CPIDGY?@1NQ.VB\[6]9,d)3LS>HaU^/=.c
@[H#WJWD;0F[feUd>Hba-OWT[.W2P#1(De6]_U.K0VNMQa0GcSEg_R)))]aVU1:(
]SXcH)WXJY:H(#SMK2FAZ\f&>DH8\5Xg]:fMA/TKeVJ///OIfZ)K/=G9+=NF[6FT
1NR4-74TW)C57aW7K<X4E4>^O@g>P+aPb=aDacT([FNCDBO7\\cLH)feJ>NOV@39
ZdNO7,R4&^:GgYeKd3XT[0MV#>L@[Mc9O(LbMX;aPJd@/O^7&O?@8@d>SK#a>;RN
4f_]1ceT<>IJV>K/1B,K6Id-0X5^I9D3K6bEaZINf3(M98<MW>2=XA&55>;0Te#G
TCQK5M/+)&1K6MZ5<)0V9K+9UR<C?;PbRd1QcG>]YX>3H@1C-.UF;8PO[V0(\9L-
3OR,0,[\IU/[b1R<,gR@?1GRC5[YS2Jc1G#]Y34K_?M4M^bD+4W[LCYSQ0CeQT(^
E09^Z>]SUVN8-f_IPf86-BW((;R=Q9ELEe=8\X2VQF6LF?UE_#:HdGN7?Q#A:?HE
B[Eb[B31NG9#d;L]/FbRU-&g#WKQ.1f@P?T7_/OXYC9V>V\2)g@:;eFce=deX(aD
M:BXMA8YUbU[A?OYEK:I.6\ZTN\?FP7W?=]#2WN^SQB>a-R9>LeJDCE?K8:YIQ)V
;_7eaLf?YFg#2C6,W>M[2\/_@VO0LLf-R2>+.U(dQ_H7H;^1[>PO[K0&S+EeM)/J
3(9Md;C;0e0Q;Jc_fX].<3G(ELC\f[S?RCS(3?RNVW<#:N]aQ.eE[a/d-EPVE>dK
45P;/L@(J-#5d=gNDf=G8Y]AI0KC_Z8U57:3K/W-&H/(QS0HYf^/N&gf9Z#7=cH/
(#@eN92K;Y66K@XGD<H^:18MaRF>05O(_/QZ-)O4Y(B=76J7;6[E29N0S,^:IOC#
d8L=W_UV#D(Z/2C#PcV?L:gRIO;G9HB#&=1BT.A\KRSF.8_>3>CB4F#aE:.UX]X>
@.Rb5\=#dcd>VaI90_dR<(]@FCM?A;Te=</6\@bP.KS,V3TAK=CBEDS\1OGN+;Ke
b6=E&J?8P-(GC:=\A=SB5[A;5ECIPg[+8RZ&EWCF+O[2&YK1ad)Y@<b45.ETTI25
JD.Z:^&-,_2dDFA#/\Vg#OZB[,5;=cSgNd8+\=;L6@aTUBDYCGaXT7D^?8XHS^+Y
OBD^GB9ZN&_ZbB(GZ@]?A18#Y,1,<(Fg1S@:+5aT//B\Z<:I(7T?A5+JaNBI(B^5
M61e:a;24b^cZ@6dUZQ:L/;0P&JId)9V34.:QP^(9><#@b1(3S=bAWKG<@MbN,UC
IJ<DM>Q638JSH#[Q5=DCVP-.WB(,[><#AA66c_(Cd8=F.MQ=-6)g9/L^U93>Tea0
2f2XSI.+L8+;RNGacfXUOWKLNSWOYT8b72IN^FG8\I9#]\Ig(#I__]U0/I5MF<6^
,^(-=.7\g3OIIJB<C==_YWR^3-Y7.T>GA&@1FD#;65/GSDS<d2/5a5GebdI,/)BU
@\11I,?:8BKM[fPfGLH9g&J^G0cE,^,YH)b[Y7(LMC8/Te(X:[CMeR136M87W5TM
A:c4>HC#;C[G\])5:K1Z]+Pb(cUQ0+M60TGP8#_H,T_,)U3&0,]JaeH9Tf)V>/LA
)I2NKOL+L0g<^J3a))Ud_R<[BUINWK(R1P1+F;f>e@]Q9aZbIcX8(@_P41A67-.2
&+WB5T;I9;>K#772\6f@(.O?@7e_]@_e2:,\d6N.J5X=MM=#S74P(H.V2IY#6M5+
9YS1b-PQP5W<2cYM9f[cK@G&X:U;Lbf)<;cf+4KI:^3c+f\9EN-WTd1Keb4>^<@<
<bTM_U3BUWPJ/9YSF.[^S(BY24b(QQ^?U;<^#B/Y.S?8;D,f\Y]/UY8\W:?gKc6F
=\A<.#98+^>6J/IA0ORc3IZ-)ZY?//8=]<d^S#9V,eZ_]e[/^+4@M:a&Yb<da>(4
AHFDJ4Z;^/[+eW[HI@P:Td+d,c9F;EUEWQ&-(Mc1dWX^#6fWA8N1+.ZI5V<:UC&6
T2H0gD&U>JS@WUZP-G2M&L05-VJT>U<]==cc0Z,eA9?36H\=.f-F,NcX4)MG)FDX
U0BaA<R8(X024D?cK.8Xc@>20LaIW-Of)b@[bG,S36=[Vg[JfN+>-E>3+6\7B_#U
JYN3#8-MVI.LN-a]E+IYX5(R4eIQVLSLO^[?8^ZK7-]B/D/5\865@C4CO#?QF3d_
We0MVe_]Y??UUdg=BUbfA1_<d0?)[KQFZ/_S7FP1GP-D+DBg[+G;F(0)UBAH:5X5
>^SIS&T5[_Q^?-WZM^+dSMBFPg0((H+R53(a4I0f[9C6\S]g.d+&_N;GBA:-U7;2
1C1R:Q(ea<)e-fRB:dGDb4a[FK3YJ-F;=XTgJ];^DW<c:Ga&9XM,KX6d5VMW+J[d
LBNHYB>Lf,JD0FCMO7<d>L7(7#RU,d1JPI5b1L=>e\e2ZK^QPBN9Z<\CE?dR4aRJ
@S5+b+G57#Y?EL/51Cdf@gT_4^E>Yf&JL9L@gf\3;TX8N,4=>fNQHLTOS[TaV[-g
_0SZ,53X0\#Q7:If@329IBUc2@6G;U;>KY>]=/@WB[0Bd1@06U#Q2R5H3-8N6fQS
Obc=_a6#U]_OU0G\.aO](VH#C2]CL8FBg+,c,RD(,Eab#Q[F)#BV9>E7JTMZH2M;
Z.3U<#[.;J^e7J]SDNC.<ae.VX&YE9HU4U(7Q.C^2)=?eZ\Z25<0FNNRM(M7f]3d
e&[-5[_D\LG/4+V[&eG]Z_SL:O0A=TF)HfJ.(g->QfXK=Gb:eL^(PCXeYW+VR2\Y
BcV3=+-6e).0LDT468OX;+^>R:6,-S;7)<&M18,523bI/3IfTDNJ4:H^SW=d4_eN
-,=J0/(.ZSe;TaIcGIJ&H4(0_d@a26H^Sc^N4+D5W^,Y&;a+)51?e_:\#RPSI]7L
7/0P+9IY^[ZD+3^1C69a&)D\N2A@LVF+P0B2:JL3QJ=QW>1>8<?f-8L4#1Ve0?EE
23)I,IfK)BRgYLF5B]\YO7&1U8d:(HXfBb+DNT8TQLL2(_Z_.NZTZZ,PF<#FD0a4
Z)FED-]4KEZ?e&XX(YE#5/;+(##U4(P,=BXGQYZG?gR97d?0#442MeN4^RH_WHb9
XdeB<2;1EB28XSTU+[g=7#T_1_WE-W_MZ3MHS&</QH6]NB/g=K\M9DAf&Z2R,;4S
a:fUP>KacdZT)9KS5<^WEPKOKQ4[)NG3d97(HAVP>M5>/?4bdf=.eJ6gA_?4TTaM
BK62\:Yeb2gU_3,V-FfQ50&ac3C5Y+(;:f]Q;QL11)/:E/N(>KLf\6R&4QHMa#@I
[@+KX:-MWACaN)cCN(IeZEB@;B?#4=Q79/11YYYXD(Q57<0,ffg9;B7Pd1[,/X[(
QTd\8O9/;BcR?&#&P]2./ZNJQXK2d\=QN^)_6#N;<E<+X5L;OO6<(7_]M2?:N0TV
Ze)YcAWc-H&YacPU0FbAX@f\K;ddZV83_2JK[1b:&&5T=-AJE:@4GN&Z.:A;3=&a
NZ(aV5R;8YZBN)_fb20_V)J76>,YF5bY2O89b7BOH<695P8-G1&=:Ba-,EJ:_@VH
#)<&G)3McL+EQUPd/5Gg?@)@PM@#PYJf4f/TWYf8HB/Ub\P\K&=dQ8DbST^K9T1E
D6QFUY2J2aD,#?(/VPL8Se@->:H@6Jf^PYf<W817@7Y#(BYc@^dA[/O+H>A?/@?f
2E2geEgT)P:_A?TCW.PbHaR9b4/KHD-H^A]J#cA2#1eB\bY2<bG/\GgS>=<9HBg;
=I4(/T6cN#(G_T=:SYb&ZO^(+R[COL],R[9LXW^b?[I+>2VaPM<?9gcDTOQ)^+<T
S3=S4[Yd&NQI#L4Q5^C;Ge&KH_5-20PS7E2)T9P72.NX1>]OD@B1MX[<[7cAF,<U
J.dcJMFB;MdA9(7)US\JM#>)fF(:;#3@&JZNa]Lf<V5S9BeP[M\g\])Dd@Q>0[KK
SVb+9_52RgOQK=R9#Tf9G#54R8];=8@HK0NgMLTP.7;M(Pf,=&K0FEI(-_ZT#RS\
N&1&0^BOD]8,R^Hg/R=P[EQC?A1cP<B7+(Yc=.Z=(VAJb,4I>;:][IDb_d0Xe#1I
b@BSe3-:@Jc\f6_;gC+5EXEN:LUG3gF4L/O;B^:^AbS8[#Q&aL=U[OIM.+1ZB1DZ
-K^f=J;(I?#2ecRRMc)V46^G>[?7_Lfae<AR];]3AJQ@>6?^4@bYX_1B7F;88/?/
CH+U09&D3O2#L_]^XO/?>5-c.G[7ecV^0IPN5@VY]<27MUA1S=C>5MW(]RMeJBYY
g;EL\,IL54CT=WO4C-2LAILCCU0+9>AB]&[baX9\A>7>#FKMZ<_,>>^0?ZJ#/_XR
H2_CO[>#eO/J8IBX8>4g1_U:AWB:72]R:g?gD8e-fP<+@+O87If@A3[EP0e;MCG4
f>VfBQL-X@[W-3GfYT&6Z>MP&M=^JNXRCF-Z3T>3WF@g^6+GWMH.Y5AE(:SUY6d.
XXNdFdGX^CcgA]0bEX)e8A_2L0+0,\GVW1PZKIQ+2VPMAX.Oe_17e8:FY\Y40LP,
GOS[)E0a>2XHf^?Udb^QBJ-GDT,EO]7BLDHHTF]R7;.b+C^XV./:U4C?FaebJMM)
ZPL;94E77#ZDLL_XRb+&1ANG5KKW?0cL78Z<c?QK_9^&^2V<QV59BO(fa2c3[\P_
d,a=#[eXZEg<?ZB)[16HH#KV)\U2FgHeY^YX&:I]7&2O#aJAE2D-Q^d[bGA#2LDW
fa(@CRaZ71ac)bZU,X/FSXW?U/W2a)20P@fa36AfcKDQ(Ee/I5<W)9,SFSf/=36(
<-7bVf,(NC4(NNEE-CS2?X_;?I=4dfc:#?1.:I^70>_<#O[OJa.[7Z<,FF;GK:I[
UN1A7NE(>3L:9#A2:#7US1V-9+;G7LW6RDMW8<T.gWbSNZP\[\Q#?[/&F4UE<S:a
a]J/Y.5S]><D59B6;T1L+5JXEe9Jd)B?I\EN4JWHUT=/\54OgP]1Q0,,2LDV)b^Q
S6Bc6eCE_d_Yb_,QT,1R-S9U)]K?UE,,89/f_RO.V;TUK+)b+7eH7M<_+>65/?^b
=Ref->R#NM>[cDb/F.IO0XV>3+YcXU5UPIDS:]\9><WTI\0E9CfJO01W)ZJ9BdN[
0(aQTJK&>B9)&<DURX.6X?0K&bW,-._GJ-P1DdSdPL+eVW=&1e6F(U1c)Lf:-a--
2VR)1ZXH2@8=T0^N1G@W,R?-cWXYFHA[^GeeM6?[d>)56/)8O;A[7X3I845&;@\T
\IN#?g)TYQ.IaIDXP+G+/N_G&8[12WgVV#XAI.UF??+Q=:9>a;##A<E@+5D6W=L[
[e(2I&^(:FWX_P<E0-/FX_=Z2:EF/1S+ZH69-]We8EdW7HOQCG_PJ</g-f_;g<KD
VA^H(bU3;ZHJJb5A2Da];gKGZA2UOEIO2H8d4;6-C5F/(93:ba_,5+,FI&82agJ7
^aU=&\=JO4&&0YZFLX@9XA@Y]9@GcIKO[?&c#dZ2L7WB7730a15;+3<\URL;g_5^
A4ZY[I-cacVD=OWD++OMG9(fV=6ZaA1?HCNRUG(R.JG&?EUEJ0CJ^bc7CeVcdO[U
[\+(C[F:08TKdb+FQY+:eHR&YX8:cV@.F#0cMQWVK-KbKBX36UY49M9PeI49(;=B
PdTWBJb[3a0SSf)F&&?a#L:#eI@6f3F5@7?QM=1H8S/GB3<eg+I-N&(G/:<U&S<F
e@32PZg),>gHa161^Y?ID<DcJ:L2^;S@dW4(/ebbZ_FF2J7\D/VGRPV;:Z9F5a9A
f()FF_XS7]C>,WBNg0N_@bE)-YKBT+Z_K+VD@XD<eR7AZA]#9^5@HNbNgECdg0RD
D881L5Kd@HQ7)>/=W[1b.f;b(9PQ1A^B14.gaaF0)a[ONe1:7\BB>dSZEPa8Af5V
Z3g(MB<>W?I:7:MDL]XgcO)LOQSE4/PAF+<VC(-G7XZPC1W_A@eOg5J:A(Y^@5F9
.fS7UOZ8La>0Z9/GB8RWO_Z-4S.XeFUHbfZ:&H\:@K&ZF2E+dUS=KB]a)XB\?+_C
L/V8X6S:X?OFfXf0/@;CKU:M@S>@U02fW<(8AOFD\KP=-.W\c;J>U(2HG,76^NWB
VU3C<Kd-KKLD[316eMB-\Kb:FZW:?Tg6\L+f&4ZK5&WY]2PXBBX.L)IT5@T6G33)
L6gYSc=M#DS3X:2OGMY[B<+#PCFA;c0NUYeODKQ7NON74ZYSY^JBSZ0f;0KI6Re>
3R,JA\;79B)LY,gP?[@[\#S[^_#ca/EcQf>SdL,g]?=Me0@28W<d1LB]\fSF9ILJ
G\&>Y=7)_g@=ff#-?g4N]\S6=NNU=d2/4ee&1GEa9#cI4?0-0/#PP2:e-L[(Nd-G
CX6=VTLOXAA1bR(K+0-Y(UJ1DMTW/3eUB>=_11QDT&DaT/3KY(g>K;NJJ=M=-QJ5
^4agdO&),J])#-e@YL&K76</8+^/5CE\f(cL;Xg_^2YUa;G>O-OP2=QY5ZER..P<
/U<B\^.<#a,NH#;[DK.6W+d)YJd#B6Y\:f2OWCJ__M8ERM+2^T<JM>H422@L0;ZJ
(Z+bDT[f]@dT>S[@A^7+,gUA7NZ9PO.-a4;d,\SM#8f1dggg6OR5,F0)5ONQPB]c
-@,R2/d7NR-TF2XBG3b]JSgPQfP+8.9ZJ(=.W@>T\[IO;Mg6QP?]LNQ(dVHaeN3Z
SP1M[OY3_P#=d^TUJ4Y?E<\]\COJFP@CO3HaGZ;OI=,.O,JC5JW)\NY^C7.g/5aP
6Z1SYZ)\e&I,X,.>G?@g3K-T2M+P@EHM#4)(>Z38LNHZ>M(A&[7??1FMF8ONM[##
Q99(+X4W_MOO\S)^0?MJHT-,/cO1M2cT9.9^=<eL.^6D2Z.D62&;\)X-FH6O2J5M
.ePce&F@#=<6_#.N9][AbTL8&4O)R1A8H6O^9<gX;Y3^SWA91.<G3-Kg0+R=@)RX
WQ1JHGa;PWAJFa,#d0f;D9#QXOVI?S\d^2]AS16X\;RNcBRML>PW,2>]1PSH5Ia1
dWQ_C4,-3bXHe#B?:(DXXTeb/QF@L&[:2c&?FaNPIRLdDLa\]A=2eb\UgbCcB1,f
R8fU[H>DA:0IE0Q]S.VX]68N(,]9\Z.GS+@-N6QYCX;<N_BY85+dNaReee@f[dM.
^gTV/MHc2[7Y5=gN)-EV6WG1H/[R2@=.REJ4;4#BFI9MfQM4M5)OL5E</LU4H[#.
S;LU,/afLTQ-KQ2E.0Ag,)eD+0+9^C?<+->XF9D&J2=E,2SD3?DYb8T7La79^8V(
a>2e,b]c?.+/b+BA]TaZ>W?]#fKW>?-FCBHV\5AT#[L6.7NIMI.OcZ]_@]MX\Tg-
EK-IQZHZV\4&W-<=0)Og7bWK.YRB@8[SRPdPE8C?:6(B1[0I48:1P3C.=MS+=_Fa
R;578f@AB3HBT;1LU:.#)/H&=,cS__7X-MK8M:IH#C-A2S7?@a0?fVFE@KGA7T0G
VZ]0WeATS:D]\[YMRUfd4@:0(EL=M-?&.eM_SI8-1<;6][-S.N&@<[R-gA0(=A&e
=\(H<,Gg5LD(FHfN(@T@7<g:T/BcCKEPdZ<PXg9Wdb:KJD8J1@:/WGE^H+S40EC@
dH8#J;Q:6Z9f(A)b]5,L&-RZ+V,N?b@PB5Q3P9XRe+e\E7Sgaa5g64-bCJ\<54KZ
N6ZUR8TMZ4/M.Y4>B#0RWAeB)OH5^_^[/b]Wg@-Y?I]RWf&R^<.E-U@U<M7(D\Pa
&&-);H>&UKg53@(-])22HXf=BPG64a=,f/81HJI071_A>gdJHf06-N/f/HAZZMRS
Rg\0#ec]U(/Gb3EKIa&[-[@D1I+MX(b?[EBZa_)@YX=gT47Y#8IbN_HS9:06KHQ-
VW[(_]RFfHQ,N7JG]X^,cQF<N#@>Va(KU7b)&&:8SALd<9b;<0P9X9H[0N>]Je<N
;0fKYb9/)32DFeRSGNd<6IE0P@HAQ3O>(BRU6/+1T:_7PB&UX6\</;:I<._/0QJE
>X8@Fe[20+;P6-d9.C,X@9@OW[=2MCRQ8YSCFc:g>2X1>Ae-NGQa5eVLI1T]Y/J.
/BR>\T_9.fb_DJ_\]&dSJ.5N.V)a;2dJ19gN7T\]PQ5G22<KcV[M1TCR?1gX&]]X
V_-Ld]1)?Y_,A\PHKFH:#YJ:U8RCNG/d:R(+aL]e#/U6WD6D)#>HI#c\dfWQF^ES
3fFG4b=X1MQFZJ&O/2J+\0Y>0Nf)\9UURcUfB[4&Q0MVJBB#M)OB_^PfWd&=d3]:
1&5+/JJYS=5>G&f1\&:5)<0@eV=Db=TD9TCLIIY.e96&-7D]a)6a=B(+e2@ge9YU
L]a<I8@dIYg[8C+U86?B;5V63-U.Qa>FB.K.]#>MBP]FMZ;fK18@;7&NVIb7NU[@
>61_c7,bQU33@#)d35=6KD#NF/)&Z8UXXP4[1IYPJJB@Dg7@>-STXKH@/YBH3g7=
[P[3&Y:0?L9d?c<T+Oba_&9)M29RXPZF>.NgDOLL@g.c,YTK.>_(OX/4_C(:8J_F
BLH)RCJ;6D^MPDD[)LX1eJC>fW__bCa-[MJ/1I^#_dbM9)c\Hf+.Cg:@Z<4SRX;3
YT[P)cFH/1_?NZfWKF&&P-F)];K,I4MgbG>f\L>BYJD,bZK#XN-\S4,@V@]AgNC9
H0&Q6]ZbeJ79/G_5QbU8Y0VV\9]e91FP^6;RSR[GU?-#KFA#ggG(ZOAA2MP@[>ME
.3>([8XeP(&C:5a:H,gS#A+T8GWBZJ)#g)AEEa_89a^(=SFfc1Og.V?F5AcBL7(6
J\V)CZRHQYUgc>/\3=\O6B-,Y<Yg0UDLNPCg(@;_Ta5ENGGLQ8#A21GKg52)R1aK
;?&^MMN&RXF8O3M&L]\N@6[[:9IS=g^<\N(YE\&^DXc:XS6WL,FRM0d/VZ44.LLC
.>+QfECA]1201H#RC.UT17B@OO@2JKKECBC#WLeZBa1BB&1(X3E\#KG3-dA<9[+L
Hf[dT(X9bdM:E;8@BPQLLOP^;cg;+Q5(P>X]+a5I]C&14312G]JYd3P011SdQga5
[TG:./b#&Q12a8J/(MIHADGP=?D_O@@\7E^SMY-b+<JWU[:\B5a1)0X0WY^#b=6H
gI&7(WJVWCITB:fLL?\7&VZaSZ8M289c2O);S(aLA_Ga?Of7Z/NY,0+6WO)6_9B^
eBFD9(76SQL)a4=1XB;JA>1S_WKfQ)X-A(2d3O5Y08/M91:@J7;.D]#9-e@:ZAdL
Z>[HO+SM+TK@9(9,/@2JIDNR>.8#N/NOG7GgJIVcOPZ0^GcC8);N<(^L@BICI9D4
_U<>P(<1D8EHeC[37;<_3A-7_+I5]?:W_#6-/\;TSRCPB9HY)R@2<@9;gZ>>d;,H
gIRUT5CEE/QU1XEYc/)AT(&VJ1#)ASH8,\,De=YYd@#O7:TedU4+a]HAb55Z&dK>
Q?,Z<4Q\/<CUSJ1^Z&5)7I7\^O0-J:6&7AZ0P/=]Z3S)-VO>#@.DP2ATd@D2b\XR
Ue&)f.CLF4X3K@@eRXJ1M+gP0C&S)+49^cOPLYC2=?dg6:KWMd96ZA0+CJQCgOP_
X]&#5<H:EF3M2+?9B^&OEggR8L=f;)cLIAX2+L\7R)a2)&>a.T\4VC)?\P;BM_U,
MB-TWf<BQQ\O);_UPQNf#ESaQH+BYMT/-f],GAgZd4>O=C6b&:MX_IRJX<B1?XW2
H#4=BG@8N&fTbWdf\-H(6<e>XY8Y(FZE7c4dV\AC7K.K3=a9\B=c^FU4WU&eg0G1
>^e7V&3/=c+3Y(PVM1,A)D2[JeF//g0IRY_A]VOW<4&24LB=BC^/R1Y9X1Je&Y#I
2)[/H/W-7LMQ@;b2FDae(?[EU.Z#(=F,aR_42WK#2f0bb9TcQ@0I\>TH25\[1[;a
7]<5</=PM/C49<3b)EL,.f\^<F:T@DU-GAZ/6D>G;d^FA<))ZA/B489]JXV#P7XS
.PO(D.P>=OU=/[3KHb:6:EJWVF=#X\Pb0A>MLEDY1[VPEb384;7V[f@cR?&,V8[?
LEIUFX(E9#JU?/0ScO)=3Vg1fa#ZJS9_55d-57KbD[J@+/gB148&7cQdA_WZQD4-
RbF;D-8.;T5,Q\]R3@=3X3HE49@e0P5XKBEB^dEgA7c:6-[ag7>H24XNL<+NK(;H
&C)5^df@O0\ZNZESRdZUb[C2PFcE@NTf1O72D+NO-LV=O_U;6G=X3+Rf.a3Ob0L7
_fGB77N7G?)1[deG5;0KQ<=(>;):DOXe\b7A;gLJb<?=a#dWg&f^R@LDa\<^6F_d
&.=eMgbUX:,g_6[_WJ#U[,Cd#F0\9I1S9@J//^Ze>_eD#F5\0:320CeXC.9UT6>0
G]+0CA^^7bc_6F_T36CG,ZFR[[)Q+T5@_PCb]#QPdScA2UT)RT.;)LgH5Z>3#gU4
b<MfB.:LIPZ>TK+@4N?IG.a?A/0(DOHRYWfCB)321Eda#g>(5+O9[K3a(T26K<V9
S^Pd3?:L3KGAL;B&MO+Ka;MNPARJ1>]0I.L6:,4U(=M)@>^gZ#&5[#eLFd(0JfQQ
6VDJ,e^Ag2(GKPCPe_9POMcAeXa8>[R,9C3EcSJ(1>&UM>V:DXR+X,OG,X?>_N,;
?dP<D<JLYO.PVO^eGT\J2@-ObUYaGg+Hf^7.A1A6AN=&G93N6NYEWV]+BX9FG1=+
+MgFS?EHP,=0M,;=Y1^>]0I>(94,]]J=QB31U.S8c?=D8[PBZ4W+V=A46g&0:N:Q
PG9HbP2E4,U6:^D7:V\3;dJ=cT\MaBb/?\/AD-5HRH31b&SXGMX=,S-[&(C.GBA[
:/]:29T:,c<IQ7T8eP4L\81Z:>J/#b@T,d981eFXB<2.Da^Q2PO/+-S1;.5F83HV
-B./]:47/V.@fBNFX20D<.0]5@-c<\agGT6A^VcG\b7-LY60SSBPSR.HNOA@QX4X
V@&Q8fY]8(UIPI.g<3X@ZZe#\cCPMMCYYM4D?PA3(<-NTOW7;cN^51ffRG8MOAPb
D\BFR(BRcAd@3^\?&cAg)/AZ&G7^QPFb\g\75?.8U2;KTAe6g4).I]MYS(U^eB.Z
2U)AU-P]61Qf?Q2&</WQ^\@D[fFKdPTI=g>A(D\O.LdZ4B^B=3:KL5BcH<F+;LMf
)I0<FMTZbHZP#gWZ?XDM&L-c25_GINH:@c3#S_e@D+,:FHTO#5aC3CHG4/<ccbVg
ZPcN:.DQc(_,g[+Q,=.:O>&MNdWZWIXL67:VUEaa.L4;&DP:48=3S#(I2LC\eT:<
BD)+.fg.#N>O1<c/7LX&VX8Z,cKHZL;Cb=P&4dP.)<Rg67OP\#=5DCO]ZZ=N43/b
7BXMQdUVf.1IHdeA&UC90ZI.W#>T]&RJQV()J-^K^C87OJ1Aa9OfVS6,MeZ<B,W[
RW2YTW3g&aI_]Y<\gYV,\:?O=A==c,C8(E5)6c8);X\9.fK.cL7BB]YFJL^46&Be
2)3\AKdJ:MG?I/dM6baA#4bH?E(R2;aHN90)G37:I_\:.6LW.+abQSeO.VCdAF]D
=d9gHK<1MB0NFEL]9:e]Ea/OT+5_K1b>B4X90_Q=_gD2#?BR6W5H?1@\[D]RT(PK
0AFA5K7cPETcUf7&f<::XD&)TgSZJNWU5ebT7H5T0IN7RNITNLb7XJ0EV+.)4K(G
aEddG(I=e@40?.8M>QY-L_](ZL.[TLNR92RXY^>8KR:EV,10??6fgJS=K(S4@I:G
UXQI9#WbT=&Lbc<N-):F(MG(E[BTM3)&UH),]eXb96?_?EVKcgI3./Q93;bG\6XU
5+_8PF@2CDbFY=f?2JTaH,-L_Mg^,5>5B6I96[BVcc16>[a_:HgI4)gST(16b[YK
=B4C)fJLeV+I+Q#K(C8af=FGI.;Q\(K3#<O34-3b(dF?cb&2^H,##0KX_Q(9Wa[;
.XE3NXUQWS7W0LWID.,N9-4B/DCF#:60-MJ&/E\TI6FDNEF-2L^(<S#U=2g+2IbG
/0bRBVN8SYEdD7^L;+LK@@FHU&[S(>[XA+2WMWPJB/(Z&\gc>M)XA62/6a)FD8-(
KMC3Q<C3NWfTO>V==LD30EZ0#?>g_^IEeMe91a1d0OIK4O_Q#b]O_?4f5UTKEVe9
39aBE8B]fTO+ZA.IWfPEKU(SN6Tc[TcHZTaH3=Z<IGEYX5C[Wa0aI9aVIUa(FIBI
OHA1:Rf#XOfIGM1B8I^#:PWGa-]8c<B:@S@JHbRQ-RATd5eFA\GeD5C\/3?R02RW
B54@UM;@H9:KUO1cdecULV1M)4P(./1H95KL0E88QKA=c9gf&5[g+ENLM]G][(=I
W1ZDaXJb-^O+bdY#E(<MHEQH[LJ[-@[A?OR#c&E>d@KO1W]?g]N@b+7K+NNe9g(W
e;>e])5SY(?1e6[c(8LCJ:aT;L&F[-[B)[K_>-g/bYBO942J=,XU&:)@F6NI49VH
d:BKL==[N_.g-Wa.YV0c,ZEI]1MTCZV^Z1TX66IBEHJ6;GI=7g[A<V:2LD3RaAV5
>J8L_19MJaC@T/9KRE-e5D3<ZG@_0+W@aeGcV;V<UI8THSFM6,a(@M95L/\GfVQ8
+)KI]6-C,MUN/V<_VV-LP.\gBAZHV3=82)d0]F.84\^Ge.HLYLOVBUJ@c9&5Y^X;
)[\+ECf^58CcSP)g:2H&-.4C^)d\W6O^]T_Z&I(f2?#8YM\\IeVC#Z88&V5SXHA0
;J9We?J/;1?G9Q:Nf72g,EK.\EB\-P\+3cW=e8WO(YAG-\7K:P_BY,0KX\1:PH(.
11[OKKUX\T8Z&KG_.dT_OD9V.a/(Z?3HDI[9F#Ne^@_#/&cGfF0<:a+,bW<R?M8Y
FATNf<+A&D>QB@AA)_1>MA4F,bD6gSUUG3T.CW2ITJTZ&I_R,QdJ]5/)_N()57=\
FDEg/8Ce6.:;J2\,b]bGKC@Q4a@ON4e-5\_MGBNY)3?O4^A_4L<Z[a-H2d.B>NMI
&J4##9Da.LgVH(7AMJX@b/^ALLVSa=68=aZJc.08V-7?/RB7O;V#-[=USc(CEU#f
_EXdE:OMXU@\S;LFZD[fJDD]RAFZZTG1+>3\PR#E.^b3O6G6VIgSVYFDI\;0Y)Vf
dWFGd.^(U=A-Ka_TNDFS>L-K=\R+-d;DfafPZ)aC:.<)<\b,GU>cWR0eI_-NWR]O
H[.8Z8H=S&>5X]LN\)JF.B]6F23AG]WFB,U>Q:/^,7V;_0R@)SVa?T_9NM;Z,F^0
:9I93&E4,(4+GGdNZ\+AX_&PI6Y[#Y<5M+a)6,<Z^fX0WJBSdW(23=cTG?&AUC,C
6DEZKK-MTcQ2(4Y#g_-_)8EM(2B8RMBeS.X[X&D+TUg-UY/&AZZ&[:S4.V3/WJM9
&Lg/I6aEUdb@N/.PU/_RfI/J39#=bKPE<K5,/f)P3.a@^c&gD<]=@a6a(US9L)6M
AAUfC7Ac-g2+JRLQ)G/]O[OJ+&;&b)H.W=]7OP1DF\MbL<37LQARD/ZR?G7-d6AM
H\E>bYQFM>?D4B5BECT;Y/QV?8d/3C^D4PZM-X4VB41e.M1M4SSESgNM0ON98QL9
;U7O8,CU^QATS&5O)9aYPecG(C)MWgMMM3VL<-?V_HLBbZfI4fER_=7+?1#4+WFM
0bY>1RAS57?UHLcTEK>+#PM&C@+X1(NB+(LU5ZNURa?LDQ-RZZJ(ZZ2^e(MSTT^9
#[9+RBCcL=1_8[V\Z@8#GM[H/c\Ra9Q;S/bAFM&]EH+<K(1?0A8K;,Eg3QXQDf6,
6XNWM&M7G4M^R5Z19->6:gIDdQR._e4;)T&8a\CGR/X5c.GR52]8ARA&2YdIP,7f
TEWK)O3UY7/INJTfPBe4eJR=R?<a\Xe89C]&1)6b0Af#4TX;K7]7E@):Seg]^Uca
B]+-M.J/_gK6GL&?WCDS;,4HA9\=W(Cfe+MR9BO0Sf(/R#JSL\C86SK.@V@Xe^=K
D(+Q^#>.+H\VHR&6g]BCCL/fHCM,PaAUPB&5Nf/9S_,>CBa1W.Q(02#4dGZ.=9P\
bQ.237c(,BABEUcC>+]Z;dCT2,fH34MH?be=dE\\)<<CP>X?OJ#/9N6+(JSacS12
35Ce@YfPMD^U_+.4e1.V)C.+g4dab<1fUE\)1X@]T5<OaTH&2WEYEW^7W<-Z1:SA
WBE9Y;ZcB7b?WFCT?3Y+Rc6ZaCb;-S6f0a)&3KC(G[<KAX;(CTER:e]PH\ggQ1\^
#05-3.F7_#AegcR^JB1-cNgf[^B.Fg).<I&3UJ>Wa,D@?dgcEeJ^f6R2eL<aN(\0
7[9L0dZQ[D0J6A8;-H1@,M6P2/VAf9gI9IfK88I&BL7OZ+0-RaQ4@gI^<(BHU2d0
,)^g-HSA1>+B]:SM19&>ZJQY#YHY=0>M:&42XK9,HX[^G3D=#8BF3Ab-[3JR]>5B
=Se/VWU=DfQ3(8,,e.Q<RcL)T>DGV/SU2_26LTG,^3GRJ[de1_2aGHASS@3U(KH(
#-GA\D,Z2SY0SGUM,6(A_Ce&:4V#8O=X.[8_G9a^32G.0W]SHG17bDTB+^Z43X_D
;;M/J],\XB5<d90(_=^S,;F#NXB]GKFRVXU1V6)bFDg.7b0J^Z,G,</L:&RMfG2R
^HS[M4:X^bcR/MR\)2UT@[QLSFPNQQ)-aHXYd17X]eOX3RX8]:,LYR_cEGX0\NQU
3GH9L^[QRQZJ8<0&J(K>Z;;NW6^@XZD,_5Z;Y\g<TJJ[OdHZ[(OD0X]Y\1[F8PU9
\AgH>S?KOT9/KW#0@IE:Ka;\Q7Y1KaEV+^)2g=&VWV=g:g6d:09IZBX.P<ZUOQfK
\+#fb]2T_>->,R27VR>[Xd,>:G[D8<a;Ef.AL1HU\C-((A9/-<944^CQZ.Q3UWVY
?]5I6aLGVZS]^E@b\LULLKF7a3L[6<(MeT[VNH5FH9[=6CUfCaB2^Q/U@Re,+>=F
MQYV3b/EI]AG,79+g15XGJ40U6e_ETO=VSQOE/8UNFDXO=e:9B@V1HI]^UPHbH7)
Bd1?<0)EE.UFU;]_W058A;<K4g/9ZJ/=0^S\SZIK6Q7>VeNc2?9S9W:KV1:U<7Gb
?f[B)9XWEFD^T[a&Y3?e2/3(8YP.Z18DSaa4/&-9T/A29>,]fd>[D#\5Q/EL_#[A
Q)(F,e(GDL#cQPfP:LdLTeW5KAG2)b+Z\R1,\8V>/7HgX6eZ&BZ3fPa9;EV.V1E-
-D24&Z_TW;0X;WEMPT2Q_BJ4,RL^=1NK4+VfP+3Ma\[&>9UbH<@0_Tg.10UgCO-G
,0_=;F0?Ae-+P,15<?]\7b;39dI1V<C\c^NBZX)[PLU[DcZA_H2g?Ba,OR.\F;dd
#g(GH:b;,5-Q#Z[#gB@Z:LN/OGD#&Ad?495&)JADVX\MaHE35LS+B.\_HMK.A.,:
V(fcSGe0J;&-Lc4_Vf9N:3g?e+@4.W&X.?]^-M);fb&N>#RK:Q[c0;QZ6OHaSW8J
B<P(<G,\RZSbaO(&DFb=&VO7I^[2K_W>C@<(A;/TVQ&I@<4@d00T7#6B=#Z)@#4?
P0a8Vf-6bW5?gK=fW5Ff?;0NPb@:H>DdXFFZBFTVL1^0=-<FA5QPN^5L_^82-9/F
.FVR18,VD3gR;FHffbL#VdV_V\;6fLG?&_4B>):80Vf0WJTJc,F[;ebMc:_E:)+3
IRF4M<8S-Xab)F7_a1J=?(&c;f]S/0FXO@B-;#;f@4T4VP,7/5XceY]#7?V77(.C
L^Y?QM9_Fc+RQR2]dUg;Na6FY;PQ5;:(8(UFQMdA3J6/4(6O?N8J-ZB,d4:Nd(_;
b.[a=/P2<&Y(?X]#Db>acS7R#ZU.AWU3I-(Mg-(_b>dJKO\.7=&L&1&QWIb)EX_b
9C9C_AWY:Mc5f)U1B6N2(Jfg75B8V<PNZXYdJ2A[8?g^S\4-Sa9<M@M&-:;9XF?.
2/[Y<XY1ALG5[/g#?)04F8+Z/D0>-:N/9ET8eSTZXUC_M3O-D9gIMLcOgZ:TTVL9
SB/@LfG&Q)Bb+-,W9;f#_N+_fOL8_J\aVbRd^]0d4fQ[E=Z^cNXF@TZ4T8<NL_<L
GJUV&W06A9FO(&=U-^\W1R?^D+60DbT]a;(XAX/9=+MddBL\R,E@=D=N6=]S-]Q;
71JNY<QTLf3.(U7HEQ-T239]53&/,7IW;>WeUULgbIUF^g2R:e)6LZ27(//9e@C&
e;[7Z</IdLSc79U^FO=TU_\88LSV(e:(B-ZJX89FQ?V];_ZY;^6E>]a&(?FF9<99
D5?=,:\Pdg7_))-eEO:Y7g1R[RIQH@d?56=A3AEdKO3fANPf9Re#H86ZNC,VTYK@
JLYY3A1JcDA\NXOgd:RZE7YETBR+5FKecK?IQGG05G1W_,LB(Y#@\-^_]KP@DZ]U
&I6(.U_;^,Y9=UZ4.OS#BTJ601O:V,,Gc^5Ebf>:SM\fS^QKH0&WR4g)c8W.J\=c
W/PCLdJ;@WRYJ\Gaf63<N1ARJ=7IOME0SF;];BY26<E(P+F_dd,e=X+,M22Q@NW(
-G_&T25/=dBE&^V+@]g6SK^Jb1M[T+LBP8ff]2G#8TLU-<d[BU6C)?H5/@#BHO2)
Z\T\fO7I55D5gN5aY4Q;J+W\Q3+T[LI2Td810W1>dIebFY;:4=Q96X_PXa5X\DEZ
5WT6EfU.,N^:c#FV-UK2O^Q,:3\/;)BQG(,/>F(976_XITB+F9U&RFa9O]GY9663
INAC^d+_;8;:B=\OL+>=+IVX1GbbB)TH1/IYN=#.fg6N_LJ0NCGKAdI9RT-(Y(W;
8)(5HV++ZG]I/A_B7cBf=?-C=A>:.(W7]g<?B(a_69bNZTGZ0Edb.JDA/HAggYB_
AEVD]4K\)C?fc,H4.AcaVSfJYHK0a4Z<C55aCGV6Y7aSd3Y0M;CQ:YgL)cBT2H(^
]9+TW0T<Z3#?Q64EMd[#>&aR<[J^UG@.Q,K]\-6?CaK2O>DF_3\OJN>eFN#bU^fb
Z^USJ@7O<T/QK7FZV9U0E<9M80H(;F<Vd2d0-2/<H8L133[^O/>+eU.=?QddHY?J
(RCC;-a@2M_?R4XZYW2P82PbO^.RdSGQgZG=LeC_P[@+AaE>D_MRDBeWYIY9HN:(
cgFPcC\M=_O5eY,8W]C]4@bHKJQ/bQ41:eU_HITg5(TH;b,9P;V:V>/f(OAT&ceG
ENG?U;E9DYFJIcX9CTNU73E;[<LUROFJX@>a>NF]MVfW0#[V3)X1CY,\F8L.:La5
_c3caY?IbTaEHL)R^FA,8AZfOF(c,a\Cea:F.P)[SLe+LU;?V:2:\,8LaOdMJC<H
QR>C(_(Q@cPX72=G;<Be3LOVIVWJ=deI1P4/aQ)gWH+d8E8aV=;U<aY(4&7EbO_7
5F&+@[4.[U061I8EOfDB[[PUAKQ<fT587]3b+EP\#SVf157/6d1UZDD59(fPKS<)
ZWU/@0_UQB/]9#;03#E/#KRF3G3eeYH3eK)_K,PIg3Y;-bQ3<TROS]9.f&9L3=F.
1J6I3VB-66FO]6@8W8M@5K0[8N&)a_U)+ND.]_a>T>WAZ8#]7L[29(aY(@P\7)<S
Xfc2[+OB[RADLJWFN>)HN52:<;,c(1aa,Y?Q&3J\Uab&f3;-?^I>HG?6^G(ZLVM5
e:UYC-]_/gd#dBe^Q3->IX]A0HSV8D4>FYQUg(IG-JZaNBTW.\9BaVBE_4c8gB^c
c,c6+G-EK=->[2a2NQ,;Wg#U(Z@T7#N7^K]/I0Y\GCT8-[^dO)5UFP\,<>\[(2WD
4-O_^3[S<\7.GUL4gG&KgTRC:=TUM2ebH^a9DIM(?LdZKHfIJ66KV<e\&I[>gf.?
F81>FP?S>A=;(Hg)b5FDH@@.UfMZC4O1J/>=.Hc+>X3ZHA<=JDA?K\?PQE@bX?5:
]?aEJC_]0=<;H+T@<e/Og3-(OcQ0_\P(-[HS[=c^UF^.K8ANOP+V\-+N@HAgA+4A
?(ZNL0TW4Y+S(PCY?G[AXNZd&bfJ#>0bLVNLZ)XRGZU5b]L6YQ&Z[f)4<3G7L5^H
S.?fDFBcV:)cLGFM]\\2QeXcJ\a)BN7Ma-1gW)YMgVF^].62F/PD#5Ld=__,E_Kf
D&-^JAM3#BPGTMEe[L&I,Z2OS2dND(H;RYH:VY&AA8cB)>PBCKGU]+<0M)KB<O<D
bLXX:-b3-:)5ZZE3[I=c4>BT2]+#1<:>05O1,6;#SW>OH<H(4B<<^BYHdJ_,&+TW
]&K661dF&H+C)WFbYJ1@RNBEI[I1K),@^>U\9<W5AHFDG:W0^#D@5dN9DWA9_@=8
>&<C&-bXMaJ&UI\g&=a\/e3Y1\]]a^>8Y<[.H=LSBCLTd#M1Y1[FMP=ZKaY6CH1V
P+1,/eSbJaD+[2M1;#@(6YKcDQ\cGMYE8Ra^g]Y42K_+NM_-:>5P)T79#NFK^<GT
S\00[+8aEX=C(_+eX/RV9/[]/Z8&@EME=V3])CAabMdP:3X/AI78ceFNSbCgR.<R
0RLPB>,g.M&V0MHIHIYg7244R0^PC9BFFZ4??Ddb3NT+HgX[eOWgW8DG<>f26-e4
3e4>U,S?U+4DMCLfE8f_03S_P]=OL@<Vc0=8ad#=<9cc5V]TbWZH[#P>7(,_;U5)
&T<_-fZ<T7SC8c1dT-U\(e@2UfKJ2^RT)KX8I++4#W@[.7eQ-Q7Ygf([-Ca5f(#(
QEb9]>cb)[A.C[[>X_FI<=R6]<2ROMK;X2<L.CBRd)#UMB,SZ3[e6DFH#0+<RLdG
PO5UGQf<:74#HT)B4([NWbMN\B4HO(15a0,D-=aI4La0@;#L?R..)\/Sd[H(5_5G
YfM:a#RdcCE4IO=A69M:ZaXEC)fWC]b;88+E3CfYO5g+a#+TW(Uf-=-MS1VJTKZD
S;=&46=?@L[5Wf<?/(_=3V2+[6?IgMPO].JbJGH-R?1/QZf(Zg)X\R(dY;SIX&\3
O0P,VOBeBOH/_L.@\YM,R5Be,=OP#IHL#AYCSLA7^)E1R6H\YUdXa/0YgfLM&JZ#
Fc5e;fO\#P<fU_3=B[7ME5MQf4^gAV+Y-KdN;d6eOS5DHcENVK9ca099,\bgbe#B
+aTY(+^&d@0gAFD65.Q1I\)NUI@^ZCRA21e#bRE9a;0^Q+ZUHe5F3G(1Gb<F5[D3
;H,(-dW<:G>K,>(We#^6_Od.aM_#-I60c,)(RNDHOG#b.>/4L9/;<CN@MW.C8Xgb
T3ac.P_==McBf\35;&JBCSbERZbd);aBWC=aF>#HNJF)W/?P?UYK0LV45f3F.KN,
]G<&EfDe[3.L](7d4D=CVQb1@dWD.=MUO8e,6&OG<T3,dPeQK53@YDJW(#PBK.aF
N]4KTZGV,_TN4+4MBgN#QFR6f3:<<3ECaQ96.5]Kd<gbSMJcOJ=J7?M++C>1Tg7e
B.@N<1:YQMaO[(I-&4#@]Af7_P?X4WgLKf&>=A-&Hb<;#a.FU6PE1>dfC+TWW@1B
9Y+[8WI^3RVZ1VCU:X9M9@?F_c7D4dJNKg?,:HIRPW3+V.NM<9ab.YKX5:T.Hd]G
]b9?_=Tg+HNf;KFg-Dd_H@7JG1:g,BAgIZE4:f>Q4J730g<IaEN/;6O1MGTdO#g6
P(;9OUC=T\[)#GF<P,Q1bZE(df].e+/D0V[aQ=0^g:U+O>_K614WX<=2[6ESLTLH
4X4S&K:5_\<G4gGA,9HZaZVJe(0ZZbBT.F);c/BMDHXX\LTc7.PXO650Y/AL3g+6
JC<YEW[^G0ADfW=RfH^&;.@B+QT_[UES@R_,>G?,:.ST5gJS\ROXZ>2:,Of8;ZR\
G&A65Pe<03&#e+NCR<QCD#R<K4Q.GBOX5DYb<58cV_]X,a:.DAKbL=7Bed3;6d+O
GZ7G4SfN>2U6\Ne>J7G\P8FVZ/Y5dfXV3SHC:-c;eL\1)/HH:X4aUE/-T(];L_X2
@[<6K[&/IGQE@-FAgX6d5-F?-<F-)EP-IC-BNa^()J;aNNBJ<bAJ>[^Ad@:&10/I
H:,,4#a,:JFC^/J/O>S7;F:02K^QB9VJD:bN#T??&IYIeVS5_AZ(B]IAH63E-da+
V6>,T#-K0XF#?5A@ZUaQ-,VI4#D/N#GG8;cM#>99gbB25F@^Eg^#U((WG[A22&N]
MQMF8^Vd#[Q-SG^8>QX[VBWMH?Y40,D:F7EFCcP<E:-ETQ8?0(;+J-/Ia-Z-1SN@
XPR&F.A/>P-JGf77/a73T.Ie-LN]81b7Y-(W.BA]RD_658Vg<fL2#U_UPDB/LX9F
cQ.Qbd7+DYG+a_fUH@&;0@CXDE0gA>3]^R-?N_M\7:U0YY.U&EA8W<1.dPG3eCGa
^eC@PTCP=d9gY20;-f>]LJ\/OERG]^W([5GX7EM3K_(gVQ@B8RH[Y#?XFFH+]U[,
9O@)M)COcXGc<E]a8Q]bdTU4fV:&+AOf)3G6JD-Q9bC;?O,JEeG/0@I4LPU63+Q@
94]^NV<CRL;#NQM2?aQ#/++7]a9^V:ad)UM5]_La5NKa5[@e=Z&J-cW.LTM3ZCF3
65S5eEE#\22ST3g[8@B-LXNKQ>5N#+L4;@7FSUI@0/&eFeJD_QSYYNWHG;5]M&8f
F+5d,91<=?,,QIdLaSV-4e256+7bB=UE,bdaOZd#_9TB#6.;NCJeg+,[@XNc(S#E
fXcUNI5<K5EJ=+8BQSQHd)A7,&W>KK_#141WV@D\4FC,NeA&1b-=Y#2e3X@I+T91
&QKW)_J&Q>)01KKeVV-gJe&:49=d,[Qc0b#P#5RV>D+bgTDA>KEY\ORcfD^\cQYA
Xb#@,93W=9PdUND)0<\FXOd=Db?2N0]80O1L4ed_.7FY:abR;^:a657\?^<@4<AH
.4U?HeNZSK(AKdL_.G6<G?]V6FMDD53gBC+gLSY^2U9Xf;AdXXH01FAb5eOK2<4<
>0Q0IVb3/?@B+<_OX]D[],b03eP7]SbF1RR494a71\NeGA_;f/JWW+QCZU+=;3.5
dV-OT:OMLc5CeCL\=Ve^IU6](b200VV4_/I:XY0a[YE7=6H]M/F>aVA)N<(8.WTR
B2X.2.EZgW38G&AVJ[^>?K1[C#4D+CP3I5O?X:FZ>I_P0Da;>4:5]CP+gT=4/P\g
&=Ve(NW;K/6X&eM:6,+NTG9N&0a/&7c,e4QW0>UQQB1dR1RMK[@a\S18dXfa&>KH
,..Zc=bR5&Kc;ed1_DZ)34FHU_L-4[?3E>;CZP@#,^9gPH_UY,DV78W>@IND>OKe
0U:#N\Q(_U:Hf7:28=.bYS7BA>4B,3._g#OPCafV^&eg?fH:fYJ.PN1CS.XC][X&
)W(Q]gA:M)6c/,Z6D@G@9(U@e,?/-cS\V]LIU+/[(55]AUG=URPWCbEDcfY+URV:
d>_?5TPI2@VGT2(ACL8O>X,[7,53EMQE=BXe::IZCTdG^8aTOa<06C=b5QN+M:=O
O&gY[bcV(9FM[c^8)Y]e]INAVKfcfX4?<WI3B,_<fA=)S&&)JVK\<E^\FSO26Ef:
f]E9)K,bTX^KIH]DK)DIKKcWUX8CHCe;+&,D.V&=(-D2U^91/UHY12Q.#0Z<<Re_
UeR+/SOd8BVK/$
`endprotected


`endif // GUARD_SVT_DEBUG_OPTS_SV
