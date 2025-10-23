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

`ifndef GUARD_SVT_PHASE_SV
 `define GUARD_SVT_PHASE_SV

`ifdef SVT_UVM_TECHNOLOGY
typedef uvm_phase svt_phase;
`elsif SVT_OVM_TECHNOLOGY

class svt_phase_objection extends ovm_objection;
   bit m_cleared;
   
   function new(string name = "svt_phase");
      super.new(name);
      m_cleared = 1;
   endfunction

   virtual function void raised(ovm_object obj,
                                ovm_object source_obj,
                                int count);
      m_cleared = 0;
   endfunction
   
   virtual task all_dropped(ovm_object obj,
                            ovm_object source_obj,
                            int count);
      if (obj == ovm_root::get()) m_cleared = 1;
   endtask

   task wait_all_dropped();
      wait (m_cleared);
   endtask
endclass


class svt_phase extends ovm_object;

   bit phase_started;
   bit phase_done;
   
   local ovm_objection m_objection;

   //
   // All svt_phase instances are synchronized
   // through these shared objections
   //
   local static svt_phase m_pool[string];
   local static svt_phase m_current_phase;

   static function svt_phase get(string name = "");
      if (name == "") begin
         if (m_current_phase == null) begin
            `ovm_warning("SVT/PH/GET/B4SET", "Attempting to get the current phase before it has been set")
         end
         return m_current_phase;
      end
      
      if (m_pool.exists(name)) return m_pool[name];
      get = new(name);
      m_pool[name] = get;
   endfunction
   
   static function svt_phase set_current(string name);
      m_current_phase = (name == "") ? null : get(name);
      return m_current_phase;
   endfunction
   
   
   `_protected function new(string name = "svt_phase");
      super.new(name);
      if (name == "run_phase") m_objection = ovm_test_done;
      else begin
         svt_phase_objection po = new({name, "_objection"});
         m_objection = po;
      end
   endfunction

   function ovm_objection get_objection();
      return m_objection;
   endfunction

   function void raise_objection(ovm_object obj, string reason = "", int count = 1);
      m_objection.raise_objection(obj, count);
   endfunction

   function void drop_objection(ovm_object obj, string reason = "", int count = 1);
      m_objection.drop_objection(obj, count);
   endfunction

   task wait_all_dropped();
      svt_phase_objection objection;
      if ($cast(objection, m_objection)) objection.wait_all_dropped();
   endtask
endclass
`endif

`endif // GUARD_SVT_PHASE_SV
