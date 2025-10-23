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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wZb65VIbqg8zaw8Da+u4flcUwWZeO/zT+knd9j13XgmJ9N4TT2ikevqLGE3ANj1O
v5onYCGyEhdODf5vzewAARqMINMcQbLfx4owWeNOUCYdx7EoGXNNNY8ewlSMHDmh
Ng1zCQMyWUoSeU28a5DcXqzHGYCngR9AlgYiamKGiFoWta2ds+Vr1Q==
//pragma protect end_key_block
//pragma protect digest_block
EPIuBRkpxkl4RMyLQVUopRr8yvo=
//pragma protect end_digest_block
//pragma protect data_block
UFDLgO7nCs3CQHq13wGge0piG6MDpFJvI4bj3vW+F/puE6mIU0ZyR2IfhijXPF2g
GixOqPAm84NTZ7ycSteLpGKOcNeG54bMqTRAZn1cDWy29if0vKCYMjP/3nvpy2U+
sQmAfuA7V6os8uJ83QixirW4U7ZCLT0jdM8xqwMg45CtkoVe0PKBszKvmiVW4fMH
luWgNBwy++bCvv/nn7YRRMrP60TXSYhxUFaeJpVovFQecN1dpoXtyA24w6ooqdmq
zxEedSbbiQpE02Ex8/E85EHg+OxLt+UaNX0GRjtQJgcwmNEcv94YDsGX6q6/W5IJ
MiNa9Zc+Jfd0O4Ty6rdum1FJ98SvSjrIZk3mtXMWgEEjIvt1WnEEeiOPJmkAFA9C
JCgDMKZ0Fe7bVbT3cNhppSmyGoS9+RYWX3Ra9u+XZuYIAwv0uR/8phlNbp4gEzFf
0+3t8Hd5DO8Wxb+Z/gkOR2kFBjt+sVFaHD2glY3Kj1wWk8IrvkJeJy2kV8a1wvbR
kci5gIoIdfbk++JDZXCUBLcBDmNMjgSUmTVHk6J9Nko=
//pragma protect end_data_block
//pragma protect digest_block
6FACfpGZPywpGacKSwSBIjseI1A=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8GYc3ZPI8IdQOfso/ZWAAl791+NbgrB2PjoIg8T8dJPAH/dWfC7KU5Njs+FOeFQg
wQFHI9WODWTgUJoBaqxDHcWKWzZDLCFGJLVS7rQV9nvuaAN1+8eN/Xq5KKm7LiYD
7A9NZ/M2HxKBbEksJ2+ypaI3H5kPm2ijCS2xNKHYBL50ClSWkOXhaQ==
//pragma protect end_key_block
//pragma protect digest_block
Ev8yQaguUoRBoHCl/B6a5DN0NTw=
//pragma protect end_digest_block
//pragma protect data_block
0lUe5Zuv/T9N6TOXV9n+SWxkY7vIMwe1xJrKmlbmgr8IgD9XzNqe+l8Ki2JZ+2Ik
SPwF0uTUYQ7W+LyFJj8390GhRTNWKtIICuWXb5jUNMYfTweKV/uIYyrSyEB4GlQs
kgSJ/mwHK/HwmzDYG744OAnwNvMxOykPAcWm/KonfT6TG1RpkuEH0Kw8/wqnQu6H
jizm69Y8O6BI6CkIbOKL55ySMa2DMf4cBoU91T+qRNP43rchKtL7ZwZzjXWf2MKP
8B6yiVRXdsOpzaSqRJjm4NI1EwLXQt2dCfTl8HNsgSh86rLhzqnPr0LWAGqfoMuf
WRv36JukdSjOF6IF0An+PEjQ7tCruz3yk3QshiGcutgIMF46bTAPn3X+SB0kKnTE
HSuTq6rUvZG+EUZMymRuhd6jBZkt41Pvn+0ZhXWRlmSZSSPKm+RlATQsbDn9gi5L
TweKXUylXt9svHAbSnyENf4r7MA+kz2FcVZvim5eoHrlCJuzkIK36sj8uYx9Kq9o
ViM1qqUBR2m7ytr+r3TphZpqHSz0xvDjsEBgF6MNZy1kIT5/Xuyej4wIoghwu4P6
eE0FBaa8AYG0vUBOOXCV7g98TwPwFLwOZW3UApozhdKqfJ3XNlbKYLKFSP4vtkzM
NunLo9yDncp4izkAi2sVzSSm0k1LcSHAHEGv1d2jvw9lzSE7GUOaT1XqBQpdr4H6
Sm6jFlDp6QTN0SXTzw2Ta4F3dR92pitovDR0EUKyFq7p0xyp0xeJeEZNFyJQQ/Sm
Y0hcK3xVBpZ7/MFr1n+NIGjAWNWTKW1Ou2r3NNA3x/98/KHMv3PObVRuT1Pzv1nB
oC/BwG5iFrZU75tsgMwZKEBLgLhrZ/1Hf+J0tN9vfKhdccU36VqXAwgiCqcF+anf
xqHNmNrNrA7Vcce1pK5O1BW8E7rIgBvNtmAy+OzsNWYBFbiCmwTd3qMfFniH6hZ0
VV7X68XCQKDLUI1S6SVz1EFVU8HL1W8U1QBHvCCqcyoxETgHVjdE7ss+ZPLKT34B
bzHkaoIYxb40HUTrTXFYkhzY9zoRawH4Rfk4rcn359lYV5LlSdpw2BUlmpBdwzKq
Bw/G5ZafwZfFIou8SkcA2C1j9GTF8Xf5act23xnXNjjk/G7qC0YJOfd1Q2s+QkoA
OM2c8EI+PUlBeoinZxx2w1qBa+kRT0p5zx1N8RnxNIBc+yNS9jVKBFuqd4+2PIBs
J4mzt53RuQ4S2CNpPzPX5dI5IbGvMYNYtln5643xF1VknOsjxGD9paOK99aCfc0j
DIoNxfc9+m8/EV4RthM4Ym5Va/LEZuBJd5bmR82Puex4p4ZjqRH/MM8x3rAbAIYW
eCR+RFdSlNzAp8MquBF9l9h92IMNZWT6vUOPZ/3b0V58cfo1K7hiF/2Y0vmRIA+M
pYBAjNSUpjp73innBheR2ZQ4DWtOQGhf850Z+cnJYkm0toEtXc/HKfilzRtawMaH
IubGGWxZpypAD1Zwk2F963sALDVQBDOz5W+2qJExCXzR2kfBbnvwaZJfBYopQEcu
b33R1RFCf/ikOqhdvhSphIqQ9TeRnPoCIeJAR08qRqYiAJCJN5HfenbWmUn+BJc6
we/4LvC7G97Kn7jS6b8UYisChiCILakSVQ4wiMRW23ETVsPkjynIg/APmpzPs3T4
Zp4FTSedJtq8ZlJpCRjbLTVW5bJLri5B82TurGRz6SZaV/XAc3cFiqA6PJpFb+Ds
RaFlPAcQvG0ma0GyuVJFjA0PQfN+vJYzVt1G75MITkQ=
//pragma protect end_data_block
//pragma protect digest_block
0cm+Z8OzaqABQfUsmN0VDJ1Qlkc=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
B4KfSlKHjQ4VX7w4iLfB2DFLHB4MRgNcNKTrvExmj7/1SyRa9GFRGDNZ1YTCIDMT
6llUiFGDdqnkymAHEHkEBKyaxs40c04TIlDxjU9C8ns4x+Vb/WWNDYeh8l9lN8dV
qxGmSC8FRfy4e0lUKVaIXF9QpcHK9guOddnG73Vr2e/YzYkpRCq9Wg==
//pragma protect end_key_block
//pragma protect digest_block
FZJTnT04UJ0Yxe0n3jIUyXOfJ+g=
//pragma protect end_digest_block
//pragma protect data_block
/NowOnE7xf1Slsur56a2zpO2iQvDhImcvMn/zefMeFUitvRol6WozacnrP3/0OnL
22U/MnTWFZOWoDRi1HIJ3/WfiOuWsyjL+XqcFF0JHJhEno3KG3tyAteegAd4isvK
mUonnNkGnRXtlzTPsrZl/oQLOTLVBqlaHaXtGfS03KtiPTOVqGfc8uFfEvj0f8Hd
5bKyJaIyEy4jXdRdK73D2qMi5oGYilab7kq7MCoOcWnxMz1StXbKF6QdFYN0PWCz
f8LyY5HzfkhKQA4+WOXXH3ycmp7H+glBtEfkjet7BpzuCC5aRMkXmE/DmZiAhKzP
Ee/3LgbutxqRn9JAN+9+NfR1uHkVZVYNEKMt1ZVLGDlazDbDyYgFn89ZDzeGVbYH
T0gFJWDOnjn4a6gEQVvTpiQaYLk4omnA2F/xUvHFLen809xhhjr8q+R0ovk1H7WB
lV8Fc3HNhvscEQmok0Bh4JC8nuWIvFeY4H5Odh8CrdrgGQU17jmT72ksgnFKSARc
yHkybpv4CyjqhSleyvm820dRoXwLjSXW9Vax4mho9J3UXHAVRPHsUZcjuxaKv+hS
TcznHq7UPBvv2ZHZckknT1mTaBeslsJ7pA+3VKySV7x7ayNOCoLkOiJ9XiTBTRvb
eLODiqDIHl1KQcqhTMhtyevqYRmqD3JuIgfBiS9kUd7UbA5XJp/WmGQei2MYZDIV
a/TRRUX6l8zwUxuEDYjxq2GNb2WvaoHDfFXPjlBBg4fIEXBwo+xkr9Mc+3xdQrpG

