`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//错误描述：father和son是uvm_object类型的对象，set_inst_override_by_type不可用
class father extends uvm_object;
    `uvm_object_utils(father)
    
    function new(string name="father");
        super.new(name);
    endfunction
    virtual function void fun1();
        $display("this is fun1 in father");
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
class myenv extends uvm_component;
    `uvm_component_utils(myenv)
    son son_inst;
    father father_inst;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        son son_inst;
        father father_inst;
        super.build_phase(phase);
        // set_inst_override_by_type("uvm_test_top.env_inst.father_inst",father::get_type(),son::get_type());//"uvm_test_top.father_inst"     $sformatf("%s.father_inst",get_full_name())
        // set_type_override_by_type(father::get_type(),son::get_type());
        $display("%s======",get_full_name());
        father_inst=father::type_id::create("father_inst");
        son_inst=son::type_id::create("son_inst");
        print(father_inst);
        $display("----------------");
        print(son_inst);

    endfunction
    virtual function void connect_phase(uvm_phase phase);
        // father_inst.print_override_info("father");
    endfunction
    function void print(father ptr);
        ptr.fun1();
        ptr.fun2();
        // ptr.fun3();
    endfunction
endclass
class mycase extends uvm_component;
    `uvm_component_utils(mycase)
    myenv env_inst;
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_inst_override_by_type("env_inst.father_inst",father::get_type(),son::get_type());//"uvm_test_top.father_inst"
        env_inst=myenv::type_id::create("env_inst",this);
        
    endfunction
endclass
module top;

    initial begin
        
        run_test("mycase");
    end
endmodule