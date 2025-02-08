`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//config db路径，以及设置变量值，还有config_db::set的注意事项：不能和run_test串行执行
typedef class son;//告诉编译器son的定义在后面
typedef class myObj;//告诉编译器son的定义在后面
class father extends uvm_component;
    son son0;
    son son1;
    `uvm_component_utils(father)
    function new(string name="father",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        son0=son::type_id::create("son0",this);
        son1=son::type_id::create("son1",this);
        if(!uvm_config_db#(int)::get(this,"","id0",son0.id))
            `uvm_fatal("father","id has not been set")
        if(!uvm_config_db#(int)::get(this,"","id1",son1.id))
            `uvm_fatal("father","id has not been set")

    endfunction
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("son0",$sformatf("son0.id is %d",son0.id),UVM_LOW);
        `uvm_info("son1",$sformatf("son1.id is %d",son1.id),UVM_LOW);

    endtask
endclass
class son extends uvm_component;
    int id;
    `uvm_component_utils(son)
    function new(string name="son",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info($sformatf("son%0d",id),$sformatf("%s",this.get_full_name()),UVM_LOW);
        `uvm_info($sformatf("son%0d",id),$sformatf("this.father is %s",this.get_parent().get_full_name()),UVM_LOW);
    endfunction
endclass
class myObj extends uvm_object;
    int data;
    `uvm_object_utils(myObj)
    // `uvm_object_utils_end(myObj)
    function new(string name="myObj");
        super.new(name);
    endfunction
endclass

module top;
    initial begin
        run_test("father");
        // uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top","id0",123);
        // uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top","id1",321);
    end
    initial begin
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top","id0",123);
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top","id1",321);
    end
endmodule

`endif