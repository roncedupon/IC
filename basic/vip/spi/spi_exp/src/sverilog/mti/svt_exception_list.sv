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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oaBrr23Td+kLK4AnD29dbCAkK640eqV4QGN5sCMge/4TpbxOhj/W2izURXgbvZL3
HbVjscXaVPSt8mn5JT4AMv7yzqSlmUBut5b0cxUSbkHGy87H+NVmH1l6ORHfIsJd
pJC+sC615Sr2VtnZz5D7agwSushk1BOcF8HCCdp6+6w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29853     )
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
i8vvMlZBUZHJ9wwYBnw2okck/pB/2EpHmWIs70ER7h5ydERBD7Y1bFEKJmrHElbr
mEJyiuMsPMImRx72o08UkbJfNGbG5gNaNRUinaK8tdzCp40V/1B77YINbOWy805N
ujn4mTxAdBiuTbL/yZyXpvl1kITeVjokmDsouUCk8QYgQt07wkZIdk71OQZcAoI5
t5pNyGUMS8lTEOKS2z8KaT6tM9oLDFcOOMX0OBwU7wM8Mf7uEgK/eFovkD1Z5tQv
NM4stxZz345tjYrgrFZSxCrInARg5xJSAH8easyOYrropuapTnvqg647SDv5MDup
rDQbwkXsBVvyvcKEulMJ9kNeplmy+bbzi2T37lg/MkedL6VcHD3eDALaVAtt8pm7
LoEdmwWwjAQM8CKVQ3HDUc2ZJlgxHWr9sztVVj35Dqi76jqdTEjzwyBRXyO8r8bn
ucuaYbSNGLaBSP91tmakwRaJemXFfcUfRNY2AzUwhYSBVeUOnsXFso3urU6lIVV8
T1wqTFBhJfJ0J3N/89FFOM+4ZF8h4Jk9riats2k2jWBPg8PgMF9Ed/LpJuyQhNDk
JZxSvbncVs/Z13vQfne4M97DYBbLej17ytTJM0iZdIGarACd42bZTPHyjobUfOOf
dYobSAmtBON++1F0vQfavLxTJrA51O9X+k8BTw3WHlCr5D67FcQDoqByLAZY5cER
XkxDoGpP5kzUcDPXUgYf1uWxm1D7xTAASW+rvlxB0xRjukdd0InGVZhfPP9tlZ39
pKAWoQUwjdQrEsx5HG+BZq6bc48YIbFnfz0ztfV626YxCJq781cedZuNOfMdbQ9R
8/XMni9u9sR0vV5Sk54uIHIGd7OKf6mcOWM1rOALXMefPG8Mltb5sETMASsJPXPE
K82hcyhN2FO8UQcrHBF+LmusLFcvL+GbbkVakHUfcx/sSVQhw4VjR7KaQHVGdnGK
eItA9aEwBvkJP007Ay+ItU/UU4/Ze+FCQU1R+f8bSgThmzV9qQlsuo6kHcoTSCxg
eORI8tsbQhVXq8mtWevlTlVARrjo3g61LAnSPXa2bDtqaCbhQrmLHJ9WNAGbf6jI
UrenQc1XKjuLhthzM/U2DfdpkiHjbXql7EuV2TixdP8uuOZvGw3MwAxcDZwYmlSi
FjB6Coeen9nI4o4Kux5IthQ/iS7dSl7ibJSx/meSGHqYnLp/SoYxAl6bIyxLAQKZ
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
`pragma protect end_protected

`endif // GUARD_SVT_EXCEPTION_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QhHj1vVYz3SFIv0tQflPC2RNZd27KrIwC312kQcuLxR8W1KQ+g2RoxlfvC9HyvUH
vkMg8mpmhFDLCaqvTmWY2W4kuK0pNzrwQ+o5VTBu4sDD31Xlk23zJJ87uxG1kfQL
Zf/pRWLYbYpbe0W/ynb+4B9WBXpRvLlaANfZW/FTtA4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29936     )
NpRrwiZzqkHBwQTxeoaE82O2IDuOLCaUoYDV/ZjwWyU4PIv7G2f+0Gzpa2NfO9mF
z8O/xmo13ldNwR3oTHFF4MVN9fpbCm/LGtr1bjNi8+W+r/kUdaZIroLvb7bL12Fk
`pragma protect end_protected
