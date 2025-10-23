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
Xt3ifAyUVpocXdauRljmNn9IE0AYOZ8Jvv9yPVQHhqsRzc1Z1OxSdKkCoyNPniih
46Gs2l9cDaMNQNKCJd6esE/h+HCoUQYKdsbrkDpWqLZReuEKxlEpnjPNgmwn38n8
LllHLLNZ3q8qFk7Zwhk7aVGPwMk7SobPM5dbyYMPA9s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14706     )
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
`pragma protect end_protected

`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MNJAxKlrhxLm8yVksqtKO13lWn+oPzets7CDiWXliLg7fPBQCeHkbs5E9f7ZHHtK
IGi9nVkIynv9ml3tV/wbIOp4Ux/kSyl6q/W/GUWjH4AY2nzke5JPQgmlwMo9p4E2
m1Vcg49M2Qq0IONkZ3ZxMZ571AZ955If9Ua/Je1Oww8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 14789     )
P++VPWyQCd5tvZ4/f/cd41xuRkNezgCLHBi/CZ3yfvJFwG8zWXdy6EnKEzyXBZKI
Od6L4YP9o1ly74++dUxxlJ11VEysI6+l4BkqFwA+lLr3o0ggbx4yUxlb3yfWBcpr
`pragma protect end_protected
