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
class son1 extends father;
    `uvm_object_utils(son1)
    function new(string name="son1");
        super.new(name);
    endfunction
    function void fun1();
        $display("this is fun1 in son1");
    endfunction

    function void fun2();
        $display("this is fun2 in son1");
    endfunction
    function void fun3();
        $display("this is fun3 in son1");
    endfunction
endclass
class son2 extends father;
    `uvm_object_utils(son2)
    function new(string name="son2");
        super.new(name);
    endfunction
    function void fun1();
        $display("this is fun1 in son2");
    endfunction

    function void fun2();
        $display("this is fun2 in son2");
    endfunction
    function void fun3();
        $display("this is fun3 in son2");
    endfunction
endclass
class mycase extends uvm_component;
    `uvm_component_utils(mycase)
    // son1 son1_inst;
    // son2 son2_inst;
    father father_inst;

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        set_type_override_by_type(father::get_type(),son1::get_type());//先将father替换成son1，再将son1替换成son2
        set_type_override_by_type(son1::get_type(),son2::get_type(),1);
        // set_type_override_by_type(father::get_type(),son1::get_type());
        father_inst=father::type_id::create("father_inst");
        // son1_inst=son1::type_id::create("son1_inst");//去掉son1的实例化
        // son2_inst=son2::type_id::create("son2_inst");

        print(father_inst);
        $display("----------------");
        // print(son1_inst);        
        // $display("----------------");
        // print(son2_inst);

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
    // initial begin
    //     gs=new("gs");
    //     fd=gs;
    //     fd.fun1();
    // end
endmodule