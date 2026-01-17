`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
class test extends uvm_sequence_item;

    int a;
    
    function new(string name="test");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(test)  
        `uvm_field_int(a, UVM_ALL_ON)
    `uvm_object_utils_end  
endclass
class hh extends uvm_component;
    `uvm_component_utils(hh)
    test t_glb;
    
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        `uvm_info("hh","created test item",UVM_LOW)
    endfunction
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        hh_task(t_glb);
        t_glb.print();
        `uvm_info("hh",$sformatf("test item a=%0d",t_glb.a),UVM_LOW)
    endtask
    task hh_task(output test tr);
        test t_tmp = test::type_id::create("t_tmp",this);
        `uvm_info("hh","created test item inside task",UVM_LOW)
        tr=t_tmp;
    endtask
endclass
module hh;
bit [7:0] a;
hh u_hh;
    initial begin
        // for(int i=0;i<16;i=i+1)begin
        //     a=i;
        //     $display("%d:  %b",i,a>>2+|a[1:0]);//这里优先级的问题需要注意，该加括号还是得加括号
        //     $display("%d:  %b",i,(a>>2)+|a[1:0]);//除4向上取整
        // end
        run_test("hh");
    end

endmodule
