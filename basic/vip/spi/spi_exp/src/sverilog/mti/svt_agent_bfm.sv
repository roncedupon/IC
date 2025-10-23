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


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ndj/K2Wde1s+6AKMqzFkiUSgpxS/UO2WBc6IOHMv4tMJYIFhpX1wRCH9E4z3wPhJ
DvNAKXIG6bHfav9plxnuFVqXAJcJasgFjkgKls6FCU0yQFyVEYEY7B+t0USCuK2Z
j7XHHtxEhUkCnKkwEqbubJxS6j8QXno3SZLqj68Z9XI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 662       )
L/wBjy+ZfHZQTvKk/g25IubRCVvz0JWuO9XMDILpGWZ/x55Bb+mV8crQEy/rIex3
7vMDzWoxjHZP4ItdoZRGlAwPqlrgtH/ki9OiQhzn0ERRmhR8PXT6e6cEzKlR1g4P
wJe/dAbOBDiLoUo9F24jIZT6xjm7rn/3lmdmcyUb1KavMnAAlaO+yZMEhmwrGiEh
yzh7kA+hgBiyx4QwM++6X7HubYpcBVo9PfrEx84lXW9veb2i+dGOvfGv6DG5SgUI
oRpqwYY61Q/W83NzDT+B45wyoGUmYdNZopuiVLAyhx/UlcUo987+HjRmR+X1chaD
bOpq87NqTFLxe66/uqGFithnlnOTuGHnJHIvFVA+qQjzISp0aUPTRk3NSiRYi2Wo
zMzv7ruCKJdBbV/u6w0GQo2S9jm71BrH06jHtTlQraVRm3CDF+Ry4hER0sPdaiLQ
8JQcCnMt4HiCBjMpR9SQFbi1RRMFmqepVyrA3JRkswwo7a4UegB/YQnDD0A+N8C2
3xF7V50mxZSqD9Dy7FLx+C54OjPFWtCYAQ9pOhuSnCRzs5QqpBb9t7+xBUn1lOUK
ncD8N1RhfUf9gombgTriq+AQfCQQ/JgJfTmxRRFetPfssO3jLbyoXmZpDQLz9CoQ
EfarLcNC5KwGuuvgTkxP0MXyEnbtxeEIMaVxTh5dBinoAxQD1IeE3MK6gq370Fxm
TMi/n5SDaV64GBW3Wvu8bzxzpUkaCDdDUayxJmzj4SC5V7ZV7HAgTF9J7YpVqgbv
nzao95iCK34D8qvrz/5pSS4g8lTNYldpjHE7nkoaClrBhaHw8sMAkB0Te55+j8dm
yQZbJW1ElYLlRvtYnM/VLApqQ0lFwMqS1YZws+gt0wmgxWgm9Hodfkp7d80sIc26
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XAimxeq5POPs9ORwQvTN5feoa3acTFGQWXEIeIragbY0iEVnlxuAuHHpgrt0bt6o
GVm9tLgtkFPCDZSuEjqy09+q7t/kdKSoVXbZGLuZunCsUIg0Heb7D28wFJAaeMk7
vamWr72FYUK+e3fkhpkh15pkRAw5etgM3698St4KUiI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1024      )
Ao2+cX/WtrXr2bIQIJfQ7txxwvn0J/f7sIlth5P2dI6MvAgR+5kZOvH2knmnKvoW
KJX3CLeg8kpm5fuLS2KSNY6pIsrakeqzF8g6pHHGtb5lhgjpkPionjX6Qiw/9luN
UW0PtVJmmwsBzRaubCOn0AXJvpNIeqJFZgOduDAyteNBBcmrsBNhjedtP6UFjE2w
T1cunCxETcQiIZISp88y5Rkj4PZ/y7ELcVUHodtNrPUkjWiQKENLjjSU5AQ7P7YB
V5Tm+JUc2OMastHO+v6Sh2gQtl6uhVp5yhYu9Ex+8CTYzZeqy3BEeguA7Mn7pO8w
2fw9HXVSD/dcbyKjqb3OyQ7nTkWC91VnPciuXDZkKYKZeT9Fwg8Z9PG3ueQKoQia
hZ8Xtk68kq6f7WquvjJz184WHIy6cOpm6M2+zdL37uay8SYYOraKg1mjI4ArX4wb
Wk7TSxSgTxaNVKb6ULGVa/9xGgx/vh49F3BvvrW2Vvg=
`pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HGV+Vyo1YLvi/UkwKc8Z0s5TuXcDB5jAgOu5FmWKhz6uxeNQmrSNjcGB5/4NEBRV
Xewp/eyeA+DoBSOZvGvG+8cA4nAfDAitib0rLuLW3OOFTNbHpUtWMr89ruUcU1o+
4yI5OprUPe81hUr1YNxVBBhhf70BuVMH28nJ06JhOKE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1348      )
DDFPBTKYeP3zPAt8jqjROIuZLJUgJgSAard3XiivPlutDqrGEVx2OeiNcGrvkY1G
O3sZi6aRzbb3mg3Iu7whakpIFnvTOKzlcJheDO4fxi6VAgePIFLH/fx+8KUuawh3
5y9yzrcLWSQWBF3k5gc6+uLrND6JFf7k2MtIUINrGzagrH3aPElsXyPw4VFn+8Dj
/KFbg/vFeVZnmuFQDf57Bul7b39WqS8xPt5nKmraZ8JzL2Wr5o6G1Yi3gXrcVOuT
9NHwTdqckVbgyZEq5lunXBrbCJ4emO+zXsVPA5yNpKZPZ4H5Va3P1YC9rpLYh8HJ
7EGQaj7Hi7N2Ds/uxjv9SI6AEsW2poy7dGbx3sNQpQ4lXUCsvYmLPg96SvRghR5G
uPSVfulQqVpkOYsfzE8ewVAowPQn7VwJGU0Avdn50IM0MeRx5skZyUf80cok7zWg
`pragma protect end_protected
  
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M/lWKluECVCCnsy4O9JgBO4cZ55zpxhV83XTbIIrh1c+I7Jodg4yqCi65Yk6RH4T
3zhwKVezLzxjYOJCMn7BYyQP1A7WQC7cAAu5n8qXJ6FmSqIOyV7nsyyM5e+XAOsk
xi+vcFcRtXNWRhHpe5TE5MrOSlZuDaAWDVaTYMTyGXY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7509      )
O0sUvWOsk9sSotvHkjp6wkL7BkiWVDRKmASfw+a7dAsjfzy0lMwlIxyzFY3XobnE
cliD6s9Ws7OVxr/EHZa/wDgNngnB5OHI2e3yR024vcqQ4l0L071uy8qXRYYIfuMr
WQGb2XqHRx1NBDvgJ5M+mn3jO0Ikvhm6apepwsuDaEFHYgAQLTyLUDmc2DanPBf5
J5f/6DU8piZ/X4vvJJGq+dhZoxgJUfd8T3CUtcr5uM8BFraxYLcYu3kCjg2bkHv8
YF3VqmQryssTTfUhlDiAfVa1QQCcaX1gcqINwUPgsj9tfZf6DDK8NwYL0VnZqj/Y
qfFWlfNEs4S3/3AwqAZF91MyaTEwJO/RZP5JWlI3PDvwisTug2N1r4l32dpSVvJw
LpL0ds8OfuiCl4ngJ+kWSPkjWbJI/n5oR86pif7qxv/vTMl+2L2grlLb4awrCO0y
4xWJKNn+iuDLnjmXBm13F3vm0K3N9hFIlrnTUPKoLWrBMlScSrdFCyp89IXKOJ4k
br9/d4Xj+IAXfZr4FUJA4rY8zemnCZkJaDGDj6W4pUK4D3D4i1u7c/J5q+G57Tg4
o4NNYtjOKjMan1hViEAZ/jCkAeIf6/yR6RnJsfgVRV5qYFl5cEi79FLZ6+qi7K37
0KVv1T7Bdvy+3cLcE1Jgg8tib8cgf6QbzYT11AkqG6J3Uiu9CjKawoGUmoOxd96e
0CNU0P5cOnAdGXosBjZF1H2gr04s0gjm2hUg9h8ocngFGaGFPgCW08NvWk9Pm6Lu
HZL9Kz1rzIiXVZfEkOiMUQ+EL8lGof1c+1bfc+kUWq9CtdM6Alt1IoGN4IOIle70
ixRAl5eBREHyYiD9vIMNKwJET2F9ZSpW9lO8M3HNcN8y6Lcg2fdrfoIxL3+pGH+D
Uxww+2Xas18HBfpT6UOaJnl+jsTe1Y0YMqwvqE+AxjMFzA13OQNdQ3VD4KddTpdx
JVn/eaYcrdA3spwrzlc9nvSdoH3I91GtittvQRR38asHf0mfIgWHQiQL+jw682fm
sUszc+LB6VswVpWh5vYT+wd8ncP19QYMlsf3YN9npjXR5kUt25lTNiSLvQIuG+2G
XEy0BXTRU4u7g8lqFDeF2nyI3mi/SzUU+rRAQQ/3VKub73WHHwbSPXBfFWw23QdK
ZdYFjwrWabd0+Bb4PhwD/6ma2/P8+G4sIdli/SkGLF8m8TZMiZuDnh+MMBZzRGAU
PUKLQLnc06o4G8iNRzWh5za+QNgqI1p4S+obkJ/mqcbWHJIcaEC2aue62T7G6lhC
pzBGR8ujS6XW2mWxRzXtdfQTtpR05KGlbj29h6bnts+sH0eo0coFBxPFEglag6JL
a253Z3liG0vLXKKhndQhgujGo/SwoBzhcnpc4jNMblWmnBGZkZH5Nv+MdHl2jgZ7
PghYC95TEaWoCUdc6kaLMV4MqhxiM+c096sml5EmHpaoUc1qkSlCYlflFPjYU7fF
/dbTqXIgH8Jvq87rkKabXo64bW3sGYuIn3TXmUTj7hIHFVZl/Y07MqaXRSsxiWOO
Vkcbm9P6hSyxhNhKj/xQK+bD6vh1/kOODf0dqfOdzfqDvjlnvsiISKL5QmooHrTi
e+J4uxTpv1cZ0ipe3HX4ybvZvQncpglRbFNTdT+7AqFOoorOm5TiK1CrWSN1Zh3T
myntPgmNMtr/jdwV8xziyJFgfue0+/Iv7nTtG2KeeklKYFriCc8DTl0YBZRkOS0D
8H/JHdCges21UYVcL9xAfwjLy6rIi+rC69Rz9bL/nM+ZZIrBei4d/dPjsCyD8ZV4
d3BRfDWIegRv8zJOV0RMVnH5OfdXlAmPgnfy37gnsmCrKviN/8MiDGA7LHW2mj5i
ZnYVWnZonNrbvY1pfePHw7MKlm6q35y8t4nB5ousxRNMgcgj5STCj2jHroDrQJA4
ElIIk4j12iqWG14b3GJNzTGoEi5kxUTTunXYk3QEqtwSCdyC6Hw+esCVAX3XQI2T
AHvtSlFWBLPtsb3TLutqrBO8sInQdJxb/16V7aenQJFMyrDg5YmTuI8UKuVIRisP
JrnKWw2A6DOuviIE7N3KRdsbxj55DzP+mLNdNRQxCl0ho9TusVa6X3x51lzRDhEo
aYuosUhWXZf1LD115eZeo0BuRuGJ6YyPA7e/e5GgJahZtkbyAY/I+18xp0R9haGm
qZYtfsCA/2vJW4CUhntn4K6qGqzyjfkwNYsmOYJcN2rOgeEP49SIok73t1ViZf34
7+zpGkj39Vjh76Syut8OGevLcZ6eDZdxzoluTa8ebIyam1K2WbUv31WtMRkUVX6i
s3LPErDEz59Bqtpquk1MUSELLEynva6J2t9C83XeqwGoEqdy6uVGcRC+h1OgKgKq
juNm8j6K+qiOSSapitWNnwmLIBUN+h82lUt5NNRcfEWI/CgJ8pnDy5gNNchKSf0i
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
`pragma protect end_protected

`endif // GUARD_SVT_AGENT_BFM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mBiFX6LW29q/Yvxsu/gHuvfhdbws7JbRO3F8cA/K2QPbjQ+GpgeKhNH/m36FFra8
aS/jma+fT8AK0XjTGudK9SHAk90zFbR3+icsArWInnZtpsxQH8XZg7d217RzQ3y2
ShVZgIipCNE3EfeqqfF/8DK7zVceunEhapw+5+PAE+I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7592      )
Fqc/csPrZ16hTkSsuKmgb4Z7V16mha02a2ZpUoMwSJG1WeTiYzyFrfLK8zZTVytl
VvH3WQQ9JrCTtejtlKcsahUZlVQ1EAroJ9h6caDHx3VTEgiF88w25Py+ARp8DSfE
`pragma protect end_protected
