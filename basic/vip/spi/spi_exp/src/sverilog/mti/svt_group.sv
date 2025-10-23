//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_GROUP_SV
`define GUARD_SVT_GROUP_SV

// Only compile the svt_group if VMM 1.2 features are enabled
`ifndef SVT_PRE_VMM_12

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WiNMFZckqKijqwjyTcXDsH5KcnGofFWGMrlDodbeEGIbAqu1nBcZgfd+hmtVeCIY
QGVF00dULxAImg81JSDPLakNQBNWJ3Xwlr6Q38tPyvqxEhBvj1BpPmXRhIyueBmL
IDwqGjhUSyPdQ2RNIGf+RSxkLct7T8pzmbN67iwW9mU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 242       )
nxrR7OrUkT7XSHRGovvrzXH5GgWBiJL0L9R06WAn3rCjzj0tP7SueuY4hrPcPg2o
Jk7qZmV7piThAyHdnahoqz4tRQviNau7BEXQghCvBXMmq+/hHedtBa0aAQ3Fjtop
/BeBZSCn+AH1DvUukhJ+ylSz/qvg1Itr2ADtBSNlAy/KT0z/Wcxrg6tPmQ/36eq1
Qokt9PEhdpV1Lgh4SCPeQM1FgDVz5rhlieerzyg6hHaGz6RLOKIDrjE4LFA8huBA
/zfMxytQ1qtP6BPiWchmGeSxyaVEvpLiJmNvsfn2IB3vPk62zmDglOGi7s3lJu3q
fi7prQAxDFYYsjPGOyCPYg==
`pragma protect end_protected

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT groups which
 * are based on vmm_group.
 */
virtual class svt_group extends vmm_group;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Shared log instance used for internally generated data objects.
   */
  vmm_log data_log;

  /**
   * DUT Error Check infrastructure object <b>shared</b> by the group transactors.
   */
  svt_err_check err_check = null;

  /**
   * Determines if a transaction summary should be generated in the report_ph() task.
   */
  int intermediate_report = 1;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Jw2MdmodiokYaY615/0XNOy4RqKl/Q9cjhKMCtBnCvSiu398uib0MH85lwUVVwan
u7xv3dk+U/qAAAz6gWDa33Na2iYk1b2J/5CsH2BesJH2+wGEuti5ejABML1fKeBC
8OIUwrX99fib/EVXlRvYDioXwb0mLLYyB1FH4JfK7kc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1392      )
pcGg6+J/0sW/pLwLtCTLrMz7atsV/VtEg+T9iWpQtFBZQGeQ8YJxlmUzgnaKA8jL
bEEdZ8WLlSjmDHI5V7mnBHZHc1ELwGiHo9o4p5/8CsDUPXBxDx6llU2Ex9sLyzvz
k0GbrfiKDKCdBhAbbtKbbmdGFmZsh4u9Hfx3CplJM0w2+GJnJ6ohZZKui4y3g51+
mZEDPWr7yJYJ+WV82ohmu4PECe4XXS6dudULSQy0iDD4hYOqtcF7OQwnpwCr1Mxo
e1S0vVElugqO8aaqbwwQr5toxqe5duHb/NDu9QXvPlL+8AVKuxZhKZpDGPxwVYfL
qZAUCSucLqr1oIg/Yk8ybMz2XvVDXH8CS33GergTTNRVnaaQcy9lsS4ukoN2w84d
1YxzmDCqYX3NVDsvtEP33pCrGx8BdSTBDardQ0+IW5YWgbBebrL438BMP7wUJgND
L3DMckQN/9w9fLawaibg7VF5kpO8wpNBsh53zlfciZDXNhvCGIUFTby9LVDpBs2+
Ck+EcqyruAL3RODX1wRUwqX0sXyyJ581kS0wUCG73tQlrRWnLhbm1triQV1nsAOU
dp6b1TbSDA6i5tAPJDtF2UaYMTCoxFanSYBujNdtwme2Mo6ruoWrlxmB91OTcHAg
3CNOJdGDZnwZf5j6d/SYB5j6XvgoSmiKurGhXLtJ2YVp288+XAFSa7xeSUFQSaRK
fqcJl8oZfT64o6s5MFHA+jghzquVCqX0ojw0g0PhGnLcTsbbSSzrS9DMhhJXjnPK
LOldDrGQKXtw4o/TSOLYeYPm/XZTILXHJoqn1nYy6Nnw8E1efxzQEgf6AKYRwZNp
Zu9SOnzHFMG1Mh0eCPa6GCHju97Gn9TcB2nrcE3r1Jz5AA7KOlZ8uKumVg1GCuJ+
lsPRetNVNGnJmqv3cZV6aQBRrTv3AIg910YaxSsTMPVeKul92HfjlQWbWp/TgsAL
cD8tR9D2EruGYQ1IjnHfRIv2dXgjJ87pLTj0DnBQNW1tkBJCPpQbbTfEDI5Sp0K7
ryaGRVeNOQVDnw0kFpLz2gGSMnpSBF9bDPbj1vVrZdll9Hqw6bIRw34O2cOd1wKH
pCTjdL/Lgxku8FvM0gHikQZfM18RaA6fjNJmcD3S9bg+KvK9emRPYbfTlmBJc9yk
sMrm6Xy0vXwBHATmOkVCNkE8bIu0lkW9Bs9ZNq6pTJfQ/mLLm1OGMxTNagYJqFPa
88bjpuFdgUdHrpnq4AXOpKOsCeAX5pwkOhk4sDuWzM44hYjvwOorOAuw6UmRf3wX
4e3f6nfSr8iDdL23Dj0iObEHQTum26RqJTN4ElnH+jdUFoWGyx+OiLYdz0TEVG6u
P4HKWcgIKIcAaNHAOzjI/ComPrsXFlcWB/xTzcR2AYZH2vPuAClYsvzBNUGPdh27
Vr8l+97wuIQOvAYSuBo2VUgDuiC/gcQaAcHMhbdQvOU3M32JdyH/poLIe/3+gdOe
+x4pGlg4Un/BVznxSJVnw3UmWe3SE6uqIOkRaaO1Q2VZejNkAvU/NHj7cEP3675q
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new group instance, passing the appropriate argument
   * values to the vmm_group parent class.
   *
   * @param suite_name Identifies the product suite to which the group object belongs.
   *
   * @param name Name assigned to this group.
   *
   * @param inst Name assigned to this group instance.
   *
   * @param parent Parent class of this group.
   */
  extern function new(string suite_name,
                      string name = "", 
                      string inst = "",
                      vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Returns the name associated with this group. */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /** Returns the instance name associated with this group. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /**
   * Sets the instance name associated with this group.
   *
   * @param inst The new instance name to be associated with this group.
   */
  extern virtual function void set_instance(string inst);

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  // ---------------------------------------------------------------------------
  /**
   * Sets the parent object for this group.
   *
   * @param parent The new parent for the group.
   */
  extern virtual function void set_parent_object(vmm_object parent);
`endif
`endif

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GISajgYW6Yv6VjKrY3G55LiuFZFUnhM4U24UH5jW1IvisumEpga7rwh6FCESJOQz
dBtmEhdemax8d8h4qUnwLUBvybfhbRislVBKglaV3mMVNQS77bOlYaR+I9s44nu0
BPdXQUU9GvUN457yloR2ozmBIt5RU1JNMDZ/LdvlN8Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1795      )
Ik3hOubLQYqMYqScZRtwdFA8b0NXYBRkBZ3aepI2X+Az4CCSfMsrb9RKBhoc+FtE
gOzzidifgFHEB6Xe/sS56ztb+7iGo4AsrwgHieJK1ff7BFMt2nk6b4JYf4vor1EQ
nBWeeCS241GTKsI/Hxrz84D0iQeFISgVak6iVrCPboFL8nzupb4yep+wOP5F9G5Z
+gVaeIuvWsF2B6noWj4H6ZnSQmoutzySm2eZw8ZFscRFnDlHoMb7eYXSOSzhx7Eq
Lz+h76wxRrEFaaoQuDj6nGJznDI/hyzRpswH3mbZes34ypH11R+DEzzcbPffo9Vt
UosZ9PnhYAxz4pRo8+wU4DM4hS6GqkyPFgIage4ZGnZczDwNLBWb1ZVZTjH/b2Ob
v1eylketeMb8YOZwgPIHBqsGUlIhZTjiFp0EDY1IDwnsmCERdXp0/QH1hXKN7Qsa
84MESE0UZ5KfhG4lTRecfbGADCuKm8tZL1qvtQgCXtgKoUXLkXL2S4KICu7/H4RC
Nz1yJK6yfEDW4UWSIQKSjBjqtgfp6Cl+kgEbz0DcMmw=
`pragma protect end_protected

  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RiPLxZaDcCeLEMcO5VpCz5skLWvNUbIWqlvJSTLF3EfOUJSTJmB9O+LtNlFKcHxP
