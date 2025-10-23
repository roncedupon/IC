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

`ifndef GUARD_SVT_DATA_QUEUE_ITER_SV
`define GUARD_SVT_DATA_QUEUE_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_QUEUE_TYPE svt_data_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_data_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_notify
 `define SVT_DATA_QUEUE_ITER_NOTIFY notify
`else
 `define SVT_DATA_QUEUE_TYPE svt_sequence_item_base_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_sequence_item_base_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_event_pool
 `define SVT_DATA_QUEUE_ITER_NOTIFY event_pool
`endif

// =============================================================================
/**
 * Container class used to enable queue sharing between iterators.
 */
class `SVT_DATA_QUEUE_TYPE;

  `SVT_DATA_TYPE data[$];

  function int size(); size = data.size(); endfunction
  function void push_back(`SVT_DATA_TYPE new_data); data.push_back(new_data); endfunction

endclass

// =============================================================================
/**
 * Iterators that can be used to iterate over a queue of `SVT_DATA_TYPE instances. This
 * iterator actually includes the queue of objects to be iterated on in addition
 * to the iterator.
 */
class `SVT_DATA_QUEUE_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration indicates the type of queue change that has occurred and
   * that must be accounted for.
   */
  typedef enum {
    FRONT_ADD,      /**< Indicates data instances were added to the front */
    FRONT_DELETE,   /**< Indicates data instances were deleted from the front */
    BACK_ADD,       /**< Indicates data instances were added to the back */
    BACK_DELETE     /**< Indicates data instances were deleted from the back */
  } change_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The queue the iterator is scanning. */
  `SVT_DATA_QUEUE_TYPE                  iter_q;

  /** Event triggered when the Queue is changed. */
`ifdef SVT_VMM_TECHNOLOGY
  int EVENT_Q_CHANGED;
`else
  `SVT_XVM(event) EVENT_Q_CHANGED;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance that can be shared between iterators. */
  protected `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE            `SVT_DATA_QUEUE_ITER_NOTIFY;

  /** Current iterator position. */
  protected int                   curr_ix = -1;

  /** Current data instance, used to re-align if there is a change to the queue. */
  protected `SVT_DATA_TYPE              curr_data = null;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_QUEUE_ITER_TYPE class.
   *
   * @param iter_q The queue to be scanned.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY instance used to indicate events such as EVENT_Q_CHANGED.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, vmm_log log = null);
`else
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator. The client must use copy to create
   * a duplicate iterator working on the same information initialized to the
   * same position.
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
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_q Queue containing the `SVT_DATA_TYPE instances to be
   * iterated upon.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   *
   * @param curr_ix This positions the top level iterator at this index.
   */
  extern virtual function void initialize(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, int curr_ix = -1);

  // ---------------------------------------------------------------------------
  /**
   * Initializes the `SVT_DATA_QUEUE_ITER_NOTIFY using the provided instance, or creates a new one
   * if possible.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   */
  extern virtual function void initialize_notify(`SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null);

  // ---------------------------------------------------------------------------
  /**
   * Called when the queue changes so the iterator can re-align itself
   * and see if any waits can now proceed.
   *
   * @param change_type The type of queue change which occurred.
   */
  extern virtual function void queue_changed(change_type_enum change_type = BACK_ADD);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CYEKz8VD6vjH7/oHPrx+yE1exVf1r6QR2GV9kJTHyfk8NRWtykHDCQ6AZYPp9SrR
E27HnK9KHrwYOnnXnaMiv5qErEVk3a08HEEBUiGfkRNZefpFXXfBX6tvrZwTtuW+
YD57g3o6wFNpxESM2vc2QfqRc2GMuiodWaG+R8FC518=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14706     )
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
`pragma protect end_protected

`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EG95Y+7VT9ytuvzvb0v7IsE/N2KebG4ZOMWLPQZMrthqbZlhq4AxOwixisO3dpy9
twzoGafSurpKbpv4i/eBkMvOJeGnvmdoaC8lljVyAIdN3fmno40YKVncXAGTeOOR
VB8VbCGD1UEGG5ZEg5kUR++5K8I4IUQWDi1S3Y1KJCA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14789     )
GbU8HXaMPyvvsoBgJvekwerL4Dm4NdP/racblptdJbtOvvrETWx7yC8Ib+XeoiuN
75kmNBrDlV11hw61DZjwr34sFX/eMy8NvJ1EytXxaShx/v5huupkng5iaWm+33UW
`pragma protect end_protected
