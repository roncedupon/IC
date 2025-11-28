`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//研究通过field_automation机制省略get函数
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

        //↓↓↓↓↓↓↓↓↓↓↓↓被省略的get操作在这里↓↓↓↓↓↓↓↓↓↓↓↓↓
        // if(!uvm_config_db#(int)::get(this,"","id0",son0.id))
        //     `uvm_fatal("father","id has not been set")
        // if(!uvm_config_db#(int)::get(this,"","id1",son1.id))
        //     `uvm_fatal("father","id has not been set")
        //↑↑↑↑↑↑↑↑↑↑↑↑被省略的get操作在这里↑↑↑↑↑↑↑↑↑↑↑↑↑


    endfunction
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("son0",$sformatf("son0.id is %d",son0.id),UVM_LOW);
        `uvm_info("son1",$sformatf("son1.id is %d",son1.id),UVM_LOW);

    endtask
endclass
class son extends uvm_component;
    int id;
    `uvm_component_utils_begin(son)
        `uvm_field_int(id,UVM_ALL_ON)
    `uvm_component_utils_end
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
    end
    initial begin
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son0","id",123);//这里也可以试一下如果第三个参数与变量名不一样会发生什么
        uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top.son1","id",321);//这里也可以试一下如果第三个参数与变量名不一样会发生什么
    end
endmodule

`endif