HuEzmRIioqkOIEGcVpZ0GA9H8MlWqVNHT1xcUu3D7L4po0ZNRCVI3kraPzX6t/6F
7aJ/TDZ7OwyhP96c++LCRhcoW5LqCZclv8SKpBlpY08=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2098      )
lV/ZKRD3KF2gQGWbd20BDHEYW1WD23CHrP6Bim+mJizBuHY51kpBhkNyrQ7rHb0k
/MvG3/Dfwimt6fKiMTsFyntiNFLGpZGPMpKF40wabYNv4u6k1naB16A4BWyP4tXz
fYSRDhB77m5qTZli8r1TEX4sc1CpYxHCI/aM6O97PJfbcb0ylchruqSmdjB1XZ5l
+Bphi7uf32FSKUIMI56v7XJWIqQqxP3ADD5oisPILQf2MQuJtS4S1dZ3pEVBRNpc
VXjpwjBenQaEuzGV3paL+dmRx7owzXS/kPs8tpWzn5YK05ZdT51VXjvE4913c4jr
5RBtDJHfSr71anZOQY5Be1TRCS7K9ms8gxMng44I2cH7wNswzlh12y9A5vpL0d3H
05QS3RO+JZBZxgiZIVemTw==
`pragma protect end_protected
  
  //----------------------------------------------------------------------------
  /**
   * Updates the group configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for the transactors.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the group's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_group_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the group into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_group_cfg;
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
   * object stored in the group into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_group_cfg;
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
   * type for the group. Extended classes implementing specific groups
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Used to identify whether the group has been started. Based on whether the
   * transactors in the group have been started.
   *
   * @return 1 indicates that the group has been started, 0 indicates it has not.
   */
  virtual function bit get_is_started();
    get_is_started = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * support a reset in the run-flow so the group can support test loops.  It resets
   * the objects contained in the group. It also clears out transaction
   * summaries and drives signals to hi-Z. If this is a HARD reset this method
   * can also result in the destruction of all of the transactors and channels
   * managed by the group. This is basically used to destroy the group and
   * start fresh in subsequent test loops.
   */
  extern virtual task reset(vmm_env::restart_e kind = vmm_env::FIRM);

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * destroy the GROUP contents so that it can operate in a test loop.  The main
   * action is to kill the contained component and scenario generator transactors.
   */
  extern virtual function void kill();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void gen_config_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Enable automated debug
   */
  extern virtual function void build_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Route transcripts to file and print the header for automated debug
   */
  extern virtual function void configure_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void connect_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void configure_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_sim_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task disabled_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task reset_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task training_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task config_dut_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task start_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task run_ph();

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task shutdown_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task cleanup_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: If final report (i.e., #intermediate_report = 0) this method calls
   * report_ph() on the #check object.
   */
  extern virtual function void report_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void final_ph();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
E7PRLDwKo0r9bu83D6js5ZJqfmce4kFF6XSrZRot3LnfNtRbPqr761I40pyKwTb7
YECf5aj2zawPL8Hu0jATzhC0E+wXiMti8En6dru+nMiEoCwR6UXQOAS9DMJmt7/t
eKQKsp4OayfCIOfFWsGzbAwyMEGd4lBThJD7wMacZGk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2620      )
L/XXM7nKLPG702mMbtgTwhLY4y6T7i1qpjfDZMQCbCPdzKiHOndYSyYAwzLweUsC
RiGkIUffgAkRJe4SQM2jwY8rnFlV+IOMlwjiZhTbQZc4xjMrWe6HjWCLGE9FJOuL
zaq6AKFkTtD2hOP5YCerKrSGYER2SrIkQRbFkDJ8HG92Yd8A+BvliP6s5PxPLnqK
8mwREW6OZSbwibABvxg01gdxQ0GrxMKqsvKSehDlv5lF/fXbA1si3mJnfLgg2Iz7
PuBzunoTJ0oVr5ENZWa2O7XUpRCz6TqJ/LxxLW8nFHZODfOZw3XYNeLk3tbuccRu
dAVRFgnyG1Fjj1tAV8SEFkgpXuh+xz3/D0nUDBQ24W5LCIgLIKIyUJ1AcEw84qK5
aJPSwTl5Zo7LL3ipHhwRM9Digct0zKAeXW/BDZi08+fvmJ3xmyGcmXhIpIZhQEL8
CrUA3zWqDhfqcDa55Kb3qRuhs6EZOhgUfk39hczXSzSA1n01ZHnBlnBo8qBpvn0c
x+7//7yDoECyZ+ElfP5poq71Cgzg00QnptypURCN5pBJD2C2RBH2iZwXSevNo651
A0tRmkirjOYG/AywmLmGa9kP3VZeZZ+o1zJWHed1PzJO1aCijl3xSA1TYbNbNDiJ
uCwUvp5nBzcJ1oBKxC28kMrIAH2Zwn5SocGSZsRvezpDB+UDyLatVe89p2RYcIBl
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * If this component is enabled for debug then this method will record the 
   * supplied timeunit and enable the configuration properties that correspond
   * to debug features.
   * 
   * @param pkg_prefix String prepended to the methodology extension
   * @param timeunit_str String identifying the timeunit for the supplied package
   * @param cfg Configuration object to enable debug features on
   * @param save_cfg Configuration that is to be saved. If 'null', then 'cfg' is saved.
   */
  extern protected function void enable_debug_opts(string pkg_prefix, string timeunit_str, svt_configuration cfg, svt_configuration save_cfg = null);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

  //----------------------------------------------------------------------------
  /**
   * Function to get the configuration that should be stored for this component
   * when debug_opts have been enabled.
   *
   * @param cfg The configuration that has been supplied to reconfigure.
   * @return The configuration that is to be stored.
   */
  extern virtual function svt_configuration get_debug_opts_cfg(svt_configuration cfg);

endclass

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YILEjjyV6BsJrHVueToGR5xXEVzP3euUhZct1NBnHgbd8Bc/sl3FXc7gnvr456yi
JY0LTUJDpjZwZ7f8bNDzroqJUDk/4Sc+06Zx3MiS2TI8t3jp9suuVEdikgDwb3x5
ZLj53MX9boIgyB4KVXnUf+XmoWPLWLjsiwUVpIbjA+8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3937      )
7HyrsKAQgp6QCUO6JDhpw7AhasecRwhe1fdc6c2zEQngEKL8AJ+13P20xl2MkXLa
fBK/PcyBvLcuxBp0HsDGqzKv/kUcvuzKWELpwZYenK/CqzepnSExMtEct5JX690X
8cFVj7sZEOwmD6EAWiijHOjxVKSV3UUvPK+Obu6UHcfKZqcV+lyTCBEian0Ax8PL
08UaxcjVwI/LvJzByLfBDGlgSvAyvdqktmMZxZtN5c1z5OaHuV4LGKeHcbP0OJu3
dtkUd5yBNZgHvVgYgacchA85CxNbpOcUoCb08Sf4U4G04rCDRol7HjzTRkWypqmS
UkfLUv0Zp2UO3reOMO/z6ILbFmsgZStWZ0OyGOrtN1JK0yczMjOCIJ123fp2DQ+F
/nRn9r5vLeC+Q3Eoi1afdLdkmoXENBgeZNdHqm9hIE6CdbYlX/pPG8X8pPNzoZiU
rlyiRvebyWbqcjyyncu/efvKf+wAOkBhv68pmgfRXlyjn44u7MKieBgZVieSqsE0
sECBDzemXsyVE9+EjTWbVUqLgHqK50rAYOKy8rvH/BZ4fWqU5UzXNC9ShgrYoZ6t
dJBhBKrFTuby8WfQWv2BH0wCXt/KqcYxzUp1DptxRUevPsFm8E8lzMX8TPeWCr5I
jkYGVMMi4A0ecjvWnbgmppg2KB3CO+9gV6AEqrVzdpUDAdN8XDdIJMXsfOuPOmz/
QkTmaqc1V0Wt0WbOa1664KTnZ4QSb2I/YmdzlO/idI91dJB5f06ge1XUN//qc6Jh
fXpSNQ8dumUkwo/k0Ej1IASnJWeR4q7s8RKsO5t3qKKLafjml8+wlp9UmPjIJzlB
O0mkAf9jNv/scEzRjdNcz+oxIg3ntwjQABBDaZ5RcZ03fH8xvO1mg2ZDS3ipybca
bRl3niF19S4kr79bTS233gaogMGTh+swoCfPQcM03usmJtlrg8kOIAPZpBQbVbA5
ymF5L5F0narx/hOef2IXqPYhudhfWjLBflRIAZPDzGFczWITtkHyuMz9JCfOY08A
6EQ/0SM6IligPhgOmLgu6hUy/Uc98qgT4cPRExzY3FRxNGawnuMIbW3BV26h5DFL
RQqGLRLj5boRZy05ovfMbhfvMQUas/eexIFrhSb/ypdquvvQbI20a+w8lo7S9AI6
gl5cwSToku+vhx6k4xy4qU5EMYajvS9GWE9sGbbyGQAeK96YVUfV3xsvSV2Q5EgH
lSho+I1UZjDn8iLiNLyho2YPEF/Ic9UdOpSWm50bMPaOqMvQJRxLLzpff6INDgCy
7/iKEuq1eyqSA1ufPpENwflBzbU3hJ87XyoiMTToqDebYNjCx9nwD8RwxBqS2h/B
qsS9EuPJ3gUYIDbnnQkThdha/pmfeR9LXiTjb/ATRXqV47gyGY1f52qkPOxY0KKE
QHsSSZH7TGPZ8MvmMZkAmfzvGFbRnwD4al9x/T5y7JOAnvarPvRu4z54dlGHrI9f
v7PyWbaspdUaw/10NVLLA1OVxYF+DquTntd2ecusmxv9j7OLdMqYDSBoqJ5vnixa
WoUyMr24xTmk5NG40XPxLvB1qMRKyY/u0gQZXtUGwMix399wYVofwPMOA+GIcdqy
s6ZLci4OF+l6S5jgxigVdO8mlDUw6vSPm+uV9q50fa+Qz09vXNxXwxKtEKu7BblN
exE5fxk4Mw3/Q0a7uDjoKoQOgYz5kbzqvdYvR4Zi6prvSJTCZBCpSKcSFyTTdYPD
qd/EYyjXMFt1HgIUGnlpnSq4X7iPKx/KGz6s9/pq98w=
`pragma protect end_protected

