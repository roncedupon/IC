`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//问题描述：set_inst_override_by_type只能用相对路径，不能用绝对路径
class father extends uvm_component;
    `uvm_component_utils(father)
    
    function new(string name="father",uvm_component parent);
        super.new(name,parent);
    endfunction
    virtual function void fun1();
        $display("this is fun1 in father");
    endfunction
    function void fun2();
        $display("this is fun2 in father");
    endfunction
endclass
class son extends father;
    `uvm_component_utils(son)
    function new(string name="son",uvm_component parent);
        super.new(name,parent);
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
        if(1)begin//相对路径
            // set_inst_override("father_inst","father","son");//"uvm_test_top.father_inst"     $sformatf("%s.father_inst",get_full_name())
            set_inst_override("father_inst",father::type_name,son::type_name);//"uvm_test_top.father_inst"     $sformatf("%s.father_inst",get_full_name())
            
        end
        else begin//绝对路径
            set_inst_override($sformatf("%s.father_inst",get_full_name()),"father","son");//"uvm_test_top.father_inst"     $sformatf("%s.father_inst",get_full_name())
            $display("abs path of father is %s======",$sformatf("%s.father_inst",get_full_name()));
            // set_inst_override_by_type("uvm_test_top.father_inst",father::get_type(),son::get_type());
        end
        
        father_inst=father::type_id::create("father_inst",this);
        son_inst=son::type_id::create("son_inst",this);
        $display("father type is %s;son type is %s",father::type_name,son::type_name);
        $display("father_inst type is %s;son_inst type is %s",father_inst.get_type_name(),son_inst.get_type_name());//即重载不改变类型的名称，但是会改变实例的类型名称
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
        // set_inst_override_by_type("env_inst.father_inst",father::get_type(),son::get_type());//"uvm_test_top.father_inst"
        set_inst_override_by_type("uvm_test_top.env_inst.father_inst",father::get_type(),son::get_type());//"uvm_test_top.father_inst",换了这里的绝对路径，还要看看myenv中的重载有没有注掉
        env_inst=myenv::type_id::create("env_inst",this);
        
    endfunction
endclass
module top;

    initial begin
        
        run_test("myenv");
        // run_test("mycase");
    end
endmodule