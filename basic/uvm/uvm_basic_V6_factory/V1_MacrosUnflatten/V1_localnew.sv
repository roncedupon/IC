`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
class MyClass extends uvm_object;
    // No explicit new function
    int value;
    // `uvm_component_utils(MyClass)
    function new(string name);
        super.new(name);
    endfunction
    // Other methods and members
    function void display();
        $display("Value: %0d", value);
    endfunction
endclass
// class m_uvm_resource_converter #(type T=int);

//     // Function- convert2string
//     // Convert a value of type ~T~ to a string that can be displayed.
//     //
//     // By default, returns the name of the type
//     //
//     virtual function string convert2string(T val);
//          return {"(", uvm_type_utils#(T)::typename(val), ") ?"};
//     endfunction
//  endclass

class m_uvm_resource_sprint_converter1#(type T=int) extends m_uvm_resource_converter#(T);
    static m_uvm_resource_sprint_converter1 #(T) m_singleton;
 
    virtual function string convert2string(T val);
       return $sformatf("(%s) %0s", uvm_type_utils#(T)::typename(val),
                        (val == null) ? "(null)" : {"\n",val.sprint()});
    endfunction
    
    `_local function new();
    endfunction
 
    static function bit register();
       if (m_singleton == null) m_singleton = new();
       uvm_resource#(T)::m_set_converter(m_singleton);
       return 1;
    endfunction
 endclass

 module top;
    m_uvm_resource_sprint_converter1#(MyClass) test;
    MyClass MyClass_inst;
    
    bit m_registered_converter__ = m_uvm_resource_sprint_converter1#(MyClass)::register();
    initial begin
        MyClass_inst=new("MyClass_inst");
        
        // $display("result [%0d]output string is %s",m_registered_converter__,m_uvm_resource_sprint_converter1#(MyClass)::m_singleton.convert2string(MyClass_inst));
        $display("%s",m_uvm_resource_sprint_converter1#(MyClass)::m_singleton.convert2string(MyClass_inst));
        
        // uvm_resource_pool::get().print_resources();
    end
 endmodule