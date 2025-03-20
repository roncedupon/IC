`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//这个版本有错误，因为想给new函数加参数，但是好像不能这样来
typedef class son;//告诉编译器son的定义在后面
class father extends uvm_component;
    son son0;
    son son1;
    `uvm_component_utils(father)
    function new(string name="father",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        son0=son::type_id::create("son0",this,0);//←←←有问题的代码在这←←←
        son1=son::type_id::create("son1",this,1);//←←←有问题的代码在这←←←
        `uvm_info("father",$sformatf("%s",this.get_full_name()),UVM_LOW);
        `uvm_info("father","UVM_LOW",UVM_LOW);
        `uvm_info("father","MEDIUM",UVM_MEDIUM);
        `uvm_info("father","HIGH",UVM_HIGH);
        // $display("full name is %s",this.get_full_name());
        `uvm_info("father",$sformatf("this.father is %s",this.get_parent().get_full_name()),UVM_LOW);
    endfunction
endclass


class son extends uvm_component;
    int id;
    `uvm_component_utils(son)
    function new(string name="son",uvm_component parent=null,int sonId);//←←←有问题的代码在这←←←
        super.new(name,parent);
        id=sonId;
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info($sformatf("son%0d",id),$sformatf("%s",this.get_full_name()),UVM_LOW);
        `uvm_info($sformatf("son%0d",id),$sformatf("this.father is %s",this.get_parent().get_full_name()),UVM_LOW);
    endfunction
endclass


module top;
    initial begin
        run_test("father");
    end
endmodule

`endif