//pragma protect end_data_block
//pragma protect digest_block
4oKoj1ZIqFeV8PL/vO/PPc0a5p8=
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
dNoHTjlySf5oO+5QwC+zrRPciWW2oTuRgcihIn1babeCvil3JYS4kC4JswGMNSh+
/WS32IVSAFr/HVHetzZPQ3eQicKpcdBwqErrs8gjC0w7vqITsGnTGX3ZldJ08NrB
Y+ZN3uG4/g7r0FMVYd9GpaBwFkWssnBL9wGawwxsf1VQ2jFVFmCiGQ==
//pragma protect end_key_block
//pragma protect digest_block
d71jvIaD9N9xA+GQS31zzFRltwU=
//pragma protect end_digest_block
//pragma protect data_block
mGHiQ2S5qpY8byihKoeRxS/VGI+R3lEe+6V3WGuuQLkmT4vFNFo4DfxErYFmvk+i
wLFDZsxXij/wMq+lAfDONvUED3DlIBlndS4J0NRoOVDotbLnDr6Jm8GMmxjh5jQr
9XW87xvSOJQ5AWemRhEaryZ8O/RnHbK0f5ytGu8LHXS9TdmJyynkN7Q1slly+sOu
KlnubeRMD019tkq8V/gMNQiWDmv4BriBSgRj5kfbXa/7O9QS7IQ1/VxQwaiQApyH
etEEm16cWeGzLc1rhNjIJp+t3GvbMe06oLqeaX2A6ubcvV+ZmHTdVK8/IZ+gtB2O
DXWi7iCweO+irJCDHNV9azF2BXwVE7cOzS0/brv1L/qeskwWatQIaiHcIOu/RVNS
bQUGDD/TxTfzb2w0Tu7VIwWwed34BcnC7O+zSremIwWb3t8apcoa+sLSGNePotO9
BPEioETjiEWereBdKoZEIBljlR0+SIosVTmUeOFYGcGXgptZ+63v8w9+eCTyXHPi
MeepDlbmqB0ECLzZguDz7lrvu1D+TkfHTnrKo86+o3K6aPPxck7pcEHqON/6u9XO
lUL94B63vb1ls+sJ6cco+XK8tJlWUQFHO2Q7Z86zHfBnK2SLYxL9MPJjNWDYKUV9

