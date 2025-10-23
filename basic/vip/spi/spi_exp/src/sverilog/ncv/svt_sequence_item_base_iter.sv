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

`ifndef GUARD_SVT_DATA_ITER_SV
`define GUARD_SVT_DATA_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_ITER_TYPE svt_data_iter
`else
 `define SVT_DATA_ITER_TYPE svt_sequence_item_base_iter
`endif

typedef class `SVT_DATA_TYPE;
typedef class `SVT_DATA_ITER_TYPE;

// =============================================================================
/**
 * Virtual base class which defines the iterator interface for iterating over
 * data collectoins.
 */
virtual class `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log used by this class. */
  vmm_log log;
`else
  /** Reporter used by this class. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_ITER_TYPE class.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log);
`else
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  // ---------------------------------------------------------------------------
  /** Check and load verbosity */
  `SVT_UVM_FGP_LOCK
  extern function void svt_check_and_load_verbosity();

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  virtual function void reset();
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This should be used to create a duplicate
   * iterator on the same object, in the 'reset' position. The copy() method
   * should be used to get a duplicate iterator setup at the exact same iterator
   * position.
   */
  virtual function `SVT_DATA_ITER_TYPE allocate();
    allocate = null;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position. The
   * default implementation uses the 'get_data()' method on the original
   * iterator along with the 'find()' method on the new iterator to align
   * the two iterators. As such it could be a costly operation. This may,
   * however, be the only reasonable option for some iterators.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  virtual function bit first();
    first = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  virtual function bit is_ok();
    is_ok = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  virtual function bit next();
    next = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list. The default implementation generates a fatal error as some
   * iterators may not implement this method.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  virtual function bit last();
    last = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  virtual function bit prev();
    prev = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list. The default implementation generates a fatal error as
   * some iterators may not implement this method.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements. The default implementation does a full scan
   * in order to get the overall length. As such it could be a costly operation.
   * This may, however, be the only reasonable option for some iterators.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length. The default implementation
   * scans from the start to the current position in order to calculate the
   * position. As such it could be a costly operation. This may, however, be the
   * only reasonable option for some iterators.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /**
   * Move the iterator forward (using 'next') or backward (using 'prev') to find
   * the indicated data object. If it moves to the end without finding the
   * data object then the iterator is left in the invalid state.
   *
   * @param data The data to move to.
   *
   * @param find_forward If set to 0 uses prev to find the data object. If set
   * to 1 uses next to find the data object.
   *
   * @return Indicates success (1) or failure (0) of the find.
   */
  extern virtual function bit find(`SVT_DATA_TYPE data, bit find_forward = 1);

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  virtual function `SVT_DATA_TYPE get_data();
    get_data = null;
  endfunction

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SmTzPhcywEsVmRtHQS5FuSdowzUIY4/lwCw+abfez+iIgZ+ANk8kT5aUKw0MyL9X
02Qu5A82E4Q00vQ5pYmqhjIPs5TXBBdRj4pHuY4NHbkoHDk2CulEd0UHomjYl4+G
jaeFCAp3GY78W509zDbpI5//2vZ9oHxT+4yxmIOIPCo6uOVxvbYRWg==
//pragma protect end_key_block
//pragma protect digest_block
ihHqvQKIg0PZBSjBnnjhQ1+uI9U=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Q7o8Ht6kqRRB3X1DqiUO94tdZrk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DATA_ITER_SV
