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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PKK1YiwELR0LpOO7+UKcIniCs9XwHFUSKoulG0jtkZTVl5dQieGQs/G9Z/DvlWEc
6IKOcfLTeSVAo0RwaPtJdZbURPGTkc9upBCIxiY53X+y9CVjCBeYin7J5zsZHo+b
DLJkz+u9IXuOSpSm2YLKkbkVhUo+g9mec05r2SARxvA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10983     )
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
`pragma protect end_protected

`endif // GUARD_SVT_EXCEPTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eKWbbJDRCRzzZtSx61JAgMGfbH1dcuT+brcVaVS6LTs2h5odwxlreQ+cQ0Wir5Hj
6JfIiKdwBefEHWhzxtzS6gPHg2rIJpQf2JG/+o1RexoADOxbPQBgJ8ltRxiznNpr
4v69UnRtZSc8dKyEdK3TUrCOvq5K4OkyKQ6FzB1Zeo4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11066     )
yw/TqceZmwH0WegSK3yEGF523w0GwJXksKqfgHp58+WekpkugoxpdvqTQeQ+iAzX
cdtjN+rLB0mwgvOYhBij5ERAdYsQg6/39MRLL1p3cW0qrM83XdWvujZL6dJZHnrD
`pragma protect end_protected
