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
g0AD7TQamEo+mhnG1oleK6nArvQZ0wambQeCPlUhCgcD8JF6grq8BtLIUwmYynNG
oQfjP+7LzlCYPA00XcyHnBadtXEuqCdH9vCFEqNeNiDEg6xiRNWqmumx5YXkdcva
kgju6iBQMb75A9I19Y1iiRl/ok0eXY2+y5ZFNTfZKxXQh1wyQSsl4g==
//pragma protect end_key_block
//pragma protect digest_block
bRZeRoCKLcmc7KYN46ejLiLA6ZU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
b87lRrReRHAVR3w9SNSJKtXHyh8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_ITER_SV
