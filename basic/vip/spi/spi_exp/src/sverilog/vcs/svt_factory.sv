//=======================================================================
// COPYRIGHT (C) 2012 SYNOPSYS INC.
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


//
// Generic, methodology-independent class factory.
// That way, SVT VIPs can have their own factory that is separate
// from the user's factory and thus avoid exposing internal types
// or having user improperly overriding a private type.
//
// Objects need not extend from a common base object.
//
// For the type-wide factory, the constructor must be callable without arguments.
// There can be multiple instances of the type-wide factory. Each instance
// will provide a "context" for overriding certain types.
//
// For the name-based factory, the constructor be callable
// with a single string-type argument.
// The name-based factory is global for a base type.
// Different overrides must be specified using different names.
// Currently does not support pattern-based replacements, but that would
// be trivial to add.
//
// See the "TEST" section in this file for a usage example.
//

`ifndef GUARD_SVT_FACTORY_SV
`define GUARD_SVT_FACTORY_SV

class svt_multi_sim_utils #(type TYPE=int);
  static function string typename(TYPE val);
     `ifdef INCA
         string r;
`ifdef SVT_UVM_TECHNOLOGY
         $uvm_type_name(r,val);
`else
         r = "$typename() Not Yet Implemented in IUS";
`endif
         return r;
     `elsif QUESTA
         return $typename(val,39);
     `else
         return $typename(val);
     `endif
  endfunction
endclass

// This code will need to be refactored to work with SVDOC (or SVDOC will need
// to be updated.
`ifndef __SVDOC__

`define svt_named_factory(__T) \
   typedef svt_named_factory#(__T) __factory; \
   typedef svt_named_factory_override#(__T, __T) __type;

`define svt_named_factory_item(__T, __B) \
   typedef svt_named_factory_override#(__T, __B) __type;


`define svt_type_factory_base(__T) \
   typedef svt_type_factory_override#(__T, __T) __type;

`define svt_type_factory_item(__T, __B) \
   typedef svt_type_factory_override#(__T, __B) __type;
`endif

virtual class svt_named_factory_override_base#(type T = int);
   string name;

   pure virtual function T create(string name);

   virtual function void print();
      T val; // default value is OK. Not actually used
      $write("Override instance \"%s\" of type %s", name, svt_multi_sim_utils#(T)::typename(val));
   endfunction
endclass

class svt_named_factory_override#(type O = int,
                                  type T = O) extends svt_named_factory_override_base#(T);

   typedef svt_named_factory_override#(O, T) this_type;

   static function this_type get();
      get = new();
   endfunction
   
   virtual function T create(string name);
      O inst = new(name);
      return inst;
   endfunction

   virtual function void print();
      O val; // Default value is OK. Not actually used.
      super.print();
      $write(" with \"%s\"", svt_multi_sim_utils#(O)::typename(val));
   endfunction
endclass

class svt_named_factory#(type T = int);

   static local svt_named_factory_override_base#(T) overrides[$];

   static function void override(string name, svt_named_factory_override_base#(T) o);
      o.name = name;
      overrides.push_front(o);
   endfunction

   static function T create(string name);
      foreach (overrides[i]) begin
         if (overrides[i].name == name) begin
            return overrides[i].create(name);
         end
      end

      // No overrides -- create a "base" object/
      create = new(name);
   endfunction

   static function void print();
      T val;
      $write("Factory for type %s:\n", svt_multi_sim_utils#(T)::typename(val));
      foreach (overrides[i]) begin
         $write("   ");
         overrides[i].print();
         $write("\n");
      end
   endfunction
endclass


virtual class svt_type_factory_override_base#(type T = int);
   pure virtual function T create();

   virtual function void print();
      T val;
      $write("Type \"%s\"", svt_multi_sim_utils#(T)::typename(val));
   endfunction
endclass

class svt_type_factory_override#(type O = int,
                                 type T = O) extends svt_type_factory_override_base#(T);

   typedef svt_type_factory_override#(O, T) this_type;

   `ifndef INCA
   local
   `endif
      function new();
      endfunction
   
   static local this_type m_singleton;
   static function this_type get();
      if (m_singleton == null) m_singleton = new();
      return m_singleton;
   endfunction
   
   virtual function T create();
      O inst = new();
      return inst;
   endfunction

   virtual function void print();
      O val;
      $write("Type \"%s\"", svt_multi_sim_utils#(O)::typename(val));
   endfunction
endclass

class svt_type_factory#(type T = int);

   local string m_name;
   
   local svt_type_factory_override_base#(T) originals[$];
   local svt_type_factory_override_base#(T) overrides[$];

   function new(string name);
      set_name(name);
   endfunction

   function void set_name(string name);
      m_name = name;
   endfunction

   function void override(svt_type_factory_override_base#(T) orig,
                          svt_type_factory_override_base#(T) over);
      foreach (originals[i]) begin
         if (originals[i] == orig) begin
            // Remove an existing override?
            if (over == null) begin
               originals.delete(i);
               overrides.delete(i);
               return;
            end
            
            // Replace a previous override
            overrides[i] = over;
            return;
         end
      end

      // New override
      originals.push_front(orig);
      overrides.push_front(over);
   endfunction

   function T create(svt_type_factory_override_base#(T) orig);
      foreach (originals[i]) begin
         if (originals[i] == orig) begin
            return overrides[i].create();
         end
      end
      
      // No overrides -- create an original object/
      return orig.create();
   endfunction

   virtual function void print();
      T val;
      $write("Factory instance \"%s\" for type %s:\n", m_name, svt_multi_sim_utils#(T)::typename(val));
      foreach (originals[i]) begin
         $write("   Override ");
         originals[i].print();
         $write(" with ");
         overrides[i].print();
         $write("\n");
      end
   endfunction
endclass


`ifdef SVT_FACTORY_TEST
class user_object;

   `svt_named_factory(user_object)

   string name;
   function new(string nam);
      name = nam;
   endfunction

   virtual function void print();
      $write("%s: user_type\n", name);
   endfunction
   
endclass

class ext_object extends user_object;

   `svt_named_factory_item(ext_object, user_object)
   
   function new(string name);
      super.new(name);
   endfunction

   virtual function void print();
      $write("%s: ext_type\n", name);
   endfunction
   
