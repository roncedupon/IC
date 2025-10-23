//=======================================================================
// COPYRIGHT (C) 2011, 2012, 2013 SYNOPSYS INC.
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

`ifndef GUARD_SVT_OVM_RESOURCE_DB_SV
 `define GUARD_SVT_OVM_RESOURCE_DB_SV

/**
 * Dummy resource DB for OVM
 * */

class svt_ovm_resource_db#(type T = int);

   static function bit read_by_name(string scope,
                                    string name,
                                    output T val);
      return 0;
   endfunction

   static function void set(string scope,
                            string name,
                            T val);
   endfunction
   
endclass

`endif // GUARD_SVT_OVM_RESOURCE_DB_SV
