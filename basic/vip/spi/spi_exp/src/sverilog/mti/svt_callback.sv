//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_CALLBACK_SOURCE_SV
`define GUARD_SVT_CALLBACK_SOURCE_SV

`ifndef SVT_VMM_TECHNOLOGY
class svt_callback extends `SVT_XVM(callback);

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new callback instance, passing the appropriate argument
   * values to the `SVT_XVM(callback) parent class.
   *
   * @param name Instance name
   */
  extern function new(string suite_name="", string name = "svt_callback");

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string get_type_name();
    return "svt_callback";
  endfunction  

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to initiate activities.
   * This callback is issued during the start_of_simulation phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void startup(`SVT_XVM(component) component);

  //----------------------------------------------------------------------------
  /**
   * Callback issued by component to allow callbacks to finalize activities.
   * This callback is issued during the extract phase.
   *
   * @param component A reference to the component object issuing this callback.
   */
  extern virtual function void extract(`SVT_XVM(component) component);

endclass
`endif

`ifdef SVT_UVM_TECHNOLOGY
typedef svt_callback svt_uvm_callback;
`elsif SVT_OVM_TECHNOLOGY
typedef svt_callback svt_ovm_callback;
`endif

typedef enum {SVT_APPEND, SVT_PREPEND} svt_apprepend;

`ifdef SVT_UVM_TECHNOLOGY
class svt_callbacks#(type T=int, CB=int) extends uvm_callbacks#(T,CB);
endclass
`else
class svt_callbacks#(type T=int, CB=int);

`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log log;
`endif

  static function void add(T obj, CB cb, svt_apprepend ordering=SVT_APPEND);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot add a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot add a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
`ifdef SVT_OVM_2_1_1_3
      cbs.`SVT_ADD_CB(obj, cb, (ordering == SVT_APPEND) ? OVM_APPEND : OVM_PREPEND);
`else
      cbs.`SVT_ADD_CB(obj, cb, ordering == SVT_APPEND);
`endif
    end
`else
    if (ordering == SVT_APPEND) obj.append_callback(cb);
    else obj.prepend_callback(cb);
`endif
  endfunction

  static function void delete(T obj, CB cb);
     
     if (obj == null) begin
`ifdef SVT_OVM_TECHNOLOGY
       `ovm_error("CB/ADD/NULL",
                  "Despite documentation to the contrary, you cannot delete a type-wide callback in OVM")
`else
       if (log == null) log = new("svt_callbacks", "global");
       `svt_error("CB/ADD/NULL",
                  "You cannot delete a type-wide callback in VMM");
`endif
        return;
     end

`ifdef SVT_OVM_TECHNOLOGY
    begin
      ovm_callbacks#(T,CB) cbs;
      cbs = ovm_callbacks#(T,CB)::`SVT_GET_GLOBAL_CBS();
      cbs.`SVT_DELETE_CB(obj, cb);
    end
`else
    obj.unregister_callback(cb);
`endif
  endfunction
endclass
`endif

   
// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RsmZHRxscBRY+WGBWsKABmwvFgE5lPoMBaOLhabOxBSOtoawUFPCKvGyij7PhtZW
PVHwN1fCI6M+3eDlvekGuyvmz3w3WuCGns7IEpUI+LJgdO0IHyKqiePvBFB/ZXOz
maDKO5iy6VCE/Op+Z1S2ScM6+jpZF3HQz1S2dfrWgHE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 723       )
h0er/FypOJEakHjl6QW1oknmTmB3H40HhjIgfWQjLUwqMWQJ7spSOQ7bdkGBM416
Jn6627MbJhwuOMXD+Bki76CW21GCb2JXwjrp8dSE6vjsBMU+bsBvJ/oOtyDmYsQG
LfOJKhFYg+FRfTCt1AVumiQYG8Cy1oMX78SKnl38uAmYt6W4x5Iliea8gxnSDwdq
1ljOFc3+JEYD4RuaBkxDVKk8jKPSk5+/dh6/2o6w632kEJzXvTC1QzW1I4Q7Y8T5
uXwSG7UABv8To6NYcSAcAMbRDpch1EZF5WX3eLrRcNEQU+Lbn04p7Ie2jUFz8udB
lYX6N6rGcB4y9D4Wt81lq85FEwrPZ3DCKvJGeqLVGx5I5AOVqloee67PuYPd+AJc
pDO6m/eGr9YvgtK2I6O1Zs02nYEFjDTkEUrf/Dh0NItgbTB8ySdyhb1XNIa2ua2m
nLSH58pw+G2UYPO8e4dv+6E7r32F8pxv89TRxI2FPki3bJqHetdig1OXoJta41Ax
TTq6PtB4e9/Z9jr/+lDwpDZrCVFegj+dEC+rkW0pfCVuQ3YCNb7uqS6XGLPXauua
VpRdOXQVJ338lRNhFo6Ft3Q6VttHxypPb4I//71bDS5V7AJ5glXWQsWgarC7stG5
Aam0aaDjG7ff67p/m6Cll78vGz04mRPp1/QEAG62vL9Z8GLm/QOz/Qifl7PA0lu0
xYHGYp/Uth33NGHprCFp675B4IYZizfWM67A6Ji6fS6dZzVNIrsQXpbohvKES+Je
G/K6SVvu0dsH02iWZXrtPt+TBIXVwamjPdFRkmwWqzJ3tB72vKJExPVmOKbo6TYm
KgkmbPPtsOKAwzXD/xYSEXLt1sWcDdSUEZMGTT+CVVQ+2aHX+/K6DZsfd1FINN9H
5YPwWYGZofXdbmd4cjbJDZOBCMdGknLi2GfZGZrbVCF5r8lZzQW7JuniQYOsb2+1
lEEHm1nDNWM7VPa7Zr6MqQ==
`pragma protect end_protected

`endif // GUARD_SVT_CALLBACK_SOURCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dYkZrP1I3d88TzmXn+W1xDZZORz/xLEuFraV+83I8vL97eI/q9NRdZxHYoNTQvyV
lKBN/Tc3dCfKs3XLjAW/eKtAJ62JeGfNc6S68QC4eHxSGyvur1dBkjXLLFReuwy8
+3Q8/Ph09S0X9TBFQjMOdFet+w9fElroXkZItlJlBLo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 806       )
UNJLPHgBtA7LRoN3g7dufWxjpNNOSetsyx86UxIJPAIjxyJRThKe/0WD9hHTpHzh
NnzBv5pLlMMEL0Ew9EV2nbsfECryvrXt1BDOvO6UvWKGCRCZanEvIJUfHHdtWqqQ
`pragma protect end_protected
