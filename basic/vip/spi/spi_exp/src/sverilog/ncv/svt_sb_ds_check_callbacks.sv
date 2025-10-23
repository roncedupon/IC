//=======================================================================
// COPYRIGHT (C) 2008 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SB_DS_CHECK_CALBACKS_SV
`define GUARD_SVT_SB_DS_CHECK_CALBACKS_SV

class svt_sb_ds_check_callbacks extends vmm_sb_ds_callbacks;

  /** Log instance */
  vmm_log log;

  /** SVT Check reporting class, used to register and execute SB errors. */
  svt_err_check check = null;

  /** Check that fails when transport is found, but not at front, of Expected Queue. */
  svt_err_check_stats check_pkt_dropped[int];
  /** Check that fails when transport isn't found in Expected Queue. */
  svt_err_check_stats check_pkt_not_found[int];
  /** Check that fails if transports are still in Expected Queue when checked at end-of-sim. */
  svt_err_check_stats check_pkt_orphaned[int];
  /** Check that fails when transport passes vmm_sb_ds::quick_compare() but fails svt_data::compare() versus the pkt in the Expected Queue. */
  svt_err_check_stats check_pkt_mismatched[int];

  /** Transaction name used in transcripts and reporting. */
  string pkt_name = "";

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the SB check reporting class.
   * 
   * @param log An vmm_log object reference used for reporting purposes.
   * 
   * @param check An SVT Error Check class used to report SB errors.
   * 
   * @param pkt_name The logical name of the transaction being scoreboarded.
   * This is used in checks and in reports, and should be the name of a single
   * transaction instance, e.g., 'Transaction', 'Packet', etc.
   */
  extern function new(vmm_log log, svt_err_check check = null, string pkt_name = "");

  /**
   * Creates checks associated with the stream.
   * NOTE: Modeled after define_stream, in the hope that define_stream will become
   * virtual someday.  This method should be called with the same arguments which
   * were supplied to the vmm_sb_ds::define_stream() method.
   */
  extern function void define_stream_checks(int stream_id, string descr = "");

  /** Extended callback method. */
  extern virtual function void mismatched(input vmm_sb_ds sb,
                                          input vmm_data  pkt,
                                          input int       exp_stream_id,
                                          input int       inp_stream_id,
                                          ref   int       count);

  /** Extended callback method. */
  extern virtual function void dropped(input vmm_sb_ds sb,
                                       input vmm_data  pkts[],
                                       input int       exp_stream_id,
                                       input int       inp_stream_id,
                                       ref   int       count);

  /** Extended callback method. */
  extern virtual function void not_found(input vmm_sb_ds sb,
                                         input vmm_data  pkt,
                                         input int       exp_stream_id,
                                         input int       inp_stream_id,
                                         ref   int       count);

  /** Extended callback method. */
  extern virtual function void orphaned(input vmm_sb_ds sb,
                                        input vmm_data  pkts[],
                                        input int       exp_stream_id,
                                        input int       inp_stream_id,
                                        ref   int       count);

  /** Extensible utility method used to obtain diff string for use in reporting */
  extern virtual function string get_pkt_diff(vmm_data base_pkt, vmm_data compare_pkt);

endclass

//----------------------------------------------------------------------------
function svt_sb_ds_check_callbacks::new(vmm_log log,
                                        svt_err_check check = null,
                                        string pkt_name = "");
  this.log = log;
  this.check = check;
  this.pkt_name = pkt_name;
endfunction

//----------------------------------------------------------------------------
function void svt_sb_ds_check_callbacks::define_stream_checks(int stream_id, string descr = "");
  string class_name = log.get_instance();
  string chk_descr_suffix = (descr == "") ? "" : { ", STREAM: ", descr };
  check_pkt_dropped[stream_id] = this.check.register({$sformatf("Were one or more 'Expected' %ss Dropped?",pkt_name),chk_descr_suffix}, {class_name, ": vmm_sb_ds::DROPPED"});
  check_pkt_not_found[stream_id] = this.check.register({$sformatf("Was 'Observed' %s Found in 'Expected' Scoreboard?",pkt_name),chk_descr_suffix}, {class_name, ": vmm_sb_ds::NOT_FOUND"});
  check_pkt_orphaned[stream_id] = this.check.register({$sformatf("Have one or more 'Expected' %ss still not been seen?",pkt_name),chk_descr_suffix}, {class_name, ": vmm_sb_ds::ORPHANED"});
  check_pkt_mismatched[stream_id] = this.check.register({$sformatf("Did 'Observed' %s Mismatch 'Expected' Scoreboard?",pkt_name),chk_descr_suffix}, {class_name, ": vmm_sb_ds::MISMATCHED"});
endfunction

//----------------------------------------------------------------------------
function void svt_sb_ds_check_callbacks::mismatched(input vmm_sb_ds sb,
                                                    input vmm_data  pkt,
                                                    input int       exp_stream_id,
                                                    input int       inp_stream_id,
                                                    ref   int       count);
  this.check.execute(check_pkt_mismatched[pkt.stream_id], 0);
  if (log.get_verbosity() >= vmm_log::TRACE_SEV) begin
    vmm_data status;
    vmm_sb_ds_pkts status_pkts;
    string diff;
    // Grab the status information so we can report on EXPECTED and OBSERVED
    // NOTE: Relying on the notify trigger happening before the callback
    status = sb.notify.status(vmm_sb_ds::MISMATCHED);
    void'($cast(status_pkts, status));
    diff = get_pkt_diff(status_pkts.pkts[1], status_pkts.pkts[0]);
    // vmm_sb_ds already reports the expected and observed packets -- just show the diff
    // `vmm_trace(log, $sformatf("mismatched() - Expected %s:\n%s", this.pkt_name, status_pkts.pkts[1].psdisplay("MISMATCHED:EXPECTED:")));
    // `vmm_trace(log, $sformatf("mismatched() - Observed %s:\n%s", this.pkt_name, status_pkts.pkts[0].psdisplay("MISMATCHED:OBSERVED:")));
    `vmm_trace(log, $sformatf("mismatched() - %s Expected vs. Observed:\n%s", this.pkt_name, diff));
  end
endfunction: mismatched

//----------------------------------------------------------------------------
function void svt_sb_ds_check_callbacks::dropped(input vmm_sb_ds sb,
                                                 input vmm_data  pkts[],
                                                 input int       exp_stream_id,
                                                 input int       inp_stream_id,
                                                 ref   int       count);
  foreach (pkts[i]) begin
    this.check.execute(check_pkt_dropped[pkts[i].stream_id], 0);
    `vmm_trace(log, $sformatf("dropped() - %s (%0d of %0d):\n%s", this.pkt_name, i+1, pkts.size(), pkts[i].psdisplay("DROPPED:")));
  end
