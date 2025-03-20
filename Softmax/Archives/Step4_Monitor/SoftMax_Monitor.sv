`ifndef SOFTMAX_MONITOR
`define SOFTMAX_MONITOR
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "interfaces.sv"
`include "SoftMax_Transaction_Out.sv"
import uvm_pkg::*;

class SoftMax_Monitor extends uvm_monitor;
    //在验证平台中，monitor负责检测DUT的行为，
    //driver负责把transaction 级别的数据转变为DUT的端口级别,monitor与其相对,用于收集DUT的端口数据
            //并将其转换成transaction 交给后续的组件如reference model,scoreboard
    virtual sAxis vif;
    `uvm_component_utils(SoftMax_Monitor);
    function new(string name="SoftMax_Monitor",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(~uvm_config_db#(virtual sAxis)::get(this,"","vif",vif))//连接虚拟接口vif
            `uvm_fatal("SoftMax_Monitor", "vif is not set");
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkg(SoftMax_Transaction_Out tr);
endclass


task SoftMax_Monitor::main_phase(uvm_phase phase);
    SoftMax_Transaction_Out tr;
    while(1)begin
        tr=new("tr");
        collect_one_pkg(tr);
    end
endtask

task SoftMax_Monitor::collect_one_pkg(SoftMax_Transaction_Out tr);
    bit[63:0]data_q[$];
    int i=0;
    while(1)begin
        @(posedge vif.clk)
        if(vif.sValid)begin
            data_q.push_back(vif.sData);
            $display("%d--%h\n",data_q.size(),vif.sData);
        end
        if(vif.sLast)begin 
            `uvm_info("Last","slast detect",UVM_LOW);
            break;
        end
        i=i+1;//用于统计接收到的数据
    end
    i=0;
    while(data_q.size())begin//这里不能用for(int i=0;i<data_q.size();i=i+1)做循环，因为data_q.size()会变
        tr.Matrix[i]=data_q.pop_front();
        $display("data_q.size() is %d |tr.Matrix[%d] is %h\n",data_q.size(),i,tr.Matrix[i] );
        i=i+1;
    end
    tr.DumpData(i);//将Softmax的输出导出到txt文件


endtask
`endif
