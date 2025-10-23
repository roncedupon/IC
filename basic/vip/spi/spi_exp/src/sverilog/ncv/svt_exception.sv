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

`ifndef GUARD_SVT_EXCEPTION_SV
`define GUARD_SVT_EXCEPTION_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

// =============================================================================
/**
 * Base class for all SVT model exception objects. As functionality commonly needed
 * for exceptions for SVT models is defined, it will be implemented (or at least
 * prototyped) in this class.
 */
class svt_exception extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the STARTED notification (an ON/OFF notification) is indicated (i.e. turned ON).
   */
`else
  /**
   * If set to something other than -1, indicates the (first) time at which the error
   * was driven on the physical interface. At the time at which the error is driven,
   * the "begin" event is triggered.
   */
`endif
  real start_time                               = -1;

  /**
   * Indicates if the exception is an exception to be injected, or an exception
   * which has been recognized by the VIP. This is used for deciding if protocol
   * errors should be flagged for this exception. recognized == 0 indicates
   * the exception is to be injected, recognized = 1 indicates the exception
   * has been recognized.
   *
   * The default for this should be setup in the exception constructor. The
   * setting should be based on whether or not the exception CAN be recognized.
   * If it can, then recognized should default to 1 in order to make it
   * less likely that protocol errors could be disabled accidentally. If the
   * exception cannot be recognized, then recognized should default to 0.
   *
   * Since not all suites support exception recognition, the base class assumes
   * that exception recognition is NOT supported and leaves this value initialized
   * to 0.
   */
  bit recognized = 0;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_exception)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_data</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new( vmm_log log = null, string suite_name = "");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new instance of the svt_exception class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * exception object belongs.
   */
  extern function new(string name = "svt_exception_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_exception)
  `svt_data_member_end(svt_exception)

  // ****************************************************************************
  // Base Class Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted.
   * Supports both RELEVANT and COMPLETE compares.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1 );

`else
  // ---------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the exception base class fields.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //----------------------------------------------------------------------------
  /**
   * Pack the fields in the exception base class.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);
  //----------------------------------------------------------------------------
  /**
   * Unpack the fields in the exception base class.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in verification that the data
   * members are all valid. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_is_valid(bit silent = 1, int kind = -1);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Method to change the exception weights as a block.
   */
  extern virtual function void set_constraint_weights(int new_weight);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether an exception is a no-op. In situations where
   * its may be impossible to satisfy the exception constraints (e.g., if the weights
   * for the exception types conflict with the current transaction) the extended
   * exception class should provide a no-op exception type and implement this method
   * to return 1 if and only if the type of the chosen exception corresponds to the
   * no-op exception.
   *
   * @return Indicates whether the exception is a valid (0) or no-op (1) exception.
   */
  virtual function bit no_op();
    no_op = 0;
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Injects the error into the transaction associated with the exception.
   * This method is <b>not implemented</b>.
   */
  virtual function void inject_error_into_xact();
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Checks whether this exception collides with another exception, test_exception.
   * This method must be implemented by extended classes.
   *
   * @param test_exception Exception to be checked as a possible collision.
   */
  virtual function int collision(svt_exception test_exception);
    collision = 0;
  endfunction

  //----------------------------------------------------------------------------
  /** Returns a the start_time for the exception. */
  extern virtual function real get_start_time();

  //----------------------------------------------------------------------------
  /**
   * Sets the start_time for the exception.
   *
   * @param start_time Time to be registered as the start_time for the exception.
   */
  extern virtual function void set_start_time(real start_time);

  // ---------------------------------------------------------------------------
  /**
   * Updates the start time to indicate the exception has been driven and generates
   * the STARTED notification.
   */
  extern virtual function void error_driven();

  // ---------------------------------------------------------------------------
  /** Returns a string which provides a description of the exception. */
  virtual function string get_description();
    get_description = "";
  endfunction

  // ****************************************************************************
  // Command Support Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived
   * from this class. If the <b>prop_name</b> argument does not match a property of
   * the class, or if the <b>array_ix</b> argument is not zero and does not point to
   * a valid array element, this function returns '0'. Otherwise it returns '1', with
   * the value of the <b>prop_val</b> argument assigned to the value of the specified
   * property. However, If the property is a sub-object, a reference to it is
   * assigned to the <b>data_obj</b> (ref) argument. In that case, the <b>prop_val</b>
   * argument is meaningless. The component will then store the data object reference
   * in its temporary data object array, and return a handle to its location as the
   * <b>prop_val</b> argument of the <b>get_data_prop</b> task of its component.
   * The command testbench code must then use <i>that</i> handle to access the
   * properties of the sub-object.
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
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data
   * object array, and return a handle to its location as the <b>prop_val</b> argument
   * of the <b>get_data_prop</b> task of its component. The command testbench code
   * must then use <i>that</i> handle to access the properties of the sub-object.
   * 
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command code
   * to set the value of a single named property of a data class derived from this
   * class. This method cannot be used to set the value of a sub-object, since
   * sub-object consruction is taken care of automatically by the command interface.
   * If the <b>prop_name</b> argument does not match a property of the class, or it
   * matches a sub-object of the class, or if the <b>array_ix</b> argument is not
   * zero and does not point to a valid array element, this function returns '0'.
   * Otherwise it returns '1'.
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
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
e56JswBosO88UQDPOe32MB9uR3EgUHIl+4V04LN/AceUE5rX3okUmdEhdomKVvgq
bR2eyT7K+afmkTfBoTqet48zfM6XoMA3Z0kpgmp1Py3lWkzmwvhCkryy451PWtOy
zqnBCc8NafrH4wvnQjhzna+DRtUdZ19VyaJUJsLtR3887QKJGwAqQw==
//pragma protect end_key_block
//pragma protect digest_block
85N/rmQcxfrfyt5RtpddKY7zOMM=
//pragma protect end_digest_block
//pragma protect data_block
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
v07zzpHMSNptKUbe+RdeWA==
//pragma protect end_data_block
//pragma protect digest_block
cAWRsMS2q7LOMAYutrobN/UkiTM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_EXCEPTION_SV
