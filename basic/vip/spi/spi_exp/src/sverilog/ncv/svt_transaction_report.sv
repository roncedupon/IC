//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRANSACTION_REPORT_SV
`define GUARD_SVT_TRANSACTION_REPORT_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_REPORT_TYPE svt_transaction_report
`else
 `define SVT_TRANSACTION_REPORT_TYPE svt_sequence_item_report
`endif

// =============================================================================
/**
 * This class provides testbenches a transaction mechanism for reporting transactions.
 * It reports summary information for individual transactions that are in progress and 
 * accumulates information into a summary report.
 */
`ifndef SVT_OVM_TECHNOLOGY
class `SVT_TRANSACTION_REPORT_TYPE;
`else
// Must be an ovm_object so it can be passed via the set_config() API.
class `SVT_TRANSACTION_REPORT_TYPE extends ovm_object;
   `ovm_object_utils(`SVT_TRANSACTION_REPORT_TYPE)
`endif

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
rptOkZUjp6fHuZU801ab1UydVI+mDvtx5DnKKB8/3Wm030MKK+GIfvIK6fgmFqIE
9TB4MIWcBknXtjAmto53apJJlBPX2xLRCTIagYfSx1UQ5mFTx3hYRY/1chHZd97A
2iJ2V2JAhfHQLZbtvNW9+6XqiPn64fBdpsjXeGXf+oczhrMhjuQiRQ==
//pragma protect end_key_block
//pragma protect digest_block
HTsOszZOFiuThXP7N7LpoVJXCbw=
//pragma protect end_digest_block
//pragma protect data_block
YnSQFm1Zw1wIMa2hypTX9qJCe8dwZl8fXRA6fPPh3e4CjmlGOMGfge+3XBIpPvg/
9oYBNKrdcnG+Tand8+DdMk0eOiJwhsY8uRHpOmyN64y6xOnS7Os2/LUbNxfhpwo7
9uH04RzcOT/1AqDVC5xCP284u4yp36HwgESPERGFu8pfISVEYQqSMIETu5GzVCaK
GKjmn+2jAv6OXGEYNFDZJgS2shUgzdjfdiaxF+i2co71oF7dOSGfmSRawq7vo4HI
SL0N48cKKj5K12xZsUY7idTqEaj9B2ywiAde2biWFbZPlbPW3yXPnCgGvOSUdNy4
s5aaAjSnFARpLpUW+QszAbrh4a1W91rRuQcd6A9P42ZJqkEjO6Gs6xcArfatxtXW
/xOKw2Ciz1Aa7NT2QuZgZy5eLFjWPlQlbI3qu+6FkcEV9Rcg7uMXNKlVq/EaQxdJ
rtjmoueZVOeO/HZTfSR3tBlgKVDANqJ1ZqfVTrpwEENIlmDblnk+FNjerF6k42mL
KnCzZT5VSEpqCYQW7q2pBWTbX/5rmpyJcetrIa5mKMhArQDSXz3w0DeF0G0JSWZK
tQ1We5BqoqJ5lh6NiUkch48ECrVHGzp5XX/tb5QvZWkP1h6d+p96RFXSyrt4UIUL
CD6fv+o7d2Vm79iD8h0UlzkRky9UlP5gH/LrtA6o3vWrHFctrqILlt3FKpWl/yoD
7epuYHdPqgp7UcZr11KAfW6S3rGhOycF5CwdNbakr1SEuN4v6Zf6WK1oEQklAEOx
EErnObdOCzH9o2fdme5B8qwFLAuQ17IQdQp28PU1bkR9a0pSaD51//ebtv9kiw3u
TyhtkMsw8fq+mW6HFe9SHBlgpIuPvz8Cu+/n6/qs9k/TvX982BFZqG7K1xonNjjU
K49J3gqsLSj4v+6j+jOeMA==
//pragma protect end_data_block
//pragma protect digest_block
0kR4p3pMs1odlFIOBjbVmRJHtbo=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static vmm_log log = new("svt_transaction_report", "class");
`else
  /** Shared report object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif
  
  /**
   * Used to store the tabular summary of null group (i.e., summary_group = "")
   * transactions as seen by all of the chosen transactors and monitors.  This
   * feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this
   * report. This is the one summary stored directly in this transaction report
   * instance. Grouped transactions are stored in their own `SVT_TRANSACTION_REPORT_TYPE
   * objects, inside the grouped_xact_summary array.
   */
  protected string                   null_group_xact_summary[$] ;

  /**
   * Used to build up additional labeled tabular summaries of transactions as seen
   * by all of the chosen transactors and monitors.  This feature uses the
   * `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this report. These
   * contained transaction report objects are not provided with labels, and are
   * simply used to manage the strings that go with the labels.
   */
  protected `SVT_TRANSACTION_REPORT_TYPE   group_xact_summary[string] ;

  /**
   * File handles used to create a trace of transactions as seen by all
   * of the chosen transactors and monitors to an individual file. The
   * trace feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to
   * create the individual trace entries.
   */
  protected int                      trace_file[string] ;

  /**
   * File names for the trace files, indexed by the group value. If mapping
   * does not exist for a specific group, then the filename defaults to
   * the name of the group.
   */
  protected string                   trace_filename[string] ;

  /**
   * Indicates whether the header for the trace is present (1) or absent (0).
   */
  protected bit                      trace_header_present[string] ;

  /**
   * Controls the depth of the implementaion display for the the null
   * group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      null_group_impl_display_depth ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * summary group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      summary_impl_display_depth[string] ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * file group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      file_impl_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the null group.
   * Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      null_group_trace_display_depth ;

  /**
   * Controls the depth of the trace display for the the indicated summary
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      summary_trace_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the indicated file
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      file_trace_display_depth[string] ;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name The name of the VIP suite.
   */
  extern function new(string suite_name = "");

  // ---------------------------------------------------------------------------
  /**
   * Create an individual transaction summary, with a header if requested.
   *
   * @param xact Transaction to be displayed.
   * @param reporter Identifies the client reporting the transaction, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern static function string psdisplay_xact(`SVT_TRANSACTION_TYPE xact, string reporter, bit with_header);

  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a queue of transactions.
   *
   * @param xacts Transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_queue(`SVT_TRANSACTION_TYPE xacts[$], string reporter, bit with_header);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a transaction channel.
   *
   * @param chan Channel containing the transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_chan(vmm_channel chan, string reporter, bit with_header);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Generate the appropriate report data for the provided tranaction, placing it
   * in a combined report for later access.
   *
   * @param xact Transaction that is to be added to the report.
   * @param reporter The object that is reporting this transaction.
   * @param summary_group Optional group that allows for the creation of multiple distinct summary reports.
   * @param file_group Optional group that allows for the creation of multiple distinct file reports.
   */
  extern virtual function void record_xact(`SVT_TRANSACTION_TYPE xact, string reporter, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Method to record the implementation queue for a transaction
   *
   * @param xact Transaction whose implementation is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Implementation hierarchy display depth.
   */
  extern protected function void record_xact_impl(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record the trace queue for a transaction
   *
   * @param xact Transaction whose trace is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Trace hierarchy display depth.
   */
  extern protected function void record_xact_trace(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record a message in the file associated with file_group.
   *
   * @param msg The message to be reported.
   * @param file_group Group that identifies the destination file report for the message.
   */
  extern virtual function void record_message(string msg, string file_group);

  // ---------------------------------------------------------------------------
  /** Method to rollup the contents of null_group_xact_summary into a single string */
  extern virtual function string psdisplay_null_group_summary();

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summary report. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a transaction summary and/or
   * file group.
   *
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_impl_display_depth(
    int impl_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a transaction summary and/or
   * file group.
   *
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_trace_display_depth(
    int trace_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /** Used to set the trace_header_present value for a file group. */
  extern virtual function void set_trace_header_present(string file_group, bit trace_header_present_val);

  // ---------------------------------------------------------------------------
  /**
   * Method to retrieve the filename for the indicated file group. If no
   * filename has been specified for the file group, then the original
   * file_group argument is returned. The filename returned by this method
   * is the filename that will be used to setup the output file when the first
   * call is made to record_xact() for the file group.
   *
   * @param file_group File group whose filename is being retrieved.
   * @return String that corresponds to the filename associated with file_group.
   */
  extern virtual function string get_filename(string file_group);

  // ---------------------------------------------------------------------------
  /**
   * Method to set the filename for the indicated file group. Note that if the file has
   * already been opened then the filename will not be associated with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param file_group File group whose filename is being defined.
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_filename(string file_group, string filename);

  // ---------------------------------------------------------------------------
  /**
   * Method which can be used if there is only one file group being handled by
   * the reporter to set the filename associated with that file group. Note that
   * if the file has already been opened then the filename will not be associated
   * with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_lone_filename(string filename);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/+cXhcHfBCjXTQpRiUyWR6yshhJX+DLlbUmsV4pRQ2O1KoVgaLzNfqfTr6NYzy2q
7yryvsNVm0tZJKJGDTLBpFjbOkvRzp7EbOiiuNoAOkSqf6dxOWQRpWj6f2W1t+/p
N6s5veUzq1ntdJAypsW+0eb9wQ8mU/nWnqtAJRpKwuZFsM/yHFWLYA==
//pragma protect end_key_block
//pragma protect digest_block
GiaNV/qFSfoMPysiaStVTaiWQ2I=
//pragma protect end_digest_block
//pragma protect data_block
amsLPOwPsGNXeJ5n+Wt29hDAa6RC/82BiGzEjO/IsXgmiTf4CHtkkN7+BNART+BH
gAnoc8DhP65Te68PXodU0SQsrTIr/b1YxiPeFZijh6UN9ZS6dIvK5OFRY7zqkEKl
NHPjQofqy+Yp+xvoirSBfZ2cYg2bK5vSoZiCDT1vZFw78D/xhjCxIVoh4rmlilNn
gaIqUxD8o0hAOHkr7JjWdV3U6U85k0lG76MXcDqsYcPHFs0j8H3swspT2u+ycAID
XLU6A4IeHcyWkQcSx0nLaVqqQvQHK43vc31tjNOMOHySmALPV0l5vm3bEEzFmc9G
H8WWhQ2ROjSKK0kU71cY7mXgfnG+PElgeH13UQYCrlfTbE9ASbccfZMhk6VeXd5o
VyYtiGRHGea3PvGJbESSnQB79wnAZ9Xa5fQj0HOl8WrFrVOb3GGO2bR9jDLuHRYF
fkN3/h61jCpnukE5SPqvIqdYMj3gmf7bQYtN7TY6i5HZp/ZTeFePMlDQxyEwKl6a
TJaFNnmCsLzL6mwAzMRbrXOFaqr6oUW7u5SLpzZDqXyIhc3IrszVgaC055MC+eG/
u/vXLbGzXplr4A7tAk/fHiu+8gp4AIEitCw28ueibbaBgrKt1MlRhkh1bXhqEsJx
09rzB8oViAh6KgZG/5HOL+VCTx/OGcoeIFZd0L+ELDPCNJj9cAQ7KA6wg0BvMGmt
DOsgwni8vkp52mD077EMgeW1M0tfj2RHERjc7Jo8GpA3LOImIjhWwU6d8iJrmq+E
+TBoBfRjr70YmGgJLUzw2gRvZFb+tpyTGdQV0jjzTTA43i0G8btMmsBFrMEE1w2k
2h/ONpaAfsxkHSw2tpku9Kv7H61RyFZoKK+Q7t8DtbTlVWd/CJYvPPrVup9X2euy
qPN/+45yxc7Bn5oOXfre0HHqpGqTmbxwhssw5QDbfwUmaW7mSV5W2LqL2sSIVVSc
akBkgSl0f/zkPUrMNKDfyYafAzlUFLYZKJVO3VDdIYSysPmpFFVoNNUvUrpfTT/z
l2aG4uUeF6T05RsaOkFlddlljl8PPETdWsax84eghao4Fpjeb8O9Kf1JxqTsNO1q
kI4wHV5k3LGgCQ+GMLaELzk9OIgb/1iFDeNIMTdtrr10WWFx4hi5AI5TejwK7gvK
vQgXTqWu9Sb4Xht2+BGl1WENLvdNtTZGUNE24BwUHSTIylAlPTe4LjK2zwpHTqf5
Xzuw0wwyK0txZtOkHe/UQ0Dl2rFvw8SzZTdFrokmtp1xWnbh//H0MvIyWw6ZzM0/
30F76l2C+3wnye6Sm5XvVruc5WcOEpwlpSoC0JqA+aDSS8nm2FQR5JkI4gNIZ4nL
Cw32N88aMF2bZovHAm8rjodB8AVSXnpcVOxBm/O56B6MZEtLIy3JLyKnXhNI+TjO
Si7JCfQZADQ3A70Y609UFPRqwvCLMst5+wT4BvxRyCspBL/DDuFEpFljyu6XYPpO
9BAfUg+yadP0K4ha3XS6tN19DaP5VhrqPH9MpGDuqCAcL1dS3QNSxqA86jWuco+g
HgC+zwL9pTw88NG2b3GYgOHbS9TfnVOuLS36WMz1/VTwgFBoTHmG4d68wo+iL0Bz
mcadvvkdCnjA+rKG1SvO7AVuRTGuKrqLX3XqP+xKKSpcGhUBwpbMi9CMW6bmxxg8
7S5ATarkSAsh642UDFQ6xuqWo4Otgz2gvlXDS7JrwcMr2Z/kWsyJpfmzb0ei8X+d
8Pm2mH12BxnqSRACPezPO42VKCKsAycMrpj3Xk2FkbMbQDLIiOaHCS+rmIIJ9q8O
+2EMqxAFFnEAdmMAQUyDR+JF4lOuf+jwygbumnefdHyzen1FQ5TljVKbQrJaCF+w
9ug+5NtUBwgx+UkEIXNu1iXG2WLdvVaXsC0ofmXQXW/zFihANmraiV8CECYxdLi1
lRkBuZKoMD3fddROkdPTsvc3yTNnCuuw84Lniu/mu5aHoFNmgJzBw1oYSWfAMEIz
hYX0q8E8Rf85hCcP25+7SAajhj500DNSxkBo62cM/jz4b398/IIrJ+2j7ndaL7xD
BDY8Ae7OuI8n8ylVA3pVqa8ufFN5iZoP57iqsclnVkEQ2ZJ2UcV32l0y3c4BPqyU
khkMFytYhg93JrxezSKjH2T+8VGeIBnB6R1CRyEjaqFEbwM6H0nH2oih1VQC6YeD
Z51vrlPZ4eKIeNMFXACr0pM6WXik+T0Z9WVknp49E5LSIv1FPesgrNbLZqyTuBqt
lG/UFsOk53PXDcDg57/W8pBO7KZi5Exv6AGDJSqmswBVV/m292Dr/lbOTDmCjSYA
wzxFRaDXDTVwgA4HprvPeWkfyzYLULG5D7WlzU27AMtY/6qZZ3q1kGUJ6zFGbdO0
x471tntWbRH9bAA8pjMjmowovET8p1SIqJJiCfUo49ytjz7J3eaNSWxtPXAHk63C
ibuDVTACWtnLfYfDWb21ciyR5yOvEVz5n79RhQlYY0k/ANHtk2Qw6BKzTxzeXXXl
F1OLmD5bQDpky0ZahVxC4nfvCV4P4SOyvF7foetGETFp/BLv6OpjgZo9V083/zxq
8re2MLJw2Zrp36i96CXC5slUrs9JSM34u+eFWFfseHLD7tHrYuNILC/PzfjcvDnE
9h2B+Fm47au0NY/KAvpdnm5DI+0+HrS92smYCb7payEh+oGA/7iisD3x93nOG8hp
Z80jiQAy3ArxcjJDhxyqFzTkCgZ+ap9tK3ETBi5Q9K/tmZcpmtQaGIGIq5Rvka44
TkI29Kh2tGQPycrnYQ6uEEbLimc7ZSgmdZQZ0XhY+YvCOnWudsjiSbYrIvVThEj1
2PhdpNxrZEEXE/Vuf5ZQaebQiTG/WQnvAdI61+2KUEassvyIdbOjYM8Mrlcaa54x
RuvHBwRjPTGdt+hkgBBH+PyJmvVPfvAkwTHkOcz3D9K5K9iGtMFc0qHlaY0rfoum
wr7zMOR/8L59GBcG9iYrBTsCeh5aMEf7NeDWrvBgCDBnIajG1R4IWMc6c1XsqMGK
e8DQJXxbjP9Opx8LEAlgfA9dLSnXZafeAZNOdKEwRpO/wDnYoFmx9nGKeMZfkIYx
Corp9FQnkXnxXydlBA+dKHxS5SE+LRiW7gSgyny66nwCKMWWQkAIdXWAcX8Dy4qE
mERdRZOymnVnagvUxa1Q0Q7JexNnuCCun2ew/0pLdtHpLcSKm45hgQS1Ifp/phEE
F5KN8GPD6BPN6AK1KxTTrOvtJxZQw3tJJLw9g/tVBJ7LQYe6TKQzA6DLiMWe9I8P
WofaZpWJPK4xE4LaEXg1lMolvUg+zy312X13FuluGimhSCLi/e68xOOQqes5M6QZ
X44w9hcEKSpANwaZjHRdrKi6/lleG4H1xBB8i79XFlr9r8BYk9wfug6GRazw0gOb
BTb5P9Ym2zCj0y/UTN0qzTyDrbMULNlEYrrTfyV+YVlGANfN/mXYYQvr4DyjIrBJ
LlWVZQc8hbqmzULlBQ4sKUf8z5C1poivADm/xSDW3T6hOTSWS6HVaHfIqYPO9hJJ
tEJNdo+MyE+YPQOhTpwVrzKRNwOoEV5Qcg7xDyXCZ1UFq1m+Lt2IU9n0ajwUd+im
Ke70TtORVWy65IbpzXP1cdGx6dfIhWXAXznQJPkoqdxe3uswLvWtu0N9q6WphSHF
hSO08ynBiWJFghBeIhQjPIdbIwVubdLoSwrn61zOhhfye6i2UTG1XDM6YfPNraBJ
RatW4vxJNjTQKHqxp0u/n/LO5GFlde2aRJOZITQelkWalD2Sg37uRUTkz6fY46zX
xRCZDKxBknkrN8FItRPkiVjnogDVd3tGIjuz+igf64VM8xuR0nmhSPvfJ3CIcRrW
H5F6YhmSYhsamXQpXiTsBnD41ElrnenjBABCbpDKj3CsrP7QXloQTvbxqe65S3Em
GTlCnPkQfkbmKt4o4zD5OTrrscUNwmH75PtZcaQfs4nZKTp2Q8NKAkZIcYzXoK/l
HSNnPvr4En6w7M0UTHO9IdLcBUT1uSQeeAgZpyUbopaMzPWFDxnSVyJ97ds0YtA9
FlAcmIDRiSdoFek1dugogkoSG6tijrn029FBs7H/kZUoM93+hOobAaEYh/mhxXlo
xOxT8ZXl81eT23h7p9wDf026saIeeGEGCnoW3EQRKGnv4kvk/eKFjxcY6PuCNBqX
IqsMoSp42nEvuGdh79SzKNSzg+dFDvR0JLHLr1Tu2CO46YZIzjXtQzCGB+EDOsnk
z8gCtoKwkBP52WtaQrfq/DkO2rCv+X8wX6jJcYt1VbhcRJ9pt17R1KlYIlbV3DDD
FmPoWKpKADJybvggg9a0eMeHBSJeJbNs9qGRB20W15TwfnrSt+1YWaH+yEFVFCo9
QtfXZzDDnjEGUl6sQvsX0j8T2ihVSTtC/3TnukPwNU8eAQ/6Ba+4YIohYr4AmBnw
xNwC7K7z0U61ywiqusDIdB1r2IMlRVCTW/WmjOrjJm/DMaIpowP3fbVV0BlRiXQd
759s+YVdSS7YuuaOvRznZNzyMq8oDZHxNLopkpJYLJ1+uYFVb8ojPosUFx1RKzc+
VLDXG6ioEKJ+gbUpaTL45tbRECSGDT+SsxW9oyTdNqRSviTl9Y8P21LfpU7Lo1c/
TMGc6tk3m+/q7kNJDoKwEUaUAjYWj66tyiPc9IaAekY55EM5vykkL9wTEjXn/rpm
klHSKNH3MUCFfZ+5S0q+diEoX3ERPUT+L6cpG0qlwUJzFpAU3X26oh6BSh5TWbpt
rT8t/6PiOmPAzuMxYXnMDQ85FLYArqIQLMk12sEo4E9IwbGFHnD1MuoHpD/Azynz
BHnPySUQZzyr0AHEq/SNvn8Pnrx6YqKxdG5R59Cd0/wDSUE5AprkOwuFB9K+5+9b
Eq67MHxiEHCc5q59egoIZzv4AlR1qtbOMpTbS5C1hBeQUEN7VtOIvwx3EKQiHjiO
kMaO+7kYaxpzME48WB1ImI8HPEw8Psq92O+TeFybhXorMt7vMU9nJSQxR8bBaQx6
erKRULDp33ACtZivFCgo9sMzTlY+lGe74L75hqsEfVtgZNajPd7Ucl4cBKiTWb7Q
KHCjdtg/YaVuWdg1/1vF4EXZqKhuFhUeefTuGcBGTNM6IuxT5jThoQ/pslGEBKTs
FHxP090kTvdU6/3rmclOJt4tEIlwHsCF1SNIMaCsnHDDS+9Q7kMXVpoqBP6RGkn0
TEAr8Jb2AxACW2KZEET4rqW/qZlCSHok5ZovqQmTYonAGREc1la7+JF3Xk6wKbU3
oRFYTVptszTKLRbdPOlvVsl7T66dK7dxNlBBBbu2R3dtSI3KxN8SQMqwQcoTkH0W
mCY5vB0k60XAgpzA6sXDB2Wv5exGd6ESKXKTcae6Q+dKFIYNsiEC5JDP1/Ub9GYd
zC2lCdQXsn1fFou1dqgXUIwKZqgMFF/8johnPSSkL7kyg9UJtDCl995bJXqL55ha
bgeF0szVWLBTb5cBhFmyoKLFLqUrK8vFxnGndubo7yGlbEZWTGw4IWk9K3V4oF/i
ArwX8OUsxxLCISQDAXU3qZaV/1iOAidIH3KaRjadBLE1sjdNKWJiUggoGLkTdT2h
E1zLSTx1+BG9bfXsDRnNpnojexwe6U9Ou1cORCGSyCIdtCG3ngyKOw9yJULytpZ/
7jew4BrQ5jgkAmUGQEJHv+9y151VietOfD29QUbcL3Ml5Bio4DGqzB8tclv3AjCB
yE1xgMh5LUubJXoNG9oUe4bgenn0Nhnm45VO55+C7gXgM0zaOisAyMiqNyBdIH+j
zbYvnvhVD5UXQuU4BpliphHf+6szLynpweaGoXLhhnrAxvKbWFRYhd09AaJBEYra
WlxOG6vQePv4QM6SYiEd0LXcLajNWPSPfAa/6U9foSf/DWRHLtlkGGbZ8ssJvcES
dqQuA8dDXVwSpzlkqdbnzJPD9YjrIzucw+7Nyjkm5IXPbQ9zeSoIfTyU5zP5AoEc
ggde+lZXe0LSiXbjdpMiWzTfwHbNOj6vYgTNaqDIjpudGDZd/EpxPjyb+5eQSwh4
BKyEsUeEqQnP3h4zdkrEcwtChTiK0PpyLqrJ1JOqkAVMQUpHkcyACdbfpbvIuC9/
bFWbdjvG/z1KT9lGyqihvyr6r8f8tTHr1N+YNtWhYwCOTagXhlGpJ08HuFF1KxMj
qlpcw8yyHnP8NSgsnqCYppzgP0Z6n1j3HiS5axb6XbhA88VN7/x1nJGUv12Xy7OM
4k+6zTjvp59egWQIdityRj6wjuu8FTkUWzjpBsYuMALsdo4g3KY38bLcE9NER5u6
1L879Qo/j7Q9XvqpYTPvv0vIjTEDFuD59gmjUe5r8sGk3uqdmgvwuEkU3LAl7Vdz
jweEXYi4F0cPNt8hVjaEEnsoY9mkNVxglu6zoVY08UIshhD91TX0esGXZ8Eakcgi
9ujemy5Bl2JET/KG3ybjijVhyKl5rTsnv5WrQcIlZon5uloOPs8+1rPnzmzqEtjk
zh1RUqspMQnpq2Bdm2O6yhHT15yX7apHOdm72G0F2MskfIhrWtrpTRr2GvR9uZ30
MBj39635PPsi3bWmaoCfMcYUkn4PJJw3UYD6otNSA+lxfkaXx9SFW5sdxB+wW6GT
UZfKzatmB+ubvKZnOIwkaP3JrWkLHZZOMkHfk5LuXInzHYqbn1f+CP9VFrOyuM27
trnHg0pmH8VdIGiG/tdQB/+qmC2xYAFod3mklBRheFNWOtM7cXu9l2fAGCKx/CPQ
HsofH5NuaKPL7HeR2bI1i/akXlYB1nYl6vvjJ5KvWAXTgIyAeYBdV8u6mZAirmaB
THVc+SQTtB9wVDhPABy3BLWzXhWNFG6zSd9elu19ekF1D4HCu7zFbt6MEd6neeP2
jSdTx/AxJrdgC1UryF4bV7y1teOnt8kSfKlP8hEviq/W3PQ736xxsXGdqnS1TONv
YF8J9m8tDMPFUrdIhfT3yUnB2igNWjQ927WTs7g30oa18y8i7Y9twRuFiokKjU93
Fy0kVTDRAAOajFc9FBKdhGixwxyCdn2n1iAEEh8ensTwE10JZhhxDF4yhMapc0mK
acrXPxwexnFtr1s6LLvWJKJADsbJ7za1awMogTicYK74Bfvqxpy6joo3NFZnJYZN
OqOIsFFKOA4k92uqe8wpx76sr44EBBpnmQRlvLHE71S/Eq9dTxW6dXWYnm6cL2nh
YRNfZwUNUsXO1YY95KWcXRWI43jpIoky60JZk+8GiDqlsr9dbCDAkPZF6746TXLN
9Bukiy4ntLaGrxAqmhCRRBR2kIFUYz8+oVGXTI2aChXuzXqMmp4Wq9FevVx2tVvi
X1NBI/CtCPw/ySyfBfGaaL+kg7+P2XNl++HMhj8/lCLCeeRSyuJoBak46KrbWs5K
q3PO3N5hpHT6PM7Upqu/8dBe/1VqVRwguRTxvIDIN0Fe6p1xKFkm3fNAgMvVRWNb
Gx8oBIkf7WMbOSiX14pldZX+LM0Ums5tfCTWR0Ax/3hl7k6OHSp1BHZpt/TsinoC
vjvshgZz1XnOENBHCaqS4LiJ6B8Y749jSgPuF3Zne34C3YZKF9LGlVULme4DV2NU
cy2jhefFdSW2lYeM0cODIEJX8gbt2udnRSwM7G0Y4jfoazJTWahmGy8G2RlkB1/+
o4tixGLbFyHoowQEaDi+Bk5mFHSLS6hMFEcvis8NYsiMtI8bJEHh7HuQqpcq7hVt
dE0n7f+0ebebWNrX0ULXHz7UnaI3SUhohmvxrbqkvS2H5ycqqCHQUAB3peEAeXVu
mXVPbdbhM6AuvX7WK466kqDlHgEOum4pQdI/n5ncXzKl39L8HFuDiA2ukfejyHPR
I7ILRiDt/Aqm7aJtpsPSICkxh+UpQfXtAAtaj38ZoehLqIgcA7C+B+k5Voq8fZFR
Qgfx6ezD/vO9OwpnQaE4E+tdvrSWrKc0fSNW3u8JYLa1RI3C7eT1sIoesPGhtTlr
K8PNUePI3buYtri6qUKLzYtSpVK2BvBI16QwzRKhyd17WylY5G5VcEKLhMX3mPxK
8IVLUufck+XZCUgXQX4EOW8is8riDGQ2Owmh9xpOOx3eG6vRSzJfdrezw0GV7zJc
p2v/MCsNWauwa8jA5jSbraDTuwbf8qWVZc4qlKrkAGnwx1f/f7NsCu89YdkIN0dC
UBhtMAiDa5zZmbb8vTqAbYqSW7PSHKBg7kdrav8sW6JgfNhoHU11BDbAjwhpfCNa
fAXw0U6sYw51JZnKog/X1iSgj+tQmI7zMupj2AQ4RZjfgL5j8LYCRXGEg5OI38Tu
prlkY27XrVGnr6ZPl9BaukEn8as15qpzGGTZVYtEB8JAL7TkY8JlxOWVfphM5owi
Gl5Fi0pb3DsFuSmhkR5b5SrlPtMalVhPYqcpl94Yr9RfPjhQcsJo/d4/nugnhmwC
ORaV/otlb6PANbJE4G2gmsecc+nwZNrkHdSDaIabH2J83LS+h1gj9JsUj7546j86
sMLkLCbkAOtt2E5JmPw+vDPKJJuQklvzw7SoCl1hJxCMZSSe6f7bCOz8osbuXeCF
QLgw19lS7a+dFCHmSJn5IjXLhkMcqecpHvybyc1O7BP0SxlLopPqnN4sbOUfyllF
oqkkbytrbQUIAtMtLx6Um6VfpdHWEssH/0FTIRRDiVF5hB4j+E8jYl4P5WW9CMhX
oVOf/NHPJZcVhB+ppNne4+/+G9iYLVuYOoMSL2KC7aq9iYzDi3XuMhNQkKgeUruO
TEs+LDWc8j0GOEJva8XOvPBnlzRoVB++n5laFHIrEMj83JHUichh4KrfN0QTe7iS
AF3HJUd/RwDelnsNrDj+Z4k5DTdLOSS7BrTtoYyQtXga6m9qD/I6yS9f+S9biRod
wM9kDSkZwCGte0PugPnI4VhuliTFqKfLujmdTKsMd9y+A4eKHh3tMayLoOJ/tCwn
nZDoQjj4K9FCt5+SeETqalonIJsF6dzDrRJ2RpldtZgQZbsts5Tc9vbcdwS+DiQb
v7GU/l8prtq5/V8LVaUG7dDePYNDTAJrlA8Jj4cFeGT8MzBtFgaVRiZPXnTniIj5
5HLSa/NJjj6trMM9J9RnWBX18gC0wlr/AlCOzDGVXXCQRbuHsTEXq8af1DWNJXJC
72kEmgpBzOz7XLi1QLiz7XH/GIr4MEd6ll4fhpyOWm2Y6t8X3qFwbeH1ZOlFZqg7
RCIXnWaNcqQNChb9wcTpwCX2Vku5Kv773JmI0tVrYy0J1thHpdr++QsgkFtJncVv
AG/Q5fr9U75qUJ3BQ0XtnX3IINLoBnNwDcoAGsEuGU62xFNisaFSCYPSy8p3uzuF
tyRDe5MLhp1H/UfL8fXC8yfgDd8YUDCN6j0ZKQbqxjKRBWB13oNR4cXGsDreqti5
eFSLudQW14TOB533bQmhAuEJEduuA3xvuiYG/MKkeoWATUzssrY/9TmSFbxWOJV/
L7hn1TOL8q1SW96toSkG/lw4QhAHDeU8YJNHbYVJh5rCrognzYW8jnfK3RBxGoly
eK1+WWw5M/C2CKOHDq7sFysU0XgZqThH3qStqDXRav1v5Iqqu9za9hkoW5LbuA1S
l/7LrTOM60dOXj/KPd1tJP7OPnvh7QvYm/8iHa/MhlM+4EB91ffRHHRgsrNBIdBd
d3S+FEj8ikIJX4HZ4V7XAxx+yxy+IVlRojfRosAQjlL1mAuhNBm5Do95gEYoh0Uh
o1Vml2YK2APOsKo5uKPskIrTWClTZJMQJyqJ6mB/npK22BPXTcR0IbncIR9ogN0Z
qGsgfRkdvmbplJPq6bLquiGRCCSFGWAkog+cj0VuZGb8kuB4pGHJfY4MH7aXfGnK
y79QEmiduCsSGRuKk8JC9muM48jrZRQhR3nbCJe6l/OeArYrrdQaO1NL1MN8cueo
Q4Xz5PejdZ1/K097E7K/P3hh5x+oQOdMQ8/9zkMglNjLuLLy0Mfm5gs7bhJmg5RG
2+XY8A7jgVGiaVeOLWTxP3arnKMkLf0c+hZSa1YV5aKoeIUtk3V7O6u2HZxWpmIu
khywjyz2vkUGLB5M/xHAZY1q/Zjqwb9TyPNDt/oM2cxtm30YD8OJSEKaGXLn9/SZ
Hk0R2s+uq2fqFcESGEU7tC6nudmhwjfcJko142S0N3rbfraD/DkXRmT478BFaGg3
zmr8QhvDtf5FpZj7LJF41lLQe5cZmNSB6FOMGzLxwksLZ1eVkfCh9CJMuZRmtl7o
hZ/ZHkYa0alKKWk0n3Ze1QGlrKgb0CZxY9byKorIYGXYhUsove/TJW3UpBgVJUVW
8RIPetqSJo8yBbBWTce4oeGSBIEY3Se/T00sVBhpylg8XLPw5UaaFAIORUhnI5qO
LKKKnM1jITlK5qwMHHQIidPH0nKA1ZbCuSZDt+xdi82aUGMyd6q/WxSl15dnwl2T
2tEKWIGPMZVmo9ZqnC+hH9MURqpTpLw085YjYaffcY8svcgBwJb20n+sN0wN72WI
dHt33RvQoqXXX3p9cVA8JCV9GhYnjKG7MVSpahx8hmiIC5Y48j2HyFU7oj1VvzLQ
4nR1iKdjJHgmRUK2TfWLc0ay1zGfWC8B4V8CqSN8JJQDKh75cCYXGThKcQdct/ss
N03tDL3AdJ2PWhIfw30uKXl5PqX1OL5/OP5e8lp8HD4QQhH/8IinMI/E9unkWmQ1
NOQN3Bu2N3aifWWUDDRfXnWjx7zrjyH3nhxKDIScN2s7biyRpYTg/xekuujgXWSf
JtEMoVpM9nvUeE5Xadd+RdTEjGAUfJJJk/toX8vE6UaZylr1LCq8IEIgvqC/xI9R
oy62fWnlxIIJmx446QYyueQG/ihKlnMZLhd3rRwO66dexI3x7Fo24PqtJSHbnmqq
NUT3UM1DKvT0+MeANONrCcVYaAZpFLyLceQZuvUvp3NjAnWmt1qIqYaWjaBnnVLM
k1307PRZB2EKCKMEovicLXDaVH6/8cn61ksKOpeLmfx9OCrRtPFm4Y5CA9JjbJ5H
Rh3fJw8BVkYU40euu2qM17MvfQcHTHviKiukYY4DIzqvuNB/svFXfchdGZHb+oKH
/yh7CtRfHVljppeWNZV/cpx7jyfNjrG7nODmqKJOP3HF+kd6W15ynqrDEMpal77z
Vze+aUDMPQAPmXzySCr77CISYxlvcIylFvbkLvZDb9xYHIeJOD55/DKIkg9261JI
ko3eabwj0nJ09p+2CMDNvrHVrvuCz82i6SZrwaIrNHwi7H+9OHFSsS+V3Xrt60pk
JNjPi+OUUGAcWJ4FAw69gDPDngzAdE8+twyHHcCXYjAyvWGUz3F5ESZtYBWufV9z
LXpOjBhudBeK0WAdIFyNTSpQku7gPwY9xlC1REsJdvYCwF6MSZLJgvBvtwahCFjS
okFzF5j+b2FI3iFCNWtSh58WEkThx6HUjaCHCswDl9+p/l1nu4OD2bHyyLkRgMb0
tlQGGkvsFQehc5CgwIcxFyrqVyx+OFoqSlrCMFiKTEbfs5IaE6EA7ge9mu3WSH7w
cBFNtRjzneIycmGNyQz4DOUhdwVKgiUzBIEWO+GxhNU9K4GfQ2mLdBHDrkNjtAAc
COkBnTCPT9qMnvsqGEco7n0APuVaFkp9UivLSWftwccm3upjNSFO7rv/KnB+Ej/Z
1NF3MdU+pxBk5RFshyvz9TWjngztk+xbIg9Reywy02qvcbutgK2rZnbC0UgW5S1M
ueLEsIG3F+PHNZ5SNUB8NLvWCo7S18T2dMqaBDlMgKz/Xtdca49re8IPpSkUnLXA
D08ZVrmhVAaAatXR8ihdrmDsatB870dZfvJc7Ik6tXDCuGWV6yZKXcpWH3E+Wopa
waYRZH0UX2SHyNwnpM854KUCpAvQd8P+N6J35kJKOvOvj2mYLUMIUEk5RbV6pfBs
3aA6I3lcwDdVbfYZhicsL3bhYN/UExWPCjcom/OXgoOh0Z7eyo0Lsz1JQOGBt3qQ
y1v6LRr0HH+rSfkal/NJq60+SnWFbJIrf2iGZ2G5G7Uf4UgQb0D73tmD0RDt0bT2
n3w2PiM9R1e2dI3LgE+9ZWKlDOT7yfNyDjtHY2Hcnw8t3c5ewCEq3R8ITICFvTyI
8uyXvyCY0GuIk0We6zIzQ24+K3aeieXTZK0GcgX1X6LuwOekSVWkbwoyYz/O3ZvC
tZFO6/Ei9qmi8hmTj1RnjRZecIUgmw6yGnse3IfLKIuTzanTvETZjqfX/7c9irhl
rYtInc6OPJpWjCMFBn6d9ZJtB2UoywApKldY7wRhqytFz9KEAwpF4H2rwZLLalNb
7Qpg3Z3A50wv4kDKRSlTN8vFVt+bo0SGp8EWQNeQegfmvM5pctYxelpNLCHbAtge
nqgP+lhU0VmmjDcqXZGQMy2WFCCWolLDPHeneK/H+toezSGewH2uJKjmFFEfkqMO
92FIrSU3apnMjUchDm1qU4FjB1qiFknrKUcC12s1BNFOtK6oNui9ve+vsiVn65EO
lJJIIC/N3LpUfOZPqcgzNZkyGYuSBWfC/SxUlyI+Qz9VGJ29oqGq+HI32uJBJtx3
o/X/Bai6ex6DKTNBRXS18MxLHEz0LFfKHhttQYLeNz7l6q5EfSepkgMa1WUP+HiH
1viG14sevGh8Az3rWCen9aKpJ0IeHbPcnBQP8afKejqgHbRDM5EGGsYD5/71ozBX
QmlrKzCwQKypMf3cUQ6zFH2/6X7GwTnMy58RIEJurx363n5nmlmEjM+B+whRC9hk
ubgP+5bMZ994kMjHjuHPnEvKYhO3MZ7kqGWn2yiIfxQ+9tGUjsfMuorZTZ4Sw4hB
qzEeArdZx56JaAnE/g9SwVQ6MWJJ4heJznQH7JrHMW8Xw4++/PZnP0Gj2iHCxTlb
IsqyeDDRj/1YelFX8mVlxfzCnCKnKiLJCvU4NXpQs7cXgG31/tMArB6hV8HgxOCs
kaj9lwE+pqddf8OxbXTl2H03ULkC+39YyKpNwdiTN3iPdC7eKlXtMPDTM/HOevLv
VumAc7qvxEN68OP1EiaPtzuxiPh3Vr+kIKQoZDT284YgFqfaMM2DeZZdta2oYuXz
+tH5aS+pYkGbHGiGuQuTOFU0tBzY8E5v191FVihbex7H1Qr6j1BtlI9WbL0EJmxN
Cp5j7vjMqftb15YZISn8j4aKMRmGMfMmzb9HplMV5pwPZ5JGc7aS4t00C/L8l11U
XXayzURAHqkO1uWfphb1kVvFrzJM8pTCNxPIBGNzvYHkHEtk6hSLMiH95StJne5v
1BHMT8ZExr2b0eMrPs399iHkR/wKcLokDxZig+ZgVFIaw5UzhijwrLWeuFOyEB6t
9XvSJCZU31dVrDG/HM/BlEzGjs048yFTlyfeYu8cMJJZDBs0FmHhCKzk1pDeStSH
fY3ZfG0UT8tAsCkXL8Zee8XhbejXWga80vbDtmnBwxnNfl6mRjWa7k9NG6zgBfeR
wh+b8YqWh2KDi4o8jv7MDCp6QRqjPNvO5cYCNDuoruei0o2U8Nj8OB3PVmovUQQV
PICi+GnCisw8FzxqHUfzhIwcMeLx351cAH3gednuamJ0y8/hj+8g7t7rfDNsr9Ct
umJUsdJSMj58NxayUIHFbVisQgHbxibFLtkAml0hqvwT5hqslTzO5fuf3QQqrgrm
6VYw8Lb6xPBKI+jakWd7HXRl2RXeTtaLAyjtzZ/owMfgIClt0JCw1J2iD9Vxp/OQ
YLjtNWbMW9mBvIMt6Mw+HFc2NZg8a1JG2czU6LBorg8mEFyPpM1km3prM5Id/vTy
PdGgYY+hcD7P6yzomcbLT6lnn+qogT+LnLF7WQxthWGhqg2SDwwZaZdNtUcwP1Zo
o81aAfLcTug26HsZCVpjolJrxPYMG5BWzv3FYJzT1Q1+G18OuakN+3mJ3zWoyn2u
hjMYGq4FfM0WlH90+il71UlofLW/HRndomtZQIiRnXSLTUJ39bl9HbDQe/J7r4q+
GTWDOmGYIiMRLw0NDQl7HQ/+T1vni9jf8YHBf0Z8P90wIjYUOVVttNesJMFPBI5C
+CrmJ8YTcsMJLjNDNQfh2NOYWUFWdTYhGwHOUzwArb1Qpp42GELEkeE3ePchGVj5
iezjNjcUPl+3IYF5RNm3xFcMoS2ooGg4kZso3Nx3nrKQo/A9/MxcIxBQ2aQpNJ9U
dnhTjGhNfrlPABSf0tWrEcMIZx41wTbzwnAz8Qxo9eMRS46zXg1EFKjwReVn53bZ
hyFsnMCwaRSIh1kiKv7LlhfykasslPt9g80JHjh/f0GxZgnBHP9fgGlqcFe2MlgM
r6n14OV7AaJlbNIyQEfB81mWElIcboMdJ1iaytqfZJshEcjja0OrA0rjpWc4PyFg
k8X/E8I06Gw/CiYCtbY8Uz92CMkeFoWNYOQOc6vDUoPh2SRiSJq3922Dh5+wTUqm
Tf1VDExQgpJ38qZe11+eDCRFvC/30uczfieAGyeDQGcVt73p8rL79twfOKwYk9gO
FD3ve61EWd0jv8aCpZAW30s8ESY3GM93NhD+B1Bt7QXzqm7B8zbCnAshsIppUro1
3EZJUmZxYpH07kJO6fDFYhTKNM9UVjIYTKsFWPFJv/vHZO2UjlDVuAELBeiI46lk
0DD+zX02rsJnv07q71tEV7EikRbtfwZZJwTKkqHzmmodFtMtgRazhDR53oc1ksDz
p040pRBlC5ULaKcjXTnj8NSir520890OO5pb9x23v/5Pf86Y0BM9gdv0jzLImCOb
xGnHZkkzaOGdmamSVeUkwB2T6m6zVbFPqCrUFGHJQ5fKvu/oqGVcHHXU50+bEJ9p
40BlHlh6aSPrFg8DH+Z9sD0cCpnzBihmZbH7OC6QN9lkGLaD+neHqg42uIg46Q+/
cFKMcv8boPkZhYHcB1Tz4W/xTCingjhP+iWIj9oS+fXAxA0AghoeMJTmTq7QTl72
B79x2yEEWdIkxxmFpc14jGBq7l7z+cYPXTh4eRFv2UlYsIVYvNTN/6WJJ4Ih/cfZ
ypAAKIdxwz4uDSqNw+W9Vrf7T/fu/IcC3I4wOP3upBpA3MzEee/moMy58fLx2cGL
2G7YsgkHniB8zeEIY+VudPLzFT0hwB7epEaBdVt5qdKRTzogF+VhaXWHMtsmYhaf
r7NBon+qFOuA+9qfjBfdHOIGXSOrXWqT7AUBsSxF1tZsrebfV1vECabM2NjPA1ss
gHXpH387O0ax8yw3x6HQ1f24Fo+GsWy0Bm4tLl1r9PVWikM/YxzKt9n/RoT4g7tZ
wJP3tMRHSWopRE8xCUiD5dqiynod/C+5rYRf0Ng+7k/a51iIBQ67mQcC9YZOrF2R
EJee2zDTupiy/F6eQrKXrdneBP4zWOrc9G8pU7b5aXQbNjtRw6FHALaSHEu7/mN1
FV4YP05IDgxk3Ops16K5D6SGWtHLfGIUE841WWUI2ZZG32hNV9I9mqBaxTRQVevT
8H8Kc62i4B+ZNPIsTYPCWeRahJF4jcrNZPk//qLSe2vdPQuvnaw3zWj9hO0hJ1GP
oIlhIWsxxGEGzzWo4RUABqJI4bHG0FkV/j8fUg2qAt7kwavvBWE/BfgnUgcLVLbv
ZUSXfFzuRRa4zTHjJNIEboU0n1jXrb4TizT2RyTMHbHK9JMH3769kJ5QInsj3G68
rzO5l4LdWkCXBjHlaKTKD3ejbKBHNlhpKADmxakTf16sTaK7oqhp5TXJgZ9jRpTq
vSKHp5Y+QfOoezJ2K49+L1ZvTiJLs15QchrOEPSIv9HbttlVx4Hag11XOe7r4ZZ5
AcQ6Gvf4dUlBBSXCAAndz8RE8MmE3Vw+exIkHlTh2hIUROlgSlc2ySNi8pyjmRo7
QUZaEWZXGcuWTd39O9YLJLkXfgeYmO/39ILbaplma+bNecspXVKUVh1togWrEiQ9
ULo/pDxGPDcmolijapt1+aPjeHWDsodIkUJe/xTfNGa3BOSGVoUD6fr7go/h6/0Z
3YWDmSswu/3gMFqRlE5iEpCZHZwCp5nj7SI0WV+isQ4+sy4QCxipx65loZJ7sx/q
pEptlYj7Zlx22TDfGRmM05XbsDBSYwG4xMU7aRe8nLqs5RAfjWnZds5sScc7khOX
BRNdKHy9kD1X6LsWzMCtwXVVvLCL0AIIors9UBg0wdzCnxz1eSCic55jV3ZtWYcQ
EBSxAgizz4IiDdbKdcbtbw0LdMZacHBujLhShigEg/MuybTgsyRDk4+GX0M5ndb6
2PWy3iyys+zW26d6PWAeMqfleghOLGOJlY8zm5lWlji9UwhtcYpntF0hpGT6lF4N
vNA6wglh+sfnnmmX7n5sCZChTGxbaEePRp00KeIrxBHQ0273PlxZW+k6yBmDQzIc
8uFoyvN4+DC3LfVba5aYvujvAv3m77VU6zxh7VpBNQwha+OCT2lJxC+FSGUpARcv
qT4Hb20cq1r+9wOv/uVWVts3B1RqYdMfLr0dVijUlyTJsPjBNeoB0PmNZPGi5CjX
cisRExB7ikirULz0Lt4AcLaydKEqq+rLvnA4fUJ2LULMwaozj8upkUigElNlzOQr
VkwMzD0d5ouYFS5lqRhQf3FGwRpjU8S3NU0xiQlSRhvde0R4ch2PPoeLV6swR/ma
6JpxuRwzbqRf9MjTMXMQPB7C6AbLo847S0ozaymYZ/3LEq6Sa2KteOB3jDXtlxDB
C0inAzf71bfE7OwFjKxp8HLwZXKmyBY7I9p9771WtoD7RuQX00o2SOA9Xd3VYCPh
HVVX/tcFW/gMJY8JltpPTX8UdX+EeQVJRhQCXk2daeAMSBO2yYe50aY8IZc3JVG4
1FpxmcLO83VysjwP5l/I7SPu7KF9ovvYi+YiJkaDEzNCoFRWgHjspuT1cp1aSXu4
OtBmpL07N4snSKwkbmWNCJcOak+85/pscFzfkbmutCm/IpFvgiC+ymK0gBTxkZYI
cw7XXxmp0O87ihakg6LVpm6YvLK6FKkhTRyHmb64gHs18IEHVbsECiKMGYonJz0j
gU5rIAmqs+35RnDIwMygM0sVuW9se+o9+V6+Q6cCmpNjQaWxeHzmzeKLGcesz0OB
+zUHXutir2qEXffMZ+lRSPgu2v8gXE8yuDf0hEHQKQNDTKm3jSeNrvrUv7SxtEGd
7CGqLbCgTrnYipBmJwwO7JbRnAZu5mbUe0XskwSpV4OW7qYBhbiwDY2cxkyAvdiG
6Ufh0lbJ0ZkUdVqTcHzgilnrw2LpoXd5uG4dTYncejrc4YeQVMPmE8WHfvCD0r+r
1XSO5gZfR+aHtN+ozZ1nQlvjYWdtoOaNmCNp9DbtLdzQ2OWSiBnPWnPLj0wDqOl9
SHQpd6VeecXPVD/bHeUmKjQFCAIx4UIOq69z82K8GBBkzpEoyd8h18j7A9+34Phd
HRm5iU30Zbg0oQqoKfMf4DnHmb2iKBrMBSeBftaDjHbJ/2EdBkAV3gtpaTYeL/pI
mCNH4zUEUfeZKD+/zR8PG/2agu3AHThnuQgX2rL38zzNNZDnqaBx6VHYk2Gi3N8O
FejROvTmpCLcleQiKA7DdE8svRNgteiFBUNYjXXPaDvDaDETnzgW4fiLZZDd1sFQ
Ul1klX/ryrtew4zI96ukE23ez5CHl4Y3yS2Y0Azi2hRofjPMjBNZBzBF1BROkgWe
Rb+3rHzkDqPdybASpS9f4AemyUrufKg1HfZ8calAC2qD7WgaKA6lLVB6gC+eb6ph
P8vjO5pfHXhhOQQ3WpwmbOFpNd8FSgPhv0T1lq0DhTaFtTZ/tPTEx10Z3xDAVfsj
IUsRWDoEOvvUF6qlTLj5+gI35ZqUaDVquhmMpGFPshYnO0k/smJ0XhbEeAU3SREv
/5bVewRgFC4VSxkQ7H4mbG4wJFV0g4ufObsb902hUfPFDnPz25W7x6Db2Dix+pIE
HxswMmOEcGi6f1ytUQ0GBcMA+05oNwIZEqLN1CSHvj9ENPDiltoDQwOuvE5sn635
cQFlfmjvJT9PN6INd6w/t69tZaheCMeBfEoBLaYy4G9VOg0+R2bNX/I0ZZfH+NHO
239QMXai+2pZTp011zglAwg+23+pZs0PNDO82q/GTooOEVse0gnXHAvLOGOcCq9m
uiEiXenGWJWNDXzOUuXeD8yeijg2MXrUDlW1g8i7FN36fd50eLzwcXx3QiiM4d2a
+Esxeulo3BTffkg7E8vdo9pICRgfiR0Dq7yrIel+M1flZuD03xQNPEoJuXN8uz1D
XyEnTr12S+0xQmU7BJortUK7aMkc6Sr/loz6VGH8k8cBs0fECf7OZtnxTP/P3m0x
s/b+aWeN41DeeIW4OddLchfuqMknHUS88A/fauk1GmyiShZEufF1j1jeOEb8tNEW
WJ9eWFIUR+GjRjgIWZSlM69cTOVjDNyKaBhBEBvKhelmP6dwNYZLI3Zm6NzVPGvP
DQLC3YSxG3weY3Yna2Kf1/U+UIRfQFlGhpsCIMSOPYtHZgeogfWMZ9IYwdWRxHmS
K4U/4BU0FPJIf7AkYewEZskUMbnk3wiZ7ltr/d2BXWCG5lUhsquUipTz059gWNj5
Qk5aCvAU5649W+Xi2LmzZndjCTiZAv8FXJArCy3RLE3XVkrzMKdwgxOyaFVPil+w
OmtytGCXwpQLu9+CkUdMO0RgZgXL/rr4z0zv5Shxytk0AKPoSa6kQ2dbjkGuBpu0
T/GAgns+/62d6p71Yj+Pd7zqyyeByjMilwHlMrgFUrWVVzbFjnaIQbjA9+JJ5qYd
X7WIFJAH3S42L+JC8LgKZ4LfDmt2w53SL0jICkDl2cvfIdKZsMfQMBdD9MXvpD9J
N8hHo/1mT9jeLd1hnhjOLFUegJ4rwNuIVUo9GO1qRPooefz56e8ur4h5dJF85U4r
bf8RE1ol6UbK7GSAuoY8/ssrTRKbhQIVV+hrUK5CYNuvXxAKQJqIXdnaGq0DxORe
H1NFrXxGYUV+2bdsD60/JjECrLXQwyVnJeXQm6SbUsK/hITew4YwPAnjhqjrFXCt
nqr65xN0NRWC07kpGpcK465FhHZHW2NT4MmL798VHd4N54h2i09iO2SgxStPpeh5
3TzS5nBp4RNvyfmyHhob/8clZJBbHvz6nRS6+sMrldvvfz4Rgdfb1AwJLXt+El1p
aW7AiuRr3FPpnB/nhEdxodhxmG55kvyOeVxwWj03GkOPs9zWOPTNW1tXK6yCzLqO
hHTV6x4miTvwuYK8kyHB12cP4TUbNKPx1oBOSP37C7ZJA0IvEZ1zUfxd+s2FVbUz
z3lsi8L4Yg2DSGV0bWqY1ranN1n7IxTHAO92TQRcp4J7KB3m2H2brSPnShHsHytn
2pb5z4in06LLyhv7kmXOGYTi1QlRtDD8q+hM7I+UEaxz/eiDNudGOHkHmmwhSB7y
gH2c/1TP7FdCixO93RDPfRXPNkpR+5joFnqUCkiDfxXlhG7/Wx0v8lWutXRYJVIz
yQqRGdJBNXkSTAzZbJLgqtN1/l8/pdieFbnf2zgMasneg+76Cm+OwemRhitYUY0w
+8xbV99AYXQmmxCbu/WFuF3SyguWp2teVC1KsjtAmQuomub+N95U4a55K3nt9aEz
97U05jG+y7U6YDyUOwYfy9WjJfV8z8x7A2uzDzqWsQORNSOJyDMnof6SqzJB+krj
1HHnGIJi0q5jyINrplFYDnxu7iuHQsEJgoG7b1/q2V/XweqleQax1ULKd27trEOG
ho4ogkJCNAny0EaQmLgo1lUa1WCyeN2WcUQS74OPxxY2+cjP16VmKcElYw4uQxl3
E6+4k9GxWc78GmPmGk/oxdi/HBqTCJoJ4BZNEr7o5WsBEg8e9D5TTQNJabG52aw5
JTC2FRE3kRWiInjXhkfRrYy/fZVZLYp3pxehAYf7QcPnTWNkv6QILxYvkfRbyZSu
iWpBSL46Zf/Zso8hfAEF8x2KsxwDg86YhFJBmcclyF1LFHKFxJNyFTMZMJibIAPv
jOSZ1QJAMQ0blt5p4Np1ZCE5oOEPKbh+KqvSatcwAaYXZKLQhnVKdWbfvFHWERIK
V7FIOtG/6XtVMvoiz7mm3yFuYI7qfsJSDv7oKW/2hWqEYwEILaOss65FFXypMRl4
qbJlJVMjQqErf/A//B2yneHytK+cVXnw9DIv619QXADfSZPyOY8ihZaLoqybPuwj
rYjWp8Vb4IuXjgeLfdLFCIg3QB2XOmlUr7G9QcVO22ItsBAj0aucqxQAYkur8uQr
KK/R95iYYBg80x4bKkLG0ohsmhmv4zX0jGx7IfT13LoXtJtHiSb6xbZdi9OFke1E
sBYfzWgy4oOLpEcGi+wjvGLQVc4QyYvaYAOud15CD77MUM7FW7VL4aYS+HRy4BBM
SevNPF+GweIZqLTHg7XsW8nnnG/JHEQOvaxltJUstwCX/P9wa5G7YjwH8pVwqN/r
FLdwLmKGiUSr49C3iu5s8kuFxsQYLDTQjyl91YHCu3BiYzvNLanwgwRs2n0/pltq
lHoQVtw/uY4DmRZ2cvLEdt+eeDL1KhoYMCpZ+iVIPAoS0vpQP2x7aMe9iXy3acR2
gX0+oHWLalkmLoQMsGtstB40+9dL9Lz5Mh2hdWJ1PrysoaVpAupMfYCXasJjWcVN
iZpZXygyYJmGdStUX1pr0fjgjlXXOfn3whQVWjVKYnVEl0khzhYmOc+GR4+aLW2B
u0RfxCm6Lhe42r/wz2Fk+mSe8VOugnmRhwtsx1uebSJzMVP7jkSQ81wWCEzhlJTf
jAjhuLQbFvh7tdJtiTYvnUrfmH1YTOzmbkcWCLl3c9vxe2KN9b+QswmimyaFCodR
cm4P6lG/squr+qY5+2Johr3bf/rD/hp5+bjgsDBy8O+Z4bQncmASrPYHZDn4Zo9y
3YI7Q5taswwJQ2Xv326OutNhBIKPBENK0uXmvjEhHKMiwg00n4feNsOh7lrjPZAj
54KwIaAH1pCB09xCDlaRUmyI/YTvdHSK5ywuJ4x7DROZq4l7BGZ5x0g/o27WAtGC
66VBF5MQesiivVU8oOyqmxXznC2voJDbTuKK0RAhTwwMT+neOEGOFlF4TGNq66ex
jL/fSuAiXHqKlW6OafKzQRJLEGNrjlEX9ayyqNeCRd1urmGkMlT3fyUKWa2oMTZN
PyPitp5NqrHlkt15G9FkRLUTWBsYS+6rg6CfmyuaJSbfmEZ4pEG/sEPR71LjUgF9
618nzlgis7lhlLdvhZwYSEW37lxp1gVI65faHlUnB0LC/szaVKqHeY4jFRMoicOt
T9hlVoMbraOlSe4OehzDEFUJiYNDduhKY8/9/HeifRngtnYs6b8LePH/CbvQZRr+
2gkVHy5f5DHMJG5H8vxrrINnOrTdnNlaVZoLTpvHVVbUTKfB8Ypc3LUgbJpomJSE
+KarpK4XJU69XMQYFglvjeguVb9E8vly6hehyYeDWJ1pn+We2vxvyqyateiBNEfe
SNhenaBYQ5xHP3AMagJx7XoH+CmxVr5RjxhREerEVauyKB+e45CWgPrecjcevVUC
qHk7hg+GV6YpaBL7FLPXHcIGRPyhErjrI0Dm2NVNEELhpXjqpVT4MSmgWL76Azw5
/3cozVlAdEXTnyi2xUW4633Mfemo/o3HcuRhXAHGItHpd4Oa/uYH/fYf8egQaAgt
gT80q99HQ68XR8n1l1OzjTHnfY6jY3XwM/dGa08jLytg+MLGvyCwywDToOZ88EtU
dwLfw7/aqgAiNK0V2jXDGsGGHOO8+V/Rak2ECcbmHkUpYpk0vGrnWZ9E8FnvaLLO
BgDtjIK6mVrrHI3tu3xYDfqTjU+iOmIGkDjScNR5KdGYxC6WmXHIkM3WQMy+Zxo7
bfVXEj2EuRvPzmtFYZ0G/BH+qeeGxMXkPyxLO9hRe18v6/UmfQBDZmjo97+VkW8C
3IzyFB7sB8ytkdVWX6llCpGxfCQ69nGcmt7Qa+FVxELZoPti2gYiFFOHzjhELrf1
/b3dXXoX79TPu2+z7i73Ya6xO8ycMQyIARb0poyeZ3gU3gA0xSLKtwVEp4xBY09l
rhbYTsv06UftVTI+TfJbbyUi7xr64Z9eT6fy3LXnABNzlOuNosRLh5LZhVLZGnhX
G1ENQ8rqLkP4alcYFTa2dRMThMHDxsnW8KxG7CBmajdsHB9VWI3RbDdNHFle9A9l
B3Q1A8zeagcQVRQbyBGm0k4DziVrJMSCEfFYuI+X/o2Q08pgRlseBoS7DVODuHX+
dk7z88YnquycP9D/xofU6F9jbFAEXjbYucOkmTRC9CcNc5ANkrc+SlhP65PHSnKr
O8+0Q+IQjt7vZkq/W5jK+CTzOR2iWMMnP/MVX8ENSzMtBu5Yc1TfCCGwhQXaPxFz
pk3HXYbOiyfxaxrVGFG9EMBuYRZsLGWt8u6nXVvfVTXBOJAPqKsSUWLjkorwtXeB
IvK9VoVaYMU2XNR9ltB8HH1985caKk4FBeZm94/vrniuDEy1RAAuhdHsLcYwzTq/
92zhddYRqhbZde84+Oi6puOGqJOAVvZIkK/1RKmBtW4Lig5utBKgfycx2HWpWbZM
/OoRTaAXnwj7Fs0mhcI43b/0dsrQ9P+YIgwMwI2ZBEENUOUb/A6VJQnlzDqU1fq5
6/Q0jKLzlmWza6WAlYZfRmgMlYVLyx/P0/5JMRVoRZXrNyhGPMAsilHuSE2GrV8n
v2pE3yjmAVW4zQ7dYCh/S9/cKIfyMWJ+cABpKYBkyyI1EYLfBnN9LyBIOBcTZ5th
hbR52q+0b9WNdd39MaAHc8rsn8xvBIl3NwgLIXMTS144Ecy7ZReyDH0Dl0EHws8H
HMo5jBAyaKwJqfqk06IlayowjjDVyIaQL8lK7c94K7q29RnTX8Ecn6vjLGANMWPp
l6pmyImMiW/CTPmQQ7HxeCBhtooOmIS+Kgu5R8/gmW7NSGAGEm0wIJOnzTt3lG2F
wG51i11p1Gg37DBglZZnOWM02Tv7UkYZ5NVAkJtymjunN4cZSsnzmkn7NEuLt9OY
Wb2+Nvf2Is/8vZ0btwKSmJR1rQ1kGsrMwCrItA2pNEmU2UQdfufHur1yfDzuX5T+
SZLSMkMomIhaCAqfJ/4BCxS3xDVkkmbTUTqg6wtPkxMhJEXZF/0PAq4r3AMpfOyS
FYMxFs1TVAnteZxq0e5dIS0n0qUuPCZYAkJ4cC/OXejswdRIenf0rk0GO12P8JfG
dSjLZNRzDANB7EyaNIdCUfdc32jNuaOQWjrVBznPSPquqxI1lApIqX6GtqI6vZvv
3aycvMDtxfUFSinEPt7GZUiV+ktRd/f80bgCwCo6uxZr+4B3WawiP7veHDvQZBBt
RiaYFM/ZBlkDXVRfTXPeqr33CAP60A7358/6wnd9E+thxSekH0TChMWysXzcqvrT
NppmzJgL/LxTY6tihrP15GL7J9nD7KLgHBETDMQd0nkKBR0B+O93XWyY3y/RbsWO
3iFhvmmYVpad6ZZG8UDQp+VZ0gqFHBfHIpZ2PZyhmyWA24E/pbxE3+rD2UmOokwK
8X6fL2AL0TowAV4y24embNACoImlyA/c+vruUIrbpYiQZt5nlwl5sdXiLjgLtdn/
3fpnN4KPz6DWsbN+PcoxcWRb4EL2XgKXyQkLjdlsPlZa25mwhHSAaY+gaaTJetYp
UH6XSGhLsqma9RGze+nLkAAsaoeaV6W3R2qvZl/cCX28W5e4YQm2HduaKpWTRaCU
qQmiesjukQhUWEFDmiUASbsnt3BtLYlGFG8SvLOOeFgYUgS8HZkLPJiuJngItP+K
jvsskWXfAtDbLn8HhzOwXJ7i6j6ViH8M0pTBqg3VT7G89vB6hnK92xIN5dF479VB
FTWzSSnvunuRXVu22VI9lwPknCtcLXCRVVFkcdMr1yYIoDF3xiPpHH2DPz/p1T+4
s4u5YpKe3Wg/fyR+4+K4YcM6quzfAPUL3WO5t9z7fFfDSTaV1CqeeQDGNGpYnPZj
Jr2YSJQzV2RlZMxVU6JQnXslcoF8Txq/XQuFYN695a2UyZJNscnTZtR0JYbV2X4s
yYoMTXlmAT2ufWf2pYieD0eAnCPKx7EvPgQXaVWkP6Sd6i9tbGpfeFK5CQKmkTi0
hL2fBywIPeSGrONq895Y9GWAg+gpexKhS+6CpbJmB3ljMaeEuKEw5mdJDB74rE58
Lufefx3h4iP6LmkNnZ2sINy7PET18FQOmnqjDpWR0tzYhHz62KqjvA6sbwvndNAD
wGcGACG4bg0KvrjQ39aJRlmTPT/Xgjci/RvlyhJbfWvEi8Gu209eaF2EAVOAsr3o
oCavR4LzQJRI26eQ7Y0l0llqbLR1IRC6DrM1uxMjmUM5HlllHCmlTs4YfbOmGjf3
oTbEIbn1r8mrxmsQIytGs+SDpGlX9E1Cy7XIEV6DYbhIyJdGQvy7JsmWxxamYH82
JFdYvOQ05ToGgbpW0khaFAiUqN47RpoMPcHA+WT0g/vkRmLPHjotnsAkzqJhKarG
JO/ZQP3CU22O9x2IaKK6MzGDmXpFR/XirM+c9zHJkpPGEduyHRqchezbwSgU2FAI
jstCKjlr5ZmYg0qpydE63wCACiQQ5vyivZgjvj3Om2nKUKa5k2Or+gUQAAUyfA4t
Blf7TWWgUEx0wTNWNbya539DJ2qNNl8wCvSLJMJLRW47NK0qFVT99rIolMW0/FKo
hyY5AGbiYqDvhSiPvyhkQb2MyqDvTm+EFPs3fCXURsZlcpQmYmm5YRpFyN72GQcm
lWTc335oGFm2XOzy2t4PvsbM96BqeHrPnUANK55VOhdGpfx3jm+BjolsLDzCMF31
2CvFfZ4K+Ame6CMAUihfO/QS6uj3dobf/xNMttfvlr30NCgfFDjUgrotR3kRkO8Q
kdNv1Lcgd/ZAnNZNEn0Y2eQpd579qYYcVlTYclv0/QyC8V+E4em10xQYEG9peOHW
CR3in/neV1k3PpfzTse/1XF+Py+scan7FtJLXnsQUrWRSBqSUgKWeSeZSC17hwex
RMNwyfnCcFmJEq97AquxpgxYJC9Yn0By5qLTERtsA3A/186nXxZqNf+O6dCb7EKz
SnM90tlSYH+Xhjr78Gwuvmy76jIYtn9I0IBAxqVxc/fDbCDGZQRzQ9c2EQPbKwCX
Cu3k1mdwoPQMUPLU+8TfJ8sbYIcc4Ovf+2vmZMBmlMbb5KS5WO2ZSbs4N1bgZNVA
IPsqgr5dJ1rrwXVruaBsuD11vgjkbKg6/1lEvDy9RxaUCP6RTFPLt5MpLHod/m73
iRltLP6p/t3v4m6hq6ruvave+fuaw2Ix3jWbjeiX2t2ZoQQcEyfhnJhdnIMMjZEi
QIKn/DU7S8+P/EqWoCid1gZ00daeoqzetVYV0fr6mtMKxCE7fc1H26rfh4iGinS5
QshrGgPGQeLgigIm1Vah0CBv/rvFwzs6q7ycwePAYZk0QJT6DD3E+yDcqacuzYjN
KPPuTYetXWLxf3dGs2t9dOu21Z/g1nlY+f5lcoa48sjw/WV6pU05LtZBeWWn1tXG
rCZzaVa/tf8O7cXrooBqjLRZyhpJBpnTZZ6Owe2E3naciKPS6mMnOjEIJ81Xg6LE
7nnCUuSfMy6QzAj2idEFK6IqZkrg3gX75BB2xa+U6Eni9eaogFiV37AO0777JiCW
Aa22iV+hhFmwQIY4rIF4ycadBSJ5U2dGDcTSRxcFuaqjHr4e9l8pk7y5yoTbGLs7
VkzlZjMCie5OdDaqSqKwGTSwlIKoPlahi4qF8bmXD9SvkycuIWisOFPKPgQKlW+U
GV8piuJldT44PJ5/pa41APBIY5T68mPnmXszWQpmlMrxMeBPNdCoGiipOKbOWI9o
9/Py+iT/biI/OTFYgXYuvgt1JOr3n94nYcbmG1qWfaIzezvNG0ZysRL4sGc5NV6b
8d4G0l+6mJrXQ5dZPErQK+Qe2DYrORfP4qlgY63Cu7zeAIq4fENykTBaf89vpcGr
gsNtkSlSS3VfDgpTL2e9V9ZykP3RnefOJaKe+B7XB0W6MliCgDJKKCx44aVTrT3p
YOfppWwlYV2trOFSpV0Anp62ZWGiFn9nz2YYTarodGk0YXlX4NWRPH9X5263jYz9
9Dc+QA0kA8ER/5kTcYs8jbK5yTFjp+B8qlEML9Xe3UND5HJqJ0C1HGAq6hKtTkDa
UP+WUExryoqseMRcrp5/OYYNW8/YFjKa3sszudn5h57KFxJogJWd3yytKZEsroxZ
K7fcaMgnbNcnT7V90LEQKODBIXNqmz7faeYH7wKymFOIyKPQCkv0vxQ0VvqaV97y
J7v/k6jJj2k88gDO2wx5Ky/rKVvcDphHjGadGV3qrmOS74GvKHbikzcsfhUiw+Z1
BO1IEy5VUcAFoMtfwTd+O3/BY3kI8KCekZLeA3qOIVH2328kZy+ZFNwGk3rk98xS
Aeha/4jFK/k5xPmqKm+zItTmBi9wcC3Oqk1T6uuQvy7QQvzGSzvBjdrDaBN+Gqki
1KG3a+NiRsKZm7GHG3V2iFqupyTNjdIw8B2X9gQr5GVpU/RFYvakUaKX99s6wCNJ
nUjLomZV/JwKDtmMtL7gTA+ysdRqAGWm/3pvaFGu+Tt3DT7hNvEiij0CaEpAqY34
2ONnFHn6k1NRTFahdu5HlJztS0Ah7tVrfalMDbe9Rl8Qd0YxKjDcvJb/9Y1ww6Mh
Kn1DB7SL+Wh8O8R+Zn/oSo0fg7bfIbnIbDmEgpU+ptikOUalKbNsLI1TDgBdkHCB
fgUEgQzxQSsVZpWDB+j+MN5sEhSvpbEVMONZCseqmhAEJQCE//7vsRaE9h3PTgP8
zFtW5jQXbwbJlQKyUPZFzCIloIW9MHKmRPvVSzwMr77ncfrmQqm41c0CkkXxqGAO
XcZIkoTu1DkvxJuSPMYBhNcqf8kPYhcJ0EB4odr27mCUoV896VF0tq7ohWz0IqX+
/9Bdfp3QMDo3tpQm9/VpMfkctwq5ED/CBZWLQpcFoBgJzQOhZuR7kXAfIKNr7Il6
L6ojUX7D+6DAlQUsEe5Bytq1KlInycl0SEL7p/1iXKgao2NY2fkmAt579+aPmRwz
9tn6LsxnGQU1h3nx5h9gOehnVx0BLvL4AynPoqWeo0myY59xBRSE+DCyV00c4GB5
MTNqT2oFxzbPJcaGNVFw6wtBjgN1FRotC3wedKdk6cpKJ6divwRbcXTXM8EwmKm9
EEwkm97ZHggbmWW5y80c1dWElpAzWKrUQ9dlGII7/6ynJIt3bvAsGPme93oeWLLX
h5Qsgv5QU4YWpfXtKx+6obLI2mZzTKvF3dA9b1bjJ7iCzF7MuOrqXdXyjBJ6kDOF
qUUYNGCiNwK4Eu3zfI9DkQZXLyYVuqpb6c/GeC2gUL52rHKqqutbI8JjRxoKuelI
v7fWcj6zkgvPtfzTSZGExQNBiuFu+Jr8brx6dKnMECljBrjIcuisPhGmEoqNCZTU
StR8uvW3t6ilIFWAaZdAK6+KFC9vcQqD+GDUWt3Xj7ettuc47gTzmelTF3xoPXGD
gcuJKlfqdwf2msrEBHGftdgEcsMzwq6SINj5qAJf6iTNAMd9lu4Vw/HHAikWHVq7
XJrIS1VzffSRTxbKXrYFur/Wu96G5xePAP8Qp6SpUzwAfIdrpSmBFhM3LPZFwncN
cwHKpNX3ZGp1/elx/ATTzQnyaFOsHHCeMOGn5dny9UFhRP9TQ+IhQTTJH4fNhkw3
AdVxH2oKTXk7qwSrdmnIwl+d6igH6NsrZfC0ZDrd9TI9MT2Q2e0wwqqPHfMKTi3S
FRdr0xmJt/yfND35IJGxhx0E990oSVccrD4hJqVCLwWSvIwe4M+dVDVr/AsermJA
a4Iw1s+wK45vM8Xg127ykZtMRzFd3D8dRquBTz/oyAZqbXFumb0qv8tLbdmderGJ
VYdt7AT7g21Fh1wmGf6Vtft1jK5Fp56K7Q1TP2rwBICi6JCKGMNqMFWleRHU8am7
BERAPtgD9qTH+9dS3qJ27ekw3GVJqw+H9hBcPl2gV5giGAcLwZ7xIls/JVo342P0
jnF6W0xvodM/7ynXSUsnwF0yWgNqgB3Uq5uzHMNBYq69yvhPlq+/Uj3MARY8WeJI
1TdIAvMSjUOVKZvG7JAHrw==
//pragma protect end_data_block
//pragma protect digest_block
kbmujuVNYfXgMZqqQ14IEGbftrg=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















