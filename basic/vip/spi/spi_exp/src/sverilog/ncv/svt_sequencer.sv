//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SEQUENCER_SV
`define GUARD_SVT_SEQUENCER_SV

/**
 Macro used to implement a sequencer for the supplied transaction.
 */
`define SVT_SEQUENCER_DECL(ITEM, CFG_TYPE) \
/** \
 * This class is Sequencer that provides stimulus for the \
 * #ITEM``_driver class. The #ITEM``_agent class is responsible \
 * for connecting this `SVT_XVM(sequencer) to the driver if the agent is configured as \
 * `SVT_XVM_UC(ACTIVE). \
 */ \
class ITEM``_sequencer extends svt_sequencer#(ITEM); \
 \
  /** @cond PRIVATE */ \
  /** Configuration object for this sequencer. */ \
  local CFG_TYPE cfg; \
  /** @endcond */ \
 \
`ifdef SVT_UVM_TECHNOLOGY \
  `uvm_component_utils(ITEM``_sequencer) \
`else \
  `ovm_sequencer_utils(ITEM``_sequencer) \
`endif \
 \
  /** \
   * CONSTRUCTOR: Create a new agent instance \
   *  \
   * @param name The name of this instance.  Used to construct the hierarchy. \
   *  \
   * @param parent The component that contains this intance.  Used to construct \
   * the hierarchy. \
   */ \
  extern function new (string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
 \
  /** Build phase */ \
`ifdef SVT_UVM_TECHNOLOGY \
  extern virtual function void build_phase(uvm_phase phase); \
`else \
  extern virtual function void build(); \
`endif \
 \
  /** \
   * Updates the sequencer's configuration with data from the supplied object. \
   * NOTE: \
   * This operation is different than the reconfigure() methods for svt_driver and \
   * svt_monitor classes.  This method sets a reference to the original \
   * rather than making a copy. \
   */ \
  extern virtual function void reconfigure(svt_configuration cfg); \
 \
  /** \
   * Returns a reference of the sequencer's configuration object. \
   * NOTE: \
   * This operation is different than the get_cfg() methods for svt_driver and \
   * svt_monitor classes.  This method returns a reference to the configuration \
   * rather than a copy. \
   */ \
  extern virtual function void get_cfg(ref svt_configuration cfg); \
 \
endclass

/**
 * Base macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file,
 * and only if the client needs to provide a 'string' suite name. Clients should
 * normally use the SVT_SEQUENCER_IMP macro instead.
 */
`define SVT_SEQUENCER_IMP_BASE(ITEM, SUITE_STRING, CFG_TYPE) \
 function ITEM``_sequencer::new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(ITEM``_sequencer), `SVT_XVM(component) parent = null); \
   super.new(name, parent, SUITE_STRING); \
 endfunction: new \
 \
`ifdef SVT_UVM_TECHNOLOGY \
function void ITEM``_sequencer::build_phase(uvm_phase phase); \
  string method_name = "build_phase"; \
  super.build_phase(phase); \
`elsif SVT_OVM_TECHNOLOGY \
function void ITEM``_sequencer::build(); \
  string method_name = "build"; \
  super.build(); \
