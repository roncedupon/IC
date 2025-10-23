//=======================================================================
// COPYRIGHT (C) 2011 SYNOPSYS INC.
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

`ifndef GUARD_SVT_OVM_OBJECT_WRAPPER_SV
`define GUARD_SVT_OVM_OBJECT_WRAPPER_SV

// =============================================================================
/**
 * Class that can wrap any type into a ovm_object
 */
class svt_ovm_object_wrapper #(type T=int) extends ovm_object;
   T val;

   function new(string name = "svt_ovm_object_wrapper");
      super.new(name);
   endfunction

   /** Provide 'get_type_name' support, simply relying on built-in $typename system function. */
   virtual function string get_type_name ();
     return $typename(this);
   endfunction

  /**
   * Provide a static get_type function, mainly just to override base class implementation
   * and get rid of the error message.
   */
  static function ovm_object_wrapper get_type();
    // The super generates an error -- generate a somewhat equivalent note...
    ovm_report_info("get_type", "Returning null ovm_object_wrapper.", OVM_NONE);
    return null;
  endfunction

endclass

`endif // GUARD_SVT_OVM_OBJECT_WRAPPER_SV
