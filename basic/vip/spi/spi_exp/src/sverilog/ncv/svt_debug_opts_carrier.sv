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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
I/S423ByHEL8KrDJ+jH1VTKAlCStyB9P+fH5K90C9NzWqVOQzQuEp6RBVBS8tsjX
JULq5x3vECUBhQJv6PZwa4k4DYznjKVW1V0qrrPe2GgGkCFratMADVMeDmZ3JLei
cjT3GwfV0qAS/K/c1bksGcCA+sjbmlwkO1DRTKI4ZFHaVlDa3ZLh8g==
//pragma protect end_key_block
//pragma protect digest_block
iQNmvXF5mNG1GMWLXuqswG2ev4s=
//pragma protect end_digest_block
//pragma protect data_block
kJPtFscJcFC8zV5zsuM7ZMdpnja47HdxO3B1vtBKPy+RYTjDID9/u2RRr/PLNYWg
xGURokblmwnzJPkmnJarZ/M0Mwavf+fdhDC719d/YOvxHGVbnaJCwG3vtZyBKa2g
uMNYqg1LdWoG4pU/qPNIDq1FR5IAnRNzKVm73f9KL/V08gWYoD6D4JPkMR2M+RHK
44Tay0gNwSzbfE4upSVfyVrz9F09SyqNe1SgU4EE/diazzzUX7wV3foGS9SkF9jp
5IXIMON6dPvzvhjha3gIWtYa5XqghzsrPR6nFiL4JfrAwudjMnZg/zt+dW54yvS9
0TnkYOgo5nXyMPF3Ep+/om09MWvh+ympLXiGcXvmZJ6Uuvg8a5kkF9HPGNWSWgjB
fQiCSpi85k4V2wg7jwP4Rdqdl3ABR2RBGFdkhk4Z0+huyk+YknBBDVZz8/xTPKA+
R9XMkFKmEB4QhAH/A1r5i5mYv1RC/+FMBcur29Y3YESdeRnTyMByGXp59WiQCyNj
phiKEXyCUhAb5zyIwjWv4aLSLmBRiNFF8hiH6b6lUUBi1W1jHbmq6dsAwMp+EJAM
4tHHiFDntJ5Lho8ga34yBKs+l+ejUEpiuy7bruE7hlwO8Bz37GkGCSNdP6FrUa8I
vkDHiVKdjQ+64e2vNAPEdoTMDlTXhXSCuXfI/uFueHv6U5k4ktz884/igUSO+IBF
2FPhRbjvuLnhZOI7vdLOYBTMrkiQ1eph9Kegh658oOAPDltogQ8oK8hMrtnioRHj
+P2pWRBCZiHn8a02vMBUxGriXLywcWMwD7CaTHqNqoSErTIW4y6gXOgdOcMkLeGQ
wxXszfU3Cehgfz4SiqHsvZtoj4DJ1Tb48oXnb1uwSazW6IUnRyDrFOk6NrGFvSEP
3KZT/tzDA1c3E90uQTXfrXzkx8D4n2ZiQwfTw8jEBPcVdWwcO9Bh5Kx6o7rVm7Ze
WQ+VvhWpumJVnhCGfR35E0smFW0ii5eEm69IJgFupV09TKE4WJs3+8OApBqPwHwi
BGGM2HtRLf/CklUoegsEtHKoPBEF8lDtkYMe+YXyaPBLIR0vUjOhe6jrwmaz7sbK
XFkG5u+C034SW34VD/4gkHinbvkRUemv1i9/epR7wvjjWQt0JzQrvS4gS5FuQ1xD
d12ZHafrE1x/bMAzU+zqdQPksm0h3XaWnHAaaXD3cdqv/ZAiu8mwIBA6SCV8RERh
I3qzTeSyQw9e9Ly0rDWqfnCUibiAaqsqzgsTKGyPt3cnoGTVYtnQZJX0hgM3J24P
9YyDjZX6L+x0D+xxFkfpZZOFaDEWvXbLTmKhcTG6XmXfyIlmytW0KnV57pIIM/wz
T/6s+wXKNntKmIh7PM/J2j5CewdiZRxD8dc2LUtV/51xcNVzALT/azX4tGsPSOoc
BNUfxvWiTpN2i4vekCrkwz0O7IlxvcYIg4yo31bF6sVuU+/JTIHbRrC22SdATNH4
zkxrdgZUryyXRG6Zws+vZpBG5y9lR03i4k8n6APQlrvbq3HepVVlyUIGZ3GNUFIu
UIibl/CkLLbRJWkv31srpvxEl4aFy3CZ6VhmSrJ27S/Reu4UDRYzGkn9XGTy/HPA
bEz7p1hFWeERI88OpjuDedOC1AYxf3I5s5l/r6VAbQMdv6fWFNBRnfc7JdSFIGLG
tFrEsusbXBoNGu9rtoH0pTUMFv5qyi9MHHdlhuimo3JayF+serisEKSJvi7j662m
klCDES2uP+lGKmjP4QH9jMfYS39rb/s1sGYFfEEOupvJOnrbnkhvSv2S1QcoL1Hx
HuD15w/lMvu+dSxJpszM4lWbEroXXbt1tUkrkyRg8QEhIN/H8rK3Q1hNe1cGcyqH
d/37A3snR6Azzsa7XDokZZ9Lv51insepG9IgK06AGgPkJjhC5qsPDqZrU1tzhTpn
jJNfAImdEjHfrL3nIHTP2NPnfAaruZyKfoBBpiRpfxblub/co0PfteObjj6a6Jz9
MSl37DQumHdv81AxKt9flQMXtJIEgSrlQZJ7OlzTLZjb375/IgkvjHeoWSR52hnO
HHEohDaNGNlOS5/apCpC3rKpXuorI7zzvhXowEZKGQfnxZYjysG1M5sm6qOJkg/l
xY6zKR32sN0+egDEDH+m3kJDvNVR6mxqtUHa0Cne7mgPwwjcgXBLPOlFADJqDoJ3
py15zNSBFHeJUPGVZcwZqfcPftrS4/jl4eY3dO4OW1ClpF/0rtsq9bqeZFOC1i/3
QuLCr5a0prmIDSfOkUCw5dXtoXRe5rIAeGXW00LuA6eXuhN/kan9zxtk/1XClauL
WKlAwQuMuZRfZ07yIt4TtBxh8kwDIOAYs9t/WbBkAg5AT+nDjgHO/zxGD44EtAp7
uh9bz2XaU9s+txl20PJQEcy8TzazFjkZyk7e+pqxtgwfCGN2v7QXnmZ2rCJJrOwl
h9KOiWZK27ZWjqcMothwAJixqfZ/4UGq3LwH5xdNlwQ8IeRp240fXwPqL0cAsrLV
4BB6AGBgBQOpPTf/ukzFaLfy9wAM38en8EuyIrKW/uPlq9S8KGxdR7fZ0RSBcLOW
qWUsTuBgZGRF6ZUR2NTaPnkHGeYek75Dj3tE3KGa6UqYUgLsWcfG7jzjpzrFWzsG
92vmD38G3cTNKcwYuLf4l4Y/7OsTyyQve/o9uAYY5kBttFivLzOj1WEHgx5AKBoR
fp7X1ZgLYICWPvlwy9qGREyuOgfZQiAj2AlTIPSWsv1uWo7NAwVFUyqcCErx4708
CfjNayuzzbF1Jq3eld8ikxyCYL4xL7QrJ1rVJbTW3O/D1L0gQqjU6U/pdsM4UH9/
vRxkWh2C2ndxOc3IeMAmh6ZTaga1jUsEjCcLfYp1ne8ns/tZzfMCypq2zsEOIEZe
PKiY6N4IOxYqIL9fcJmsDJTTOToETnBqoJ/04zwDMiOT7VCDEDEDjkOz8FLjLyhS
zA2lE6AWuvnBW6k/3vmTpUQkH8oFp8eg0oNs6Wa37nD7kXD/wz4nDDpX0rrDaEbj
RNRclkjRmUpIhWD98sfZvYvMIxjF7J1DrsrF2CplIjADLNftBaVF+akAtNXYu0Vx
llzCFiQh2TO7v4BCzX9rs87XOCkTCxfVpv8cwxXoAdtqpSNLpiBYA/EnCyejqB+g
DWy4uiWSdC5Ypx6NkFkuAXgdkFCm0cctsaCW5A5Gdu1MmBzJSp9OQ8nC9emiR6aE
gr6N1HBij1/pdj0h7u+0mBX9Gu3buHNy/yLrAcq7HiANPkfxEI93zUJqHKYNUir4
CQmpKHdtl5gFwJuY6cYqmX1TucjVhFgw+7iRJ3cjS6/kPRIYlM8f6ZdzTPa1fJRI
YK6PkSHgWIIImUpe2MK5opcwUY4tyCqV/lwKyMmwW4pr9iINiaVWNUcB28676vS1
+JP7A7fKHQ7kCHAKiE/OxXVTnZGZ9Bsj5wyUW2HDFzvnWR7HtlKArmOB1wt54/li
w7m98OFI12oFZkAvbI59zTFtiKEGG1KhihPrc5ZeCPEvLYBDfPK0ttizwsjk28nm
MUxH7tcS6uYvEBEEK0vcdVfTM0xvcuxHXggrxg3nZid++AGsAkv2hNQ7FcjmcSnY
rigeRAz6RdHhy6Yr2TZDl+GA1X+QdvW1Vtc9S1/ZMgaPBOmEgZFfokpJi2I+VRgC
vfJtL+h6tlW0nuM7Pk8Lx/8wqscjBW1cCnVZbOu5Uduzas6qBfvMolX2jG52VgEX
DgSIJ+8L6iBsJIkxI+PLPnjpe9zZdg22kAA6doRD80IiS+5ejL0QM6ndeMuhkR8J
8l7tkoXJl6KY87aY2jbX4rKPmmhgtSq55IbLrqJ2m7i3oRefbKPkaMf6R0SVuFZB
KD/fkWAAW387RnuZzE1ZY22+iOtSXJ4/KRJNWBaDsiImk0evwoyx9RD9wMecVrFV
mQubt8+IVEsOJDplIHKfYKopulJod9ZJgHS3B4uCknuziLFAjnr5z2CY+EAo2YrX
k6+qOuYRWuuCOGdJvlt6jycfafzBU6qUDuh30jDc8G0cJXUpoIO9xiXkS3A/3sZ9
7YkS5+CMWF/SStJIktf9avbuk0DiQZUV6dJRjwV/VGw7mJYbaeFQJ+qws6rK2Vw1
Fv783WbvNobUJ4Rpyn49du+z8rOU/D3KTMZvg1kHtBNpdk2Je7dL+4SExRysX6fk
xQyrF3gVErVeq/jDOkePh5R+o4r+JcLSkKj1XvVgCV90P0mfz7Eq48ZRDAcujZfj
Uxr3TlQizY9yLYNAJ5QWHnqRQCpqv5okMPwwFCOeCm7L7lYTAUYnOO42VeRef3J4
Km8ZuOCZkFrOOHgiRbZ4JKeEOFf9VkkS6iQqL2Lrr/eXGJy1pC12+XxobLO3P1pU
qMitC5xdmiaUgBgPZjY1kXxZq02pKLKfauwj8Gh+u5YfuwZTtz/IKFkCmRN4iYVL
U9Xl7poSHfCktlR/abESm1XHL2Gby34TdR/QQE7tNi9zhNO+KDOG9gRpThpg8/cr
9ipZsZxVXNWGCeHM4nV5xbPABAKQzPooAAce3I6Yfk1PqqurXlTipG9GHfQAGWfJ
AmsXoSNmXNrN/+R7SfgbJA8zQDDeciXc5M34/XQw/FJwPl02yU0maNBAY4r+/QLg
3k7/y2ExmQwsZgbmzYaki0Pr+j58VQlmRkWUxsGT3AwgTceIJHxUFau5jNUnqNFr
OD6N14dKYZwhW9psmC+nM8KMh/3mjL5ZhrXmVQAm21qBDRm2MUfXYdmW1nWjMI/b
fkROf5g42kfwl7uSend2D7pwwQXBprbagSMru3BtVC17a98yaT1/+ULVQb2iLm0R
g8ymMsYNcG6sDnmhmxDXEhjC5ebuQ/bZeJGQfQRS4UZFwWv05//+7NvC1I2B36ns
+JPdBdI7t6GwivxmLYRB+YBKoZvg9RzePp/Aykps6OXpOYPoyxIWlrRFZe1VTeH/
ZI7cl/KYErUIR8o5R/Lz+pXFTdebL241JbXrJTBZHPOBbJ+ca8KT2dFgAT7tkrzS
GRWMCLsCMpfd8U1LRRfj18IgyAVZGBeQew4PNYx7pRAvjX8EfX3YC23lIU2t+NTG
D9KL+ZVpDqcc35EeQw2p/gg0x62Pctr8SR6UFY9mo+EhyP1+VftPJaLCbQJ+DUfe
rb6GxewTvIu/p9mo+SqNwhRzgd+rMGqyMP6P0igYpxIsY8OsLloDt+95M0Q1AOq0
jo1TZpWZhbjO1FreYWnxXkYXaYXCXwzh67LX26JaIfmZfSsVHOejPvTypy4TaOs8
y9sWwZjsbpc6mJ+0j+x3io2OtaobLkHkXESZaO2e6sK3sx/9B/9ec0TrWGBU2Sh4
q8DmegY+Us9YAVTqkK8R1O4JovniU109VBUozG3v4eIhSVvFvL6zuGTi2PdCD8Ha
kHSmvZD94cRYArdSS/yrFxg8LJER3NTzv496cgAFdlY5x43SDnT2+haHes6TWgpZ
T4bkqW08FygKlwHhV38hoO/puoy7x3oJv9/+lI/s+mgowod6u8O8FuK2ldudnfCd
JBXoB9wpVLLmBvy0UQHeNUk2wKdPquVqqZInpqAbWThDM1ODBzf8BC3nno5juk33
WHojuZ4b/lCMz8Sy5v43dZBRzMr/NesOOVdJf1qs8m0d7GoJV0ZG6MHHjjhncP95
gtDIaroSjndqrSlWBzWv33gkulddph5Z7rD7JlW9Kmw0HNEt8/V/ooJkJY6jVEuy
E6RPu/qGQdIyhEgBk6vvXiPQ1iW6F+VDD2371+t6aBI9X9Oh72c0HC+F3hB/L7Zy
aUdbA+oC5DtJQoFzUtDmqyD9axh3Qx1UXZ/p+spu48qMFjoj3aVUuKjJW2RNL0Q2
/bKxtdyLym3INIGBGq4WtlLdYC/vrl8HVJ5/ncLgx5Vdjl9oaPfQ3Te2OWH+hFvY
O3xVNeR72/0lIy2Rzt3jLOw3YGf24ToAd5Rj1VaLYjBebX2MeF7BwtwaaBE1LSX1
MNnGhyce4iJXVEydae1SgW8MoZQHn0kB9g8k1Wf4fzD1S5j1LT5BwPbdBxq4XrWJ
jHNa0LvGYRuZk6yqeZu197b98SQiFQaNlAQta6xIYP21MYIDB3ablpYBiUCdA9b/
CHB0nATAftTKQd+PGsDutYTja7AoBNCAG1F+L5PHh21+rRlw+0WAX/miy0eIB5MI
hGN3HfRvyhQbZkZwPTa82/Ifu9DXPCmxxv8L9wtS4EOXwJceyh8pARM84lKNbtNg
sYm43VlrzsYyfmj1w+1UFhPti9PnqbjTJ+8YcLKVMJS2Cn1pIi+ntEZZAseB343B
Kmeipa2DcYpJzzG5TswFtClY73jDJzrOoQhFn8skQjJUDVNpr76pIrcX8QshUXzk
Pc2Ij2e0X+yodTwzgyM5/TV9q6s2HZXhhJCnI4ZekDR7zGWZQ8EPdW6x38ZqiMxu
DxYqjDDl298R1RaaAuJUJGpHpCx1Kwv8fDWgYN0odKHfHLcdQ1jpthawsvr/ydCP
abHCW5auBj/adPA7oa3OyQ3Lay6ataxJWKTuKT3uRFl2j4Lvj9BQzqo6rq1QbOq5
LYKM/imwlGma7fdwh0D4xE/w4SgwzdhB+aeTr7lJ8I2H06MdG81LTrxH/N66UjYc
sX9skin+fOgjDdeQbvSIHa0/zAc5fr+jHCtjwdYqOE1L4YeXOGyGser2vVX9nB62
E6VbJw0X26PqGRiB1vOuV4KBD/O5MRlzHIm+z45Fv1Kp+3idM3zpqqKcr7ele5MS
7sL5oLiWxCYu7zy5LyvGkHeuYK9wdLqN0gxB3q05SAxaOC0X3VBGjNFyANY7+NxH
vNYZivUpoJViYMKnIAG5E/jeCkDpki3EIRUjzS0oE/fFSPsHkT1NfcAyX4MfAb2d
y3sNj/icu2NF+rAl/koVIBcZq4W9gFR28eGPKjzAKWL2NVsDOG9btyfahPgf4K+E
XdsNatoHqQZqGrSdkBMF/yV/BAQkOXZiJoUiGui1hfVBX0EK74zKquUHN8F45lhS
Kq2+0WCS2Epkp5woHG/DXVFemOdBYx+xpp/a2nxno18hESOkb0hWGSWhilgJdlFX
n1vCy9Bq5yt54m6Nuwdm0XXVOJJajhFP3r2kQiX7bH49sNXCZCeGu9t43kThVw1Y
JKRhIRmvicA1pJsUQ7t6ib0iUAsVxQtKL5WP0FF/Z0cPhvc/mFcUvdRqS1nYb3vi
2zIMc7Fgm+c0mEhbe+cyHJVstAbbD2ioh4UHWlQrhOudyKTRjDkeuxeVnzrJNiph
giDDn/f4RpeBjEH3k6btbwHKTnSVTYT3fMeyROxBvMR40cMRMAy/OO7P05Atev48
wAcMBTOiLChZgx/RGdVXgdUD4lLq3Ew3MThqYK9kqJm+86YnNajkt9FZzZQxqkJr
c/IBb+HOKvHC36p61OB2LPLSoFcg5nL9HCcXc7GlAuUjMmyJyxQharWNbLFDedG/
3Wbrw6usUDHYZqjxEy+aMpEmRAajIYsenGPPkuL+rDLznnMLowJsD1WIMv9JpuM/
l518LXdXyim5CiyhLtokfmj+A0CDxKi4wumo1xI3rlSibnbwie+Ul4g+Ix/psJt8
8cUnxTeKsQBtRWaYo61/fMwpu+uqYkJSNckFjrwaoUWFa36k+P1MZRz5NmaF8TsM
/Jjt96fWGOsXAFXaDHzlFu7ykw1HnjHfR+Oc6SK1bePMiDQraZNiGm3faPvmey7d
QoqM33Lu3BD9Ii7CosR5CaUU7mdQTWQCsRu4CjkeK5O1nJFyRzRg6ZvZTMRgTWFn
tSPw0Kpk0kGpOWVDHyMvL4kK/5AdeAtAUnyIGL0BStBd7Wg+rYv8Af12rjHbfW1Z
1QmrCg2uLHKLVFnsRrZhNeHjDLJhnFo40J0aT5ogmmnMrGoctCiEAEIR3r017K2h
OEFvG9yivhKX7cEXaErgnG4MsnRPBzAiizuu+w69M2shDllKer127t5aC0xSUv5n
a0zqdSdMNHvVum8F/5eDONdyPQAl0WhygEQLKJitr+zvldcM4p1L/MyOeg7hdBaA
LyY4wextGzvFxRVh4QCCZDzabe2IgXH7Ygb2s5QcRf0kluXr4dQ0GlQeOu88LKMf
UUbXCfyljmC6VT6Ylfzs6/jAYDIAQNWAfqQBUlR4RMeQWQX9cAhaABfNtmp0OwKn
n88TrmnQKImLlMgZxAwoXMngQ7168BOr+BpqXsDcOh9JLVxI01TpnKxxtcFEjaNK
5W7aAq6dftDY/JZoIGZJTneVQY8uOecuFrZ/+0WImuxuPgMpPW4974uX7TD3q+MI
Ihy+7UK2YR0PrT7QlO1Ke3Wywr1FEssdnyW/9EbGA4/iljguB4/1ew25BYHSbD40
h7c7jGEYk1iDrTrFs36H2jsfID50F8tEwfF89YtTDDOo+npVqOuAwDa/nZYioUJA
jAgzVVXilNSR9DCdSlLcKt9tGNYUGQoeByqI2aUf7GY+fSxMguAuClp+21esrAG6
oTq+r4D43JSwIgTtKcb9jJftmeGq1KkgATc5PAOaFGcAH4yK8pxallDurDKKe+aK
5XvSuNe912AP0jwVPhMGtD441Tv8ngKiny7G54DWUrxFdYCL53zHRBy8jcR5KqrD
ZGziKVOyFJyfOdSyDhK/GKi4uWjcGFf+eKxpt6AvypizP8uzC4hBfZ+bSDsSlDs4
5VUR9F77FfhZR+dHeHE8sum0tN9zwmLrKul/U2XOs9xNXCriaFtKcFzZkb/ZY1tb
nkS0wiRj6SC49YromeXZbp3VFYstowbCFFiN5FsGl05MNnCieC3xbPMeqQaZeI/b
hRXp4MiF2wXTm3FW7ybHuo+OQ5w5R2Dgaj1624+8pR+oCz+IKkvhR9Q4tcQK1n2J
f4BsgbZp7LVwwUcOUVSjOF4XCb/0+xSVWkI0pnu17I8oFXB/ns8DpqeD0tKL+6hx
P8hTemH26/Q02wQN+B91cAP+eEjaHC9WAvlEOaA6z+3Hq7S2nWd8CKJMyuT6xh2V
6kY55Bf6cecFA7wHhcegms+RiplFNm0omON78lOTbgobit3pnWRd4+3VJcMGeBaQ
hGH1qDmB1EVrSYpIxKSwnohfoN61XruYK5a7f4+7MUM34afR9yfwh3AyqmQqiFMw
kNqw+DvOu2FrM4NjQytI33mUyVFoW0XRJiV6xNzjRuAAUIAMBVzU3wB+0cTj33gX
RY8qVLN1ijPC+zlgLPn4k8QnGklLYls3oXqcNz6iUOd+zctqro18LTv6bUgdpzfC
il7ZEq9ok1nY511f8o5UDChAi/W0jEzSLhvhzae2MHA/Clh6wEreVqvMVxq5e9/g
lk4FOXO/CiYJgR4q5Ic16JQWaYv7HlW3FZi8joRWUYAW8KoIpxy8Ui3P31IkmXFP
jfDAquyXrA1arKVQeTVwZNaGduy0lCuR+5hb9WIcnjEH9ToUnXp6uPcGJnikWYrT
AMIHjBIwJvS6LqMjgiRHAlA+WMuUZ8L5g+3SrCHQ7Gjnrl0YPrawgK8oWUkxddQq
D/TMUQc3DSuKSBGn171wkXojNJY64tPCTNI/5F+KNRNUkJIDpmu2Pqzfp5b9WwIL
itYg2J3yAfV1zOnDpWxtSXd700uqjsEt3h7touva6hWzosl4jxbd0VAtMIfdagAE
uYvM/k8NajpEXlFeT4WqNKv4pjRaNyVJIwMOQH/izun/Hxdb9WCPiXUBWVwfMpvD
kOjK4UosH5tw1O78h/BB9/vjCfjEXyr3gxMOxhCGhtGCoKhQCNufmaMDUFekTn6m
VYp+ZTlZS5erBZjec/8kwprkmivoqRl5hY+e4oTaiEXeNT9DZbIOOSIxlWYXqgHB
yM/wPOKc6aL470g5mNtuvIZOHo0dy5Zmg5t1K5k+3ZA8eLtx2Usbw7i+pBi+2eYQ
e2ICHrNEoEztR/Hte1E72cjSxBLyOKLzUHI/9LcenGiS9Da8SvEt5JG7ir+gx+KP
RgW6xAVxpqozD+Irwy8lgzmjuiJ5xjvcQAfDvN7ebYhWLiZYfTIz6rzG72UO0YAz
7ZX6tCtAj7aDrhubYl0R+EPuHENiJ7VHVjEHrZCt2JLuldJ5Qu7RUsGaHpGgTgqr
lgkaDgPz8rYuBOlRiDewePrejtkJaeX7RXw58tKTdVJhuSged9x/JmOsIB3UFfSw
Y+mjNruGGyHsJSyQGUWKHsmFxFBKMD7EyjVVoljr50G1+xkyG0AkfaxqTt9MATAB
yj0RJTHiqyeEhfT1oURfxuP3s79A09JS136SIE1PFc/3mJZRBBOFpWKNpRnCZA0O
f1CwrCc44CyHA6X5cPCGBeqpQv4cJw1tgmjox1cu9PHGaizwDJJMogUX/LsU80li
Zm2Tx9BKKRfJ/HAutv9/72S+nLcyl5XK6c1mJT2ANqtPk4YfEhxEWoUva7jUi9+k
7xe9iZzRbvp6iMbmxL39k4yegAhQLXMsKeO4ewEev2dcN/yGzEntUzNVmqyJWWet
YolB1D1YrLgzJay5ZKpiJTwZ8M/0+EXoq3PlAXTPfb/vHN7QWqZ8Q+qTS0Qn0baI
QncDMOzobbq7058AvtbgZMscmX26ewPG4gp3nSE12NlhGuPD9n/+kVZq0OkZlvCM
IlZDYGopbhxMPG7RSBdSpp7la9wDutT9nRP0/6gY59+2SKyaR1dl43QFugMzIVeE
n2dXlxDsnyFHQMUm+w3V/ToQzAI+a4ccJ8nM0QCI4NRBhCyJrkNzxJQSBTNwKm8F
pGfLV7cl2vzTIk7amRf2NlB0M/5EfwMKzYICsrhcGhHReX5YvaK9oaUddJl5WFem
wziGMbgmtUFiLkRDiF8rVZVqMkGLo9yMX/pGPBcU/Q6QT7G10cwrhzBGRKHFJ8mH
sQYZCIZio/fj0O1V8gcPmjGIZ0F+M5Df8ojpCaGyQcDHFpfnPATVg0D+F5qCthC2
Flf1qwBlR8Ywl4cfFMya2dKSkYvqdcIDwo7Edu4REIPt2S9n9LV+AxqPfe5TOnQs
M0DgNdGI9CFBW0RaOtdmwHEvWo92NKYYwho3o2mtmBBS9bPJl+notCMzpjPBBmQD
eVabASPszt/16Nm2VcWBPIf2v/D879Xo8biyq6eyrygxkc2pRLjbeGt3KMuI8hpK
BiL41DMq/L+s93afIKOhzpqS//rgwru7B/PUDijXTckL8FN2ET4BzDcFRWdEoSRR
awMqDeiWzr1hIVguPhz//4Z48zI0OKwWrJx3+3CTG/g1TnH7q6DeORN1VRrouFRy
igIA2iaDJgt6isrlPujql2qKmRaXVJUiF9yOg18sCcZ8LOo4s7jW9M6Erd9FzG4j
ZtzBMz8YtE79sMEZl62IKZjSSVHWS3e4CZF2DjO4uC7DKiCTWLl3wPbG+pTY852o
GDUPQ90GDbnnKnH+NUCxowlf++IA1c7ylQaUIUdVPseJC3YwrhSQTX6sQrNCWJy1
beUZ6MRwe5TchcLOqZDoM0fxO7yK4DAED5MEJpM80P+BOVn7f1UbkX+svxZRyNbe
1ytoahV3YdQD4facaaHJfn8W8oVhK7FCLeA/Dq8WbcwBbLOPYptcAL+utu3N3e6N
D/e9H4AMtGAiF5q9ZU4qffVdaB0XkZoO3LHu1glE82jT+920RKGYPN6T5D88xhiU
ZiFrvm01xKb0+hLP5ZdR/nAbHqucNUe6suqLcMX5jBrBVSkR0lW49sE9LjYegnBL
r+S6O6zJCmzGwP7keajr5rYnQ4iIm1sdfzTHrdOfPj+HzyQSCHiRI8n1k2gdTeNu
Hh+o1PaI1lgXnsuf74vk8m6ELt0EBVuGPSqinFaTp3US9tBOmX4PIbcSE/wit59i
Z0sfCdrXW8EP20EQP2s1ZJVXun/YTW2Eda3NPHkh9cGVce9tUuHRujkCwkKh6VpD
Ce8+e3z/7Bn0P3OrbAm8Euxmw1LOPAFIubMJgnESXwT+auKAy4AI0FKYv0NU4208
+9Rd/DGkIoNQ4KDr1tad/JlYGLso4mr9qT4+CIIK/3YQk11ujhz9JDWgN7Fg6FJu
jlGNdsmHIn25QANuqhPJ8CMVdfXwe+imIJZOYpll1wYQjwUVTJANufHpJgMalwaV
ivhx3np6lWkP1XPWAjOzMzkQqLxUFWjD8bPb6mToJ2ZENW8AUt1udsMNx9WfyWyT
4K5BuUaWpe/0QfID5rH4NlEUcH8h7YeiUjDKErFQ0BvJBN4uEYnxni5r10jIK61O
Y1i4H9jaGl70jXCk65UQ6975XVl1qxqKd621PqM7QI1d0I9QIyqRVXTloQmXBdn9
bl3kEPDaWJOlUFX+21Mpqv4V9mym9CvANC7aFgBC0c7TMjEYgKcuQSkVxQtdXHty
p4tgzl+CjV7etTJZG3G4Qkzjc9GIOYE0eHqBbOIbprLumaRaFNAKiMrWXcXE7Nbp
3Je9SwhLEYkccubd7Nhwy+0yAhCpCVhcnZpx/S8eFXjiRBqo1ep4MmbHUiCegH5T
1yreTBJCHt65k3cdIDl63f9a1GbgYw7J965dYcSiN4kXZfodO9sFg5U4FaeCiVxp
geQ25qvwDFQUa0vusKytEy9J/plyO/wpyQkLAi1YeoWf8PxbDtFFy1eqLuYkMksE
qqzYWVOQFIvgVmOsi2//AYfsXdrx7ZfVFjALvDonxtopbU83qowCAnDo9oLBqKE7
B4zaUzYBs/XXDHTmpYeEr3C+kDPC2iwGv3doMoa8+tmZJx+GeGDV9taXSY6Xw6LQ
J2TuhToK+aN5zV3bRGZ/eDN63fI7tcWp+YypVPFEWRFvbDxus1AgbloVvGxmrgad
zL3Hrci95Q6jsjlnqad2IA61zSKglq2semcHvEmZB74hvVGnDkg8zuycBJ4J02Hc
DiWeG2F2UfYKS7I3gELyTx7grtUXF0m7yIvNpuBelYrKIBK3TFmqdPqAN2wzX0WT
ZWPaePrbxpYz815BcRMFmDN9LxeS83FP35SfiWjP5ywiwIDKC83eT6wlcn39nLMZ
1TQ6/ACu4eBeNOTuUQ9AHwRJtcFc3zz2A2zMnRBxGKXj/G4ROjXGpO79HfJ9h5K9
VtfHf8Amt0i7mji2v6L/iuYYGewk+NXz2OwgelpSIJZ3F/n+HjneN53dFKnLAMZK
WQCmHV15MQkc2Q4YS9AwU06JnUG1PtUZGUCMZL1nuX4DDrhzTTSouvpY3Se7lMhj
pj9VqK1sXYWsegwLolddq15OIy30t+Txunj31gIYVlVcI4F9OMoDj/xNnReHWSS6
0+t3TRbh859Sp+uwtUOwluMtTxMkoBw9ObNOJHnGOubU9HVQf8Vmz9t2ok4qr9ZP
N/swlFWurgyVlLjV6b8+RObXJ92dZ9YPCOhoHVL72Sj052BwyMmYSdYmL7mVYZOf
DlAvfAC38TCY9Gbny61D+TJu41O2uM1KctSvl8RhG4Ix1TLUUMZ/YGI2jE1NPoSm
O5hBJ9YkU5Ii4vi7qzo6mG0BRfXyOsoDp3+3LvV6auyV8G3/9qFom4jsN5lK/YGI
KYswg2quOPM+fZLcOQ1gjb5NL6isKZ3oepTcNSMIigolXsK3TmmO8/V7yUf/TFY0
lvvX/DaReRXta4OOsU5X0nOXjvOy85JKarDzMQ6bNM1Zf0ANYTh1TMnBv6Mp1rJt
vHkveL9+m4x/deXmsUomyhN55ddFjrsVq9ickatqyraCSFakcqGM/KbKODcA94zx
RcRjHu2eXqpz7ucTpA3PDQ==
//pragma protect end_data_block
//pragma protect digest_block
KlgWwCW2gyWd4OQvM2p/6qpXvls=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DEBUG_OPTS_CARRIER_SV
