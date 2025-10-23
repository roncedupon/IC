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

`ifndef GUARD_SVT_EXCEPTION_LIST_SV
`define GUARD_SVT_EXCEPTION_LIST_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

/** 
 Does the appropriate logical compares to determine if 2 exception lists are
 NOT allowed to be merged/combined.  Expected 'general' usage is shown below.
 
 - excep_list1 is <obj>.exception_list
 - excep_list2 is the randomized_*_exception_list factory
 .
<br> if (excep2_list == null)
<br>   `svt_verbose("randomize_*_exception_list", "is null, no exceptions will be generated.");
<br> else if `SVT_EXCEPTION_LIST_COMBINE_NOT_OK(excep_list1,except_list2) begin
<br>   `svt_verbose("randomize_*_exception_list", "cannot be combined with <obj>.exception_list.");
<br> end else begin
<br>  // Logic to do the randomization of the exceptions to be added 
<br>  // and then combine the two lists.
<br>  // 
<br>  // If one list has (enable_combine == 1) then the final exception_list
<br>  // is to have (enable_combine == 1) also.
<br> end
 */
`define SVT_EXCEPTION_LIST_COMBINE_NOT_OK(excep_list1,except_list2) \
  ((excep_list1 != null) && \
   (excep_list1.num_exceptions != 0) && \
   (!excep_list1.enable_combine) && \
   (except_list2 != null) && \
   (!except_list2.enable_combine))
  
/**
 * The EA and 1.0 version of UVM include an array 'copy' issue that we need
 * to workaround. Set a flag to indicate whether this workaround is needed
 */
`ifdef SVT_UVM_TECHNOLOGY
`ifdef UVM_MAJOR_VERSION_1_0
`ifndef SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`define SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`endif
`endif
`elsif SVT_OVM_TECHNOLOGY
`ifndef SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`define SVT_EXCEPTION_LIST_UNSAFE_ARRAY_DO_COPY
`endif
`endif

                   
// =============================================================================
/**
 * Base class for all SVT model exception list objects. As functionality commonly
 * needed for exception lists for SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_exception_list#(type T = svt_exception) extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Used to create (i.e., via allocate) new exceptions during exception list randomization. */
  T randomized_exception = null;

  /** Variable to control the maximum number of exceptions which can be generated for a single transaction. */
  int max_num_exceptions = 1;

  /** Flag indicating whether the exceptions have been injected into the transaction */
  bit data_injected = 0;

  /**
   * Flag which indicates whether these exceptions should be used "as is", or if
   * the component is allowed to combine them with other exceptions that are being
   * introduced from another source. For example this flag can be used to indicate
   * that exceptions coming in with a transaction via the input channel can be
   * combined with randomly generated exceptions produced by an exception factory
   * residing with the component.
   *
   * Components supporting the use of this field should recognize the ability to
   * combine whether the flag is set on the exception coming in with the transaction
   * or with the exception factory. The combining of exceptions should only be
   * disallowed if BOTH flags are set to 0.
   *
   * These flags should be reflected in the resulting exception list based on
   * the outcome of AND'ing the values from the combining transactions. As such
   * enable_combine should be set to 1 in the combined exception list if and only
   * if it is set to 1 in both of the exception lists being combined.
   *
   * When the exception list at one level of the component stack is used to
   * produce exceptions at a lower level of the component stack, this value
   * should be passed down to the lower level exceptions. 
   */
  bit enable_combine = 0;

  /**
   * Flag which is used by num_exceptions_first_randomize() to control whether the
   * exceptions are being randomized in the current phase.
   */
  protected bit enable_exception_randomize = 1;

  // ****************************************************************************
  // Random Data
  // ****************************************************************************

  /** Random variable defining actual number of exceptions. */
  rand int num_exceptions = 0;

  /** Dynamic array of exceptions. */
  rand T exceptions[];

  // ****************************************************************************
  // Weights used by the constraints
  // ****************************************************************************

  /** Relative (distribution) weight for generating <i>empty</i> exception list. */
  int EXCEPTION_LIST_EMPTY_wt  = 10;
  /** Relative (distribution) weight for generating <i>singleton</i> exception list. */
  int EXCEPTION_LIST_SINGLE_wt = 1;
  /** Relative (distribution) weight for generating <i>short</i> (i.e., less than or equal to num_exceptions/2) exception list. */
  int EXCEPTION_LIST_SHORT_wt  = 0;
  /** Relative (distribution) weight for generating <i>long</i> (i.e. greater than num_exceptions/2) exception list. */
  int EXCEPTION_LIST_LONG_wt   = 0;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Keeps the randomized number of exceptions from exceeding the limit defined by max_num_exceptions. */
  constraint valid_ranges
  {
    num_exceptions inside { [0:max_num_exceptions] };

    if (enable_exception_randomize) {
      // Keep the size at the max -- post_randomize will insure consistency with num_exceptions
      exceptions.size() == max_num_exceptions;
    } else {
`ifdef SVT_MULTI_SIM_ARRAY_OR_QUEUE_EMPTY_CONSTRAINT
      exceptions.size() == 1;
`else
      exceptions.size() == 0;
`endif
    }
  }

  /** Defines a distribution for randomly generated exception list lengths. */
  constraint reasonable_num_exceptions
  {
    if (max_num_exceptions > 3) {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt,                                      
        [2:(max_num_exceptions/2)] := EXCEPTION_LIST_SHORT_wt,                                      
        [((max_num_exceptions/2)+1):max_num_exceptions] := EXCEPTION_LIST_LONG_wt                                      
      };
    } else if (max_num_exceptions > 1) {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt,                                      
        [2:max_num_exceptions] := EXCEPTION_LIST_SHORT_wt+EXCEPTION_LIST_LONG_wt                                      
      };
    } else {
      num_exceptions dist 
      {
        0 := EXCEPTION_LIST_EMPTY_wt,
        1 := EXCEPTION_LIST_SINGLE_wt                                      
      };
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_exception_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate
   * argument values to the <b>svt_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * 
   * @param suite_name Identifies the product suite to which the data object
   * belongs.
   * 
   * @param randomized_exception Sets the exception factory used to generate
   * exceptions during randomization.
   * 
   * @param max_num_exceptions Sets the maximum number of exceptions generated
   * during randomization.
   */
  extern function new(vmm_log log = null, string suite_name = "", T randomized_exception = null, int max_num_exceptions = 1);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new exception list instance, passing the appropriate
   * argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name Identifies the product suite to which the data object
   * belongs.
   * 
   * @param randomized_exception Sets the exception factory used to generate
   * exceptions during randomization.
   * 
   * @param max_num_exceptions Sets the maximum number of exceptions generated
   * during randomization.
   */
  extern function new(string name = "svt_exception_list_inst", string suite_name = "", T randomized_exception = null, int max_num_exceptions = 1);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_param_member_begin(svt_exception_list#(T))
    `svt_field_object       (randomized_exception, `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_DEEP, `SVT_HOW_DEEP)
    `svt_field_array_object (exceptions,           `SVT_ALL_ON|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_DEEP, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_exception_list#(T))

  //----------------------------------------------------------------------------
  /**
   * Method which randomizes num_exceptions first, before randomizing exceptions.
   * This is done by doing the randomization once to isolate num_exceptions,
   * then again to isolate exceptions.
   *
   * @return Indicates success of the individual randomization phases.
   */
  extern virtual function bit num_exceptions_first_randomize();
  //----------------------------------------------------------------------------
  /**
   * Populate the exceptions array to allow for the randomization.
   */
  extern function void pre_randomize();
  //----------------------------------------------------------------------------
  /**
   * Cleanup #exceptions by getting rid of no-op exceptions and sizing to match num_exceptions.
   */
  extern function void post_randomize();
  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );
  //----------------------------------------------------------------------------
  /**
   * Method to change the exception weights as a block.
   */
  extern virtual function void set_constraint_weights ( int new_weight );
  //----------------------------------------------------------------------------
  /**
   * Method used to remove any empty exception slots from the exception list.
   */
  extern virtual function void remove_empty_exceptions();
  //----------------------------------------------------------------------------
  /**
   * Method to remove any collisions (i.e., exception vs. exception) present in
   * the list.
   */
  extern virtual function void remove_collisions();
  //----------------------------------------------------------------------------
  /**
   * Method to inject the exceptions into the transaction. Note that if
   * 'data_injected == 1' then the exceptions are NOT injected.
   */
  extern virtual function void inject_exceptions();
  //----------------------------------------------------------------------------
  /**
   * Method to get the specified exception from our exception list.
   * returns 'null' if the specified index is out of range.
   * @param idx The index of the exception to get
   */
  function T get_exception(int unsigned idx);
    if (idx >= exceptions.size()) return null;
    return exceptions[idx];
  endfunction
  //----------------------------------------------------------------------------
  /**
   * Get the transaction exception factory object.
   */
  function T get_randomized_exception();
    return randomized_exception;
  endfunction
  //----------------------------------------------------------------------------
  /**
   * Method to add a single exception into our exception list. Insures that
   * 'num_exceptions' is updated properly.
   * @param exception The exception to be added.
   */
  extern virtual function void add_exception(T exception);
  //----------------------------------------------------------------------------
  /**
   * Method to add the exceptions in the provided exception list into our exception
   * list.
   * 
   * @param list_to_add Uses list_to_add.num_exceptions to see how many exceptions
   * are to be added and uses list_to_add.exceptions to get the actual exceptions.
   */
  extern virtual function void add_exceptions(svt_exception_list#(T) list_to_add);

  // ****************************************************************************
  // Base Class Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception_list base class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  // ---------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception_list base class fields.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in <i>diff</i>.
   *
   * @param to vmm_data object to be compared against.
   * 
   * @param diff String indicating the differences between this and to.
   * 
   * @param kind This int indicates the type of compare to be attempted.
   * Supports both RELEVANT and COMPLETE compares.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);
`else
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default `SVT_XVM(packer)
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default `SVT_XVM(packer)
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation
   * based on the non-static fields. All other kind values result in a return value
   * of 0.
   * 
   * @return Indicates how many bytes are required to pack this object.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the
   * operation.
   * 
   * @param offset Offset into bytes where the packing is to begin.
   * 
   * @param kind This int indicates the type of byte_pack being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the
   * number of packed bytes. All other kind values result in no change to the
   * buffer contents, and a return value of 0.
   * 
   * @return Indicates how many bytes were actually packed.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * 
   * @param offset Offset into bytes where the unpacking is to begin.
   * 
   * @param len Number of bytes to be unpacked.
   * 
   * @param kind This int indicates the type of byte_unpack being requested. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the
   * number of unpacked bytes. All other kind values result in no change to the
   * exception contents, and a return value of 0.
   * 
   * @return Indicates how many bytes were actually unpacked.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning
   * messages.
   * 
   * @param kind This int indicates the type of is_avalid check to attempt. Only
   * supported kind value is `SVT_DATA_TYPE::COMPLETE, which results in verification that
   * the data members are all valid. All other kind values result in a return value
   * of 1.
   * 
   * @return Indicates function success (1) or failure (0).
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);


  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived
   * from this class. If the <b>prop_name</b> argument does not match a property of
   * the class, or if the <b>array_ix</b> argument is not zero and does not point
   * to a valid array element, this function returns '0'. Otherwise it returns '1',
   * with the value of the <b>prop_val</b> argument assigned to the value of the
   * specified property. However, If the property is a sub-object, a reference to
   * it is assigned to the <b>data_obj</b> (ref) argument. In that case, the
   * <b>prop_val</b> argument is meaningless. The component will then store the
   * data object reference in its temporary data object array, and return a handle
   * to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of its component. The command testbench code must then use <i>that</i> handle
   * to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val A <i>ref</i> argument used to return the current value of the
   * property, expressed as a 1024 bit quantity. When returning a string value each
   * character requires 8 bits so returned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @param data_obj If the property is not a sub-object, this argument is assigned
   * to <i>null</i>. If the property is a sub-object, a reference to it is assigned
   * to this (ref) argument. In that case, the <b>prop_val</b> argument is
   * meaningless. The component will then store the data object reference in its
   * temporary data object array, and return a handle to its location as the
   * <b>prop_val</b> argument of the <b>get_data_prop</b> task of its component.
   * The command testbench code must then use <i>that</i> handle to access the
   * properties of the sub-object.
   * 
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command code to
   * set the value of a single named property of a data class derived from this class.
   * This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the
   * <b>prop_name</b> argument does not match a property of the class, or it matches
   * a sub-object of the class, or if the <b>array_ix</b> argument is not zero and
   * does not point to a valid array element, this function returns '0'. Otherwise it
   * returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * 
   * @param prop_val The value to assign to the property, expressed as a 1024 bit
   * quantity. When assigning a string value each character requires 8 bits so
   * assigned strings must be 128 characters or less.
   * 
   * @param array_ix If the property is an array, this argument specifies the index
   * being accessed. If the property is not an array, it should be set to 0.
   * 
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method is used to safely get the current number of exceptions. It basically
   * chooses the smaller of 'num_exceptions' and 'exceptions.size'. Note that this does
   * NOT check that the elements in the exceptions array are non-null.
   *
   * @return Number of exceptions
   */
  extern virtual function int safe_num_exceptions();

  //----------------------------------------------------------------------------
  /**
   * Populate the exceptions array to insure it is ready for randomization.
   */
  extern function void populate_exceptions();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7p7wUAL+OkBfJnQ9iUFokxG3xGNf0J1Ax8Q09ZbhPbH1vDCFcquzjcw9ryXqUbzo
h80JQpnd8NMpsQc0BDncq3VQf7DVrJ0OkM15ZKu+RMgBhJtin8Qx4v1QJHKozyIS
YC1GeJO/vhRWx8zEX+Pr4dcwJo0z4AQ/2VoBPvJQ9HdUllHhOrZPuA==
//pragma protect end_key_block
//pragma protect digest_block
deX8JwRE6MM6LWcrr1JQi/wrVLI=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
AKHSXt9OlVXIvQ4/0zkLqy11bSo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_EXCEPTION_LIST_SV