//pragma protect end_data_block
//pragma protect digest_block
K/mxodHtY7BFq5RmBpNT0dO+p94=
//pragma protect end_digest_block
//pragma protect end_protected
  
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mGmlq0maKG/32br1f6nfsVrFg+8jVciyU4B15L+1mETgsIZWs0iGIywAEjoHY7pB
Vt4SEI0b7zxe9xe93kjVYkv3/5o6AF0Cd7wrSWNmIIX8LVy+hgxZGhtI5juw5qWX
n/x9ekxJcWqRHir0DdldqJ+n/EXvkWVAvDvd0DHSvPwXB/RtYRKU6g==
//pragma protect end_key_block
//pragma protect digest_block
D0Ji5flfHaTcYDmhGL9rS4Oo4l4=
//pragma protect end_digest_block
//pragma protect data_block
k1Cph4mli5oE2JOwPBz0RMSYqGOV9EOqXQAPUIQsRItA7zCixSvCADq2chBc0GMr
9fTnFDD9Iocx3rRjlWb/+JsRXV/gpqw++ZI6rHCLnE0tlCWdanqVgt92zKRCI2sx
rwmzMmLKw22pWekRZS37sHOQDznY51PDvWWI8WiNpOqLIC+hWoQc+C7djGf/iqg6
bH2MdLY0w3Z1rqaSw3umPE71UPpvKJoGJscoEyBMX9ExZSmGLnkoX8kZ2j0z5WQv
5Vk5rVFJuJTeKq7hkL4f7SPKSB8aSekcV4TjgEUzLrjYCOG9ekVb1g3YQ673TrU0
/caV0MtAMIxUZ1NDMbPyhgg/OlkV+/QvRuaT/GXwLTWMx0k6YzCmzUkZ9a/RBNew
k1sczBZMTHU99Fo/0nSaKGApEhhtrY1aB4sds63rmJwBCPZNMqFpsKeR/rW+Aabk
GEDdsqYIZbFXf6u36mfkueJLdHIRltcXFLP3fAdj8xEO5bpOL0i6utZQVYFAEMnt
yWD4yU7dt6pKokAMDJl2LYzHCW0ru2XM0H5gOiv15shIlVk8gO/86lC+2BO7tQBu
dLrsVjF0FaYAq6USu/pkJZsRYZcMKjvl1SnBP6BR/aRLAKxQfVQRnN6BvR7/uR6a
weq3j2zvZwdYsX0exzjnE92Vu3U0sOSb0AVc9hYkwYevnaqDqqmEpINdyTo8vAU1
ZmHBQU7Zo70tVRxPpMKslJY7LLf/lG4OIS2DaD5aIa7saj2Xb+8EjEUYmtVf1mxe
NTj96/wUz6PoJ0yRpJrKEBrfbb6/6HHZrzepFRZoULiwV97/WQrOoCSfTh3DSqym
cO3LlIZ7oYOJ1GIxoLXsFyly5p/jKym6LWDauelavWtvUQm6vNaOpSOVcTtA8z3d
tRjiuOcI6c/mbCWi4qdODA==
//pragma protect end_data_block
//pragma protect digest_block
4lOnII8lWSj6PzSYWDLJdRchcys=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZiruIsvVNQiDR96TCgXGPFa9Ii9NKbhI74PX+EIg/9jvpEl6hxgeQomi7dWkvyQl
OrEVks+Wo/wJUBNx5togDqaQjGlr/BvQjfCRMzr7PL6NaCyUtJzEDYNnfV+fIH0d
vHIiVdG5Ukdb9TfkJMUaN2ppoxbB5hKpWBf99oIxslyQGYITmR2nxA==
//pragma protect end_key_block
//pragma protect digest_block
Yat0lmTap0gfdaYpxkR0qM4ftQw=
//pragma protect end_digest_block
//pragma protect data_block
SCdfDZxtqvnlSYflspHNY881kR1STO0V/olULl4zQbYQIB0wXhV+6lG4zHJdS9lk
NXrrGOXUSRXE5GxnrlsJlJYUNvFiT/GPR3aRnU+0WJ7kBwCqWYe5JkbNcxX6nTC4
vGJAmkG918NK7BCSgdY+E4FQBmQRSvqtS3IUKnuO8UtywnuKLLUcrlTUCKKgT+Dl
WIUtqVWjzsapsaGWlAaBG4m/JE78aOJ3bfk/v+bnHX7YtgOKdpfcIqreuAFNKdTf
6T6RzZXEzV1Gx+b8RLPg6pWY+dEsvg/Z0pcppoeZ3nwsvY47sZqID3dvmnbYr87r
rdDoW4DlZeLUDadKLRSflQavZcwkkwBtG8TaZFnzvkVhADB8ufn6I9J1R+It+yyH
v9QngdqxEGL/vBiyFz898tslZtDGQAHg67gA1CmiOpafjtdzD4B9fXsCw4f/qpyU
v2HdVxiVwnsW5eirsQzDvVQhyMasn4A22iuESukg5B/hEPAWZn61s9NwavhAPLw3
GB5PaoAHg8cskbmzkkKEaTK2aJVQyrmE6H6aQjDWEZcaZPQooqsnGkBRKJh2wrnl
InQUkqI1KpaqIUjLpJudiK2Gx7AMV5FRC48RnpRizeCqzQ/EfF7H5u9xr34cwrvc
qGQl7tUO8L5IYNRwaLxY6SLrcO+2bSf1/59eiR/0wvHh27mbfD1itD1Z3W6aUzFl
OfFVM/CqSunk6cbxKzXnIMXZ2P3EmvZPKDqgbFKkb4PKwnxFkaL7sbmyXcHUEHyB
ZWSL/IPlXzoXxtnS1am8K1sb9fMN7UNU6MOYAEBkerypmQHdEJDWjqchjROPE2cb
mXZWM7n+/ncX2cVR5e6nR1qVKyVKj3zhRwJDFp33tdYjw31ZiAJ9VMcuETeghkgN
ht0mLO58B/pj3oCq8j5DAlf1Iht4IFAzYnTU9rBOtnfiCtd7DXZ6uBX9g7mEEN+u
IG2oEDufyEWMkNNADubPIPHSRy0j4Z91zeaHRSpCCqpGLgtL5QnJOSmV0tsV4oXc
t4ffbFuw1Nt9fkohA1OCO0ZlIq9SujrSTKN+4wHea0dXrKXWywXPakRC8QIadfZM
W7KQFQkABQSpHsNiMouE9um9HfuAp5SZZioCh2RYowKIBRu/D96ZZGHCseJc/DEt
dl//v+HVLqhgJnK1/MqQeL4tQqVgvxzM8PdE2F/F9FJuMq9fz8uVGU6MbI4zn5yK
2A6EuI4IimJTE71kZ26NBhsM/wyLLtOazf3LNyOhPgVdA0OXoKJyDmz91/B8+NXx
kXVkZVdpislye0zc6riXuCsxuZlY5yqYc6vlvvoRZfyzTlvA0raaATF19ytpZ9G8
sBg/kX0kGIw2A9HHXiCIuqzGyX/68B+qrc2qm0NywC66zHxpCBw8ZeO4Z0Q/ons/
+BqEW+odKH8xVfTFPJr6ni3mV3CnB5d/edNwR7eq4HR+8r26iHX4YoevQZlTJa4r
/fwI/Oadav1nPXL9Yo6GZ/Kiw7Q1CsP37Xv4gde+pc/zDHCwXs8pQDeK8yjg5NGn
yxzWCtP/JXvRALITZoSgWMealvi3UpLN/p3ajjyw7rdUd2bF07It8QuRDBY3tZqu
hYTyYaJrsD4SQPIU7LOD5c3FnuFxWFDB9BqmiXn3dPo0k7tERCW8MtL+lJB960FL
mVwRojrgIcFnIDEQejPd+b2Z6/uGVmm3Rk7bYA2QUvnmvM0jmb1nIffs8rbjnYSr
vkzyexUD5WdI+ZFp/SK0vqFwkHeCrskN08ZMX5h8sFWgwWHVQekzIc9zGHgZZEa3
niTmAup8wy9d8fNeg9tL+YrtGhvlQ7CiOmLt5lzdWV/x2LJzU8dI3wns/RaYqLlO
Fq8lBc3VVFj2GLJB65J0C4LpLQLBp5V99OmVAGHV/KPj883XpuG3IyKBiO4heQyj
Il88S783tSI5KdZq6MSApaTtDLfN3dO9PKsb2b3P5QQpKkJsd0Zrir6P7UgAtnNL

