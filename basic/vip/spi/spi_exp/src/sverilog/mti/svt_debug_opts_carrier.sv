//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_CARRIER_SV
`define GUARD_SVT_DEBUG_OPTS_CARRIER_SV

// SVDOC unable to refer to class scoped structs
`ifndef __SVDOC__
/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'before' callback
 * execution logging.  The macro should be called before the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals - Queue of primitive values which must be presented in the argument order
 */
`define SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields='{},objtypes='{},objvals='{},primvals='{}) \
  svt_debug_opts_carrier pdc = null; \
  svt_debug_opts_carrier post_cb_pdc = null; \
  bit debug_enabled_w_user_cb = 0; \
  current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)] = (current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)])+1; \
  if (is_debug_enabled() \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
    || svt_debug_opts::get_enable_callback_playback() \
`endif \
  ) begin \
    debug_enabled_w_user_cb = has_user_cb(); \
    if (debug_enabled_w_user_cb || svt_debug_opts::has_force_cb_save_to_fsdb_type(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), objtypes) || svt_debug_opts::get_enable_callback_playback()) begin \
`ifdef SVT_VMM_TECHNOLOGY \
      pdc = new(null, get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
`else \
      pdc = new(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
      pdc.add_prop("uid_count",current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)],0, svt_pattern_data::INT); \
`endif \
      if (!svt_debug_opts::get_enable_callback_playback()) begin \
        void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".before"})); \
      end \
    end \
  end

/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'after' callback
 * execution logging.  The macro should be called after the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops='{},primvals=default_lhs) \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
  if (svt_debug_opts::get_enable_callback_playback()) begin \
    if (pdc != null) begin \
      post_cb_pdc = pdc.update_object_prop_vals({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname)}, current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)]); \
      if (post_cb_pdc != null) begin \
        bit[1023:0] val; \
        if (post_cb_pdc.get_primitive_vals(pdc, primprops, val)) begin \
          bit[1023:0] default_lhs; \
          primvals = val; \
        end \
      end \
    end \
  end \
  else if (debug_enabled_w_user_cb) \
`else \
  if (debug_enabled_w_user_cb) \
`endif \
    void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".after"}, ,primprops));

/**
 * This macro can be used by internal cb_exec methods to resolve some design issues
 * that block logging and playback.  This macro can be used to record internal events
 * that the VIP recognizes, but which aren't made available to the testbench through
 * an existing callback.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals_pre - Queue of primitive values which must be presented in the argument order
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals_post -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_INTERNAL_EVENT(cbname,fields='{},objtypes='{},objvals='{},primvals_pre='{},primprops='{},primvals_post=default_lhs) \
 `SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields,objtypes,objvals,primvals_pre); \
 `SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops,primvals_post)
`endif

/**
 * This macro needs to be called by all classes that do callback
 * logging in order to support logging. It should be called within
 * the class declaration, so that the method is available
 * to all cb_exec methods which are implemented within the class.
 *
 * T -- The component type that the callbacks are registered with.
 * CB -- The callback type that is registered with the component.
 * compinst -- The component instance which the callbacks will be
 * directed through, and which contains a valid 'is_user_cb' (i.e.,
 * typically inherited from the SVT component classes) implementation.
 */
`define SVT_DEBUG_OPTS_CARRIER_CB_UTIL(T,CB,compinst) \
  int current_method_triggered_counter[string]; \
 \
  function bit has_user_cb(); \
`ifdef SVT_VMM_TECHNOLOGY \
    for (int i = 0; (!has_user_cb && (i < compinst.callbacks.size())); i++) begin \
      svt_xactor_callback svt_cb; \
      if ($cast(svt_cb, compinst.callbacks[i])) \
        has_user_cb = compinst.is_user_cb(svt_cb.get_name()); \
      else \
        /* Its not a SNPS callback, so must be a user callback. */ \
        has_user_cb = 1; \
    end \