//------------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ttalhh1eA4V8+Scy1pk5ien2ay9dpwpPLuS6woLs7U5MefGQYJvQfgxUWDXb6x7N
9KuARm0F3ezViHxme8qWValq6FlqeQ+cWk5Zun67Gg5ga6P0N2fG+v5tkGpmvWRD
oYMt7ALpoeznsSND976gesCjRtAbvrO89BJUhCvA4IU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17080     )
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
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bUbuHczuFUFEHbh1c3NbP71ciGwcnU0F1O1226vRzqQmwGeBHh5nZl0f9ssHfaOQ
Gwpo4J0HA6Gmm3Wj9fxLyPnfqhuwgDcBaHHyAVySVPxMv8IpmDPoBbWRwJvFPy7W
jjkgL3M1jdb3MBLzP8USYSuOYiQujQDM//Dl0n+AN/g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18275     )
Nwg4n5fa4fNt7LlWjpse+cNb6+0u+enWfWW2pyVU9kJGevMhCGqQuBeRMCMIVoE3
KtrOwo9OGhzFF9c0eDegY9xUKL7WdS9RG5rqtg9GQfEihh4XXlKZs8PpW/2fjGPa
o1T+PeCrkEbcyQMGH60VUK614L/lpd81oFNujyPN8vdl2RrXshlYhCKOJPzGEqct
MANZqvPi+ilVKdGBJSh3r48CzhrkufH9OeV06K7Q679FPu457sJO/HZni8Vu0Qhw
B4f0GqZ5KQjSKdZd8PRpsB6J6EsDDr5QTFzZRjm3917X3BwQH5WFoCgscCAW8X+g
NOLp5j38ZSexx6bu6a1f+kVdcSPOfznGsAig83y0w3sutvawNh9u0sxjH3ldcgCy
OEfSAQ+sc71WU9xTX9EB8yyP7Y6ohbm9kCXB5zbtEtMP8LVeqvji6cUXMQMwD/JU
TbGZZJHrrfEk+a8xV8492/zkIYOipophzUo7G575sIk6EPBODrBBU4ifo0pZ6HCH
B2b1PgxOc3OWG2seXjIITUlKZJ0WtCC+RA7NmHd2Pl1lz0Tv69G8pjKhyTaUggyO
lu26nUb/7lgeNB0xVwICGxwh9F0lE2XfCNUFpTPG0SaKvp5XXsOQLhQqtkHi50Ja
wHXIpWS3QQPgQ5KWHJJ4AIiR+V8rXdv5HuwnT8Qo26MvGXwapOKVtIGUfjqMC9ki
8U/CDMrX2njIVTkUFiNP1mx7/23O41wuScWmlssE8No9OZJDCDMbKeSV8F1L82S/
fke+tkMEIr4+hxLmLHhMIK+DZMJjQi7SB/DPJEK8GLe4XYwclu8pFY1ryJvQub2O
HbMfD7KWfJKKd4yjJngGnqT2elcKX7ECUReICzEzvomsg+LsrjAvmnOWYNVwgYJI
NSXNFQolnJS7wIZs/BrSqf4uyCZzlDK8HEuhQGbFHab0OEQXy7IfARKotc7jexrE
o2AQfUErHO67q0TvZIbK5tUFCa07elrWEYiB3GLb4u413BDErK7G+ENJsNdvVdRu
PO2u6FujOo4RJNZKuhKte5eGYTWUGhW+UpNAt/dzm+Pf5MnqD8lbInvh2tLcrhqK
0rtyrW8CIWoLLid44iupEo2FG3gRGJj69KiFZrwDgK73wRPVnykYD4brYfNQKn3k
p7GibR6ewWH0MK9TzvAgcx4rFPMi7dZtXtygIxLVkf8e6gOLa0j5WAnHmaXIm9PG
J/tN9OQSxjf6SmU4oHr43NcWLPC3Jjt0u6GUfmd7b05q8ps2QABtqbYTIobUXL+v
J+rlJugcca8YAiUgvZYcZ4OrRzSSLjWF7J82dtLAoW+sc4KePHFQCm+L3deSGHy7
uv0oXOHKXE21YEdOZYqL1T1sY17lb8xUZm63JHRvakCaW/SS9eNuwy8pVQS+fUlk
e/072CWmH00hcD6U7k+fqMikGnDakz3cLhLcGCCoU32VokepXsUahBGQBrUdAKtx
1YvwqYdvR1XY6pcVL/HSKBLSuWC5HXyrceHcoEJyZAs94GTDY+Ryea6m+gMJwhSH
icCC0njpnxt/0LydMYAOkhdEIvfau+8xPPVHj4UXpPQeajtL/7GykNBSfmyYDwVb
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WsKQUivb56985urvcv02AQlJ+74enUqrllSIJvjbakye8bz229r28JrfDEZ1rvWB
eG/IwT9JN8BwGmActd/L9UYd6pevtQ59bNNVkK+Roqv0Saja6of+O1nJbDIqsvno
LdRFBeZXt504PqNhnn2MszsRFPHUaueqLRmStw6Z+go=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19727     )
leT32kFP0RdzKk8Mz5XeuvV1gKieEvSXVzRM16GFByGmHQIzI7eCZYXv6s935fNF
XOKcBOvSaUxz702/R5au4ZvYpsbiMyhpujwU/KqdjRG2nsqoOZLYyhknssXAr+mr
0gGzkXJvyEl0nRA+iSuAqqO40hwtNfBLGygC3cIKU59BvM7kJXVDvREK6nOKGSjO
jEQmOX8A1D4tmUKBtNIpqDw87niFJX1uNE0FRhjVdlP19fUdY/KZyD8Cb9O5NO3D
E0kQP4X0+4jqGar+rsyWwwyOe8xiJ0zbOPxWVsAaksLSBc4UcgJKDl+4q9YZWLoj
bw7dmvK6aejih1zme5gNYB98SA6WKnokqYQTf4aIWP/ZYuxe6uJZCGsLD20PhM7Y
Q76RaED3vcQ5DQTwwy6hKyAl+kvkBW+2jhXrLrDYVarElFzyeTe0skpO/ze9PaiL
hCcO+fExLwNsWiYuuHLgfvy60sLqRbgfTfm6UB9+WPLnuDGR8x8feAL3URlAAiLH
sW4cw8cSiR1RCS6WENZE+7io1QkF/IXSfirXcgH0ffCIwkjaZtAZvZWRwstf+1vQ
eaMHSnIgTlK5H5LdQ1sqklW646sY1adSnQ9GQllZytaVW1ZAInU0nfYUzrqEYpTT
cmbb6RzIkzh7laFBmTeGzWO8wM4O+s+J9Vqc0B3Q3tNCiZeLYqA29opd9cuHl9US
x91Ne5FA4L97iI2eNp3aUV7z6Wt7gNHuOwSSREvtHjejqy4mIPj7eK/IEyQ0vTsn
Mo2PVLNarT1n5gK8UgOeEgBRoyDqJ9rGYMXOFygc4+yIyRDDD/HAYrWt8msA6IrK
1lLVHNT4Q7kQ6mf2s3eapvbUhzDs2hwX6N7JPm99CaFk6ZiIe7PSBbdwTojBN4mH
ZumABy+g/byoVgFgW4peniV5AjxRUJTvlGsy7orRAhVw8sMZxeNevdsh7vqGXP8G
BB9H883QCdVukX5xAXf8NrHzNouIcecZcmoeTMVN1DUhfcrnhb59ukjK20jwImgx
PjmpXH52wohpXOfLUfT3loQgJxo+L1gthmrvi8gzI7shR3/tUAxbCcV+NBUn5ejS
6PM41rVTlY6SXY2K6dgVPqbxR9VLYnshIXhiWvT9IRfS/Ryd20AlaAlly9NxPIlZ
aON6Q2NdcLKMn1EId9ifUnYmzNXPVi44+foVkc5V5RbpB/BYwgv0gyBTvoHfbBGU
8e5Gn9f54NieRKQicgiYyPCXvbNdujDUNsXbi9E4AwQuwykPUJOZTgHvtKA9sAix
YfXtpWrzQCVbbmFtZPT4dypP1r1JdemgCs2kqGgF93pGQHgZqSIduwHAicUxuCvc
IoK0Yi3VRJjBUGc5QcxWj/kzykzm5tfhUMQwXq9SBJtYMIh7wRGRbuC+4wVtjslK
kV5+7fqVAlEWAct6bn0NwMluUXRiKWx/s1qxaaFYXS0oDwFUdSTQ4sBCKYRcavIV
WfhWnKf/KpGgj4ZnroiSB3IxomHFW4dJoYtpexN2bAYkuBJzY0k8SsdMtTFdkTk8
DUTMj5QmhuHub8oKke01X7GupQjEoLEcRymJKzoxwRP5L0A5dE0Nx8sumLLAiJD5
FP8mUQf6IEexxDAVf/ORxMk5b+TeCsZbX48SOMguqmtsp/xbF0PjWTgfB+Mv3dwA
nKu+8Amxr5o133vkGIKZJYOpCQGZbzTircsixak9WGNdtmrSZN6WxiB8+vnqXges
0fVskB4OKfuJPzEsGJHzL25H1fo3ccJ/S2DK22KOPC6wpZsZNhKI1yiv147IERjw
l1z4741gEcsATDJG2Q6Tl/vfk6mF/U5idHKqzANrDXFyZ3rWACiGWQ+4/QB/iWhO
Z90MVbsXqPkaxJ1FMLEAzqxVuVBAtTMso+NyW3sV0OW8g/efd/7kdnIWdD/K9p+Z
VmO0wuakXDbAY1Hv/61MGQ==
`pragma protect end_protected

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
awARd3xOxS4eaFnOECtLS/N39uycMoVYceBSiAksfbgC3OJfnyJakxYMG+882oPW
/jluhCI4zYB9kNRu0TT4OpQlRagMhLTZP2Oum2mhs6Nbd/PQMWyZVXs71RVpF2m7
vEv3kDh9czD2PUG4vBcbupW/WnVTsONH9X9sb9oAk+c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21002     )
X6ttA7NdT53O9/0wzzbQv44oJnkFBXW1Pe7IjYXxFUmTcDEQhjZpvfj5wzvzow3a
pahvTEfBTYKgMTDnyBboKyc1+9gYJBGy9VVnSSb6z5ngfJnoa6ffYrf0GhwmfFfp
11Qx1uTdL5ueuFz9qsVxe4vuz7jivOmY3vCx3Uxat3ChMIUpMq0vWmbYNTc4i0TG
bgBE+EKKLL2rzhAMyMn5806mE8ai3zWkeu1Lv/fzonVILnbN6xGiWEeMRRlwgSqG
nADszxwqQhvvTQqAaLZK8XP2vBkWpC8o29OLRE94z2hPAikYWdDiU8NjMeMDNbFM
zaVo2l+o53co6QhjhM0e44I+Ml6D5TvfrcizPyip9He4os3b6qupKipVajodMDNB
8+IrKxbGd3Gkr8LuUEsUlskAayGCG30pC9Hfw3llnz3JGmrIqbXyWAqq26Jmfd+v
EKZJ7TpjwzjEPxftXL0lz0POtx6FsDgOBc7aNq9I2lCxzdfE28u8VAQNeue0ss4F
sWycIrcTwJJd/nMJyW3P5DYyOWUZKBtD49esF0HzFdf89OBpZWQqfNHm4GZzbc8T
Xoe+prKrHzK8Wj5vHETouMFAQscsBNA7reU6Ts8hfGgAY78F5eLxqRScheXcIr5H
TryFc55CEikpSM6VUcfCCXVXIlySYuwhMuXbvmJJ1RKUEY+kkEhi7aaTqe3TdWI/
bHDxyVjNE7vrpQ8uXdThRMfqyHKKxHAzLK1bLp6cKGxzQxyt8vuoX1NGgtQ+62lX
FaFyT5fl0rdYQHzaLPkgfIRZkqWcM8ctWjjx+4tcrc+PfS+8LiDzz2tKmobNG9G6
z5UVpXigD5iMaLZ2dUPq+eq1e8/WNxKfmMcCzuR8LWYs3unATiZrwWMF5g0uerYL
TBSiozZ7frdy0I5EOXivi2m1kTSAF9AFWHLt3lxfU7++OvRFhNVsWUipRmfAyF51
a/OAFbjVxCHG3ojkTMYB1J2ZzoF51Y/bceza8/bS/cJJG2d+dbolOb/q3x61b6uy
V93u9ztOTqrioO0ji1rSzedg19jtX+bCTeybEk2QcEWMnXnFNyHahZ6lGF84CvwW
buKuRbC3N+nw5qu76cko1khDutaEzhFJ/eVN11XFMH+7hMY9U7I+Hv8a7pAMZbEB
4YKRqLj2LGKWjbcprW847tMQCGEpoAUWy+4WOBtiS6oE8fraCzFjvbaZYaZmhztB
t7MTI80RC7qTGwe1iRT6HX9QCBA4+0MGf9b2nD7AdtWAFHvs+NhwbrbIqUB4QLFq
VtL6Dz2Q2YswFzMC8PE1syDWdOp/3Q/XcPwQDilq5HwqWsofonTMq1Bhew1nkSLG
NvTWH7eAcRBcaIHg6haUBfwi7VNY2Rw4DUtWbA6Dzgfn7nYmIRBIYafRI3zDnzox
KCW7fzCpUCEY0iADJIArs4Ok+FaDQU63seBL9IyL7FvZ1SmCVFn0sTkqI4kqNulE
xVseAPmShjrt5FW5C70YOyrl5gGyK9kLe+lnzfdGP/O+Z3WUJ8bA4W3ivSCIq1zY
pCLgoIUCxUXpuzSHzQu4r6u83s01MUn1HWrYuNLkbd7we3cLFwYhIIkkrxz4HTLH
8hLKY+3rNj1yyKwHH3fuAS+GuFn3seDPsyMMmpK03CKfJkSNrnCGPW7mjc7pmpx6
WsPnzgVF7XzkaFcQl05LsoYsGzJch1yA3ZGp1rEiTDU=
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
luZJuOPiBFiO9oZDHhTFvHEreQsvtbfr/7I6bGNF+wMvqECMDQuxGL88HxJM43GE
0xtwXyBQyI82nQm/+VFx5vfkjEatYxi1MNUtWAfa5h36y2BN59LNz+gnJLTrQePe
9DDo9yqawTWCOeGyeXgFD+tsfjJSIKjt4Tozsr8j6t4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23416     )
H8WUZAMMkt0cAKa6t0FLtcyChMyNf7q5yeNE5VPnU3OfKB7ikGhuIXmVU4IZ5E0a
ZqqncvBxILuAEI+nbRfxG5l4bc8gIvvTRhUVn6ce/VR30XmBCl8yPyGMWbPVmNf0
AmVe/jwkot+SqEoSQWtx8Pb5rwfShn0ab2wjdohcGKwZfzbXUl8goMFr/BaNpWaf
BN0SmwTRtQEBh7g6ovVTJlpnefwclvi97OXbJl5Jhq78TJS0poW6HKc54svIr7vN
8Mq6V8Rn3LAmpCz7FWbOClbDlkNf0RtwVgFQOvGoXyYfYqwXBgJb5B8iphs5tTbA
N0cCy76iKspki/ajOVDjn4BAtO2CeFLbU57clrBc+r1AgKHkLtp/kxM8CGUpy1VN
HeWi1MpNQVrfW9YmJrvaQeZsfqQngyfvnwzpszEwf/0nQNA7vYIHYKrhoUFOlE4l
wkQ4fYVMUu8Kyh0L0bqYq0vnOFC9UNi/8zOnO9rWhoRhYUsNFIOsJiR4kFPZBCyE
lDIj0x8T+kLf06XBVygh41d0sura6C38lfNdSENS5e5RR2YUct1YMq+7cJlG/6SC
rWA+I5O+onJ6eB/57buFBmHMSruyr7lKC8NZjRZyuxLpR4mY/S8gZQK8MPOtNtBP
6SlmCpJtbI2+VHGbz7pMGp9ouIbs8mx22+hMZpU5VOUpQfr/iqf/116xywkO8RZ8
q105ieSmw2aXXZVlD2K616VPo0oE7Fy/Q1P176fKZ+f6Bm5ARkfd8EwV3W8+12BG
F+OV6rt3oZYmZQKUtyUadSI++eJHlfEZ1e43fRyrYNTddJ23dTpQapbyQYsEk4Xs
h8KeL/VOxDdHxROI4b59/OvT9IEVdRw++TgT8YA5kmi+VjmSNZmH6mjTnsesb8jV
t4/aBbW+s5XT3x3FlkUkGfFmCF4y7g2O7XiNVrX/yacjHsguIgQNvKZWippfOSdU
FpxxKOpOW0kkKz3930tRUrnAjMuepxCrV/tKQtUMXH6Y63jleLPF2qN2CPZX2BMo
MKYPGpTDllLecyDWZIij2Us/ITDpfI84Kidn9emyL/QSr59N0uppnhpSjWk2haqj
j+d2Y2qCAI/eLF0TMW9L78jqS8Ho9VcBlztCW5Ld0BjV97eqwaVK10GGXEgnA+WZ
ef8yVR7qtktPNrkS65Ez17EScGhzAPm2Jkyq1L0ZlBRhrmHn4RoKdAozjA91X9oN
SRPtgpS3LxzzwMfDh0465HIYEZ9NqhSicLxux6RfytoEYp8VLN89W7/+jrI7BiyH
9jfFUwy6QuYi1qF/6xR2Kum0fGI4fetZE36Wtta7t1iI1HfdrdpOLRWXSU3DjNdB
278KZ/i3U1jaybwvFpkGC1Com9+TbjdO1ayPsbrnUyRffcN1TnCl3NhxirQ1Mtq8
TrSf08ht5oqwqPD9DQTFdxdftPDZEpI8H4xXp9nBQVDvfaIHpLls2POPvBZ/bhA5
afpO0jebIBZx3VBNTXIdM4scbUzP5jpL2h84NIMSB248/Aw/P8p128WxpbFNWy/e
7cu86v1jq93NgFhNnpJJ08FhP37a/ILoqXUaXsUV5LdIiv/Ifu71w5ry4C4M0HzO
51lKaBZHj1ZqX+gUjE354H3lu1LkjngeRLw1S6o+FpdjjkAcrPScbWb+D/+55QNY
OdScNo2GotxZgCPGIz3oULucsXad87qr7o3PN8oLOdfGsFsA9ESnHSbn9O0p1mKd
Jj1QVCl5eBscRF0FCz/M9KSCd03c5YkXmGT4sAB18QuBcjAaJg9jjuw7Qi2FuLVI
biXkp2Jm2+1b4soDCKb79UzDUkn4W1ZjfFiF/908GmXC2ClS4tvFJCikB4qKN5FS
8vsq01XlyzuTWherz67K+7Tx5nfXsoSouPrD7KE5FA0vHOul+JuxR1V3wh00Fci5
zG8CZIZCr6UriE+Z2qXMBd5YXoVgA6rSuAuw8+9MzlnM4qxmzFsNH1kUDLjTB7S3
p3muhK3GWv6YoKlpsBe9kDSIsc5q0ojftZBe/Pk76IGmNt1T81FAKPXVxX4+FbcD
hRWhngpaHutvwYCmAlvGgqeyXOh/xlaACxkk7njdN2X09cOIF/FsD0mu0qw9j/pL
5qvCP948xNEwvKN2XSm1iKQuZRbKiA3I3wonZ49bueBmBP9ofsAvPn8gc3DfNlmu
/lrtEeD2+tnZdZbeK562SKEw/NKjLAaKhJ2vCqEJ8UYeSkylQM8hWV3XrvXxtyNc
cpHp2XOy+kuR06HvR9JOvNiInZ07TJ1k3SNZ7KTTMfAVn1P6M9ufzCaK9fP9U98B
1dij21pPOkUQ2q2+4ZZXwl1u0Bp7SjG0Z/sMsUVmbMedBwcfNrsGioQqkj4A7Gai
iipxj0y1Gf7WgaD/5VeUUX4coqZYK+RVt0WJTS0xaBaDDSUWN4XpE+OUFf/rtn3S
jOZU+1GF+ziYNYJ/McXzKoheTn8tm0T/AX5YdqmFSxiJQRea8uWot0VVtEf2EVTK
JNrmUPsU04C5tuq+Eee2X3F35VMALuD6xsAS6cc5QOJDe9xvNsVpQqPrnmrnRvfN
l82hQnRSY+75sn0DdxHOsKfqVGkUbp6En8gOrih2WeJaJ2j06QygfIMsWk4hfzWh
S8T49TGebiYaIs5qyRfd4FnLrYNAOVH1zdPCRr4Mjvo1Uxuoz2g8Ank1lbuaEVHx
ssUuY3oRHuspiMKjyRvnTTf3CNund+R5eD21jy+s9EsX8BDK1ylDMyJfrWwDdXvE
//Za7TM+oCjNb9rj6kB6Fkq8nBZ5uFbgBNu5nKx0zXZt4SJrO7Z47LR0NMGX3KQe
N4BLWNoidkMTxfekCQfQmdbpMcKAmHd6Ufmiiagjwz9toN+Eqbu0wk/z2daw+0kR
Z9iWEOHBRBo4Rpf8YFbOZN+lXyQdzo302iex9iPNVebYLVldtJJoWxTqdZCHEaS+
E4lEueKhKcM/mXKDTsCve9tNrIhOCpdLQFzyaAThhdFyRj/m/HVJ6T3LuHCTK8+p
dZGhnGr3znDVsBWIlKidNGphKpIjUknMr2S36UQZOBTSiTE5pM3vW7dv5HJyaRrQ
mr1pq0222MEGyyFkMCBRSudi0wW95C+Ab/EWGX5GTl2oo6ZQ0c4rVNpuSoLRhbJG
t7QgEwnAsYKoh1BQVVSPeIUGekjzCCYcLtXAyQWu5G3o44yytYaKrTtbI6O3/bbE
ccIMcU2qFTqpYKNeZSkfJw==
`pragma protect end_protected

`endif // SVT_PRE_VMM_12

`endif // GUARD_SVT_GROUP_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
il3NukRc6BJTk4qLSSgipLNA7cE3OFmZX8DAaKQfxlM19Fp0rQQCt1Gs+Vy+Zd1i
IKs8IIsappPWUaAoJdAGn9LaQVgKKdtygr39O7HMuWxsyc6k5lNx6aCuM2t1McRB
zXWkr2xKr4lYGnsl7BTJN4e2NmqLKDfwQORVFseePtE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23499     )
wGD2YwhnmLagJjUmm1yWr/08q3U4BCYAICEPtEtaRJMIer0HclBQRkD/SYO4ij3Y
7AzoCWWx7LJvzrDdpdHOYGR6XcTT4aVwFBJjuzJPzTDAepcarVxNLoqth6qVpx80
`pragma protect end_protected
