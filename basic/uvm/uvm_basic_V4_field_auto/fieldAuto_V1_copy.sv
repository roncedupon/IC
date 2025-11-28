`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//研究=和copy之间的区别
typedef class son;//告诉编译器son的定义在后面
typedef class myObj;//告诉编译器myObj的定义在后面
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
        son0.id=0;
        son1.id=1;
        `uvm_info("father",$sformatf("%s",this.get_full_name()),UVM_LOW);
        `uvm_info("father","UVM_LOW",UVM_LOW);
        `uvm_info("father","MEDIUM",UVM_MEDIUM);
        `uvm_info("father","HIGH",UVM_HIGH);
        // $display("full name is %s",this.get_full_name());
        `uvm_info("father",$sformatf("this.father is %s",this.get_parent().get_full_name()),UVM_LOW);
    endfunction
    virtual task run_phase(uvm_phase phase);
        son son_tmp0;
        // son son_tmp1=new();
        myObj obj_tmp0;
        myObj obj_tmp1;
        super.run_phase(phase);
        
        son_tmp0=son0;
        `uvm_info("son_tmp0",$sformatf("son_tmp0.id is %d",son_tmp0.id),UVM_LOW);
        son_tmp0.id=123;
        `uvm_info("son0",$sformatf("son0.id is %d",son0.id),UVM_LOW);
        // UVM_INFO uvm_basic_V1_copy.sv(36) @ 0: uvm_test_top [son_tmp0] son_tmp0.id is           0
        // UVM_INFO uvm_basic_V1_copy.sv(38) @ 0: uvm_test_top [son0] son0.id is         123

        obj_tmp0=new();
        obj_tmp1=new();
        obj_tmp0.data=321;
        obj_tmp1.copy(obj_tmp0);
        `uvm_info("obj_tmp0",$sformatf("obj_tmp0.data is %d",obj_tmp0.data),UVM_LOW);
        `uvm_info("obj_tmp1",$sformatf("obj_tmp1.data is %d",obj_tmp1.data),UVM_LOW);
        obj_tmp1.data=456;
        `uvm_info("obj_tmp0",$sformatf("obj_tmp0.data is %d",obj_tmp0.data),UVM_LOW);
        `uvm_info("obj_tmp1",$sformatf("obj_tmp1.data is %d",obj_tmp1.data),UVM_LOW);
        // UVM_INFO uvm_basic_V1_copy.sv(45) @ 0: uvm_test_top [obj_tmp0] obj_tmp0.data is         321
        // UVM_INFO uvm_basic_V1_copy.sv(46) @ 0: uvm_test_top [obj_tmp1] obj_tmp1.data is           0
        // UVM_INFO uvm_basic_V1_copy.sv(48) @ 0: uvm_test_top [obj_tmp0] obj_tmp0.data is         321
        // UVM_INFO uvm_basic_V1_copy.sv(49) @ 0: uvm_test_top [obj_tmp1] obj_tmp1.data is         456

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
    end
endmodule

`endif