endclass

class ext2_object extends user_object;

   `svt_named_factory_item(ext2_object, user_object)
   
   function new(string name);
      super.new(name);
   endfunction

   virtual function void print();
      $write("%s: ext2_type\n", name);
   endfunction
   
endclass

class user_type;

   `svt_type_factory_base(user_type)

   virtual function void print();
      $write("user_type\n");
   endfunction
   
endclass

class ext_type extends user_type;

   `svt_type_factory_item(ext_type, user_type)
   
   virtual function void print();
      $write("ext_type\n");
   endfunction
   
endclass

class ext2_type extends user_type;

   `svt_type_factory_item(ext2_type, user_type)
   
   virtual function void print();
      $write("ext2_type\n");
   endfunction
   
endclass

module test;
initial
begin
   begin
      user_object o;
      
      o = new("New #1");
      o.print();
      
      o = user_object::__factory::create("Create #1");
      o.print();
      
      user_object::__factory::override("Create #2", ext_object::__type::get());
      user_object::__factory::override("Create #3", ext2_object::__type::get());
      
      o = user_object::__factory::create("Create #2");
      o.print();
      
      o = user_object::__factory::create("Create #3");
      o.print();
      
      user_object::__factory::override("Create #3", user_object::__type::get());

      o = user_object::__factory::create("Create #3");
      o.print();
      
      o = user_object::__factory::create("Create #4");
      o.print();

      user_object::__factory::print();
   end

   begin
      svt_type_factory#(user_type) f = new("f");
      user_type o;

      o = new();
      o.print();
      
      o = f.create(user_type::__type::get());
      o.print();
      
      f.override(user_type::__type::get(),
                 ext_type::__type::get());
      
      o = f.create(user_type::__type::get());
      o.print();
      
      f.override(user_type::__type::get(),
                 ext2_type::__type::get());

      f.print();

      o = f.create(user_type::__type::get());
      o.print();
      
      f.override(user_type::__type::get(), null);

      o = f.create(user_type::__type::get());
      o.print();
   end
end

endmodule

`endif

`endif // GUARD_SVT_FACTORY_SV
