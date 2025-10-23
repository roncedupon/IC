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
TrmlwZAZ48RJV8Dh99dnEoxtzRp35PlRJ9BY7voLCzDY3MXAsyVZPX/kx/N3z/jU
PV7qhrLD7W+obYFBQkGsKQ/kx1YD0iZa6lLe1Us4qekD/aC1VBdKm56zqtrHxriU
kZCfP1E0KDlPf3hmcJsuv6/EiyzyaADDz28ww8+qwLz5N0nMGsxI0A==
//pragma protect end_key_block
//pragma protect digest_block
f/6K/V3WTTqvXbajLRUE0iCUKiA=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
WHcKaQBEdlMX3CYYc0NQvhGylKs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
