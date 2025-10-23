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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
bRZSqwRZ9x8QPcQA+x3ei+NqF3G1uCM5WrtEv9a4KW89Vm8yJH8w6NoLV9JqPJjS
GVdjf+hI/IrGrZs3KmpxsbSMbFtaXM2Ti8D8p0cPRV5M2M5DI9dxQFHoaVncirf3
L/qXV0WnKWajxJ0CuOTV0qop1RhsLazC5TOC6t5+VzxzRGRPoFb0QQ==
//pragma protect end_key_block
//pragma protect digest_block
GFDlh89xzeixg4CWajl+SiQPFrU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
lHw1LefcCkLvAmEtPyuCKX0r7NI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