`endif \
  begin \
    if (cfg == null) begin \
      if (svt_config_object_db#(CFG_TYPE)::get(this, "", "cfg", cfg) && (cfg != null)) begin \
        /* If we got it from the config_db, then make a copy of it for use with the internally generated objects */ \
        if(!($cast(this.cfg, cfg.clone()))) begin \
          `svt_fatal(method_name, $sformatf("Failed when attempting to cast '%0s'", `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
        end \
      end else begin \
        `svt_fatal(method_name, $sformatf("'cfg' is null. An '%0s' object or derivative object must be set using the configuration infrastructure or via reconfigure.", \
                                       `SVT_DATA_UTIL_ARG_TO_STRING(CFG_TYPE))); \
      end \
    end \
  end \
endfunction \
 \
function void ITEM``_sequencer::reconfigure(svt_configuration cfg); \
  if (!$cast(this.cfg, cfg)) begin \
    `svt_error("reconfigure", "Failed attempting to assign 'cfg' argument to sequencer 'cfg' field."); \
  end \
endfunction \
 \
function void ITEM``_sequencer::get_cfg(ref svt_configuration cfg); \
  cfg = this.cfg; \
endfunction

/**
 * Macro used to implement a sequencer for the supplied transaction.
 * This macro should be called from an encrypted portion of the extended file.
 */
`define SVT_SEQUENCER_IMP(ITEM, SUITE_NAME, CFG_TYPE) \
  `SVT_SEQUENCER_IMP_BASE(ITEM, `SVT_DATA_UTIL_ARG_TO_STRING(SUITE_NAME), CFG_TYPE)

// =============================================================================
/**
 * This report catcher is provided to intercept and filter out the following message,
 * which is generated by UVM/OVM whenever a sequencer generates a sequence item and
 * exits but there is a subsequent put of a 'response' for the sequence.
 *
 *   "Dropping response for sequence <seq_id>, sequence not found.  Probable cause: sequence
 *    exited or has been killed"
 *
 * This message has resulted in a great deal of confusion on the part of SVT users, so
 * by default this message is removed for all svt_sequencer instances. It can be re-enabled
 * simply by setting the static data field, svt_configuration::enable_dropping_response_message,
 * to '1'. This will enable the message across all svt_sequencer instances.
 */
class svt_dropping_response_report_catcher extends svt_report_catcher;

  function new(string name="svt_dropping_response_report_catcher");
    super.new(name);
  endfunction

  function action_e catch();
    if (!svt_configuration::enable_dropping_response_message) begin
`ifdef SVT_UVM_TECHNOLOGY
      // NOTE: In UVM wildcard is '.*' and match is negative...
      if (!uvm_re_match("Dropping response for sequence .*, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`else
      // NOTE: In OVM wildcard is '*' and match is positive...
      if (ovm_is_match("Dropping response for sequence *, sequence not found.  Probable cause: sequence exited or has been killed", get_message())) begin
`endif
        set_action(`SVT_XVM_UC(NO_ACTION));
      end
    end

    return THROW;
  endfunction

endclass: svt_dropping_response_report_catcher

// =============================================================================
/**
 * Base class for all SVT model sequencers. As functionality commonly needed for
 * sequencers for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
virtual class svt_sequencer #(type REQ=`SVT_XVM(sequence_item),
                              type RSP=REQ) extends `SVT_XVM(sequencer)#(REQ, RSP);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequencer class then an objection will be raised when the
   * Run phase is started and dropped when the Run phase is ended.
   * It can be set explicitly or via a bit-type configuration entry on the
   * sequencer named "manage_objection".
   *
   * If the VIP or testbench provides an override value of '0' then this setting
   * will also be propagated to the contained svt_sequence sequences via the
   * configuration.
   */
  bit manage_objection = 1;

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;

`ifdef SVT_OVM_TECHNOLOGY
  /**
   * Objection for the current SVT run-time phase
   */
   ovm_objection current_phase_objection;
`endif
   
  /** UVM/OVM report catcher used to filter the 'Dropping response...sequence not found' message. */
  static protected svt_dropping_response_report_catcher dropping_response_catcher;

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XofR1HV5xJ4oYoXFNQ79DB9gqM1N3cr7Z9aB755wuGLvIJqQl1zSrLfeaAU3Rlni
VcFIOS3Zi1w6yPCsYxglVqC5tEGZhvuqOeQi+drXMpL4ms7OmzWAevwLfPxaIlY8
GZCXUbRasAZjjUEeWtaDal1jq5aQ57j//XrKX4qcL/jPlqMXh/JSQQ==
//pragma protect end_key_block
//pragma protect digest_block
yar0RWm93ap67ew457FaiIEPXdE=
//pragma protect end_digest_block
//pragma protect data_block
YR7WXnDwP+itYd8tNgTJqfV0EYF+9R0sUfv4Ipv+BQ+vZRlXNbwfKENBlrAZ56Jt
s3gxD4ykT5HJmn/e+PSp9FsCnEzVbSBBl0GvWV4UKt9671H/uZgPRhmUwiIGApiC
mFBOX564l4D12VpH8qd/pTHpumRGkqNldlWkROrlT3BFW08HQKM3OxYbFQy7UknX
v1+Yu+ShugxsZIcpNDTJkF47Q7Qhe3FVZn0HppYJXW4lij8cjOIHj66DsLMaBqZY
wkLLA9WsN+383Y1zXC9Aux/ImhRUczdRegMMfBf/d9ZHNv0LLTvkC9Ohz5aoUvAZ
/4x2vVgUMit7sO3ONPQ4hh+AmMBdw7L7czciCf2os6c+L36ug8eglN8cmQ0+bDAH
JCuoqnqlvPFitmdG8q6BJCvOmSACcp2mIAANQYAowuxB1ruYzz3xl/W2iwQAgZJJ
yZgbEyMAfUqLhXhemDTl90AOFOiT5LpCnoqzZKB/6miws1kbVQ1T/4OLx64gD6Sh
24ezNTb7tdnulZ+mI6Y0qnI2QfVylPFKMaSOqYe4Ay5EwnXKTtyoceuFiYwXGnc8
2MJ608rKHXoAqVcZhGcGt3dIvL/kQPKDa+itYVglhdNPKvu18EuB60BN6j3O+9Hy
5a34UZyWFi7PAai9rYSeUrhIvi384lDIvFR8o66uKN6HMr3wH4et+PdX/ivMf9wQ
wT+ofR/LfTRwUxNvpHNZHwIq7xeS3iX8iwqt96eUxgXlfGfoZAu7LZxqrAOwFobF
9zk8ZG+6QCYJOB1waif5LeCawTb75NsZj5JmW+RxYJ/oCpad0JXdqo5cOpRhAJ+6
pzM1VBD+l94C9LRMHPFyJ9qR8NzUCPrAelzM+Wsdf6SBvGZn/4wQVgSSRHS9LU1P
3PuScbxUdE4PASe0vwg8zziAChFnPqSwqszKgDsE23i/HaJ2h8F34P+SIObhAThg
oYOcHQ8m7eqnpFYbQD7tfWvZkjZ0j8kSSXQiD8EOMZdSA5HRXvTdl91VOH/0Ia+n
gLclWfWV2i5qUDsdUPlSsQ==
//pragma protect end_data_block
//pragma protect digest_block
t0U7T0+ILX/mAUOHP2kJW+et+WY=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WXYOx1g7Vyqya9JL3HIRUVDZbN601WopSabpO3M53+z91OKh4/Lx+c2K2mqaY/4F
TU9wH/uDK3TRSB9YXDOlp7NGpuTVxqRxdqR/hlyRlW0xpWfTx7e5ybvY28FtwjyS
QQf5FV1JIfoiHJsAs6Ot6TI5BEyisMUQSm4BOL6g7CpkDxwVmI/QSw==
//pragma protect end_key_block
//pragma protect digest_block
JQ3buXGVQCJUl85IZXHOMqxJDTI=
//pragma protect end_digest_block
//pragma protect data_block
4Lk+NcYIHjRGG4nImG4iUHYoitb/FUGMRPzvazMOAtZw6Q/XQoeVPKqdcph7+JWY
ZIdHZZrH/6QARLEr3v26lmXC45mPClooTehSdPAbnNWgYvaZUVBQWj4TyiC6i/ep
en2TRM00ud9koY0mXHxXaNqbd8zpVGZEOAp0TQhEZBNmsp6S0o/ID4Y8T5f8A6BS
qFwPTpACA0ZScEzqCA/7WbeVTMaLIVHmCt2Y9YfM9Kg58b6a+TdpEp+XU3o7pm5O
Kr3Pj/w6uevgqXKzyGGCZcFYn3tANCks4pqMVWSfYQZMGiLn7aurh4RWZmPGl0rF
oVcKOHz+J6USoyG5avwMhgfnstt6uP/hz06ChZVnMZV5bg6IjGDHEz7Ofc3/zecz
GzR7ie0+V5dBb4x9F5sDeuJQ2wlIujkmIl1fTA9uVZhR1E/s9Ugc7fWiJHpCXIW8
JmPUFZMCcyQVwp8LdS1Qug==
//pragma protect end_data_block
//pragma protect digest_block
akJ91I1knSYmdh8wi88pv3UJ0rg=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nXmUKrT4A1Sn67yVtubLoQ9dO/UPFhLvi7PwQz/TuHJqI22WS8NCK0BVaieGtGNK
YXXAZ/iw5KtUh7r1IteEBF1M+ylWD3Zilysv85U7kDwLtQTuwMhTdJ0HJXrbl3A5
4lIj4LaRTnShxNXhtGEs9vNwzB3VSDvgGIvaEF7s2YBDsVqD4DuiOg==
//pragma protect end_key_block
//pragma protect digest_block
s8uxGcfSHoyutHORv5AftE/7W48=
//pragma protect end_digest_block
//pragma protect data_block
MChZmbF01+0p6H/rI+P8zmF8e/jMf5/hqINwsx64tv0hfKWO8BT67LCUEEfaFa5H
x9JLms547RjtCLS+qZd1JFJ6MCGKwpA1Z+kqZzRxKkIvXtraHhD/2DQHkrD6oqPR
Ow+fkop4YQF/B3S0svFadiHeX4v5JH+f+tQ51B4vqGG2bACfS/8rRY8hOk5tAxa3
GHsfZxtNTJxlFH63NOOy+7eAE3hs6F0RhLwEnSKloxKEz4jb9GENomn+TqJolhcZ
mcv68DzKR9foEv6IU2eniu3MGdtTwG4OybWAScaKw11jTaqh7IvRWERwe4xVXmdX
rtuGWhnfR8RUW/pHo+/rH5MPWMjB4ZEVH8avXEfX7mr4g95/G30sMVTFcj/nOKrd
WWnJPWSIMF+n0JJR2qOLq6gMc80HmRl5sfqLSQQCXJ/PSXI4HyMr89Mn1IoDxC68
PVXkkVivU4kgeQWMBfNImJPJYSYvbznImWH+5YbM65jsE0LLCwQKf6pdY4OLxKPw
Y93fkcm7MVkKJHthYq/u5lsWWDpWFXD+sqt7eRqkiTMngXp5h7k+ne3Xr8xKVoDC
hZbjSHQfJP9IQldlk5ucTCTpaIhhjhjpc93y+Qtpvf9D/C6mzMQrYH8Ylte8SVgl
4IasiS7QlAAhlXsIw5GAjZ2gNOWnXa67K2w3RRJhtMVI5QpyZv6TU6h+jNQ27dby
OWO5y7UQzp3xmChvge9UYniz8EKjYgg0gX16aeCFitFCe6R5rYvrLXo2/2odyAbH
tEkmPG29svP6lZfqvD3Qdg==
//pragma protect end_data_block
//pragma protect digest_block
5IfXCL0o1n9IXuzUtKPpr/vAesc=
//pragma protect end_digest_block
//pragma protect end_protected

  /** Class name of the transaction that this channel is customized with */
  local string xact_type;

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name = "");

  // ---------------------------------------------------------------------------
  /** Build phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

  // ---------------------------------------------------------------------------
  /** Run phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`else
  extern virtual task run();
`endif

`ifdef SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  extern task m_run_phase_sequence(string name, svt_phase phase, bit sync = 1);
`endif

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6xBK7cZg0Zwgyll6s/lzVPGV7V6GEZlM+UUHxeWnlVcj9c0hnznQwaxhbsJwBl6J
Bk5bJ1lgFmSkp4NK9DFVHIPcTlGe9DS3/niwG6be0I+LeGr0k7wdUzP1FPCeU1ll
sHFjNly7Tf7xVDP1ZJA29fY+d7KSYk8ruXYDs/0UQ34A6+lunAWUTg==
//pragma protect end_key_block
//pragma protect digest_block
ZXBfQD7uhF42gEiJWAadYJ1TKNk=
//pragma protect end_digest_block
//pragma protect data_block
sOsPSb4ICGR+jxAeeugUjrTEq62EhgCQEVD8aNIklH6AQ+Y644FjqykmThqK6fO0
KoeV3jDiE7fxpM6sgC87rAItPcwyYyZ/Lq2ieAyDARqJZYbj1ZAfLLk3AhzWi/jx
eE+3a62q1jr31Q84F2T38Afa5N4ooNAHO74avB1E9GOWuCcSGPa7WCIej9FRr5id
RQ6M6kWbuOzfm4SptIITm82ux6fQ5HcLmP8Asy3N8QvQhvDkCUyuiqoEZ5y5v6NZ
m3W3JmrapItsdZFIu+Ih8qqDH3PwKfxFl/rPUAPIaM8JhU1LXKRS8h3aIQ9CgOQy
n+U2E7rS2+jFsDe1oSDpJJJQ+6CMe1ik5AWOZOk+PjZ6m0xEFldYLD76OI3Qa4g3
k5Gba9b0P9FCzo09B8cEYdxeoaCpsg8hW/mGQJSfr9mnlzM74flvmp1I6Ne4c1w8
gFrjAB+x0KqYwbmDj5XapZ9zkENPkinbRz+LXf/zeOiVM3UgVN627qTalw++lne0
IlrKmXC9xFqcBfwRa1f2iysCUr8abw4TZ3tFPIeUvNF/ZH2+0SY1mtJ/VJw0Yl5C
YaCk1zMUnCB6Squ7pLernWQds+bxzMK58AZGjvnzMySibS2Xkvmf2r+yn8LQssWn
nJmDyOxl1SN8UmpDTwJdcxdRbAK1SDUwkMCsxCM2bFti7Wh8tuBGiSYCNgJP0bo5
1ZjcKTZwWKGvwwBR0Kg3qmV77C+NyuiS3TCYVTwbAIYbhsxccB5mUwYYcu7X0Jl4

//pragma protect end_data_block
//pragma protect digest_block
YWZ5c4Auiht8dA9BN7VOLgXVo34=
//pragma protect end_digest_block
//pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
STHmCAsXMO1ojdGCQRGO3tJjurFUBkwQzVPh2Pc58WOalHj/YTQlQcLxfe2ZaiZc
YBRuN7Sg4CkCrLsd/kVsRDswWb6BNGFZkWgInTGnT8NEqlfSIA3ortyBlUp+CKVZ
I0nDz7im4ukiw7agOGDuVBg97SoA5wxRA2xrZJYazOABZujSUgOezw==
//pragma protect end_key_block
//pragma protect digest_block
2GGh4KrUrRxbp4lr3/KltluOElg=
//pragma protect end_digest_block
//pragma protect data_block
iMg4kkVAtOEayNIlpvTF6tj+k0qJ71kwXfUN6n3pTGnbtiWKfRIe6Yh23BH/JbaM
9AUBAUXnFF5LpKqlmJdWsW2JBuXoebYtNUM/mvZOHCrD7ckof44oT+Vm/8XfkRmj
Twv+s/yr4LjXK+VOVxbsLTKs8JVFDigjezLofHIkhZrV1CVb3WXWk+OBNvdWEKtY
Oez+7sDCjtyxzl1xxcXxO0vURl6eNQJ8WB8WsX0mdVnuFYWvi5zIPQIYTFC/ssVn
/5BOtlMpFLY0G4sJc6sIILEfGxmvGZPyfIITOyrbpahWqGGR5qyxFxkTlQlrkJ2u
EivQOFa5MOsTKdsca8jLNAQCaidTFwLJ+UVtKEQ4sRUU1NI12MbhNof/dtmm377S
LLkNfYXH79LOOQ+5HtRlZg9lmsiwkL7UVSSpCi2JbaNYNnx43pc4BJ7gqxOh77Md
68NsB5omed2oebErP3OemEK76Gck/hqTZ3F+IdrtBy0gR+TKeQlJS/4N8Hj4O58W
TbyRy7I+0d4A1N0sD7wX29RKME6RVqwBSzsPFKjxSUb5ZxDyO5In9MsSZHpqFhzr
9CPbCWimjQurAjEvYCVfiiUIaws3VWKPwWXI6lpEly0lkbbyy6X2oYKVWgEOmu/g
szD3gW0Ub1T8zbJ+/iXTWWE/VQDMRUsneX3IGWqUMjTp0NcqxyN+4SrooagZ9pXP
i/USYdvzBHlxKuNkJ52XtA==
//pragma protect end_data_block
//pragma protect digest_block
ELkv7GaXpEO9hFv7jau5UpHMxI4=
//pragma protect end_digest_block
//pragma protect end_protected
  
  //----------------------------------------------------------------------------
  /**
   * Updates the sequencer's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the sequencer
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a reference of the sequencer's configuration object.
   * NOTE:
   * This operation is different than the get_cfg() methods for svt_driver and
   * svt_monitor classes.  This method returns a reference to the configuration
   * rather than a copy.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the sequencer. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the sequencer. Extended classes implementing specific sequencers
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the sequencer has
   * been entered the run() phase.
   *
   * @return 1 indicates that the sequencer has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();

  //----------------------------------------------------------------------------
  /**
   * Finds the first sequencer that has a `SVT_XVM(agent) for its parent.
   * If p_sequencer parent is a `SVT_XVM(agent), returns that `SVT_XVM(agent). Otherwise
   * continues looking up the sequence's parent sequence chain looking for a
   * p_sequencer which has a `SVT_XVM(agent) as its parent.
   * @param seq The sequence that needs to find its agent.
   * @return The first agent found by looking through the parent sequence chain.
   */
  extern virtual function `SVT_XVM(agent) find_first_agent(`SVT_XVM(sequence_item) seq);

  //----------------------------------------------------------------------------
  /**
   * Implementation of port method declared in the `SVT_XVM(seq_item_pull_imp) class.
   * This method is extended in order to write sequence items to FSDB.
   * 
   * @param t Sequence item supplied by this sequencer
   */
  extern virtual task get_next_item (output REQ t);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OC4CKxbelLgQOONDpWVeplzo9PTpb/SN097VOfMkwfC1qvoO2yT3KR2ZemDYKsOT
30Gdt6FtWY92P8kXz/8ZyGO23TmBlNAtNsd8hlv5d6OSwes4mKOdsiZmsF8Lw77G
zeiC/qWvAXQuuMdVCbaniC4x4KjkeAjl9NbWOOw/O1PZ5qz0OjOq1w==
//pragma protect end_key_block
//pragma protect digest_block
x4MPsVfvG/xOWJ+eV/IwEnmh9NY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
5W1dQStfIETTDT2YTkC83tXMT48=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bR2J4ACxeCM6DGkBCdq4EI/tCaMBz7t3vGjhslxEGD9ToxYYgPUxTJ3ENP4zOvO3
xXCm+BZaARjjrl1/A8Cyv6AZZaFtroPq7MiB566ywEETL+Yw2fu5tXwdZuwMRfVV
wtFalLqoxR0ymRZq0sP1+Fbduc+TDKCOq1f3LAuAsEfNGlh0Y+bD0A==
//pragma protect end_key_block
//pragma protect digest_block
vNvUVR/WkE2d9B6iHHAf8EOqbRE=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
QKzg+zh1bd/JNdmedg/oU+673MM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SEQUENCER_SV
