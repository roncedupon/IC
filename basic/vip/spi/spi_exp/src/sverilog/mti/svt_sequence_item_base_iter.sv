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
CNJ0X0y8rMaAwWue4E2BsmzqyfbN3TkGqb6AeBW1+CZbpn+CProlPkZNPYwBXeuG
GPu379XweD3A2f918VNcAIvM/Vy8+sW6LV/JYdVXKBp0IC4klUX9+Wf64u1jtKaT
dy9cGVue2CMs5etktU+yo6C8jXGR+t0aFDN1x2cmkos=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3910      )
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
`pragma protect end_protected

`endif // GUARD_SVT_DATA_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n0GNLot8y4WTwknoVm4us3EsF7wEKKqeqmRRO8V8tKzVYZRSG12IdJ1M4UROLGOR
+S9xhOlzeuxii+uroVrc9rNoItmmebPoCrbdzuglEXbRkjGCSzY5adHcMxKnQVm/
pTHPmYHjnpFcTlegy0mdLEJlcjc1s5NZMYY8aMA+Q0s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3993      )
B3OInFbhRW/ZQxYlzzSmgIIrJysEYD0W8SCndgruJx2RmUi6OdpfXuJLJFzP6BX/
i+/EMHpdvoOjaj+HbSSzm5TL5KPNr2oala9kSRHygbC1+wkTBzjk9oB2da3TdXNt
`pragma protect end_protected
