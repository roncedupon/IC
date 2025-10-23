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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hL87i152F9YttUTTxmHFI2hQrpc1ArIMAWhijlLE6cZu+mumZhrWa1xJnjvy8eAr
CHH76OmnCPcR/cAUxCOM1SWA1p1FFkxkSUX3iH2uiL5NeQLfFWRyZT0Hq4F+BRVZ
sSROQUbVIvKbLGNwKj61OXubDExnfk1zj+ueFpQ/iCz+K63HdDqAMQ==
//pragma protect end_key_block
//pragma protect digest_block
93UCfdZzc0oTAR7pNyE3+sXHk5Q=
//pragma protect end_digest_block
//pragma protect data_block
N9I1nU53tXOY1+hIlPr7Z/GnbC87r6z1rfaCoSwsX2SOZNnF9U0DfAJ+ZSe07nfX
nGCHYMrHnhI0dvX3HDo1QA/XBJaxD1SrbMZfneT9Bwf1Gs1j0Ak/UnXVMTwJZ6Az
/Jebq/SVrurlDQpZbYMoNWc+GAa1D16vvASAKb9f6bxnPKDxCnnmHgFr3uEt+idb
i9p/fbCSD6hy6OQCA5Izr6kpsnW9CTMiXav6MS5wDPK5JnMHC6WwIdB1uyqU99Zg
vgS+ZK3DJ5vML1s0Hza8xTw0vENCWgeYJ54mzE0g6ERaWzVYrUCC8aPJGjZ0Dah2
Z85HYTJ5U47ClvOrt3WvEcQn+jecn/UCSVQTaqiyUPnfKYXncku0HbqGpxBJx9i3
V32U4hJrcTtS2pkEOgEy5J93ny6rQHx2cBvJQNtjR0cXkyTFYuJ+7ALNSEKMnWEd
m5cpd7Mn7aPhgvgJGBVbH1OWAN1YYWKtsNVVwrJNO4la5q7zbg0Fx4lfujuAPx/1
iciTnWnMOz90D4qaBRMGSZLKoOCd/TJru4jo9b/T05eWPOFD7oxQuFdhMj/X5gHY
+9WhHVYbeQOxGxxKwJWfikCMJx+Yco4TAp7hO+3O0f02yHJBmUD+e0xxJR+I8G5y
WPSPQiLoD5jdhqF0jPLjm+7n2cRtKvzAyGuYcvdWDi08J5XmfqeTYsEiZ49XkF6N
Aopc/pv3vtJPRZChFlZRyW4E2t2+RBnX7NVTiwruVNo5VDBnb+nhTDxDL7+LxCol
vBysnlGGtlTMBtq7zaRFPoDVnXt8l/osnMNa3Cbvn/tS6/HNfJuLOYXtTveegyGY
Hhw1+1Tup4EkCBuUqce3rnHCPnzycx0Rxy3ZhWR2LsRMdZV6EQlZtnfnDL5DltBu
ZIIOtR6O2WgC+0mLWPr/TNbVkNx7gnMnjYlw1ESVntKO2ju5He1xnWvkytNDZqA2
S+rJykUAuVfT9kTHFatdVo/DSdHtgIDgOZyx4Pu1rUocVbs8cnR1N5xFVV7SUeVA
CSK8kEJvMxfC1jZfSmKXGDnVmTvIwAMMWCVeXfCKOasW9k07qBLP4CdCyKfYEfq9
MvsswAzKI1nxeQoViXf2VqEpZQ7clp95XLXsRbPyZG+S3H1RIv/gtIjr5z02dFXk
CR0HU5LBy6hLMZVOAu+ybkfkv2sul7MogvB6YO43hxVVBSRRgMpLrz7CnlS3+zgF
JgR11M/qm1i89OjoAfwITaN0miknQUGbiuExXCmVKYs5IBbVWoLXv40F9cEVGnpm
CKQzefWOeqYcpIP+RcJM0acraYlkcU6ZL1RfJULWNR2y9nHmq7jUoUYKt2tVoYu9
puJIb+x+zLi4HHJ/x8Zwv4v1oORzH8UDhx2vCfN6a2aQWlG51OXx3qAyytBc9neS
s0hY71FdpWZJqgaLTb/z22a82Wu3mMZ4lJSIxtJRn4ED6RdrY2252/8tONNma0pE
SVHGJTvmXb7Z5SluTcqYfrrfgv5eJZ3vleynyhqvzmg=
//pragma protect end_data_block
//pragma protect digest_block
7/cXAniASqXLZlIQvpemxBfarjw=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AnpbP7Kq3hHd1swIsmTX4aBScdc3U9tdEbLZqzecHM3wKodqHp1ka4e6s1w2TZtU
BgUQPYUJt16qAf1+/K4SGO6x25voFbuHUTvHUZqXhBhtfYyEpC4UfD7msrRDVxrf
AK67GCbmlO1zqmlsZ/6sfr6Sqi/t31Qsf4g85Z3d+ShydBsyS/+UZQ==
//pragma protect end_key_block
//pragma protect digest_block
cfrMl/611fL+xwfsfLYRl9MONJs=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
nF5QCM4w2Niq2EmACVVL4go9FgA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_LOG_FORMAT_SV
