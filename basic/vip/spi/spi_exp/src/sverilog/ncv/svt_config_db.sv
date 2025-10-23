//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CONFIG_DB_SV
`define GUARD_SVT_CONFIG_DB_SV

/**
 * Methodology independent configuration database that can be used to share
 * integer values.
 */
class svt_config_int_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_int(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      int val;
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      get = contxt.get_config_int(variable, val);
      if (get) value = T'(val);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * string values.
 */
class svt_config_string_db;

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            string value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(string)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_string(scope, variable, value);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout string value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(string)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      if (scope != "") variable = {scope, ".", variable};
      return contxt.get_config_string(variable, value);
`endif
   endfunction
endclass


/**
 * Methodology independent configuration database that can be used to share
 * object values.
 */
class svt_config_object_db#(type T = int);

   /** Matches the uvm_config_db 'set' signature, but provides support of OVM as well. */
   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (contxt == null) contxt = ovm_root::get();
      contxt.set_config_object(scope, variable, value, 0);
`endif
   endfunction

   /**
    * Alternative to 'set' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'get_from_parent' method.
    */
   extern static function void set_for_child(`SVT_XVM(component) contxt,
                                             string scope = "",
                                             string variable,
                                             T value);

   /** Matches the uvm_config_db 'get' signature, but provides support of OVM as well. */
   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_OVM_TECHNOLOGY
      ovm_object obj;
`endif
      if (contxt == null) contxt = `SVT_XVM(root)::get();
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      if (scope != "") variable = {scope, ".", variable};
      if (!contxt.get_config_object(variable, obj, 0)) return 0;
      if (obj == null) return 0;
      if (!$cast(value, obj)) begin
         ovm_object_wrapper wobj = T::get_type();
         // Watch out for objects (e.g., svt_ovm_object_wrapper) that don't support get_type very well...
         if (wobj != null) begin
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), wobj.get_type_name()));
         end else begin
           // Just go to the object directly to get the type.
           contxt.ovm_report_fatal("CFG/OBJ/TYP/BAD",
                                   $sformatf("Object configured for \"%s.%s\" is of type \"%s\" instead of type \"%s\".",
                                             contxt.get_full_name(), variable,
                                             obj.get_type_name(), $typename(T)));
         end
         return 0;
      end
      return 1;
`endif
   endfunction

   /**
    * Alternative to 'get' which can be used to pass an object directly
    * from parent to child and avoid the competition with other similarly
    * named objects stored in other scopes. Used in concert with the
    * 'set_to_child' method.
    *
    * The 'use_fallback' argument can be used to establish the generic
    * 'get' method as a fallback, in the case where the 'get_from_parent'
    * processing doesn't find the object as expected.
    */
   extern static function bit get_from_parent(`SVT_XVM(component) contxt,
                                              string scope = "",
                                              string variable,
                                              inout T value,
                                              input bit use_fallback = 0);

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OqrYmeo1ojVVrQu3FhR4PhkCkAXWRBWP/INmKQbuUky69+pnEDXdsJUydZBS+KQO
khoOf2BXzOUYZHKdKq7LIKsCS9CT9Moh6abmMK47g+EasU+qk4+7mF8za7Avvxzb
mnIPN4YLk6ch8iK+MEmGtUYeT3hYlZUf5PIvbXIGtm6oWQRRNTmW1g==
//pragma protect end_key_block
//pragma protect digest_block
F6ne9t6pRTd3GEo+hRIkoj8OWsQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
VcP0ekjuCj+Se0LVSBJThlYggOQ=
//pragma protect end_digest_block
//pragma protect end_protected

/**
 * Methodology independent configuration database that can be used to share
 * virtual interface values.
 */
class svt_config_vif_db#(type T = int);

   static function void set(`SVT_XVM(component) contxt,
                            string scope = "",
                            string variable,
                            T value);
`ifdef SVT_UVM_TECHNOLOGY
      uvm_config_db#(T)::set(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      if (contxt == null) contxt = ovm_root::get();
      wobj = new({contxt.get_full_name(), ".", scope, ".", variable});
      wobj.val = value;
      contxt.set_config_object(scope, variable, wobj, 0);
`endif
   endfunction


   static function bit get(`SVT_XVM(component) contxt,
                           string scope = "",
                           string variable,
                           inout T value);
`ifdef SVT_UVM_TECHNOLOGY
      return uvm_config_db#(T)::get(contxt, scope, variable, value);
`elsif SVT_OVM_TECHNOLOGY
      svt_ovm_object_wrapper#(T) wobj;
      value = null;
      if (!svt_config_object_db#(svt_ovm_object_wrapper#(T))::get(contxt,
                                                                  scope,
                                                                  variable,
                                                                  wobj))
         return 0;
      if (wobj == null) return 0;
      if (wobj.val == null) return 0;
      value = wobj.val;
      return 1;
`endif
   endfunction
endclass


`endif // GUARD_SVT_CONFIG_DB_SV
