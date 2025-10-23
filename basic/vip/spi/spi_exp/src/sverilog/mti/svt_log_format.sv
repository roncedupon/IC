//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_LOG_FORMAT_SV
`define GUARD_SVT_LOG_FORMAT_SV

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
icrdQ0IbVaZ1Zy/vKfjSl5a8n6QiRGR9UN/WiNqExZXgyNC4JmT/HV9fkEKH+q+n
AfA+ac98fpLzO0vX1oZfLO5GpNEXu1C2INCDsNK/ONqqzpOn/7pmQwg6T3ret0Vh
LFcOWxe+TIq8AMiJO2AkqbExI6aqgSbIRd17K5vhiGk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 957       )
EiEg7AggPJwgAJ0jJPEkXz/xXG3tCq7dSZRHxs03JdYJ+S8I9E+dFxltuW+hUc8Y
L4ckPZ9SN+Gbq4Wf00FECA3ZpgsGwEgVcXqnihw1bCLAafl7o8AcJnR+OUnwf/bX
UT9/HZFIldXX3zdZvEkhjg1+n1AfSDQHUpPpLA+Y2aSAtFkNaNlxaUI2wuaLAJfh
hlLl3BSQX9zWd+kTn0eabaf1+ijaRZfZqX5xGlXh6WPznDa1dwd5Qko8ER8SsHoY
rXpTi2VlW+xEcI0L/CPuNEa174wdEQgbF5KoxIlc77H74OJzEpeHu6llneaQUleT
93mfvWZtw7JzQ3h0YaU+/weg2X607nZ0rNdf8lp/hE7JDMjfvaJDYjp8jS0mufEJ
pZ09qAe/fR3wYrb0Qoh/KfFK2GdAokBh6CMyMhrmtx+KEEe/nK3YNujy5hhE9PC1
O+HjzuIgnm6sMdRkZMU4QAEorFk+dan6toDNKlaTC89xZCzePhhoBgKPap2zGSjq
2FU6S/x0+mNt4e0skrvmOzLl+ed5GFr5g1NNMe7tTIC1eixnTCmM5fGC/esPoU64
dYyA9GOtsu9vRbK2mV8UajROhN15BKYNbdpIi4yaLDqtZI6v4OjoFqHRv7U0cVKw
0eB3+u7FqREjNADSQ4GyfAo1HPcAQFRJ04vJs/B+dabkqcxwyQNWEnbrVobvgMnE
oPozuR64Ubq/OAjt58qX4m/YXQhOqUjSqEcCLUnlzkkazLC+0+w/mAzeAw/hag+s
s5Q8WTbi97lmI2QrJ6LE7bxN60HJOM1ARoACw3WfldyjQb/AQNejv/NtazYldfdY
ThkqCewEeOLt3Nk78XnLSDLUUUuyrfavrXhGPEqku/ssaPWjwaR6NiUkAE9V5PAw
U6yxdmq2dd30h2WlxLR98kEVlGbXnyGHx6F0YS7fmmGlfZnd3OrJ+TyRk3o8s9q2
KuukNBUI/fVWHNRAuk2kUIcnrPRlQf9Cu9zd1NwCEzPradvqVSznqBGQF+/rxW/c
owQ3fRhbX902pCmBA6uisgQietnU6AeO5K/FYj0IX50uAcxxaFHKJ15NjGyqtBcB
sHfTj44ILd6O35uRQjmBrYoS3k8AiajgGGpkOdZX0MY7MUm/la/SC47QPaIEtXUj
caBblRXHujyQBpKEf2kgsVLdOax3r+Lzvg6r831nj7U5Nzx3eQtqW+alnbjU0/Rx
q7qB6dMdzXQNFedZT0iuBqpbhYhlt2ezM2TZXHLDGNKlmvsq8RUDSEpC3gPjTqUJ
`pragma protect end_protected

// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_format class
/**
 * This class extension is used by the verification environment to modify the
 * VMM log message format and to add expected error and warning capability to
 * the Pass or Fail calculation.
 * 
 * The message format difference relative to the default vmm_log format is that
 * the first element of each message is the timestamp, which is prefixed by the
 * '@' character. In addition, this modified format supports the ability for the
 * user to choose between the (default) two-line message format, and a
 * single-line message format (which of course results in longer lines. If
 * +single_line_msgs=1 is used on the command line, the custom single-line
 * message format will be used.
 * 
 * There are four accessor methods added to this class to set and get the number
 * of expected errors and warnings. These values, expected_err_cnt and
 * expected_warn_cnt, are used by expected_pass_or_fail() and pass_or_fail()
 * in calculating the Pass or Fail results.
 *
 * The class provides the ability to initialize the expected_err_cnt
 * and expected_warn_cnt values from the command line, via plusargs.
 *
 * If +expected_err_cnt=n is specified on the command line for some integer
 * n, then the expected_err_cnt value is initialized to n. If +expected_warn_cnt=n
 * is specified on the command line for some integer n, then the expected_warn_cnt
 * value is initialized to n.
 *
 * The class also provides an automated mechanism for watching the vmm_log error
 * count and initiating simulator exit if a client specified unexpected_err_cnt_max
 * is exceeded. Note that if used this feature supercedes the vmm
 * stop_after_n_errors feature.
 *
 * The class provides the ability to initialize the unexpected_err_cnt_max
 * value from the command line via plusargs. If +unexpected_err_cnt_max=n is
 * specified on the command line for some integer n, then the
 * +unexpected_err_cnt_max=n value is initialized to n.
 */
