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
7Ka4tnrkTXHnKcmAgdKtBXtrwDnVSxRantyUlMeBZQRUx9/j5nzdsrXRJU1oJsEf
ggSkpKOBbkSh9HH3F5WMsYiuZcvkOSyjI8/9HXHkzLJ0lOpBcmWjefwikN0GWUGB
FTPLcGjACItoEqifeRvc8XZIgjnhiisW1J7Bt+++JfM1vgJJgZPkAA==
//pragma protect end_key_block
//pragma protect digest_block
rQdH2xHs55PLNztM7yW+jb6g+/4=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
YQLSV9PPRkM3lFj51tlirM5YGsk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DATA_ITER_SV
