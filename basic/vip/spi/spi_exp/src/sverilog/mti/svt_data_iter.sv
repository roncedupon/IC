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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iGWAKNLcIrmqSPY8TGBO+/LeKY+GP9JyQpuBexqpLmUaKAoYBuji1qQ5rkOA1ORx
xH23IlQZlxwP0go/anEyH8bjGqoJqDYO5EXtfs5qWs1LN4Rmeuw4bjlnoZQf+++n
2Iu5IV79BFoGbGRR8iAqCTHFmAosXse+BQHjPnaGzWg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3910      )
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
`pragma protect end_protected

`endif // GUARD_SVT_DATA_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
je2b46FSgb/71r92Vl/bHO94PkmVZjPCUjLGp8ZUrqiB1s9AseUZcZ7xmoHpZwh0
7hRhE+9HvBmny7Uky+/Btm6uLzF+22Ayg1ZEf4F403Z79jJcNZ6bOETCDKwzafTT
Bn2PxbhYByVf5Q8ATcICxiMDpJe4mgZOkVH5VUonhR8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3993      )
tvmej8m+R0VN/QOJIaRJ3G7mude0tNKqT3ci3vQZcB7Iada4OZWeCu1PBTzopWlL
qMD9pXwTiZsjznta6+HgcuudzWIcMlC+29bUJFl0nkERECUibDIMtewypCSFmV/e
`pragma protect end_protected
