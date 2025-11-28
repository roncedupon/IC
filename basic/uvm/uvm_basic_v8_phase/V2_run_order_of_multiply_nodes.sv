//test running order of different phases
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef class son1;
typedef class son2;
class father extends uvm_component;//create a father
    string tID=get_type_name();
    `uvm_component_utils(father)
    son1 son_inst1;
    son2 son_inst2;
    function new(string name="father",uvm_component parent );
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase); 
       
    //    super.build_phase(phase);
       son_inst1=new("son_inst1",this);
       son_inst2=new("son_inst2",this);
       `uvm_info(tID, "build_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void connect_phase(uvm_phase phase); 
       super.connect_phase(phase);
       `uvm_info(tID, "connect_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void end_of_elaboration_phase(uvm_phase phase); 
       super.end_of_elaboration_phase(phase);
       `uvm_info(tID, "end_of_elaboration_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void start_of_simulation_phase(uvm_phase phase); 
       super.start_of_simulation_phase(phase);
       `uvm_info(tID, "start_of_simulation_phase is executed", UVM_LOW)
    endfunction 
   
    virtual task run_phase(uvm_phase phase);
       `uvm_info(tID, "run_phase is executed", UVM_LOW)
    endtask
 
    virtual task pre_reset_phase(uvm_phase phase);
       `uvm_info(tID, "pre_reset_phase is executed", UVM_LOW)
    endtask
 
    virtual task reset_phase(uvm_phase phase);
       `uvm_info(tID, "reset_phase is executed", UVM_LOW)
    endtask
 
    virtual task post_reset_phase(uvm_phase phase);
       `uvm_info(tID, "post_reset_phase is executed", UVM_LOW)
    endtask
 
    virtual task pre_configure_phase(uvm_phase phase);
       `uvm_info(tID, "pre_configure_phase is executed", UVM_LOW)
    endtask
 
    virtual task configure_phase(uvm_phase phase);
       `uvm_info(tID, "configure_phase is executed", UVM_LOW)
    endtask
 
    virtual task post_configure_phase(uvm_phase phase);
       `uvm_info(tID, "post_configure_phase is executed", UVM_LOW)
    endtask
 
    virtual task pre_main_phase(uvm_phase phase);
       `uvm_info(tID, "pre_main_phase is executed", UVM_LOW)
    endtask
 
    virtual task main_phase(uvm_phase phase);
       `uvm_info(tID, "main_phase is executed", UVM_LOW)
    endtask
 
    virtual task post_main_phase(uvm_phase phase);
       `uvm_info(tID, "post_main_phase is executed", UVM_LOW)
    endtask
 
    virtual task pre_shutdown_phase(uvm_phase phase);
       `uvm_info(tID, "pre_shutdown_phase is executed", UVM_LOW)
    endtask
 
    virtual task shutdown_phase(uvm_phase phase);
       `uvm_info(tID, "shutdown_phase is executed", UVM_LOW)
    endtask
 
    virtual task post_shutdown_phase(uvm_phase phase);
       `uvm_info(tID, "post_shutdown_phase is executed", UVM_LOW)
    endtask
 
    virtual function void extract_phase(uvm_phase phase); 
       super.extract_phase(phase);
       `uvm_info(tID, "extract_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void check_phase(uvm_phase phase); 
       super.check_phase(phase);
       `uvm_info(tID, "check_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void report_phase(uvm_phase phase); 
       super.report_phase(phase);
       `uvm_info(tID, "report_phase is executed", UVM_LOW)
    endfunction 
 
    virtual function void final_phase(uvm_phase phase); 
       super.final_phase(phase);
       `uvm_info(tID, "final_phase is executed", UVM_LOW)
    endfunction 
endclass
class son1 extends father;
    `uvm_component_utils(son1)
    function new(string name="son1",uvm_component parent );
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase); 
       
        //    super.build_phase(phase);
        //    son_inst1=new("son_inst1",this);
           `uvm_info(tID, "build_phase is executed", UVM_LOW)
        endfunction 
endclass
class son2 extends father;
    `uvm_component_utils(son2)
    function new(string name="son2",uvm_component parent );
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase); 
       
        //    super.build_phase(phase);
        //    son_inst1=new("son_inst1",this);
           `uvm_info(tID, "build_phase is executed", UVM_LOW)
        endfunction 
endclass
module top;
    initial begin
        run_test("father");
    end
endmodule