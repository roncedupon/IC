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
ilHccIc26BEsRIESeNRGW7ci52OI0sZMXRTJJlvVAQ2i/3fErI8a/lNJ2fLnGL8+
Vu1HIIidi6fwmT+DPCFsyz5URZ/f6TrwhX9L2U7rncN67Wn3BoKj2Lw8cptOZfKo
Ye8doRD/YFxc7eBk30kqVCwn4yZZFHgx4bwmUZ4/w7w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10721     )
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
`pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QV87+HgsWQFM7nFY4dN8/6MWNggrgXb4rZA969GfQ8FlLLNo8Kdtj9J8HiSIa1jU
Z7Z7USao5fzdpYdv3bZ45M9gx9WS7usIj9g/J188RN/C2GFLL07PUJ8nJgbbk+9y
W2cp9wF1iBgucmNvY+fZmQyT8Ww187YkALu17tvvgaw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10804     )
gicWD/7vglvruIcn2eEWmtH+KYot3+TrvS7Ok5aqifgZ+0oKNU7gZTUKED7frQds
+ItqJW0FTcv4WUm4YBtsROvrq/rSve/HTz9NUMTofWEnIH+dCmuGTilNgztWp7ad
`pragma protect end_protected
