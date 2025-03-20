`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "svt_ahb_master_agent.sv"
// `include "svt_ahb_slave_agent.sv"
// `include "cust_svt_ahb_master_configuration.sv"
// `include "simpleSeq.sv"
// `include "ahb_slave_mem_response_sequence.sv"
class mytransaction extends uvm_sequence_item;
    logic[31:0]     haddr;
    logic           hready;
    logic[31:0]     hwdata;
    logic[31:0]     hrdata;
    logic[1:0]      htrans;
    logic           hwrite;
    logic[2:0]      hsize;
    logic[3:0]      hprot;
    logic[2:0]      hburst;
    
    `uvm_object_utils(mytransaction)
    function new(string name="mytransaction");
        super.new(name);
    endfunction
endclass

class mysequence extends uvm_sequence;
    `uvm_object_utils(mysequence)
    function new(string name="mysequence");
        super.new(name);
    endfunction
    extern virtual task body();
endclass

task mysequence::body();
    mytransaction tr;
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
        starting_phase.raise_objection(this);
    end
    //先发一个single过去
    tr=new("tr");
    tr.haddr=0;
    tr.hwdata=0;
    tr.htrans=2;
    tr.hsize=2;//word 32bits
    tr.hburst=0;//single transfer
    tr.hprot=0;// ?????????????
    tr.hwrite=1'b1;

    start_item(tr);
    finish_item(tr);

    //先发一个single过去
    tr=new("tr");
    tr.haddr=1;
    tr.hwdata=1;
    tr.htrans=2;
    tr.hsize=2;//word 32bits
    tr.hburst=0;//single transfer
    tr.hprot=0;// ?????????????
    tr.hwrite=1'b1;

    start_item(tr);
    finish_item(tr);

    //停止发送
    tr=new("tr");
    tr.haddr=1;
    tr.hwdata=1;
    tr.htrans=0;
    tr.hsize=2;//word 32bits
    tr.hburst=0;//single transfer
    tr.hprot=0;// ?????????????
    tr.hwrite=1'b1;

    start_item(tr);
    finish_item(tr);

    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask


class mysequencer extends uvm_sequencer#(mytransaction);
    `uvm_component_utils(mysequencer)
    function new(string name="mysequencer",uvm_component parent);
        super.new(name,parent);
    endfunction
    
endclass
class mydriver extends uvm_driver#(mytransaction);
    virtual svt_ahb_master_if vif;
    `uvm_component_utils(mydriver)
    function new(string name="mydriver",uvm_component parent);
        super.new(name,parent);
    endfunction
    extern function void build_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task drive_one_pkg(mytransaction tr);
endclass
function void mydriver::build_phase(uvm_phase phase);
    $display("in driver build_phase");
    if(!uvm_config_db#(virtual svt_ahb_master_if)::get(this,"","vif",vif))
        `uvm_fatal(get_type_name(),"didn't get handle to virtual interface vif!!")
endfunction: build_phase


task mydriver::run_phase(uvm_phase phase);
    `uvm_info("drive_one_pkg","strat drive one pkg",UVM_LOW)
    $display("restn is %0d",vif.internal_hresetn);
    $display("restn is %0d",vif.internal_hresetn);
    $display("restn is %0d",vif.internal_hresetn);
    $display("restn is %0d",vif.internal_hresetn);
    $display("restn is %0d",vif.internal_hresetn);
    $display("restn is %0d",vif.internal_hresetn);
    //先发地址和控制信号，再发数据

    // vif.hready  <=    tr.hready;
    // vif.hrdata  <=    tr.hrdata;
    vif.htrans  <=    0;
    vif.hwrite  <=    1;
    vif.hsize   <=    0;
    vif.hprot   <=    0;
    vif.hburst   <=    0;
    vif.haddr   <=    0;

    //step1 waiting reset
    while(!vif.internal_hresetn)begin
        @(posedge vif.hclk);
        `uvm_info("drive_one_pkg","waitting restn",UVM_LOW)
    end
    while(1)begin
        seq_item_port.get_next_item(req);//这些代码应该都是固定的
        // req.print();
        if (req==null)begin
            $display("null req");
        end
        else begin//逻辑非常简单，如果下层准备好接受数据，那么就把这个tr发过去，否则
            wait(vif.hready==1);
            drive_one_pkg(req);       
        end
        rsp=new("rsp");
        rsp.set_id_info(req);
        seq_item_port.put_response(rsp);
        seq_item_port.item_done();
    end
endtask: run_phase
task mydriver::drive_one_pkg(mytransaction tr);
        @(posedge vif.hclk);
        //先发地址和控制信号，再发数据
        vif.haddr   <=    tr.haddr;
        // vif.hready  <=    tr.hready;
        // vif.hrdata  <=    tr.hrdata;
        vif.htrans  <=    tr.htrans;
        vif.hwrite  <=    tr.hwrite;
        vif.hsize   <=    tr.hsize;
        vif.hprot   <=    tr.hprot;
        vif.hburst  <=    tr.hburst;

        @(posedge vif.hclk);
        vif.hwdata  <=    tr.hwdata;
endtask: drive_one_pkg
