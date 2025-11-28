`ifndef TEST_ROOT
`define TEST_ROOT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "tlm_tr.sv"
import uvm_pkg::*;
//这个版本是在上一个版本的基础上进行修改，手动为id赋值，并且没有再在new函数里添加参数
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
        uvm_component son_tmp0;
        uvm_component son_tmp1;
        uvm_component son_queue[$];
        super.run_phase(phase);

        //=========================================================================================================
        son_tmp0=get_child("son0");
        son_tmp1=get_child("son1");
        `uvm_info("get_child",$sformatf("son_tmp0.father is %s",son_tmp0.get_parent().get_full_name()),UVM_LOW);
        `uvm_info("get_child",$sformatf("son_tmp1.father is %s",son_tmp1.get_parent().get_full_name()),UVM_LOW);
        //=========================================================================================================

        get_children(son_queue);
        foreach(son_queue[i])
            `uvm_info($sformatf("son%0d",i),$sformatf("son_queue%0d.father is %s",i,son_queue[i].get_parent().get_full_name()),UVM_LOW);



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


module top;
    initial begin
        run_test("father");
    end
endmodule

`endif