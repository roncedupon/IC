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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6Nu/vamRkTTUa/93rKAMNY+kNVQsxoCKroftiuVjyOC7w1tcmJ590RwuU5q1c/FK
RG0M1FfYa1naVYk1afFZ9bdOQnwQRgCtVmDor0BG1zDwx23SekbIe4qbJ93q05G7
M1WHmvsCyZjRbQPnrgFhT2sAhphPZ+BJhom3o1xjzKEBn0k8RQPAsg==
//pragma protect end_key_block
//pragma protect digest_block
Fd6QqxujSE7SwWWAuPMGDrvpvy4=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
S0p6jxYNFPggWJwl6jMJu/1nLDI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_ITER_SV
