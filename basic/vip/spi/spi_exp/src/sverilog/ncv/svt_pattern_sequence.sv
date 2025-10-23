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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MAL7O4IGLj1ZL0GEUBYa/J2D5ijxJus+6BKG8FemmkWry9Fj52S7H+jOdaj59fry
4ndrUBubnMMubdDzf80ZorV9av/QJBs1nFa6hd+v7rUodzbOL6c+3kvyGlSTiRLw
2GiNY/b+tHnRpZaFqMZkdDR7YrlGLohVvyYoAGguKF2gYtyB0mJiIg==
//pragma protect end_key_block
//pragma protect digest_block
hr13wQCh0OkMvZVyXNikxkS/mOo=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
+YviqX3KtOHeslXzYEkbkDFBQfY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_PATTERN_SEQUENCE_SV