endfunction: dropped

//----------------------------------------------------------------------------
function void svt_sb_ds_check_callbacks::not_found(input vmm_sb_ds sb,
                                                   input vmm_data  pkt,
                                                   input int       exp_stream_id,
                                                   input int       inp_stream_id,
                                                   ref   int       count);
  this.check.execute(check_pkt_not_found[pkt.stream_id], 0);
  // If vmm_sb_ds is called with 'silent == 0', in general it will report the transaction.
  // This is not the case for 'expect_out_of_order' check, however, so to insure
  // the we err on the side of "too much" instead of "too little", go aheand and
  // report the packet contents.
  `vmm_trace(log, $sformatf("not_found() - %s:\n%s", this.pkt_name, pkt.psdisplay("NOT_FOUND:")));
endfunction: not_found

//----------------------------------------------------------------------------
function void svt_sb_ds_check_callbacks::orphaned(input vmm_sb_ds sb,
                                                  input vmm_data  pkts[],
                                                  input int       exp_stream_id,
                                                  input int       inp_stream_id,
                                                  ref   int       count);
  foreach (pkts[i]) begin
    this.check.execute(check_pkt_orphaned[pkts[i].stream_id], 0);
    `vmm_trace(log, $sformatf("orphaned() - %s (%0d of %0d):\n%s", this.pkt_name, i+1, pkts.size(), pkts[i].psdisplay("ORPHANED:")));
  end
endfunction: orphaned

//----------------------------------------------------------------------------
function string svt_sb_ds_check_callbacks::get_pkt_diff(vmm_data base_pkt, vmm_data compare_pkt);
  void'(base_pkt.compare(compare_pkt, get_pkt_diff));
endfunction: get_pkt_diff

// =============================================================================

`endif // GUARD_SVT_SB_DS_CHECK_CALLBACKS_SV
