`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mytransaction.sv"
import uvm_pkg::*;
//  Class: mydriver
//
class mydriver extends uvm_driver#(mytransaction);
    virtual delay_interface vif;
    `uvm_component_utils(mydriver)
    function new(string name="mydriver",uvm_component parennt);    
        super.new(name,parennt);
    endfunction //new()


    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    //  Function: run_phase
    extern task run_phase(uvm_phase phase);
    extern task drive_one_pkg(mytransaction tr);
endclass 

function void mydriver::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);
    if(!uvm_config_db#(virtual delay_interface)::get(this,"","vif",vif))
        `uvm_fatal(get_type_name(),"didn't get handle to virtual interface vif!!")
    
endfunction: build_phase
task mydriver::run_phase(uvm_phase phase);
    vif.data=0;
    vif.valid=0;
    vif.delay_times=0;
    `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
    @(posedge vif.clk);

    while(~vif.rst_n)begin
        $display("[%0d]  ready[%0d] Waiting rst_n--%0d",$time,vif.ready,vif.rst_n);
        @(posedge vif.clk);
        $display("Waiting rst_n");
    end//等复位好
    while(1)begin
        
        seq_item_port.get_next_item(req);//这些代码应该都是固定的
        // req.print();
        if (req==null)begin
            
            $display("null req");
        end
        else begin//逻辑非常简单，如果下层准备好接受数据，那么就把这个tr发过去，否则
                wait(vif.ready==1);
                drive_one_pkg(req);
                // while(~vif.ready)begin//只有当ready下层准备好了才能将数据打过去，不然就一直等着
                //     $display("tr.valid is %0d",req.valid);
                //     @(posedge vif.clk);

                // end
                
                

        end
        seq_item_port.item_done();
    end
    
endtask: run_phase

task mydriver::drive_one_pkg(mytransaction tr);
    
        @(posedge vif.clk);
        vif.data<=tr.data;
        vif.valid<=tr.valid;
        vif.delay_times<=tr.delay_times;
        
endtask