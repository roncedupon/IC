//=======================================================================
// COPYRIGHT (C) 2010-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_AGENT_BFM_SV
`define GUARD_SVT_AGENT_BFM_SV

virtual class svt_agent_bfm extends `SVT_XVM(agent);

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter = this;

`ifdef SVT_OVM_TECHNOLOGY
   ovm_active_passive_enum is_active = OVM_ACTIVE;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** 
   * Flag that indicates the driver has entered the run() phase.
   */
  protected bit is_running;


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PchxW3zJdcuxlzH79IDbc2uqEy0rDpThDWQia7fiBGLqddyuLoa8UPDT3fyULwTK
2rJt2CFnmYzS0S1j9YEDrcyP82GNuMk+yCZ1PtU8gMURxaPYQ58p6nNWrYmzcJjB
g8YC0en23/uMlp3Xwhva7MLealemmJXfny8oXo+EWl36GeqDOoZ+1Q==
//pragma protect end_key_block
//pragma protect digest_block
ovPNaskt564ih3Lp1g1wrRC2Xlo=
//pragma protect end_digest_block
//pragma protect data_block
rR0oaYFlmOh4YdtIYmCYYkYRLbLOZTB1uY2L8UnjoVpmKqoRyYLdXuKMgybkf3P4
pgEXrmoHArZkmbOuGtt9Ga/7lnRnsAoduIxMa/YkQU32JwWVUt8LMDz97lRnKb7t
VhzFqKJTedhXffglP9oRLsu/y89+80bH6HlFgbMBlUh+ULQR75VAj13wJ698NGlN
vwBcbKv+33EqLFVnbL3CwOgxNcnXnN6v9AEsSzwo38IlRBQ6AECxLGuLTp1nLhDM
58JikCLDiwcv6dR0K44HLdT6XCZ5PnbefziznnVlv61fmca10yPisQS4eeGM1oK2
JEv+Lb8GTnDrIQI+LYtABagBr5BqiEGT8LMZBfwxBta5Oy2r2aAyjpVhNmvsHAe1
J9YFRP5vOi5NeEv/bmZRoXZunuC16oQUlpJAc2fjEzwOkJAcOZh1omSnyxZN7yOz
dtMAjJXNXm2ImG9gxL60bMKzQbg31Lkt1l27XGzAKhvV/X6ZtbVNnLvvXBl5yhS8
UJZc+z0MHDPBPz72qBJOhMppP+utTxYpUw1JJCXHb8IvhTb79xH+4u3eJUEYho7E
gVczo242LVtStpmXnGEi9p2USM7sFv9HazXHBBIUiH3XFRlSBZ+38+eAnOBJwtfj
76bAQI3J5ENZqeNvLI65IQdXxrdpaAUzJ73dVcT5KaI0sR++by9AmurS/enCRGii
jpBDd02lh6hZaiYMY7zAo1/dxrB5hRYwyQgiekHLlAHTd0fVSiGPsmCdZ4/SjqV5
pdQZAR2XgAomgKAYxHkT4QXuIwI4Lc7DHdaWpA28LdbwDI3FLN/QmTGbNE1vITyN
4oKtbqWXF3d2uYQ/jmpzBgV/++iUn98uUweqEJsQeJopdbt0x46yR3YNa5xaMWbW
oPc0tHWNq+Tc/Z1xengAxXcPe83jpA06d6LKdyAxVnfgGqJmhBa8IC6fnHUuXDTk
XLwhFwcqwuzwGIC36IBX0jketgeDzwFFkkLkBX8jIECY2a2Nz7yCV4uaOf154PVe
ACfo/0LXli95Q8SRtdwJc+wOwVbFxPqL3MUqx7y+zeslvuU4ZHO6143F6nTZMrlP
Mn4PcHL2jeoldPiVkggKBg==
//pragma protect end_data_block
//pragma protect digest_block
N4bxhdhuPNDZBHMYA6yauZFqtn0=
//pragma protect end_digest_block
//pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new agent instance, passing the appropriate argument
   * values to the agent parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the agent object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);

  //----------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HB8bkp3nYx9i2AIUImgqqfS37j5rC7gKKcbk75tRw+WtbfitQ8teymvUL/LS+5F9
il25e4TRL8riWVOJE9OZ73Jz1MnzadkobRA3qSp6FubD10d1LA5VQQ7neNGY4MTX
PPlMTewPzMLKdNcNoG4mMbJLdVwM+AP164ad2B7AIkWWcKq76iDaxA==
//pragma protect end_key_block
//pragma protect digest_block
FvmJIY+d4JJ8vtArMrMaCFdYO7I=
//pragma protect end_digest_block
//pragma protect data_block
Vjl1z5kUPGgARmOfMNyS0iXJ9i7Fm/giAPLDq0SFf6xHaQSFM0n21Tx611EXD789
3iKT+lRIAymHFU92q6SHPdr1HUnsWSgeLjh4/PZ6Z/bpSQ+jmqW9MEBmcboPV0F+
TsSgGEMUxv7dju+Jg5Zkt1tr8rO6dWSRnjOiBYO5Zsq0ZBLCVlnQUDZ0IlhB0GZl
wJ3v77GOpVRLgp1SAJZmq7UXGtmMQmp/8o10J2Y0u2xaHHZWHyewDPjowv7+Obqr
2mXvt7xWXed/5jLZkFdzMxyGJTjNjJgrGVFjwvUm9XTS57dkr2s1fCrJucF24K7F
HgWDeMMOb/ls3B7Aw+ZJ08xibZsSa3pf+5ziziIdZQ299hql+qEQTOZVys6ywbpY
p2Fo41cz2REvP+Z9vFdR9gzPTGfgTB+17VNptW1mEKoJjld87ka98n+HGbEztg1N
lmoVBmqvqrLcyNcqEkgFCKVAEGOyPKIWsvrTgTZzT4svjt4m9KyR7osG0kzQKxmy
26FY7EjkbTct4E9+rObDIPLCtw4G8XPP3YoAElDrCDddWdKoE3U1OK6E19ypONMy
UVLnhIW8QegnvLVnl7FVkRYZrkUWVAfpjEWXcHEE9/cf7d3k422ODAVmC4JxVLpr
rqmM81qYDMpl3YWne0vIsvKd34qcPvZGfR13GDKFS6foMyLq1Fw0ON/k/jcIJwSq

//pragma protect end_data_block
//pragma protect digest_block
Jhv+eVXG5M3FdoyeABWa/Hs/PJE=
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
iPfsu8hLueqfpgGoHL+Nxstra3QSirleowENxsjN7+eMHDkKYIjLwkn9fyGP71nA
jm8KwyzY0+k7mPib0AGO4+D0B+4BwWBAWkDU7WxUsweXOsd2E9avSYeHuiK5fkYT
3F4VcMjDif1EyPQ4R/7X9ZcXxINV3j9F4RETVwnsF5TbYrPXBmHHDQ==
//pragma protect end_key_block
//pragma protect digest_block
IByFqndrfuj5FqtCGy6LQHjxHPg=
//pragma protect end_digest_block
//pragma protect data_block
TR7+xh9vhMRQKC1U5J/qy/3hjIQJwX6hz1iQNAmYdZ3ztJqXYBgNwJiMlJiiR01R
ksSx8U570h6Xy0//oslWf5NPv9z6qE/IDsykt/tHcUsm0x/aNSWAZH/crCXakn0M
U++H6y8SgTD2jw9Gnf/+WpEr6v9QlzhoKsRu2kcjg62w1JhbxYA/rSLrWILbAa9j
9Hd9X7RtbFUHeNsgE+jF81UNbsl3bsi1ysdBddg/z/sNv1jGvRGmf9awFPCFeIL2
zpHj8U10PF6XBVnZzWVaW9yoc7TAnRdbyuXcjQhjGutVcgF3thF4v3HlW33ms6Jn
FYDhkJ3FMUP8Y4rJ9R5fy5RYbq8DRP8FjC7D+oAB9CosJH26kI7SskzxvzvDOJFs
SBYrzWCI2akSjcikQv6DlXOIDIqAGj7y/LxB/dC6co0GE5CLv/Ho64kjqtKCTgkz
E3yy46pgdJhpKwZ8EDzKhgbQpsLbYzeB5ix51UZ/DxDGrcDah9iRFaYHSCiHyrNl
9pWo+dtECJQ9crhP6yLdQpi03FdcJMHAEpUCjaxQ3ZIBm9kYym8jjJ3stl2ALpnN
RHBkfyIW2REPmn8ykhQv4nfkdETCUX3Vd+Z0Q1V0PfR4v+Ngx+bhBNINxpGQBG8h
3L7CpBcAdZ3MAK9ZXCP/pA==
//pragma protect end_data_block
//pragma protect digest_block
dE24/V/37roW09HsWEE6bFGpwm0=
//pragma protect end_digest_block
//pragma protect end_protected
  
  //----------------------------------------------------------------------------
  /**
   * Updates the agent's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the agent
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual task set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the agent's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual task get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the agent. Used internally
   * by set_cfg; not to be called directly.
   */
  extern virtual protected task change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the agent into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected task get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endtask

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the agent. Extended classes implementing specific agents
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the current setting of #is_running, indicating whether the agent has
   * been entered the run() phase.
   *
   * @return 1 indicates that the agent has been started, 0 indicates it has not.
   */
  extern virtual function bit get_is_running();
endclass

// For backwards compatibility
`ifdef SVT_UVM_TECHNOLOGY
class svt_uvm_agent_bfm extends svt_agent_bfm;
  `uvm_component_utils(svt_uvm_agent_bfm)

  function new(string name = "", uvm_component parent = null, string suite_name = "");
    super.new(name, parent, suite_name);
  endfunction
endclass
`endif

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SPRkXM7EDQnaanTAgJT10DeZlyVVzqoHocUqy35STclvv7Fjzk8LcI3ZzIPd7hDP
oowIF/d9sA3GiNrPHdz7EV6RZ1XvzjZBP+hENYxF+2hcuAoqwQ9Ozh8QET6UEd15
FOJsYPIzJq3O6TAHnu4ENhmJ3rTpvCgOG+JzazhYUbZqwrdFMRO6Pg==
//pragma protect end_key_block
//pragma protect digest_block
VNGRJzxXTjuxHNrIRJulLce52Eg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
om2BGmtDEc3o60s8II02IZyFt/o=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_AGENT_BFM_SV