//pragma protect end_data_block
//pragma protect digest_block
luFdiKTWtqHmO2M2nwB885saFg4=
//pragma protect end_digest_block
//pragma protect end_protected

//------------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cYuu3RM0614u5/TPhdNIEiTrAOcn4ur7HlyIy+p2eqq68SnTRMyigpvGWlq3dH8m
LpbOx4EvxrdVF9FS4WquB5LzCaN5y6UIMkGdCKGYPq97R8tWPhSWqbhK9jabLJs1
PXWRUP/F4k8B9Hlt5pVzyFrYYuMrLNJkUjEIJ6t47LO7cjnz5rMYvQ==
//pragma protect end_key_block
//pragma protect digest_block
jU9h89NkMbE1ZSeFEy4sicdblrg=
//pragma protect end_digest_block
//pragma protect data_block
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
dv9j7DOzaKKVlZlOx8P74Q==
//pragma protect end_data_block
//pragma protect digest_block
Yb1Jx9WXxG/ezofhkff7uwN3N1w=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
cVmefVTDM38ISVd5p2zLgCwH5xdF1vjQOz3GqQLZyD8kz3TLGEq3ZgPuxVAv281b
QXS2wozXLp34a7Z27myeV9d6ZpgPDHb7U1BxaOPyp2FHg7C6fvQEgf5f2DN0CK1Y
jsxvC6Y/dJzxPxTSBguTL2gokL5nx+hwsTzFhhE2JjQ9+RmurxYSqg==
//pragma protect end_key_block
//pragma protect digest_block
BWsve9pTsh4JEF25pyrWRYypMUw=
//pragma protect end_digest_block
//pragma protect data_block
GFNUPps9Lh1p1cvUXMn5ttNgyId/SLsYPBHZgK/MvT7Q+hfOFkNForNFZGTYBO7z
VnZlmN5N0uHaUwjcQ28mTgfafwWO8QHrgu0X0CZW3na0YSZ4Gu3lzXCp3FWsuYfg
Iy3Ov9SaVgeZMX4VlhqcgsTSux54/w91QIkacSLua/h7ZKD9/jKUjkmAGfJgOKxx
bDo1EeauptyiINOl0+SSZY7bRpkcDjdho7J4HXRP1HRLe6FV8x939p1WWGYCOPfD
2sS+8IlD4DWsP56Kv66sOk/YKakmb9Ko/IQeckufs/FUYWqWeDlSkAlLyerq1v6H
goxg1Q/QgAIHrMW46GyNfOZoyg1t5fjyO2SYAlJNMExuYH1zzozOBFoUJc1BVPUk
86Kt1hP6K4O7j35of4Qc+YfcIOLwaRGiObQOhNdQbTWY9EukG92vk8kANUjIh2yC
m1kO7g2l8XI4bmshCJMbV/TWBNGzkk/PeXEjYvGpXQWlHlzJrWjJ9PnGXHbYojsf
MYtCAduwieI3+H0j9C8/yPdKufLcjskp8sZpnOSgSzapfxYhkJa+8sU8x2xpB2aB
lM4CSdIpLj/15iJa8lyO1jskTy24hrWsXvQ81ZrfpuJxTOUIwqnPfEjEhGUr8qKX
2/n5ShHFATXlMB8C5besR4NSn/BKZyTUwEfGOs0fLR5qrwD8hv3MUPhEI7NUoE7y
6FjG3hw5qyHn/zG3rnn1KMrfeKNqpJLPtgxh5RhZZS5iiILMRTx7MMWdQd7WPOGf
Fk9IREHdaajlvKLd2C/X7R5eexFzaNKA+fMrV5erw+eHw2biwfwlOzwJ+VUqZe/F
AmSYz8+NRUjSxN2HDpnNF9FveB0Nl9cJvRfBTRox3MWKDdKoY0B5U7R08ocb7Fom
keNs+2pjcT8AfMDukNkgMBIsFRPOfFnCDR3qOblVrc09JA/WI+5mwtbFTTngLlrd
8brJ2dnwHzBRkO/u2E879VGK2WTF0imJcq3V501qWG+OgVPczbvObqqZkqnXQWJQ
S2z/ufeJMdCKVuP2/ZG0rEpL/1xZ+gZEj+q78iH8DOXEcCGjtwTGjoPyz3H/ZtL0
KWjBPF4wpivu58J9LLxsvTcVLVqqqFAoE7EtPEGQ8RF554HiLO5shUfCOWPItBew
K9DsrTpRKkBAWYzF+6MiBjicZ5eQ4EGkT7oxfB354IEwqZIQP2WnWHxGY+lJmx6b
8pEqkcczVu8OYFTkxzM8xE/KvAMBAPjBQPhZxPSV+hDYYjZ/SeuHMq3ST/u7B8JR
ixt1KQAofetJ19j99hEI7ZIhDN8jGA/sUetxAYari8iy0/iHTBaMgBLjaFQRdpWz
AZbQiqzvokTf3QqR2wL3IfgWOsGyLbFvnG4f2yuqptvaWnV7cHpdTufp+6EQbyVe
gTu5GwCuzl5k/sOxOySj/XkP1nnn6IXTkxdOzXiibDaIpzF66DA9v9gjqIBH6ma6
Rg6eltnSIk2E+oqGVZoeS/a40/2jrJ3a7sR0bl5sabVGVEXANfVdXikqggORcGcY
yd65GPwwkEbHpE5X3TBmP7xrA2Hfclb6YrrtOCViO4qdeXT6Y6LjsKcX6mL6aAUm
a/YjALyzZC52yD51B0FZ6Hv71p6I2EVbsmv5xKwmAwOJIdpNxDwCCRlLkyOHW5M+
UQli666JOa/OFReCMCjB0bw8HT5yBsM7k/uAwBU2e+6LRMeyCrIlRAb7xrXdctYA
pIkh/pmgfz/wAKVXgkzq4hku1qEQ6AfrEM3YrQMnEO4U9pK//rXP4GMOFMjQomN6
c1zpbPjvEkiNnpCqlrpu7w==
//pragma protect end_data_block
//pragma protect digest_block
6zHlkWZ1aYXf74KebiPWJu1TGW4=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F+Dy8x2eD1JBovVvReOrWsYWiAqQZJb7Hh6TtQU9P7zvz1PJBZW+M+u+HM0ETStG
RMe3jsMkyq2Z30W4yCFLX/oT3hyDXXCgNAZcRKnwYd623/EbDPQ2EzdNi4NEoJny
TEfXuMIZ10d+IwYp5VbyV0N3IudzZnWl8XpqU56+3KdpxR9U3kvVJA==
//pragma protect end_key_block
//pragma protect digest_block
0fF9ZaXqa2prSw7GAk9A4e4x1ek=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
5TVIiHb6EHaIaX5b4r2pdVE6cR0=
//pragma protect end_digest_block
//pragma protect end_protected

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
x3UvoBxZlrvtvUngyj1lFUnJfOH4YQ3Ky5U6sZZOYFqwedESXiBb7VXKFxTqs7g+
Dfj8H8XwqSF0YDvQV3BpFEn3jmG0XWO8p+urtwCv9mycWsgLNvwMw1l9Jf2WlN5v
kCSgeUo/BpWktVHSAAMmtMfhMpJ+e/gzVBTFGZbxU6PX2poO3X7ZEQ==
//pragma protect end_key_block
//pragma protect digest_block
6+P9RjBU22j8oF/r8jZg2Nxp4Tc=
//pragma protect end_digest_block
//pragma protect data_block
+RG897WqLDj+hGNcaW5iKh46Mm0KVE40Z3fA9rHZTGLrpQh7TvhyJ/CPkbGaz1GQ
JKA57N3PrC+wlYRrgMXsQDEuwngMv+DYxlJUQ9ysFERssvY9R16n5QuHVlTlwANU
L7WH255rrg2UcWaIY/IdQHQPhI7Np3Y3UbozQ7tU2tYYq5c2qN1nr0LXvVGk96c2
SgaV5gFeCsRvVqD0fD5C5GiL8iMnw6rd4LLupB90a08EOW7I0zkQ+NHLo7J32Dlo
xPm861lBf8pXGxjsFZ8KMURFUMj2Yf62yWuWx6Pke42Eik+oY3t17sUgAEMM3Jzu
F7fc1rS7urLk7KT62szLkouPpUxJGAbbSLz6hwy2hGCerfVfwvFYuVprWqL+aeMA
5zVRndXQHtEPiSluoOYtl94FImQYVUdHLEcOgZCGVFZKXfkyFBEI4KI0Nv5zbnqu
uuUGgmcsVhuDErn0/2+elr4T8k6kYBflx4Pi+MrVcYEuEGCSpove8ec9H5eAsOcI
vs7yRNAVyMIZDXZ5lzZ29UHPJjp/2p4Ema2uXDYScNfEj+N6JThqcP6LXedFDRDq
Q29I66QTXxN2xecTZEwFpaD5gZabLgeTPVCQO2F2yJeHVAbs4mkQYAC6ZmzrFPJM
PcBRdf8s9ayae/fMa44yMbNw6U4/ONtGSZjRiy0N3B49vQmvW6UetWgJ30zmNKwS
TacJKaYJlzlXxbkwsGZD5Unl9SyPM5+M89/Ener7jv+Ef2ccomK2Va8R8i18WFxs
ABbiab7L2zipWZMwZM8hmjNFlD8wPTTcDoJLVif4AkdVURyvmbQxMn8vU+yEgMo5
99KdsG0c+MCb1PkFO1re0VaHWOkhtVywO4cvDScWXlhD4d4vWmONc9MfmLmASbnA
Tu0EG8i6G08lFlpYe07aBR6WmYTk1goFvQg0WAVE4p3wcdMojAEDFe+AcaO2+by1
xraCwF07TWtWkIkuYkiJaRMFFOcAGbV7uAPLnclbzUtgN6qaWgvzrtEofKL8rH8e
w2172545vOcoAs5WiTfNjIz/91IGugI/eNdW4rXmChU08HvB4wofgWZLP3okpsiS
Zuryan3rXzZl3wKeLey2evV0frFBB0MJcTY/RzudSx8l0vd8O8EmRx8rvugnLxMA
IwVp3+uAica/vQ1dQhaVj2KUyLYdtpvuhbSz7/B1NlDjRFXdnj7gBH/qM/1f0Oyk
JVEakeFmI9HJRtMOAVomVIFKSIvAwBfp3+Jqg6rToj4avy4mSxg+r5KweRmXCATQ
9n6AC4fwy0hpJGhuzVfXo2/UV94XIeli1Ekn0PWLa1YW5jmAh+Ha1IslbnYNdr2J
PsyCGQGnJ1FHepTU6olmyIanX8FNWhNJKnZfgjOkshEQ1Yq3l/K+rw4vIwUo78J7
7FBvbjXgVuBRkDd397cc8lyADFKc7Swm/zJUFatkigdXardslfG3GpxVpVH+zE4j
MJ9CKTyJ+uBnEQ2g11gVGi/MYa7APdjeLr9pzPN9sjPG2iM4TgV+5xTjrbjAIEUf
0+S5kcwe0sRsK9KYzqKTZ0qdbHMIX9yvWSfjmaLmUM0OBOnoNZ2R2fSZ8fAjBn10
e5aGZLTQHpzuGGu7W0DZ1qd5HuRCJqx/bdlrqZKWyQvNcgRhPuWkVxiLBX45OhaR
/Q3V+2emivIKWqyxk2ZPaY3rq/PeKa74b85hCJkAnZeaPuaNyn2ZgQHo2v6Y4ibx
qCGqwhJMak8PPJ/QKJHu3g6FU1vHU5+6tdCASWuMl5R5Kz21czICgIQ6SwsyLaJn
Cdz7oMSFM+0V2jldnNQjZPdT/d+eYIQ5YnM53ISZiYQUXtckWuXG1o8qaRqajkmE
0ST2SFbVkfXoxlC/x5iVqzLUIwhUZXzwjWvGCtks1dqYF5rUfeA6D9iIjoAstGuj

//pragma protect end_data_block
//pragma protect digest_block
r0a4qfIBsUHVP67XzaX5/TfIZIA=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PXpUbdNjR8B42j0P7RGeNj29lUursfNwG6x/4bOwZDN2Grsogbuvw0lbjLi/B/AA
bVyiPNVon5xajRvJlAcQC77hNSdPZupqH/X79trKNhtlpG7w+8DKGQlLkguRxtdF
aQlV5vpgPjfaxa97bkZf5JfmQ1IpEvKnwp0gQ4viiF/7TcSg8WIkfQ==
//pragma protect end_key_block
//pragma protect digest_block
oaNuAtGl7lkSEFqj+U6Ozdc5qaI=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
vYkCNbXqHUoWmu5WKl14VmDqjtc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // SVT_PRE_VMM_12

`endif // GUARD_SVT_GROUP_SV
