//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_SEQUENCE_SV
`define GUARD_SVT_PATTERN_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object that stores a pattern sequence as an array of patterns. This object also provides
 * basic methods for using these array patterns to find pattern sequences in `SVT_DATA_TYPE lists.
 *
 * The match_sequence() and wait_for_match() methods supported by svt_pattern_sequence
 * can be used to match the pattern against any set of `SVT_DATA_TYPE instances, simply by providing an iterator
 * which can scan the set of `SVT_DATA_TYPE instances.
 */
class svt_pattern_sequence;

  // ****************************************************************************
  // Private Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log shared_log = new ( "svt_pattern_sequence", "class" );
`else
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) shared_reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_pattern_sequence.class");
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Log||Reporter instance may be passed in via constructor. 
   */
`ifdef SVT_VMM_TECHNOLOGY
  vmm_log log;
`else
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Patterns which make up the pattern sequence. Each pattern consists of multiple
   * name/value pairs.
   */
  svt_pattern pttrn[];

  /** Identifier associated with this pattern sequence */
  int pttrn_seq_id = -1;

  /** Name associated with this pattern sequence */
  string pttrn_name = "";

  /**
   * Indicates if the svt_pattern_sequence is a subsequence and that the
   * match_sequence() and wait_for_match() calls should therefore limit their actions
   * based on being a subsequence. This includs skipping the detail_match. External
   * clients should set this to 0 to insure normal match_sequence execution.
   */
  bit is_subsequence = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_sequence class.
   *
   * @param pttrn_seq_id Identifier associated with this pattern sequence.
   *
   * @param pttrn_cnt Number of patterns that will be placed in the pattern sequence.
   *
   * @param pttrn_name Name associated with this pattern sequence.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", vmm_log log = null);
`else
  extern function new(int pttrn_seq_id = -1, int pttrn_cnt = 0, string pttrn_name = "", `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Displays the contents of the object to a string. Each line of the
   * generated output is preceded by <i>prefix</i>.
   *
   * @param prefix String which specifies a prefix to put at the beginning of
   * each line of output.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of same type.
   *
   * @return Returns a newly allocated svt_pattern_sequence instance.
   */
  extern virtual function svt_pattern_sequence allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern_sequence object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern_sequence copy(svt_pattern_sequence to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Resizes the pattern array as indicated, loading up the pattern array with
   * svt_pattern instances.
   *
   * @param new_size Number of patterns to include in the array.
   */
  extern virtual function void safe_resize(int new_size);

  // ---------------------------------------------------------------------------
  /**
   * Copies the sequence of patterns into the provided svt_pattern_sequence.
   *
   * @param to svt_pattern_sequence that the pttrn is copied to.
   *
   * @param first_ix The index at which the copy is to start. Defaults to 0
   * indicating that the copy should start with the first pttrn array element.
   *
   * @param limit_ix The first index AFTER the last element to be copied. Defaults
   * to -1 indicating that the copy should go from first_ix to the end of the
   * current pttrn array.
   */
  extern virtual function void copy_patterns(svt_pattern_sequence to, int first_ix = 0, int limit_ix = -1);
  
  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the indicated pattern.
   *
   * @param pttrn_ix Pattern which is to get the new name/value pair.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern virtual function void add_prop(int pttrn_ix, string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is complete
   * and that it can be fully accessed via the iterator `SVT_DATA_ITER_TYPE::next() method.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next match_sequence() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual function void match_sequence(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to see if this pattern sequence can be matched against the provided
   * queue of `SVT_DATA_TYPE objects. This method assumes that the data is still being 
   * generated and that it must rely on the `SVT_DATA_ITER_TYPE::wait_for_next() method
   * to recognize when additional data is available to continue the match.
   *
   * Does a basic pattern match before calling detail_match() to do a final detailed
   * validation of the match. This method will also return if it makes a match or
   * completely fails based on starting at the current position. The client is responsible
   * for setting up and initiating the next wait_for_match() request.
   *
   * @param data_iter Iterator that will be scanned in search of the pattern sequence.
   *
   * @param data_match If a match was made, this queue includes the data objects that made up the pattern match.
   * If the data_match queue is empty, it indicates the match failed.
   */
  extern virtual task wait_for_match(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method called at the end of the match_sequence() and wait_for_match() pattern match
   * to do additional checks of the original data_match. Can be used by an extended class
   * to impose additional requirements above and beyond the basic pattern match requirements. 
   *
   * @param data_match Queue which includes the data objects that made up the pattern match.
   */
  extern virtual function bit detail_match(`SVT_DATA_TYPE data_match[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for creating a pattern sub-sequence.
   *
   * @param first_pttrn_ix Position where the sub-sequence is to start.
   */
  extern virtual protected function svt_pattern_sequence setup_pattern_sub_sequence(int first_pttrn_ix);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to check for a full sequence match.
   *
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void check_full_match(`SVT_DATA_TYPE data_match[$], int pttrn_ix, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method to evaluate whether the previous match against a sub-sequence was successful.
   *
   * @param data_match The current matching data.
   * @param curr_data The current data we are reviewing for a match.
   * @param data_sub_match The data matched within the sub-sequence.
   * @param pttrn_ix The position of the current match.
   */
  extern virtual protected function void process_sub_match(ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, input `SVT_DATA_TYPE curr_data, input `SVT_DATA_TYPE data_sub_match[$]); 

  // ---------------------------------------------------------------------------
  /**
   * Utility method to set things up for a match restart.
   *
   * @param data_iter Iterator that is being used to do the overall scan in search of the pattern sequence.
   * @param data_match The current matching data.
   * @param pttrn_ix The position of the current match.
   * @param pttrn_match_cnt The patterns within the pattern sequence that have been matched thus far.
   * @param match Indication of the current match.
   * @param restart_match Indication of whether a the match is to be restarted.
   */
  extern virtual protected function void setup_match_restart(`SVT_DATA_ITER_TYPE data_iter, ref `SVT_DATA_TYPE data_match[$], ref int pttrn_ix, ref int pttrn_match_cnt, ref bit match, ref bit restart_match);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to get a unique identifier string for the pattern sequence.
   */
  extern virtual protected function string get_pttrn_seq_uniq_id();

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kdkwiZeeT3/1uoVLtA2ASNc5mItcEQqg6rO7WZ59AgxQ5jdL/yb57sIM2wpqmlGL
iOPkMoqONaQPx3qcWygaRcxpB77kbDbfveV0ufab62MyWlWNHpYK6vJ3BeWveUUx
/XiJYuQ71UZCCBb+bK2eWDxxNaWEtVcMWjoQ+3RnwVw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20368     )
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
`pragma protect end_protected

`endif // GUARD_SVT_PATTERN_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Rq//RhuEL9glvU1U6XE0iwbEUePaonyw0rDZu3NdhynwtdxDP1rwqeQC6LXhtTQd
W1KJrEfy52gMOS698oP+bsxi7+TmMUoMj55U3VexdiY06pNH2sthoDbj6sdxkBQV
tlDsqUamj0roH6SZnu07MgmljHzLgi2R/KvBjUIUxPU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20451     )
/tIPcbWDntuFT5t4gqclDrwPyOk5aIySlSCj77fM8Q4Yei7HSULZYYFQ3u9p+orr
3mAF3wAkDWi3EUFNA+TsNjGmgeBQeVrvyncLEniN84T2/3chliOfYNndR6c1mtcI
`pragma protect end_protected
