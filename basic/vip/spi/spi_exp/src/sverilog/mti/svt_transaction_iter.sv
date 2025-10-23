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

`ifndef GUARD_SVT_TRANSACTION_ITER_SV
`define GUARD_SVT_TRANSACTION_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_ITER_TYPE svt_transaction_iter
`else
 `define SVT_TRANSACTION_ITER_TYPE svt_sequence_item_iter
`endif

/** Macro used to pull the data object from the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_XACT \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation[top_level_ix] : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace[top_level_ix] : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace[top_level_ix] : \
  (iter_type == TRACE) ? this.iter_xact.implementation[top_level_ix] : \
  null \
)

/** Macro used to access the queue size for the proper collection */
`define SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE \
( \
  (iter_type == IMPLEMENTATION) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && (this.iter_xact.trace.size() == 0)) ? this.iter_xact.implementation.size() : \
  ((iter_type == TRACE) && ((name_match == null) || scan_name_match_trace)) ? this.iter_xact.trace.size() : \
  ((iter_type == TRACE) && (name_match.get_class_name() != iter_xact.get_class_name())) ? this.iter_xact.trace.size() : \
  (iter_type == TRACE) ? this.iter_xact.implementation.size() : \
  0 \
)

/** Macro used to figure out the first available index */
`define SVT_TRANSACTION_ITER_FIRST_IX \
( (start_ix == -1) ? 0 : start_ix )

/** Macro used to figure out the last available index */
`define SVT_TRANSACTION_ITER_LAST_IX \
( (end_ix == -1) ? `SVT_TRANSACTION_ITER_TOP_LEVEL_QUEUE_SIZE-1 : end_ix )

// =============================================================================
/**
 * Iterators that can be used to iterate over the implementation and trace
 * collections stored with a transaction.
 */
class `SVT_TRANSACTION_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration is used to signify which data collection the client wishes
   * to iterate on. The supported choices correspond to the collections supported
   * by this class.
   */
  typedef enum {
    IMPLEMENTATION,     /**< Indicates iteration should be over the implementation data */
    TRACE               /**< Indicates iteration should be over the trace data */
  } iter_type_enum;

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** The base transaction the iterator is going to be scanning. */
  protected `SVT_TRANSACTION_TYPE       iter_xact;

  /** Indicates which collection should be iterated over. */
  protected iter_type_enum iter_type = TRACE;

  /**
   * Used to do a name match (using `SVT_DATA_TYPE::get_class_name()) of the scanned
   * objects in order to recognize the object the client is actually interested
   * in.
   */
  protected `SVT_DATA_TYPE              name_match = null;

  /**
   * Used to control whether the scan ends at the name_match (0) or if it
   * includes the 'trace' of the name_match object.
   */
  bit                             scan_name_match_trace = 0;

  /** Index that the iteration starts at. -1 indicates iteration starts on first queue element.  */
  protected int                   start_ix = -1;

  /** Index that the iteration ends at. -1 indicates iteration ends on last queue element. */
  protected int                   end_ix = -1;

  /** Index at the current level, based on single level traversal. */
  protected int                   top_level_ix = -1;

  /**
    * When doing a multi-level traversal, this will be a handle to the
    * iterator which iterates across the objects at the lower levels.
    */
  protected `SVT_TRANSACTION_ITER_TYPE  level_n_iter = null;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    vmm_log log = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_TRANSACTION_ITER_TYPE class.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   * TODO: This currently defaults to 1, but will likely change to a default of 0 soon.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param reporter A report object object reference used to replace the default internal
   * reporter.
   */
  extern function new(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 1,
    int start_ix = -1, int end_ix = -1,
    `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This creates a duplicate iterator on the
   * same object, in the 'reset' position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE allocate();

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  extern virtual function bit first();

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  extern virtual function bit is_ok();

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  extern virtual function bit next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /** Access the svt_data object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_xact The base transaction the iterator is going to be
   * scanning.
   *
   * @param iter_type Used to indicate whether the iteration should be over the
   * IMPLEMENTATION queue or the TRACE queue.
   *
   * @param name_match This object, if provided, is used to recognize the
   * proper scan depth as the iterator scans the objects in the specified
   * collection. Whenever it gets a new object, it uses `SVT_DATA_TYPE::get_class_name()
   * to compare the basis for the two objects. If the compare succeeds, it goes
   * no deeper with the scan and considers this the next iterator element. If the
   * compare fails, then the scan moves into the corresponding collection on the
   * object which it was unable to compare against. If this object is not provided
   * the iterator assumes that it should do a one level scan.
   *
   * @param scan_name_match_trace If name_match is non-null and the name_match
   * svt_transaction class has a trace queue then a setting of 1 will cause the
   * iterator to traverse the trace array instead of the object itself. A setting
   * of 0 will cause the iterator to just include the object in the iteration,
   * not its trace. If name_match is null or it does not have a trace queue,
   * then this field has no impact.
   *
   * @param start_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration starts within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration starts at the first element in the corresponding queue.
   *
   * @param end_ix Optional index into the transaction implementation or
   * trace array, used to limit where the iteration ends within the
   * corresponding queue. The default value of -1 indicates that the
   * iteration ends at the last element in the corresponding queue.
   *
   * @param top_level_ix This positions the top level iterator at this position.
   *
   * @param level_n_iter This sets this up as the internal iterator which is
   * working on the internal object in support of the top level iterator.
   */
  extern function void initialize(
    `SVT_TRANSACTION_TYPE iter_xact, iter_type_enum iter_type = TRACE,
    `SVT_DATA_TYPE name_match = null, bit scan_name_match_trace = 0,
    int start_ix = -1, int end_ix = -1,
    int top_level_ix = -1, `SVT_TRANSACTION_ITER_TYPE level_n_iter = null);

  // ---------------------------------------------------------------------------
  /** Checks to see if the iterator is properly positioned on a data object. */
  extern virtual function bit check_iter_level();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
X7Ok0+iMFoNQG1OmOJCuMp/h4Fxu7Y6p8LQdkwBJ9ZxavA2GNORxhTzt5q98dpBX
az/jAzx6WsC6FgVoBujJuvRLtbMZO4woNv8c4O1RlydbP09bbQiwFo0Lv3bGFyj7
VvxovLdLClvv5BQJ9HtzjVDgqOYFjycekTGOcS5HwRE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10721     )
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
`pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
i7PLfzFqxsqjd9aGL+tLF6GDSt5YHn/W9frjiUioUIFCDgNeUa5yi6U8beW7aEZ/
90OpzC/7K7AYNoRNPvnTk1doOQxJHDiARk8frcvybezdB6hqbgzP3ag3rG3RBBnG
dWzfRl8obXHz5+wB111CvtA7Qmy/p9bizIE4v3gJ8Zw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10804     )
g3CFafBsmQhaXiAIifU67pSmooCj6onRq2WP4SyOUO9JcJYqVW+imZGxTUs8nOrr
lEx3KpA2qkuuivsaap3EALPJbSgpRlmU85zTXKE+U9/K1KWsOiRRQYBiYzS8HR2f
`pragma protect end_protected