class svt_log_format extends vmm_log_format;

  /** Maximum number of 'allowed' fatals for test to still report "Passed". */
  protected int expected_fatal_cnt = 0;

  /** Maximum number of 'allowed' errors for test to still report "Passed". */
  protected int expected_err_cnt = 0;

  /** Maximum number of 'allowed' warnings for test to still report "Passed". */
  protected int expected_warn_cnt = 0;

  /** Maximum number of 'unexpected' errors to be allowed before exit. */
  protected int unexpected_err_cnt_max = 10;

  /** vmm_log that is used by the check_err_cnt_exceeded() method to recognize an error failure. */
  protected vmm_log log = null;

  /**
   * Event to indicate that the expected_err_count has been exceeded and
   * that the simulation should exit. Only supported if watch_expected_err_cnt
   * enabled in the constructor.
   */
  event expected_err_cnt_exceeded;

  // --------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_log_format class.
   *
   */
  extern function new();

  // --------------------------------------------------------------------------
  /**
   * Enables watch of error counts by the svt_log_format instance. Once enabled,
   * class will produce expected_err_cnt_exceeded event if number of errors
   * exceeds (expected_err_cnt + unexpected_err_cnt_max).
   *
   * When this feature is enabled it also bumps up the VMM stop_after_n_errs
   * value to avoid conflicts between the VMM automated exit and this automated
   * exit.
   *
   * @param log vmm_log used by the svt_log_format class to watch the error
   * counts.
   * @param unexpected_err_cnt_max Number of "unexpected" errors that should result
   * in the triggering of the expected_err_cnt_exceeded event. If set to -1 this
   * defers to the current unexpected_err_cnt_max setting, 
   */
  extern virtual function void enable_err_cnt_watch(vmm_log log, int unexpected_err_cnt_max = -1);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to the first line of an output message.
   */
  extern virtual function string format_msg(string name,
                                            string inst,
                                            string msg_typ,
                                            string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                            string fname,
                                            int    line,
`endif
                                            ref string lines[$]);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to continuation lines of an output message.
   */
  extern virtual function string continue_msg(string name,
                                              string inst,
                                              string msg_typ,
                                              string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                              string fname,
                                              int    line,
`endif
                                              ref string lines[$]) ;

  // ---------------------------------------------------------------------------
  /**
   * Method used to check whether this message will cause the number of errors
   * to exceed (expected_err_cnt + unexpected_err_cnt_max) has been exceeded.
   * If log != null and this sum has been exceeded the expected_err_cnt_exceeded
   * event is triggered. A client env, subenv, etc., can catch the event to
   * implement an orderly simulation exit.
   */
  extern virtual function void check_err_cnt_exceeded(string severity);

  // ---------------------------------------------------------------------------
  /**
   * This utility method is provided to make it easy to find out out the
   * current pass/fail situation relative to the 'expected' errors and
   * warnings.
   * @return Indicates pass (1) or fail (0) status of the call.
   */
  extern virtual function bit expected_pass_or_fail(int fatals, int errors, int warnings);

  // ---------------------------------------------------------------------------
  /**
   * This virtual method is extended to add the 'expected' error and warning
   * counts into account in Pass or Fail calculations.
   */
  extern virtual function string pass_or_fail(bit    pass,
                                      string name,
                                      string inst,
                                      int    fatals,
                                      int    errors,
                                      int    warnings,
                                      int    dem_errs,
                                      int    dem_warns);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_fatal_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_err_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected warning count by the number passed in. */
  extern function void incr_expected_warn_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Sets the unexpected error count maximum to new_max. */
  extern function void set_unexpected_err_cnt_max(int new_max);

  // ---------------------------------------------------------------------------
  /** Returns the current expected fatal count (can only be 0 or 1). */
  extern function int get_expected_fatal_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected error count. */
  extern function int get_expected_err_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected warning count. */
  extern function int get_expected_warn_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current unexpected error count maximum. */
  extern function int get_unexpected_err_cnt_max();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jf7CpltKbGLbkIoMLImsYuziRnb4b3bewm2V/qq4SmCS8uEegsIb6cbDi1xeBNNG
M4PDzvXsR86qBH5IaG5zHOmRVZIfrfxy6utUZvIllTrXNyN285jnbMgZW1/5573M
iLq6N7SaQJjP98sOeGYbfFX3U1TvIr4HFamDO6qbwLU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9641      )
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
`pragma protect end_protected

`endif // GUARD_SVT_LOG_FORMAT_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QXxBdfZE19DM2Ft9oZBy3qzCXZDoVXsnaolHzk8C8NjjRTYN3aIQFH2dnJY3lRpP
GuEu54Kadua+saphKhJeg6TXIzg6w+ILTFxSxBxd0khEiENBCDyfXm09rfX7K7tK
DpNmoEx8hrBFd9+qRJc+k3olkpP4tDJIXpZLAfM95Hs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9724      )
lhE1ytIErTBsl/3XeRhSydASkhWYbLTqJ1jZAtEGuFAAD3nzaYmQuK65/KNlXRKi
m0m1diTqC8S/HYYKw8j9G9nWAFjNYh0pCQZpj4q/HIAAeTz+IYFAe5d4ntiHYNe1
`pragma protect end_protected