`elsif SVT_UVM_TECHNOLOGY \
    uvm_callback_iter#(T, CB) cb_iter = new(compinst); \
    CB cb = cb_iter.first(); \
    has_user_cb = 0; \
    while (!has_user_cb && (cb != null)) begin \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
      cb = cb_iter.next(); \
    end \
`elsif SVT_OVM_TECHNOLOGY \
    ovm_callbacks#(T, CB) cbs = ovm_callbacks #(T,CB)::get_global_cbs(); \
    ovm_queue#(CB) cbq = cbs.get(compinst); \
    has_user_cb = 0; \
    for (int i = 0; !has_user_cb && (cbq != null) && (i < cbq.size()); i++) begin \
      CB cb = cbq.get(i); \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
    end \
`endif \
  endfunction \
 \
  function string get_debug_opts_full_name(); \
    get_debug_opts_full_name = compinst.`SVT_DATA_GET_OBJECT_HIERNAME(); \
  endfunction \
 \
  function bit is_debug_enabled(); \
    is_debug_enabled = compinst.get_is_debug_enabled(); \
  endfunction

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_debug_opts_carrier is used to intercept and manage whether the baseline
 * pattern data carrier functionality is actually utilized. 
 */
class svt_debug_opts_carrier extends svt_pattern_data_carrier;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param obj_class_type Class type values which must be provided (in order) for all of the object fields
   * provided in the field_desc.
   */
  extern function new(vmm_log log = null, string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param name Instance name for this object
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param prop_obj Object to assign to the OBJECT properties, expressed as `SVT_DATA_TYPE instances.
   * @param prop_val Values to assign to the primitive property, expressed as a 1024 bit quantities.
   */
  extern function new(string name = "svt_debug_opts_carrier_inst", string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_debug_opts_carrier)
  `svt_data_member_end(svt_debug_opts_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file. This implementation is mainly here to intercept the request and
   * pass it along or discard it, depending on whether debug opts are enabled.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK
  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update any object references
   * with the data that is recorded after a callback executes.  The callback is
   * uniquely identified using the full hiearchical path.
   *
   * @param cb_name Full path to the callback that is being played back.
   * @param counter_playback Count of <cb_name><_cb_exec> task triggered in playback
   */
  extern function svt_debug_opts_carrier update_object_prop_vals(string cb_name, int counter_playback);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update ref arguments on callbacks.
   * The pattern data carrier object that is recorded prior to callback execution
   * must be supplied because the pattern data carrier object that is obtained
   * post-callback execution are string values, and so the original property type
   * is not available in the post-execution pattern data carrier object.
   * 
   * @param pdc Pattern data carrier object recorded prior to callback execution
   * @param name Property name to be obtained
   * @param size Number of bits needed to encode the return value
   */
  extern function bit[1023:0] get_primitive_val(svt_debug_opts_carrier pdc, string name, output int size);

  /**
   * Returns a queue of prop_val elements 
   */
  extern function bit get_primitive_vals(svt_debug_opts_carrier pdc, svt_pattern_data::get_set_struct prim_props[$] = '{}, output bit[1023:0] prim_vals);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AgFZYjmn3uu19zmhnzvU1VFYJQFbo6edRA+HWBOm7GWu+NoHbgcEeCf3xvr++Yat
FWoqMcGsiSE1VZI2gIL4Sg8NdhhF/hHnUbB0mwjAG9St7tkJbsl8qQTa1dWR8I86
Lb9WN7t8r4fXghIbSrE0Jb8zO83AyP7hSwZKFQOjQF8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10075     )
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
`pragma protect end_protected

`endif // GUARD_SVT_DEBUG_OPTS_CARRIER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oNoM5Li3QPQdJvGQzjvEd8ccbN8IctY9ASMWK0iLzONgehriYx1/2s5B5y9shgLG
kXSa3xrKlW8jYGkUgAYj1nBBLQAhxlOljDp1um/Tlhor592hjrMjJHNk71emLEPs
99cAX3G8NpL98OO+/Wau3+TnCFbyKzuElRkiKET9GAU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10158     )
+K34Bqa9g68g90tQ6DvWCbBhGeqx2fWQI2GR+fDPE1f3NuiKi/JJ3+9t7QAPkA4B
/ThfqX9yxHw0tNgVX11qOmmJgzFM+kwRquWU1aslCyzqSYm0XQqCJ3Vchxfad1hx
`pragma protect end_protected
