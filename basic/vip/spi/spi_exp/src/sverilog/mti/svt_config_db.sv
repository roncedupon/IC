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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bfRLKkE4xCm3eQG/jJGouKnbxd3CVufH/UP+mp5lXqHAyxMUsjiWCVjwGt/Dk79V
Cykrep7GgH5zaFRY19wM1AAZ9lxEh4CJdvE+CQMczg1gT6FZRfKUv+mam5FUSFK5
lqDw3ECnqYAlyKDQgQ99I6rumw2XO5olREV/4fn/nOE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1551      )
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
usQl5qBDRG03uwdJB+fEoQ==
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FxVT8sT5zwSGOIcQgmbsEJOMTjrryqAUU4kE+tbqR8cP3uzKOUb4tHElRsL6bg5G
MYcWhw40A7X2Am6RLnwGNNh+acL91M0//5uN4XPUmFclXkgoXfpmW1AVBSpu6uUv
RJaA55Ji6Q7Q870eQADrRZF6xJpopkayQKjXv7hpxVo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1634      )
J5rQMNljEiXigGnF17BcmUmqHVADYul2eTn5q2j3YWVuc+kH8ZtaSeYBEY4C7SVF
IXyRubZv8BRrWsmKbUI3CO8SKeqyLOwyroPiXcZ8+UjF4IxW5hi3+K2CTYi6zqWm
`pragma protect end_protected
