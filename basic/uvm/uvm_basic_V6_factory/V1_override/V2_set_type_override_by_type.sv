`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class father extends uvm_object;
    `uvm_object_utils(father)
    
    function new(string name="father");
        super.new(name);
    endfunction
    virtual function void fun1();
        $display("this is fun1 in fateher");
    endfunction
    function void fun2();
        $display("this is fun2 in father");
    endfunction
endclass
class son extends father;
    `uvm_object_utils(son)
    function new(string name="son");
        super.new(name);
    endfunction
    function void fun1();
        $display("this is fun1 in son");
    endfunction

    function void fun2();
        $display("this is fun2 in son");
    endfunction
    function void fun3();
        $display("this is fun3 in son");
    endfunction
endclass
class mycase extends uvm_component;
    `uvm_component_utils(mycase)
    son son_inst;
    father father_inst;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        son son_inst;
        father father_inst;
        super.build_phase(phase);
        set_type_override_by_type(father::get_type(),son::get_type());
        father_inst=father::type_id::create("father_inst");
        son_inst=son::type_id::create("son_inst");
        // set_type_override_by_type(father::get_type(),son::get_type());
        print(father_inst);
        $display("----------------");
        print(son_inst);

    endfunction
    function void print(father ptr);
        ptr.fun1();
        ptr.fun2();
        // ptr.fun3();
    endfunction
endclass
module top;

    initial begin
        run_test("mycase");
    end
endmodule