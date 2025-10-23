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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
i+MbR0czkPk41jmwlysyaJgRTT9Gmel9E1Z4vGjDK6/93pF30ugsHWcmYYyj6Sc3
v165vgihzxTKsoe4E9+i0I5F/5V7cqxwaHsC1z12lxgNEigOC/oBInRkukX5lrDi
AsN7OutJ1ot4z/zqmoLP7DfoUxn0ZFgvZJXMMZXX8XgCnDHlofFvEw==
//pragma protect end_key_block
//pragma protect digest_block
59P52uPiw4rxObcKWaAmMR7pdRA=
//pragma protect end_digest_block
//pragma protect data_block
OSsqZ3kC62bi482iVQL/H6DVcjBZI250ILVlZ/ezzZ+QldiSLpzvVrgqsOK6WZVo
rhSpukfnYtFIG0GJQZkGLzWctbwNLlCz4HU9hn4iQSxdqZNtoGYi7CtEegoeT/uU
KTkNCXL8CFUxtuJkd6CAsJjlYzKXp+qSUHlIDP/1uoPM5RhwqDsi1Rec1QIv8gGk
qFdvBKA407N5W+lzPkMUrCjZlHVeV6MXM4JrhwWvxeUgRQO7FmnDBZPfRcAf6Wxq
UKjLHljilZT8BxAl5gZlgCHegMDUlWGqBqRBgMwgYEniqwmkoPP5VapflYLt03Bg
n6jqeGvVHQ59myYW0v9x1QG31IAS7oMcNDeT6Vz1Kn/CRY3v+gG8qUiXOZG2VO+P
18C40CUufwu7Q+vjNu4JnrSF7PvbM6tDljMzRvGxrG9NGpLNgUXR8IeTLeDkEyy5
sJnRzIbigH4D49QpIae7QM6LEtLx8MH0jTUyFmCcKPXW9CTMxPfWo4uf9fN64GNk
H692qwoG3V7f7Wk5EGdls4muMoR6Lwyj5fI3qfYBV5uZeXJXQOh1d7V5U8txrWq6
fvYFf+f5zakh489je+bbR3joyFbGGevPLk6x/DPTASEN6/9Wm1PfAWkSnP4tQsty
w5+F0JGOD6hvZMCwdkUEbVfUhWLUrMmOxkR6tjmT9198dJZa3u4W8yrpwtTfKQqo
VelmtpfZI3xNFU7N2D64cI4k1s9PKaBz/HTk0GRgAs/sOmRK/8Wnr66+plNw4rGc
RtZ822b0WdP8SVcU0UfwX2roI2wh3rK+HbSPpWEeH1zf3Njh38sQlTJOnwkZCV5M
AwKnR3HVCNYMusM+KV9ch5YjlF6bdk3zLcUuCEeOgxpW75BNAmZmE6+NHKsE5QEV
SOqLZRcN7FaCjKe0YosHsQjp3G/7pyR5mpx6tkwivUErharHZAHdndADhfKT58dD
YEBJG22dCtZUJeHhbghQ7xGNOggO0RxJshAmIvp6l+FJeP+W6ukOsz56mlIKmchN
LzKxNblgneaHcmwv96gyjzOXMlfPjgNvUdjpeTmWHbsKF33UJnvvhgdollXz3sA1
VHKsGYE47vnvPac4us15AbE8G/kFy5tUQpGVst0Fc5eLj2N8LLxch1rOqJv2bYex
pZ89Ff2h2rnjy2U6zIheRgvTYq7h5hLbvNCueA8lOgQ=
//pragma protect end_data_block
//pragma protect digest_block
zHRRZydyuUakWHtxahM/KDngyvc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CALLBACK_SOURCE_SV
