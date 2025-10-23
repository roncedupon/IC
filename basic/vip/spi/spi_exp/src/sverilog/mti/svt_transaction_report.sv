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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
J5Zpl8SNbpbob/xfRRjrCVajcW9xlk2w8LshVEvbe69iDUC5o6mPdXX7rLKDyL4Q
UPov6eCDg6Pp0pyrF4UFcHvhJkoLD8C+ht+fEV+b9e1eaxMjxDJdxQ+pygPPFvBs
9B+No0seYrQoGRfNGtRfzj3z3rr2D3eKd9F5Ao8GtFk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 523       )
1ZIqFNCwlpVBvJyYUssq1X016kemrP5qlpWARUI+pd0CWlawZQ5vJ3Ai99j8jXzz
OkMo/HDqYIvz05xJu80pqtznaOqOG+efAwQumNI1eXUJOVoH/f4wGbv2KibT6QGn
58dJCReXaZwPMlqmkYsp5M1sQKadshg4faE+GjElHUeoAtC+ZEQRWwW9D5p/TRRp
t908/XcUHp+BkH+1z5jBtAbGCuJzGQ1Hgjg+Nx3xJnO2o1TLBvdblfoM7JMbJx2W
EuyotDErPmVgOICTHl4bW0zxFKcg3SYta0eahj+yb3/NmwPdsZ9wuocds0gpxjmf
1eq48J2Mc/bNVq3j/4YvVsYnPOh3X5Ml49Lv+Wf9G6xV5Vhrf5/sZcK6mfkIFjJj
mMzFx7aA+xsOVeVj/1Afh1FiMaLoTN6gpSni5gbRRdRkMruNz3IZJOuXUAkiGL60
Hchz/gQwDYscPUAGi6JAmiIhg4TsEq5DViCzoxrzhsvvxErdDpTh99g/kVNTriMj
zwlBWPAWo2Vi+ft1s7LvEIUP3R6xGX/Ut6jcs9rn3PMgL9jc+1THQfbK+qjvZ+zH
73ZcXeMJGtQLKZ34wNn7n1ws7WO9WJSeF5pc0szGR7KXn4+xjHlmwOs4UWJgLppz
CazcCP4v/Trvsw33nHveN+aeXq+GQnIq1/wxZDqiTYbD10/ci4SyVgsMp4y1h91p
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oYbZdIznmbwTnbjY8taPNkBAjED+7ZEvfQO5eLpKJUjcQfOMhyHS8PDmH0PHBS4n
aQejDA+5CqitHBuxeM2kbLAwHCnfksr2nrf4STfonhwYOQYj5LrDm555cGTKSFcd
lVmA3WYSN0qMcKQzHh7amPHpb5Xf3OUjis3Zf2T0j34=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21301     )
ZaYsFMpMl8tmlZtf4nvpOFGD557sbijHh3DQcjIGC2rNpwMqyRNGDx4LOsQ3uGAv
FgMmq3xoCwxfYbEnmxL+dIRmzFaUWw3uRBvGwg8Ovw8OEQrE2f0xySTuhXHhbwiA
gKOQ43wYIRT4K85jE5X5eKswmOkrPfFS72eoP0BJ0kkKI5SyNphao8fjeDcI/bcL
7237ow+KA9ZAxcv/+6bfTibZUvrGjCYv/LHoyo6jUFbb6/XwGRlS/mPRYPToiCx/
6l/wAJBQ0ECTswuJMyGq1Ga+UumMikiqxzfRXR508OUDWnr98ad7lCJg9EBlIeEH
2D4HskuGR+L8dkGENbERlDAK1+hyEQXLjq/XS5DvEHtuVcFadZEQoYSWVv/XWNbq
0cnB0/8yIf29vn7mloR6u7XCM4d+HH77+Q7lg+s+LI5D/leKCzzSbtYqUkcipONX
d10xXr3PWXX8oMijn4SpW94dvcc3W+RSQBR6lqgFg8ugQGawl7jSnqoSxx62OS8J
K8sIcVYj1CHDqvboGLC0gzYNbbREnsMYlwYfKCeTN4Z1yO7t54VjdwyF+sVtPrZT
xCP0UrzgsAUHZSg712ixesJAQIIMbvA/cZcUEjl+sZJgoG6bfoW6CHtuLa2Yh2BZ
+xNU7UptMGNAIB4fSEUDXzT+wJ+O99joMgJTf21PF+dSBUhl2H+QE2utvipTxIT/
VjXUN95fedIprEnIlQ9bOiOIMzHs6qEKEia7hA+uAAoi6EcDw14i7P5VLaJWvFfM
a3CPHcM6aKGXEsV3QMBq+0RYGQTRPc/vQztPUSG/JUFBUD8LKk4pvArC+bDAwz5a
FM1YgIPjO3d+CTQgOT6zD9XTPVJoIT25rZlGyl0pcYImyaOvUsCYFOqqBggBK1x4
ETmwXQT+k+r5cxbdi4GyjF0lz4RfVn38av3WXmPaFsDhqqdO07rcBiCzN15Pxs5b
QbtafqhB89PzLBXV+TviZEOKz8vO9RIyHPufrjO/ZokU6LWq7tDd/pCQyJ7EDDB/
1UOUHYAxwPUXawGhEJQa0nFqSRuIxGm70VJ6v8S6nvxkSD2KV8kyCHIWIkLqdj4/
tKquI94yJbpCtx1/+Orc2QGqboksj8iB4LQw9FEeSWcvVcdQ0SIvawSfyzbZ19Sb
/BpC2F82rkJkFvg3anDlmbB8l1dVLCMHa4Vip7ks0VnPvVOXcVqWFam6HwebEmLN
VXib9bLIf7IgxTLKkON9uZ81EutgieT6G+VZS2XtxGgkYtnNgIXdCdV0HH9Ix36j
sG8npXcvz6eWFBTlHJWytLzjPadgQm5Ai62Z/PB4wCxyfMEgu5BTr4WgrGXQGDCo
ER99ud4JaWzDqDXV4bIkZFNqESZkgaXOOjL9xktnlpfOCFSA5bqSPW0Sl8GvKcU1
AktY1isRCMIuxEKNnwtaF2aWLgbXe4w3eYVBOzeuuPwUtnNYlWY2zoY7//nhuOcF
uj/8avZI34xrkCu+9HIryzMLJByknY3yYh5g53tSEKg9vJNcoVZfBebjmd14KcDS
sHp37NfBQZKYscWJDJNT2yzgQqMUMzTgRt+h2/PFUSq33E20gkPRVnlbF6E+l2IY
5J/eK7TCTZC/1gpgqFBJhOJaXd0Ph6EbesNevFkY0CTo1ztKQzzZlKUMzyBhSnAf
E27sSYjst4fykctKUfE126jDBHGSqe2en14ZAqLjmWuwlUu/TgAcieWPl28a/d7M
1ubbNsg7Ued0qhZturfh6H/7bDtkOgUh4I4jRWCL/+KjXy4hPxB6gRl2odhCLeFR
rwhM00NtWl/8beSxOeg3hd/m0dXSuZ7FoTDAuwguWvvPd3tvPv+HeaGCRRXOdxu3
lDXdHmQnVsd16JtKXUqa23L/ZWpghSipOROJBwRDoDo2sjKbCnlqcMJxoEfg61Ki
8kQHaEQLmhYOYulxcJp2ZxeO6RCjnXCxuXqbTLK6+RBNYb95cjfGWv2mmaIj/Arz
1PSzXEbnW0tAxpR6MwSWeMvbQX4lOHVVwI042KbB85VUFZzdYNH0WF1OZ0Jtv/o5
k4ZxaN6qwhYYGBrFSSFFAtuK0DCoX7JsFhY6ApkCPmyi22VKEsevuggnFGVUsql2
aUrJCRVDL/y0EVOheOdpp4sFfsVhVfzdVNWV9645cYhK0fFsIYHjzzEPfyKo8XMF
x5PENqOTpvCjm7V+pfahCiffON25y4fJf7A+j8OSTR/CF8EweZWBq/sWYwn7kMaU
DaJHGSv2z+q+w4slqMDyorrUlkga3A+Oo4G/ospR5wA8ZH2eBSDCuQOijvaLj1Dw
JRCME6uh3ICTwLwvVleex3Ou6IeX4NTCzif9cqMNsUvOfa6rtLLQ9n7VlfBOS9zr
mWfkZaaNg30ystiJ3mur2es+huG/y6Ag6dhY9B4WOhLQztjfFK6NnqvEHDOUW0fb
oC5VL6pLUOhh7ltDrB0o/OHdEpTUgcPa6fFCMRPQHTtWaiPbsdxU2JvY6hdq1gzB
CBtjqeOA7cBLxtOA+9YSqB2ssAx+gAUfJM75sjLRT2c1vO71t3szEhOWyCVrjoYQ
E7LkA0j1DLE4D5IKqKXsaxB8v9pcEP2z4GS8wzS+yZxtk4wPN+IR5pwCVDgzygx8
NiTQBLtKOR/lzAkJIX4g49Xt1DTaJpInxwiO5t8gWSvnUiZjGJamJkSDWZkppbyv
qKDmyZf0i6Fz0S4ROdzrzaauSb+HMyusBJVqpLwY70oF4zBZsW4j9jW6dj4AsJcx
4n64+qzjTAU6EntIUrCZ4+SAt2Jj/Nrd3DjXzGH5cOEJh7QucGgOkXsO+KccCFDh
QM4SMRXqdkvb2a3Gxo2LMJik5HCwRNH4v26D+ag4SIJlpi+aD+46ZB8yPKGtioh3
9CfsV+zNzPhj8eXP0uRyHJ/V2yXYVWsyxvyzSRIY8wHHhLc1lL0NuNjUdg3CAzUT
d4pgnWX5LK5pnB3zS7kM6u2BOdPgbicdUnppBGdC24AKcT8zX1rxlvttAZ1HItGe
HZH9W3/FbDCgKQKKvsjmn2VXn/4Yz+fKXs7FyHkhZMTElLSfKCC2YAr8GzFtiv9F
xJHj/CGRqTwMAQfBpgFOR0DnbL1PITKTSQlHgttQkbrJWK3tEVokUvdF3F8YB59r
EORCG7mGvgHZznoaOkt9qzyA8iX/TmiyWCcNIzr5Tslk806Lqn0HyX8hvUBO0FsP
pt4k61YlMi7B6DQcnrgTqotrvsFfKi/YBNBizCnorwFGEsDIj2skZ2a2BOZDhH2x
DYDQoGAFJP3t/XespV3Beqb2XjpREPA8gIcuyooanYKkaVWxxhxywcUFGTcrzVVI
XlmODJE9rT3zZNW9mHKy4SeWunupa++kOWaGRlGDU9WPunzYV9moIafvqIzhFyTR
em++jDvVjICHeXqz2BOvbh5oCbOyfGYUrPC9UD2LOu6oB5CG8SekOQZ7OhS/umMF
dCOZ2+X7ShIoypHlYAUZa68JMnPBRFZ6SlptGloVSvlE6KIFsWxlTc/rvGr234gs
9Pc1P4eS+i8/p3akM5yf4vsTLdV+k9s9TFRlGNnfHZ8jTAz1wBg46dzibAZdeCq1
MEVkGp7hpf4ddzGOB5jbahvvc9QJSro/x7/jYFiwOm8Xuj2uqX1oTZH8uVsiV7yk
Tir/ckzitodBx2KsKDUdftvzIVZPK5Ivl+CqgimQlmZPN1uQsuDVyoQJojmhD/GV
WD4+q2rTPH4zPkP1BVVAuoAjaD5cRlVlK0JzEGIGs78mjkrk9DyhW1NJoxvhuT6o
soPDDoWjdNUTkOoUNjn7SMi3sldi31V7usRW88u8ahCKEUoMQDiWqqSjvVLKyKx4
oElnBVhllyiCfdH+R4ktqtHt0ZcfpnYj9Gim2Cl0FfcWYS54xGhaxosRcgS/HJGq
sCm1z72ItS3Ywle4KEL9olqLS5jkifSobPnlCZnTpfQtmmNLtUBrn3hTdaadqCO9
iMreikYiuNgYBf9SJPbZbycssr4Hs4FLg0VBs3X/NBSoL9+/hBdIV551xEyD7oDd
JEMSrNk6UYsa8yuha90uhjsyFYsGQkJzN4CEXrnRpd8e1ED7NauhF3Y3kVkhcCwZ
kcuweWZRvRhksm/q8vloOhI2HeTwHnyjIqjVQsY0hU4SMB7eOC/fQi9EpJuS3UxX
dUWty+Qe/w45OjaFiujCeyBVqvVQ3QUDujeBTjuK10pGK0xgQbTyyv549qJwk9GD
mLdAKIZpQwUE9n9u2TqRzNaOag2rLMcTCWxxTcPVy9KKvnNvQOc9T8TQ0F0HWuES
OZWFQcpclNv+u9RSBDjIleA0Y8Mwgcafn68f1BmKVewzwqc6NKTWaUh8+zYuW5sT
9yDz1afQ1zOB+JBsp+/RzQ8yhyJSYNAZe3paahr1htGDzeJZ7WbKKfNCeN2F1xQi
lK7eyDOyr0WTb2rh3HmjOONDWP6+HCBFUgC389CRm27akrrlB012X7FQbMA+gFHW
XguXcaTJYR1RRUpYrDVvKlC3sX6pdn3FM+haawap7UD9R1lZwOL4Ut1GOsQXgQGl
5ZVQgDJKcP487rsAzq97CHoMYS93We6ca128NCnAYM9cHicc8zIc1GeHB5kFs36h
AjbJy5rzr/EbDqM85Db129/NY1S5QQoiJCj/qv/x4QaS6GI9uCJ2vRBKbC+4/h26
DYL1akS9UjF2I88lebVjPJUHHj2yU9XpOXC1CPKo2/uAJjf7uXc5RopJeWAbcpu3
TV+wAsBSqwzy4vK9sibdr1LUuBEDwL0z1nZeY+peSEwVyM2BpiC4PICFLct3hkxc
CPbM4ITHsWFfl30JalsQPajNaU57pIYynvOFoqKqLxgGGES1vVgfyDABpkPlnYAT
GAvdx0kjadgy07CLUTK4yoWvv0bId+nuyHrohyhogptaktMSzok8xtRprmwDvJ6m
TbgwGGhJNq6PeTexJZslOXDSpzQcgNsY1cPaip715Zx2FVKByvw4HOvgwuUTDT25
H+QZXshMUcVBUa6dVI0WbKWTxO9WPFQR452mlZMOGjKdhO04Xfl1FP0z3jUDtKxe
TAba9wCNRB1nh6wZD1rA66L+aeIKyhSACZCHF3j7P1ZKUQZiatziQLJ4kstapwr+
rsmcwC368/avaeQJ/4BTtPBTjvxi4i1P+wVBngWMYvO3WAGtV4mdkL9kQLOmOc3H
/BqZIXGZJDLfXYx9VtqUsBdQ5IjpjCLE/IVSlz80EsNqkoiL2IbGfWh/IeRBHS9r
43iNrq5LPRKE/Z7DNwU655xDFD/czNc1ADbY31F3ydVqCV5inWHQxJORY8y53EJT
yCZmdLnPcvqNHk3Q6/fRzFgP5zCA40ZX7hQQrD0wY1jRCqP1o5mwi3EfHsdCbAuA
N5dRT7MLiOMUuMCap810Nu+gblB4aRK1h6qDrsv9lK+in4mayxbXigL46GwNGOyD
pCbhaGMwUbDQbvQvIFZJXLu5V1tjmhdtaQ9UOpACTZEuzp0ZzluHHXUj8wLTjtBy
dpWURgD+ycnR6UOEAFcASVsXiBUkktLchvzWYJu6C+zW69oaUjP529ciakSiuKoN
iJZlGq2AJH6CcYbxXTk21y5RYb0i0CRdqd9w3cKEyw6VLYKoB1YPD1SNA/NN2n8L
3bo6szpcIPpbnRRjq9nEMvuAT/A+gNH2jdLmy3qSlolWAW6BSqAh/3cT3z/aC9cc
fG7YnWQt5d6xvcU0Zgyo0Os3UqW5Uas3W9A/IA+lHoJDDiWV7JCMQYVv3hxVCslZ
rspekmgF7jRCdTpqrjMJgX2pSLyWsSCNT6kGPszsUYFSddLBukGmXsHclgBWvpDx
ratju5EjwnuBya/z258I8C08vy3/U3q4oedESxOXsaflGVyN8cGu//hjWZNv/A0H
e/tFvEhgVM12Az92ceVjIBRwF5KIS3GOeGzSFpqAYr/cANhUupU8NVp5fQGDFrMq
FzVyZFDMWlFs/sP+twWq1aPjTHxVo4JowgUwBz0jbIYwz6m71W8KQnmzNZbJ3Xl7
to3aqDWvtFiFJ6bqR3rn6jFwjQRAtqkVgS/K6YvFJrYxZrCusLE3t7z36t0AfZEM
dssivSK+2ah18YvhOtyySfhUmT1Fwz6WJS9CPqyz5qRavLNlEztPZMTRTd/L5HyK
iE56J9VoX3Z2dt8eJxUMl7+LrXvU2PP7pH0g/siwvmsMXp8gumA4MUOpsxZ6+ZpH
ifNG0x1REf6wF+OZ151qt2vFTOiQqLllj8MscelmHjNlHG60aW/G7O6GbyKxduJZ
GezGbbaFPHlIdwy/aMtzm3/ozYIS4MzFTsIIdQlHfR4LaNthV+mI/2wgzKLYdJll
Dv0CAgfXeS9w017zCCl9pGr5gsH3zqDbccKgh/HE8UdvCv+2iFTKGrO+KZzuh3rg
gu2aqx/FEu6RuGvzgMMitHievn62xCRkGqPJYZYJD1CSJM5VORyJ8RZwrB1emhya
c9DgqWH+IIAwqB3CCyyScNMJ4WdH+2lBgXCe3fqTCgMlsKV4cbe8xDUx974v7Wyr
AyMmLyLJmor7zh1tm+pY0So1ft5LgUOv46TLxu3HAAzgFX0Z1ej5b+QlfIBAGpIf
t4C/PkVZ9EgJl0dtd8vpGmAg+U+Yese1SmEvDvq6MyAeLxqYiL6MPJZmh/SmAt27
oL/OrBMD2sH5Ctk0lZerb0Fjuo3yThj5CfYHsYyVMidS+VJpZc4R5Ncr5GS8hKEF
ow4WtC9GBKE9V4RKgsDV3YAS8tv4NwfXiUYa4hWVYzP+/I/3XNy3rYp/vSKv6aIR
Dv6TKcUp5ODdYx/mGnoCKZBiD9mZaRm1VJ+Q0HdLTO3A7DPZ0mxeN4Ks1inVri9I
lgc4bD4upcbFRlGRRm2jIftfWDi7y4wBLSZcQPWTmE9nn49AyQh9wVSoLJq2b692
IeDfoB/ERG43gIneV7A8EkpWoXVycQ4JS4I3qSXSK3KdGVwf3lGVOSj+H3FlaZ6D
U8+Bt13Z0SHE2S1ZCSxjVQHwWa58Z6iWUy2bZJCwyQDf18MTfIPxTR2r5PPc6w9u
PFtWx0IJ9IoJVecCaMYoLD9cZz0VuXJHgjFZ2i7nhFoOudblr0JAxl3JLkLuXVQB
qiODiuLEsHd9f3W49NxPxmbMQJKpEh8gajjohWzGC9DN7Bvd0p6+Ha6Z2P60zSxm
VKRtssf7qnjQQoI0poMlpDx9WgEB+xwhM3Vwi9k15L7SVFFGHlS7/SxHsowLlrH5
JShpOM2l2KK4RYaLzref8rMHIlQDgwIDaI3bweRp6HOLzOju+jo5NETrUx+xG9Qo
Yb5d9PKV6rW7hpo1a76Ogtctl+sM2sQVd3wb2ZN5CTt0++ZveV0VBIfhLQSEQNQT
02EnPaJ4RJbj9feV25USfnmdsh8OUS3nKRAEc0GG12aXvsv+EobpUP3V3t5ewR5k
J4pHrZxmt8rzGAjKvbk+/WKQyosAXlVqDdDjd/w9cL5CGgJ7z5XOVUY7fOe5BKk4
s2rBfIAi/Z4hdb6FLAumzRxpb6qRPuwgXMHaMc92oVLJ/eysymA8/eFRnJQGdrkX
vMPum3+I6dMfjpc6deaEvIr1HFChy2v99QFLENStPNOeJvrwuxhjTEGywsbH2qFL
g+8okS68T9EdL6M1AGGyz1HWPQJHl8M6ckEMe2iKciSKfSsZOuPSpMPo4uCq38cK
EHyRaPEMC6CQnjmd5AgrSd49Ot3ZmjfS0tawPLXjmd5bUuyvCsyz/rsxhGXjUJS2
ipv2W9U2++zTk5qSkkLOh3UJyd58qpmYx1anfGEg1C2HZa2S03cIsVo43+49r+7L
XEuxIGYHIvvzsa/UGEVx4wc8YAgZzcySPsCL0eQR9i3ZSbDFTpATB7JQeA2qF9qV
CUwXqJ3a2222XenO9dHIC+TyiFgUjkn2qJV5WPcz+mRrlZk7cNctlctKN4LYdMKk
BswKjPaKXmROnCvLOWHuhqL0UJ1V2h5yVJEEPzN49FADWjffHsBpR1KrlO7tU2eU
oMc3DgHUyUswjy0K2f8Mv4rg5aFOmKR8Mb6fjdWT2/VXGi6KTKhz6fQpNVfe5gzD
LD0YN3Tbc+Zri7b2DLTnquH4JJVvmgxfT+24bNSN4tG8Kh0nZUPyk+Fvvt/aoh6w
CTHCYC0nSFFGZy3ty+Xljl0KJsoT/PyAgGxS/AZfSRnl/vtJmXqoliTKB7PHWp+u
CuYyJhEMEkuS7Wx0M+4soL4uKppzO6zhGnRufk/sxNeyzUF80uBSQsZFLluwpKxs
pGPJzqI63JWp/rqhnsSChN0lAU1fRXIgUTfAU5aOvs5s3JM5B6+EW2URioWzNCwc
bHHpxgmH4pa2BDcXkfA5Ez9wShlMvPG1gaOK1FylnUaezTxPZTV+Xc/V55uSQKEq
Aizaw1h0YRwRmMVhm0PnyXF4vvMO4VSqmigGm21M92M2xijFW5tHZTaDVILI1IDu
pX7Cs6+R7UKbnPkdBxTLlAzPxED5XyoWsK1nrA3aMBPDDJ293g/capjq9xfGaaW+
ow/HN2aZTH8yhMgHrZl4bN3ed+6OUOBRuYuhXhqberWnjh8dbZCV+zEJVRP5jHLX
f+ZrSLT/TWp+YlclKU3nRblt9TznhfsJ63aHN4FmCpj+lPREbigYmwi8qarX8++s
zXAuLDvAZlPsuvjhdQUEdIylH2fDESmZjreABBQTh5YVrN8qgUROztTCuKm3Gqki
fNgDborcVd/vg/yuCMqDx7AMPqEHJLvfr2PItkdu9NV0vOnUNSUapBeJfS4Z2r7V
QrGb+kb9Df7twA/OXXImMTvh+TbmzKb1rQNV0dEGx7khp+FPxjR37Sjl85baRQYB
coZapuXuSl9e1eOtoKMO7i5F1dTCVcsqU/pZGXeCS5685LmHwBF3SD4wIjRO4h4Y
YJfd3Rh0ih1pN+WHIVV/2p/NjRrANwFLUO5ewBKPeatEZWfwDNfLqYyGwoOwpCSy
WBqUybQakmZYng6S5Oq/AtY4Oixg8IHW8HJpNGlR48S2H6VzJHd30j7riAGM7zEQ
BblVVBV13ykf1uaxqpwrQNCkIxsGyn3dsiBRUlNzP2ikhiPZ1V27WcrFLLfSlkQA
+nNX2bK+20QDOqGIw+lSYOvsNpvgIe3+wJXkoE0f0bcYg2PbafmcTXN7WiZToTUn
S4+0NCJ+JItvZnzehbAuoFjOhpPJMfyLljb7VWn1j80PB74dO5itPwVO7H7mNeRm
4DEnvVVtCRSwI/os1vm2N3/6XUtwTGR43d2jr6fQ44Ot15GK+A8Egk+eLyWjvSh7
J7Y1RwWzZ4e739L0u/UFl0fs54TpwS8j34Lu3e4bcawumN65fS+Tsry3pAzFrM3l
Odt19EhN9d5sdkN2cml5js44FVx/tm49HE8maTHdGuyCL7vB/4Qg1UrFOBFKhNJS
UxU3ZBdSTaq25atLcOexUDkVUiYNfYPkRSALtSpTTLPzWeoAmYaBkKwa0GVjypTA
/+6YOAO2BV4radvJ/EIX+ppyVWOalbD4RmgBpoESyaPjaEGwKvcX9MiuXPCMFJBj
jLjInOu6ZwXrGqwOsNItJmR+H9CqBoTwajUSzPlUqpTEbgk25niv2a9x8gxL2PxM
YLz3+fcHRBVjzAcomd8LZa8AR/e9wEBclAu3HqRYro8F4iFqw7t7EL4h3B7MiCCX
P58mosuyB4Uhi94K108WOY0imYocBq/83ArRwdKgKioiJ16NCtwSt36PvkIFtKtj
UsANbth8OYNNSo1/UNOFAIm4t36D6kIFbxT2gXrng6OWRsiUnAxwLlWyCaUSMtJN
JMvoKRlWp/Guqv/atf/KRTreQkrmWhqOjx52NU1/GN7Rlf+WR8F+oP/hMpyFxIoD
XQG4IHMXVfSOIsbPPl10Ilm3hIeQuB/pnlEue2ciGFoPdj95TBfPS1sGPqcpk66x
yOk4efk/86O9JhHGc6oI+9kwFXevW7PNXw8cLZNt6+XCq30B+SUWGWT6jyj54Mu9
V7WYcSs9sFMsW+vYl0zEIlEA4M1y+km+fmqnsubpcFwqbEGJ576hX+80hY0Q3Pr3
arZR+xLOcGqyF74a7L06CIxJLLB6yMuPhwPeJc8Bb5VgCA9dW65eIXRhJBWh7XsM
nOJDHhTN2/4KX8xW4+8yp3yD+NLU0w2bEQHgOdyVZ8zW1amGUCBYDxAmaO39E3rb
Fk8nxEfmKO97xgn4xxR3ZwecIJnm6LMwWXN5r0qJApvloIwrbmaQY0oo1tO7S68A
t8KEu5fosqpGgvEz6kdsxtIj58fnz3B+NHeAAXONU2xvdkQGl5H5fDP2Ukrmt2j3
jmFhrEbl10CVGhCyzO2uVoGruvhmsfZ4Cf6lOoFuy70c7lBOLyQuAI23PsDnTy0m
CwFRkYOzMv15EJ9vGQBYTY7z80ZZVDXV+09DeIVbyNljY4K5++nwKTDpOwYd822U
bR0IBV/dfkFSPv3ouIp26Ji7UO7IvrNmofX6iillSi7dV8yPxrhVEOLSSAnlsRed
FtR/guZOaJfwsLqazCxK0UrPDRoLnBVq4ydvgbTqXniyoV48eNVifKIpsOWjh7La
NgvdLTshiMlJXzPk/0Z/WqjYfujoUPw4YQ8KslASrriSOeyJUPAuu/8jm8rcvkpC
gB6sXuWYatHRtUlqVjA4T8h2YnBrtP6TFf2hR3XI7MqQLEkokl7wBLbL3ej1JyUd
pKbzj8E1zTCFWgXZi1CHVGsTI1BFXtJc6TOCfcqewC+jVbmgSFfGbX8ZAztes23j
P9+C+4NfzrXU5jTKz/ickqn7Z7y+k2V0Gj/WZKlDwRhpJ4n+aNEQen//JQdGZOpQ
POpCD52TRSKmv3QyIN1fH07vI/CwbPapOJeFiQM9L2wi4BTqs+b8F1YWEYJtSchC
3Qh6pcpp3WJpLxvReFobG7R/fx9i0yghWikgzPmsGNDPCnMQKYAZnl/yFCCFyw4I
BAcTTSKd4bS8IKFSVhSHVvwWPijp3Gohm0mVa1CFI5cfMdJa/zbNGlOuqVO1f2C2
5e4Yfl01UZ8eHuLEReFVxQddlah0NlDkW5AsxxXDmRQ3jrxtdV/W4JAPXQR/S758
c6w3faC0ff1wkKCEh+voefMHFkVdTwCpumuqEwr5eyRQFc0BSHMOX4/4SginOAXu
Oz0kGL2ozWAdh+YLoc6ef3PLg4vvCcp0dIsQSiTfVkLj7WbmWR7q//s7OWODmuHM
c9Gs1FAf9dS6SxCX1GJh/vcm4dc+1EENQbd+aWRdEdfyVeu0SoIH2CmWcJanZ5Z1
Ue49TG741j+NhRIL67Sq2o2heyCne8+cDC+MVe4ExQkdTnusv58nrW90C7yvNiPp
ppzWv20kTTDf587Lu2NJAPEMZKA+7yqIepu/+KXOpyegel2HC5mfNI3q7VJCSErC
Yk4u95qCvm6Z1yHmVr3wAXbgNLIvkGbyZwvf6r6rA73zBCwb437dhY3ZvyR/QuBJ
bJ4tkgyY4vfJz4bufqbczQRTNAlqo/gBR4LLvaNvXc2BOVw1z3WJPGJZE9oXPC7m
6PDvDkLL/x1JvONdgs4X9dFiGzISUiVE34t/lkIOLyj0VV75QIuTZcT9u7nGNFAX
o8p2gEt64hr1SMbhtcZJ7l3WBHHQkk4gU0wFxyyNvansC7gQp5GwnfVa3ZlHNUks
4h33BXKbOcANkX2nN0Y+nqmrBEFZnvrvl4tRPOraWauENXeMmKMSdvuuqYPjMUk5
zmr3ttOdIHjgLCi2lF1wphjkQUa74BjSZs9KVpHKdAhfzjRwuR+bOTf3rLUkiOFl
Hiw1Thg/qYal5amObKEZuWo3ZY6d+ZRxcxnqWn1iC2QCSi+GMVIIKeUtFUNoojsD
kwZExkGgjr865MkoOVBaJWeH/lS+AVj8V8lmFGZ9qLEexSAFAK6a2yMsQyTMfU9C
YLbzmy/CCwCmj9PIFkRkjM1j8jNo52t1xYbKgFA4o3Z8e6oQDc2Kjf6m//VcSVDT
dlHrRtHLFmEw65yIAkRr7YtaiPl0NwhW3I7fkt/1o9suAgizmzUi/KPKBrwugbhO
Lw3EIZGJN0bCx7GVzUJmUDPdBG3QsTiPoYNLSaxr/nchdCN0v4CfJeTAIYN05LWU
qzsqCgKE4psGQc6dOFfFy7jANGoC2FPUxKKqZ+mD0YNVOSddDalYs+4zvVJCTsib
IxSwfcxMCC+gZfawQBSjZcvYRbmZ8UE+1LW/hoSld7JeBKaPwnO+mQW1BeExPFuH
cbYEIYYI6+BCqQzsWpQOvWug+I9FUki3BhRa/7c2TSXTOkw61dAIGjIghgLWjobk
7TnqW3oAvtPTPBhLS/gPTxh3gVAs0c7JMEQBJGGCtMjhlMh85fEO8Z7tKC1UxZzc
mmT7OcYJDFz9c/OcJoCZKdPJ+BGfFfp9I+u7trYqmeYq3akzx8t45i75EGkr7v5a
PeA9/TYYryQ5KXyV7rNDqsiCv7udYMXsVMcAUNbNkNPCZfCqcbbhnRKWxUfZDcw4
1XfBr6kQXXMQCLshf3tJloQp88NND4mtMgF0PJCHp0lhC3RHIl3Tugf3m8X4Ko/q
A6fO7r/z4lqx46IhN9MYqcgfBHWxT8WFaStnuaZlA55lWwrebvJhLkcumpbby77B
Qygl8/SgoJP+PcMDgmSn+hX/EJEv7GTduU47lj/z2992V+7FU7CyegdpwSqRf+U2
3tJJp/tUtI3gCwTN1a5YsOcj7cCGTiNtUSWMA2z27xkblBSMoYj8YGa3e8HUfIFS
kz5lMHAkEomNzbAaPJlW0Wso/TKw+2Mela5JiygchFxGFkyNsqzEria9uz5QNiAt
YWoRghf+IqOpppjCbuuxSfkKW7Tsa6CQGfLpoiMDz0ZOWVtP8c3FiSgjJwQJZfJm
d45l4Hu+gb4K9W4SppyPZuWPHlV+iDn2WzFjDVAc/Av6Rc5lCvIFHhdofWL2Ma8h
9R007jfqPBf/Sj56CWwQ1d45zWTr37gxwe2shwOakAMh0H8fDl00Hc/YA/lIRVsc
k85GDaMTGQa1QkoS1U8YYBig8cGTAB+dIJ5zxG7i4p+ry3I1ADUq+7U3dIpyIp5T
kWmAk3xncHFDaSMHrsOLzcK/TSOON6qHNYoavfuB0BdrZgN1HquxShwfAFyGxoYE
vmkoqpKGjsSmOx5VWuw8fiRlCfghzsuYk0zcU8sQeA+k5ic/HfQQsND0ce34xE6M
lsRyJVaYsiIpsaGJebkfV0fhLaCsoMvMtlylr5K1PdHI/OTAz6OjMEucn/V17HgA
O7FM27BdJh+LUTBtL5szgVo8rM0Hc4Ps1k8KH/VOpev5cQW8+cDgaKWvM2sAA13w
Ec7aVi0kuKBY6iYr7krxa6KqhvTTWhYf3nNp/mldcUDmzNJ2wqyfYUC4dhhpxUq1
i5OD+ddThlGDfpeuZtHHIcC2uOjBNjrXX3do6OGCgKY5d0lf3NhZafucAp6bIohJ
EvxY0cwOhv7cPCyU6qYQfqApsFjCrKYpBIQTsMViFqHi9xfJdX27VcCA2teW0bo+
AOYQXIE9QQ/AFegYdtQVg9F8mWw/axw/7Uumc203JypnHcZcNSLQrxzrx2A9mkqa
teQ44heXqDqNgdyXNb+Yt4hd3DNAhTrEEw5zrDRpBP8VZoKZZaNwl13udW7GQTYO
3NC4A5SesyU5vqBwmrlLAlONQUPhE2XXKrbjECrS96mSkEOJHddhVJYZpmK3A/TX
HVXzYuxxPF2j5JmRHUxurZOPUPYEw0cYp7b8jqkBsNRdW2E92RnEul9bQd9Hcu2o
N4vorbILBvfKfw7hGZCa6OPnZpgU/pgb7tRzdgGEyoOgfY6oJOQKmL6jA2ZbzK5D
30KNuVf4u60eTck0b/H3zvGFVXESIyf/MNHyF83eD44R7V8fKILhWLc5eCeNqM3q
lIOUBWAerPeEx2kcvc75b+MuguYeYYCWVbWUtzxX0BCEcG5G9URQWCXrYaokFYZm
7sps/NAnlyW8Fb+MH1ZweliU5YPmaetrG0eNhwZT8xOhSdzRatXlG18QJQfqvWoy
O9ibcemS/IcSvKJ6p1IxOgxiDixWPXmGYTcNGzH0bNRMyUMJKb43sbwfdDQ6mtnE
QoG8oizQnyxGNihSFOFDVrDY4PxYT4eWBA6JoAquMoKFN6I+1DENr3Iv8b6N+me5
UlxlfCQlV7KAvZXP8nzc1ZvqsjxxBCT7YzxWk6WzYkJ7rp6YzqOuh++HC2XiR7Yf
Aqm7BAtpbn3CMI1nqDkqfatm0YTQTItZqE6FdTSQucSgdTEKoD9joS5ZH5K9IYB2
SHO51Ya5BnrtoKl0M8dT+2p4nxFB1H6HKqwczDhH5zq6scRlz9Li0ayCdZB0CjbA
zBUZ9kIUdsYImUixKkjrdJMZ0Gp/Q8O3qFv75QUhjiI0fIQcNmYPoQ3eLkKYaCG6
ZGxG1fzN/+4O0GYG8K9aXLcDhuJhQh6PvjzBRdHEdbQNFqW6VidJPPGas+UbE4nt
ijLLMemrym5vM62uMUOQ8mU1W0Dud6TAI1evzLlxa2eUt8BnwTkQY6jgCS8GPB9k
7NyYb5JZlIVwNEyGJ3+awf/HIssNzaFMLWLQXSXT6leSCp9zVd2uHOmxqH4G55g4
GZuQnJ+Kai/9FA6MAkRyVpjiYkLFodovTomSeaSmLUpPqjJBr43AZwgtq6insADW
ubGLLWzwJR3uflUfhc9S4r9I7c2J20ZNx2ObgH5af5OtFYPwJ6GjB+M3oVaPBNIN
6zu5Fkdh505oC8wmhv1vmGmgX6VDxsUr/WmONL8E5JwU777r+AI5EKWewFQyZl+w
AEMA2CgCGON52fplGf0NGf0A6XOPVz6dqbw2YgxVJhJgPMDLrjVn4mINp4RybXAw
fPTj60+xv84JTrYx12soZGuLCjfXKC+n8Kghzyx3FneiwWc1WMyU1DNP6Dp0/Xec
Wt7e4C+TKzEytrnMG5bIvQJbhiYQ/8PMaeBzhLGOtfJBN89HCbT4jDlJmPpY/HEB
+KEmzp/EbqR8vKPZ8yZ6LAEeyoZphQiSLZ09LtFh35SYjejICnD8BgRlDbRKmv30
0F5XtWm+ddYfbGZkF7VNjE8sfTZX2I8cYJSk0kA1gIvkHkz0XQTIFfakWrTaEMqg
lMrHI7jKWzsixweCxuUzgJ2C163PfczAU2GeGxmmKxWUeHkw86sAG4p1S/DafGyF
wstzC2BZx9TBUZ9pQS16grd15L2w8+04Rg2aeSRC9/eQvpruszJiB00CD8SHCJtZ
bA5Ezl0mTCc0cJicvyZ+hhz4P6Gjs/kzwuQGf13/Z/uzIbLvtyWm81UVFMEDC4d6
vX42IoO2TRkaZH+Hjcuo42v5500Nu8LI+N1AtEoCe39oisN9IIRlnBcBIMVsziVp
qb7zgIxWEh9gWzDPwm4p/CmV2a9+Y/AMFW7v/zvRj+dltwveadsdfilmvWGbciJe
bQK37+HNzJCYtlbGkMchZl+TTqdhYPM8hIQkmsboDEy6t7cE5V36pn80Oyrum1vG
loDgJum1F3OzTLg4Mzk4h1JZwRVPVYZsQBLtwKphqZTAN3hWLGx//eQG8ubpTBxF
9lrEte0nUSLLKCk2PqgqwvoWgG84Jd3AyaP9HnMtksSZJIOQavYnqzC5/ad2HYKC
n4Bkcl1nut/Sgtb9ZzCyjOmIzYvvCdch/lGDXl2SeCGbcWsrNcAaGjHgZvO4hPPo
kgz7VBswQdtwVjaW6AYRpP/T4QrdyM5+JYAoN/U5MPQUY9eBhQp1O4igDC7wEtYz
aMzQbUMLh7Kx1QbrmgqNIxHY9muSzJpaXZLoi2XjfrITxADvhTHOhD7akL3JzTL6
iaUq/FqVrleo8ZYCMHd1OaZ5ZhETxlQsKoz7c24ljBMjWVDVEfeWEzo0+NbttJ0e
GUxOkX75buoxqCKUlXz77OEOrVEPAvaMqyZmnKlwGRZjA4Y14e2DyuHmzEFYFh2H
gM0qfK5kvhMWhJMQFASV0x75cvmIDx26VcrHpZpZKupPO/H92b6CRPU87qRkxfx/
O6D/o6cQUQzFWm1bAS+JVvtmrKbSFMaV3ejtPNC+x2sK9WvFpEvHOImu840qPMRm
d6xqDOioTcvmvqR/WqRVTa9lgUStXzQkqWOmDcAdW3gqP5LrUAwaOBhbVdwkuLZl
k2FoidmH0pTc6zuH4fGIrjhoa4eTiKZIdJrv//kO0fvo41+fS+GT7uDIu0VmIVdA
Dr4xrusBL14j7MFH4boOngi/V2xNg0/zcMGIVe5OP1R6ARQoYicdnANIHw8aVCU9
dxQKBoNpOqzFZmXBQvSXg8ZTrhu3/cq9mLbi1Iolfd0CsIlKFiQDJMjtMVWTTvDz
MBo2bUR3QSDnckpkahAMoNImcYVXpMXLKCriodaL+GCQnAxxTlnMM1Rnqw8D3Wpu
h9fTMNXYPEMS2arBQSZO06NCNk+X5H6nVXl2elfen+Gsaqv+EBdpOzur86y7VCJQ
ljilpaQiLHWZZj59aWaOs/bZeuDCmn+uLo9LqZ8cJMcWdIEIXy4YA0jCnyEEwtSj
bfiJ9FWBsEef48ZRgYuc66dBgN4Qh9wq7/4W7+x96EqFALanQ/NPHECKEaYFOYVR
6osNF4wiqpOYcy4VkbMrPdqU2RBouSxfOvw5b2L9jgHisZHVKJY5w0fibZZeyRfk
VRUo2sqzukT+7h4htcG4S2oTXv7xBxFanYrUNCw8uzNBxYC9LlCpQL7q78SuJ8EB
zPvLUF8QFSDP+kAQPBUWiyFYxVJEsnMyuZPNRNVEzBEurpbsALcxbe4Lyz8WrCLQ
cfQoz0cBTJV6VNjbkBLHYMOBl8tf4QMcl5Fq9Z+5vAKxVF72/T4cprArPo3da9Ej
KnQduRtWI/G0+wbCniOyl1ZqbXVZ6eHuyog40rxoKzx+hYY9CGoBZx1BTYfkJlJt
PddUBuq+F9+kbT8uYNpgbH77KhNZY0B79erf0lnqqgpaFX6/WigQ+W7M5zwGYSWa
uS0qH7B2BWPo7JgF7qCWRw+wT/Y+YPp1yRFrbkuean5tqX98aOVZcbYKr6XgZI70
H/uzWbFrJWTCN0UK77070iKkjIqd9leLfMvYgwhZm2ybsc41CDqywYVYJR+mkxn6
5O2ATmOqk6EHcpRwZgCCBS7NHrOoPWbge1J0br1rUyXnVkP4kBVCtN4lthuudS5o
yWffmnc6Zqys3MxqGNC4h/lh4ktYbNVtfMZluwFAGuHFtpxMq7Hdt8S4X/WqTxnK
bH1yskdHrSSyEoJioohCOBa5eFFbFf7da8GO5l5nvFcUrhNes9cSqrCDnT4Hes+L
grMaPFRjGUmd7Hz8X5om2ODI4eu7M8vU2Cr2LQX5Nn5wkaihyrjjGjeqduIbDAqI
LGDaHeUo3s52V1s52a6Tco23yeI0/a/Mds+9qhu3I5d6er7ilcSoqiOd4acDb/qE
JHjJW+gBWuusAPzrrGolUyM30QSBB7puw+g54VLhabzTaakOIg9gNURphqv8wQJ+
DWu23LAX+drIRTIPgABKkhpR9kgvg776KrS9G/jdQc2ZUGiq9WT1FNYO+XA4SLBn
218N1fLydfnPnct9+utFvN5DNnsADSO0eBLaLy/0eQG8Sea9le/LDtJY+giziF3a
uZoiqlDwyPHdKGykTLkp5UgwvmxeGBpAO9mIemoFvWbVLekcZXEDzUC34Y4gOHQg
UnjkZO17VVIkQewOKDE2f0nZPEsRVk7ifI++DgrVgIS/rOvdR3791Dyp1m4a/2Z0
2q+9KxcjezBB9gH8xM21101Houc54z4PcybepcqWQWzPg3kR00oStMjnVFXznR5G
SGssrbX+i7htCHUbqln0gGLPbKpeN3sEIkOvbjFiTKJfOy0/Pu559/oIrZXhDag4
srjGRw+IP4/3pFlasfECSMfqaoGsH0LDSUhs7hoSWu36gJKIERNa5hmt0Hqrz58c
nbr9M2yiGfoHfiZSXe8zQCDkOElPAs04BnJhxcjEuKGANnT2J4mgF7gLz2e4kbDZ
wqk1tyYHoCIR/txWPhwpK/9ARg4rfTTzNzWelyp0HWungGw1xfj3LNSW3iZpwXrP
6VY3ydn9OzP8/0puUYKQYxQhFyOcmZswqgUrGeJGZ8cVHn18ziP/ZAUmi59UIlPp
G7xzL91NPFp1wl72QaGbMPOKJEzJdpu2LoS36CDOm3Xk2xKdn3v63w58fp2Nistd
4hAlZ8lu52BsWG5erycNcXGnbruCNcQgO6CwRE36SO4nl7uCcnGLNMsKV53aRvNu
KdTvg06W9wEWN2CwF6S01mdI8F04XSvtoEvlE9y/7PRI38wZe9hojdVVtpfElCWi
KEHGS5Lh4/dUG1/oVdyrirho4jJznx8ObAuxSz75QIXedfn8fEIJkQtO/dsXLFkc
jzob1xmBSBXTCA36m/2fU1kgImA/XIZ2VTfLicX55kIPrhmZO1h7g8q2pDAp0e8g
z3UBImvJ2O/rYkwpJEAMfOXzKZCswMAc79kH0K94K5UTWzVZpZi6wW8txk6rWLm4
VAs4FMxm/7Q5g2IwbUgWK6Ug8LVvyfFe5mOOAGseQoE0BOkE3RVXkNySARWOEdrP
8HUXv/46U/1rA5YTn7/O0S8exAVo5fY2AS5qwgBBr37VPbXetLyz8fRhYJVlJjAd
izy1ANNavtdIkydZAnsUtgkky3ehQ9hDfTw5hbeR/tszVyAoqZ8a+0pLfpnLK6IW
JlQ7jANC3SK5KGO8DYsizIM5vHiPlArieQLlO340D9AMLxvK1c1lmJEB082ulhpd
f0D62e/C4RSmKhXKsthpe1PAF+goqgCYfboRZqj9HPw9LsJvCHCzWaDkYmN6FFJc
buz3mFyXd4d2AO+HcsoBNjK12ND1kxzNcjxIWCquyqLTpWAEgAkAkCPMFF1ev8J8
p6OdmuAAfq9Xd+ycEEPop+afWo66Bpkbc98T1lNwAN2XSc9kXZS2JX6qCm0K6mm2
5RgIAzRFF3slXXbf6jo0bB8/iEwVmxjujdjXlVQMOtS/ikj4dkVGItMHqw46eTk+
20Mt2fwzZGbr+ysbjtlrTWRzq4T3Av49gLmVUMzVj5VVT8XB36wO/DRN6r58gFMm
5tH4nRmGXgySi3Pm2V7aUjYGVKzmxBuqjJJoX19Y0HicaqA2XnZxhQ8jLBvSjUOY
7trlziZWBYoaltZtczJDahOygAngo+eLFTiRPp6CE3/KLn6kc6Sh3zwzFT/In26n
RYw62I7L9oY1KG8hr5ozg6OmvR3YlVQBxoj2Iaqyqu0sGN/vGxUgRfchTSFKApq8
yLz3XlMvHpHuZbG3SR7N8q0ExS7ncipp7yJkEhB4quIeX4CJAXzOwcxFOwi3JNov
msqSWFegbC7VI6kGBJOYJAxNhkarq8YogXDukakyVfOUVCmibmWBu01xGE2xglHR
dAsIWJna0MswPG3NjbHrxY5YKZRPKessl7jZS84TkzEwPN89BbEYbVI3Oq1w/Dkw
Ut3u/mPuihek4C85RU01JTFQJulDgtmlZpz7BzIQ525FZu55Cto+15wlWd3pAYLs
DEHDLkN9mQ3x3OMLyl2/ty1o+0XN9xTtj/VxEBsyBpXaEPJuhxwudVBwoV4tC7ux
9Jg6YFq9tTt63zlbkBBPwqft86EnLe8jL3znxdddYb3PK31jtJVobyydeukDRSCp
gILh0asGgJztnHPfMR0uBVwWXCSN604p06fnPuN1+wbyVRkx/A8v+w2o77/AGbLG
P9SiToUaHsuoM6HLXdNVC7ZWHRQ2VHrDRpVukHUQjCcegLfgQAqAHdwCDG4GBORE
3ODfh7ob/tzq0PpRExEeOSCR8f9Ik0XhHO3MGVhl0GTpZryNatxzoObsiNGGPFqx
mwxw93ZUCENhY+tcyK3BQeZAv7R06EKNY9OKN8S7zass3HbWcuR+MYPOkp598Xcv
eqhbqRd8YRwacDkC6ghkOEq4ZC4ZJrfHdjE1ehDCsRatHVfM/bpR//cauFmPYRMs
0SiflS/3HL0Dib6GRn90px6ru1Ma1JMLJDwYXxtgVxeOJmZC7ObFf3/JeXa9Kb5I
daBFA93G+39RR3XZc3KxSnEJqfrtP5ABbv/vQjal4c+p+AAYH/FGKmqKOr+JnekL
26GcCXOsCxgv2iKgbggNAc4gd2uW5IG1P+rBfz011j8VnsANJWdK3kTyEJhN1SWk
F/3kHbPyyOeajTT+5sqh8I4NRT8ifgzMHjg/8odRp1LEFaCNvm1PdznsYbAAOxg5
e180MBFYkTmtkFtjIfGd9zwEs3hQ6veq3lNYN3UuCZ0TObvLcIYNbHPU+dyb6o+1
2B42bI60By32wqlZksF7BHAbk7EUvm+/95r4+51b01BPYVIBwbsjnxVtkMCTJ6qW
USpk6SfEoOruoR3dnLlOPv0x1bQsHfZhXcamPkFNwjjHRR6l+niDKo816KxflnfI
2dA2I+YjkC7AaTj1jumZSeA/4bBvqkrHtNtQdGDunjjG1Euu61ltfRTR9IP3xaDT
mw3C2CA1MBs9GDV7geLflQ9wxjIe+MzSFXwYjwoMdu1mmiflYGK4XgfEzgoyzy8Y
aTEts7f2pOcX9uQWBN5TuWPanGQ9DwyY/G+uwvLcZ4qyOtfvfjWOYuzi/gkqfGEP
NaK5XlnB7SI9Yark7tYWKq/A+DU15He55ZbLUOTHA6+hieVnbs6B2efihzHgu0wJ
pP/EjcrweSuXrGBOE5mK0zxeKiZ42dxku8rM1MyvngqPCYeZLxS9Y9Rty0oeeZ9N
vjhFv+5Y81grEDwpKor+HwifHkHjvbBgKieb//SqOJISF5PNAKLsO7X0nRAue10z
BlUPIMKquL/pVnbKR/1VHs3dzhTaeOLlZzN9WWToQhMZNxkCWHtH2CL3pIyf/qIC
MuSOoN8IPPDLcVNRsK90DtfupKIkxf1B9YoITafhTrp/LCqdo5PouAZb9ARoMjTC
h5FikWrD9whqfiCwsQCRD/Oeu+RaHmi27ZKEAKAaNqXnNS2yUtOx9BOHtY81ZvOd
Xw9K4AJkVvpqGBaiGSyq4hiqUjix8SLfGIxJmYXqRW4w2ZbpbX3z753XLwfIvADt
raGhnGxwyTpliLWa9NumZ/R80c8TlTXVGlvqYbX0b2VGZnTonBgd1i1BXVfRTW2O
4AvVU9QXV2T8I45J0LcXIAhpUFRmNhCdGuN02ETPQ1t9zeakZdFL4wzRr9U43D7j
qxhB+xSx1erwW8ZDEcTiLeathjOzKY564158jM/LYZJoT1m1s0s6koJ5ADdValqt
GYJ4u3XGo+sEG6TcewA8wTsKOYTp3O+r6Qc5LcjzTzLWU0+bKTlD0aA5xrPcIYWP
W0mEM/EC/6SCiTRID6HzSeu4N9RrSptUxuSWwLbQNSF3wSymf4ypBkxeuW6GRoI6
Y105M89giB7e1Cck8LocLZ2F7cqtTK6fMAeVbp0joukSp7xMTzwO+6HPtA6r0MX0
xlcdpNpey6jenkLBVAGEClvL21Ozin8mVNIwVN6ux5IU9hJ+IlICzfFAqM8V07RP
BPI9dE+GXKyXANZ2h5AHLjGdACRQd+2ydy3eCdMDNOfWEMHouJ87F/925zAYKHFA
FCxR15ST2Abj2e9f7hYlWyLMcg1a6AYiWdHNJ6MoG1vVmK9Aqbmd9gceuu8H8xfX
9Cx0gkKfxUox8iPJsmein1VsgbZj2k5xHEYMEYOnXNBwYy1sFZPWRp6y6Vswv2QQ
5MDSigLmgoJxuQN/Ib6xLLjddu+OClkhQ+krPGnAuaBCctkRkuN8TMr7O3PkW2fJ
qBY4PPEx9AX5iII/K0SzDiWQDrSFjLAVIE5o//Q+a46qYLCkxsZctMI+i9uPajRB
yrt4kgTu7FAMjfWlhAXYuQR9eSHOYj7YL3vTTQ5n1yUlMpDcgJA0bxYiD8qzwG4F
1Qo+Y9o4o+IDS/abDxI245QKWI0LOHHJlrWKjJSYENC85k9CWs6BT5m1LZg3xEDN
9xsTtVYR7x7rcbciXwdSvAK0KwyiLjIjas7ECf1r+FslWzsQD5oNQ60P+mBtmbPN
9PL0tvEKxc/GqVXR48oQeRM4qszGJjuz6uZOnlt+OwcAiVNPvjbVk6obX9cJnrHX
MR9gu4LdupfPr9M2c3Fw38nrZMwI7mj5O9jwsPh3NXcO5zakNMs4OSEplmDIbPsS
MK9Y+RbgrMcRN2/TQRZxh6WSF5UUpyJplIRH/RgkSEq6x6JbBEjodBcGXiQQ3VK3
75t1mYtJw4dw1DpS1dUggpRe36+xT54iR6VwhUkjyGRKv2uKjBpw2YfU6laXsDJF
/f+mMOSnT3KXJhZ5HTQnFme8PLb3/53jgvmZcU5s3eFKlzEY0ilz3QnhwosgyXSF
K96ttXiXu4C3yWpja9G/TFaN2pKF7t/wrFNbG5UHSuu8C/m1tJ/uGnowPwdh+JaI
2jm6RrrwhmMYJYZt5Hn9Ga0jkXWulRTmj2OQ61ObAsiFQOlI2AQVkxYhrc8BWoAK
aU+vw8Y20baSpLziJy8ZuoJsUm1IOhN6yyFskFnix4nxWVhHTcP9Wc05u842BxN3
ZoQCllKyIpa0WM4yIfVawPA2PxeM7+04n/DbD7M+798Y6Jfhb7gAQANLgFDV/6x5
uiCu6HKQdD9/xQZ7hZo6k4iRBMwQvl2t0eDOYdeuyDQB3LN6zP0bwAUyqCKpG6Er
KpOQRbcLcdUB/89DbctlRHuCoW7nkmUl36bsS05ULy+jQxDELOlLjmD6Us0aSLFZ
g3QIGuqcXhPZO81r4DO4ckyfndGyZe2aSwowRgx/94E1NYm93DV294E4zP2AFFIl
HQ2QNibacEtdWMhI6mIbgbEWlSykvjkeJALJwW29tAwlSVd0CgW/+iRbdiynrjRM
+O14KSPp3AB1iW/9WZLtQuwZGzaIgmnEIdliWCHyiJbCHml0NbsCtfuzNjf6eSzf
mfRI7vGli1R8bjZs478LO/Qp2R8Mt3Grxwv0dwbBOYAYrCVUSQC5pO1/DGsizuI7
DjPlZHiQMZLSit3mg6vvQqX6cNVGGowYMXppMNUHOsOmao573c5aA+xi1MIGUEzm
H2SByFYljnluwIpvGZdMtBzfI+qJyakh4LI0mSMUIukzoCSk2ogfaxxJ1Foa1FTx
Fe5oVC5FL7PdZLVHlif26eAM+jCZ9NzkBrdu5hIMDGoVeOuBzGKyXHmYdl9adqEv
g14GtvUMQqz2UEPP9WbgC9NXkcGBgCpganoWdVHmylqeGnaf1T8vBEZTiHiwd+iV
snEr3TyuKXcj9P2EFitszAsoLdVIOesZ6jAPbJHbW8C7eB2lzIvTI5E3LE4MkzMg
0rust8LaIqYIrX+fms+WeO6EQPAuMhoJkdDJXpAm2zeY8HgvICsKuUvIJdSbotl9
wQ3k6B0R2xfnXgLvmYGSnc5xf6WlTlees9teyNwYdGqc4J9Q8kXqE0Ikc89W/yX+
e32ZEZv8nClfLg+ak5/tyr7wwMBsAMwSsER6uCC2PBinQQMEhoc1i98LNN9FuaNf
hRwb2JjsgSIsmQtCwAzlGI0JgRW2OShMyD+x3KaA+G76FCn3jB3+Sp0GT7zAEoWs
7bjSBLre0IJWeoOJd23L5HSuNFZchf9V0EVzG+dbmRVwa1e8OLSWzHkcIxfrm+1z
0/gvu1C71QuCpkhsocb3OvSebqNZ/T4+t6Ry5JxasH82yAinRNhtGT2tPNdKA0ft
tL/MQ/1d1KmxAHaMFXACKsGc1VWeimAOQwHUqCnnZAOZqgKipuder5MUI0fGPOnJ
V4DI29TYgZvo9qk1waRQOWuZ1UiA0dH2DSV2YbD24Ut/Iv1jyVCeAJAwwzwfkJFb
ElyAamDiViVy2Su1dsdmEI5crhBy6XOoTuGrQcIQKxOujBRGSQvfnGklhhlK1m1K
b+38ZVBuUbWZpUHFH28zcafkyB2YneoZX2nJP7W+7Ow0jXpPC983J2T1ha+a7Qko
q92+vg3dBNtXDqG/StgQRq0LRPvhCdbXe4MPagUBoWFp+aXK2okDfu1cf+pc9mD9
g1sb81FKvXo0vuFVMeP0ebB2puDH92VKbN0k6Py05GbUxfw58zKDCuAOVJwNnwgz
pNEa8Ernh04+1q0WXT5HP8qXkbSrkptGhRQv55dZxX+OqS+v1s4jaTSth+BXw8eD
wLbG0LLCSGfkLLkfszIdckRq66YVGi94bWWNNnAG2m1LPUa19GNWdw1gC7jsvOVY
RcSRugLsW4fDGkmwKsNQJvF96XiM1vMxof/PtoWWyILSmkcz6CvVK/xTmPG9YC9f
QUIaIsPg2ju2pSVwz9hAj708uO1mJf8Skiht2ZmDM6rg39RWLd8xSi25UAqna08V
YhWfqgX7Av/UyFw6PV+GXosvN7cwrma2F9YLVxAv3c/z/RH735cfvZUUJ6bIUJ7E
CtXw94utq/AE7DahVrK/SQH3tpuaviRUk027t0Xrpniubyc/r/HIiaD4g+UqvhMH
4XMYa+snwtSILGZJD1zzQcB1B62fochkFvl0uoA1vSis30dFE3T7FusQaxb5ObEl
Rw48pKF8JOJvtI8P4C1Mnc29040XwukXPEimOi64MiT3vptDS2oCMsx30o40mH/u
6XjKQ7axj9uA7OHoQQRemwHy3jTsi3AAjg/5a6eAE4nY/aRoKXNM1mAgJObFqkiD
+LwtbYl4sQ6WsYzGfOLVFyeUz0CNqoStkzf3PKKcOZlPEjwF06xghzOpJHC+7EH6
mgIT6z17c8ij2wgPiobgDw1ztC1J0+ShCZfAoOg22IJDqmN1nF1Z2bIpi79ohugS
2HZCZjEJogVF2lHN1/4rN7/sAGEAovLTxGEMeZ+Pu1WgrkuuVI7V8w8taJsimQye
dOD10HmH5exrc3tfeDIjVArm9tt/x2il/AkgrdA80dXTX7MIs+LOLVea5aZ2UIJe
Ktc0cW1968dYETrELOYwTLxMu9U1RZ6z9ZEKcVkvEreIwloeXloLxfWXpAPO5zvf
fGKe6JWnLrWWEisk1c+7Y1mX2IF1GhK8QtRd2+LaqNWbMtAWGPcwko+EJ/l5xCv2
MPw7vtwmpiJRRIXsO4YiyDvzt1WJeukOA2kl+nNwAPXz/3Vkm9hAOYQHaG+UfmkG
YrT1uQ/7CMh7BLT959757ZlYXv/Sl/gTAyABAsCd4hg1vJm3ZQ7VdPy7La/YG7Ox
nADhjGQtAYGQVzvveq5vuqyAlz+3nbOVZxJJUO3g7MS1wEZatJbzMxUyyVBIWpuh
HhUcrEtH0EO9H8f7aocCrDPSKtuI2Hw+3YjubyysLKnZsRnJxyCyk0q40seBxQPO
UbFArOns+go+i3G3+PksX6wEFttLr8Q8xax3E3fvpNjsvE31YN2GMJcomrisZy4B
jdGZak+17AbtHluImfF+BKINrfzW0eJQwFQzVlRMdW+H6MJyHXCFK5EuH2rH7sBs
MH3I9AMri5P3RUy7+HR5n2uTV6sS8G5TZXGqpoyJmpTI9NU6yb5Ea3dy9CWfeOKw
YhsEkwGwlkxMVW+PbDmT8m5iLTjBN2eQaLr9w6jZqdFpBWTY/3iEVUPtOxy/3WCm
f6Yq244ZGsiAZChk11EXjzTn/Ey2+ns/JTLVQ8kGa4ycQI8HwI3oLTIlxkgbg1Lv
s/6nKUnSdYMe3NWUf7zht0oAjhJum1s56/jvQ1gMyN9g9yzwAR0qJOWgjulNn3qh
oL2Lt5EXCCSkFpOCX4Vxl/UafMh+tQQ3ruRbI6OacFx2jIKxf/vgUV7nDmgGaPgs
kAJDV7Ly1YTpEYytDyTXwIRdhDeEqow9HwRoNinzq785dGGiu+5+33j+rGWa6hV/
otTHKX/1+hwQXb7RGH/k4TwPawLjWIc8tpRgSoPcAvouH7EuNOtz1xGY85Rp21sD
FQJyTXqAmm8gxSJhCMMo/r0QhR4XP8w1gbrRoRc03IvKYKB0cEsojaSOj4AwjqBq
yrJZO+Zn6gYztp/aQXAiAonfvqkc1Sst4O9N64wdI/azasASx/AAHqOaY4IxsQFI
fhbBcK2ud9Xn7gKNurW3qtq/EOJ4xPPSQukFYT9V7fICdQLVw+/iK54Gc70omj1A
N4mdipeQpT5P9EvQLibWttkeXYDEbuPAOvAdp3PXbXrzOpuZjTHXPTJhGcoMfIn8
AvpHgyPqwmmcob+iKsgQeC8kdWfW9QrF1bBfKTvi2ll3ufnZeIeDl2MQX+7hH0D/
oAkCjgrZmQbhOn2I2JeHhHJyo6JxGde8JkKz0+tQEJ5MegxjAkeF5+kfE1Hy6qWW
f5fZifZWZzwP2VNcTp/ONJdUaQtA0KraDNuUwN8sc4vez3LuwgAkItcAnVycVJ/m
J5EovwYvKK1SSM+SFTImNxIfKvqoUXn5lSbIC5F9V4/78/REVkYRNNT9Upor0syR
/gRZRRcaU7Y63JL+HVWTsZwu12hfgwTtZZ9zinTzUjgiYOsq0TJNNvw/bNOT8b0R
bjSYy49LHY0zkub7kWvBLVb7VfLnX7RwtI+dx878S85biMhppyaXqkVpE+EV6nd+
iiCmaa0UStDmD7Zt5vQFtmW7IXbFbiVqaKAUQDIxVXIwpdcydBkmtocJ8+jN9Sa7
py2PVc1QgYe6NO7Qed9B59JNQY0vx+0cE7URB0IQdpMMaPjeEq2GRww09o+aNBnu
csEwx0AooQgPb/GuYS/o4a8naDHNHuIhZbgyLuSFevfQLutee0S+O0ESJO4DNhzA
mmYBVoGc8DgqJz0B+zyzVOa0gBh7OfiuBAu5wc2hyyc8KiPxWE5Un3MqC5ahTV13
pxBg0azZ7LvIZy78Bo0re+80dnjF8zEtZyGy5qcUXTfYqQcifT1zomWPHLtqOtV4
UyrH/RhgJ+vwVZhosTmvNQaEUMeErTBRDvAAJLBrSnhvRzCZRU6bZ+VftHr+XoPy
0T8TZkO9MHxGm+czujf9cEiEpYr4oY52iAYEl0uxD8GBCfT6Y/4lThP++pfcL/ww
irITw9yaSVYre88mM6Witwk+t2ZFy0sQn+p+IazQu/tOXU/W0qujYVHZX1o18AzH
5dkA/aQ5cQKadAM/vum91xx22pkyGUBIasxpIqWzLiPKPsK73t88qlQcC4NpiqvY
ElHqFbImK6HnSHBusEwampUBTys3AyguNPafnsUWLlvV1rD6dMpoah4NcZZ41NW5
GITdjx6f5cWeAgiiNyu8phS3cvpqsbjRMM+Aivx5PWFkOK0+JvjgrgS1txDVrg9d
2VBBnLS8qCLTd14wra2iArY2YQoEagn9jjE1nrn4dR6lWdINjXB6gyMSs5f0t3mZ
cdho0puULC/ppuxLwdPDnoki1xCpIzIfEsiQR1hJ8feh7Yht3vKHPBF2fWxmauA5
SHhYsLk5hBZLRtHxaq641DWrk9vyWEi54sY2rv+PszZfzZGpOwB0ZT5pZ5bYSgQ6
bocmRqIzDvICW6lgJp+jhQO6P1V36fD8R8H+XVo49io9kHjqxLfhT1Ut7BngEsXU
9xGGvn0HrsOAJ5Bt7gQd/xlAEtrZeWU7bCXQ6xya3G/wys7bHZJaIk8n1kjR2Drc
KyMT5e6XAfsILV6DJMN+PGIOgomOo5q1DJNyPaciNgdQ8a1rna/4E3vPdbmPIMfp
lSmkFZ7WHJoZOKcTXPGjhUIoRaJoxREtERrnWCXm1+FyJvbsx4LzX5bhaeLxZbs9
UQszX1rpU1+28/7zJbn5mlXPilO12/oaKy6m8sqDbHr1dUkndJxNfnbIuapHMyOK
`pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jDocOuI3S8vwiwezV+o2GWvDCYGvAYKUTkWhnBzWsS8EbCgMEWR5XCD3f0nSXBFy
PHNXmNJm7pq5BOE4jrG89EedO9Veno1gKBMOwD6FgtLq3orThaRoBMA8S5QqlmOP
+buSPM1el4j05BB8hRTGguBrq3y1SkjMH0j02aQxSbw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21384     )
rhSbpD010Q889nvZadIpkLnf093l27CgkmeBwlbXcmnPEDK+GPEbsxbbirSac+f9
KsAz0bfFmPDNDBDCL3muc1D52DezbqcsRHedQTMQqF+6J2cUl8nnWQhyzriXqlqa
`pragma protect end_protected
