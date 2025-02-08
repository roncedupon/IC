`ifndef DRIVER
`define DRIVER
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction.sv"
`include "SoftMax_Funs.sv"
import uvm_pkg::*;
import SoftMax_Funs::*;
//driver从Trnasaction中获取一张图片，然后再将该图片打到dut内
class driver extends uvm_driver#(SoftMax_Transaction);//所有的driver均需要继承自uvm_driver
    
    virtual Axis vif;
    logic ren;//读使能
    logic [31:0]cnt;
    
    `uvm_component_utils(driver)//factory机制，注册
    function new(string name="SoftMax_Driver",uvm_component parent=null);//首先实现构造函数
        super.new(name,parent);//调用父类的构造函数
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("SoftMax_Driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual Axis)::get(this, "", "vif", vif))
           `uvm_fatal("SoftMax_Driver", "virtual interface must be set for vif!!!")
     endfunction
    extern virtual task main_phase(uvm_phase phase);//main phase来自uvm_component
    extern task drive_one_pkg(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);//main phase来自uvm_component
    extern task drive_one_pkg_field_automation(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);
endclass

task driver::main_phase(uvm_phase phase);
    // logic [31:0]cnt;
    int dataNums=197;
    SoftMax_Transaction Matrix_In;//Transcation 从txt中读取一段完整的矩阵数据
                        //driver将这笔数据打到dut中
    // Matrix_In=new("SoftMax_Input");

    `uvm_info("start drive data","main_phase is called",UVM_LOW);

    // req=new("req");
    vif.Data<='d0;
    vif.Valid<='d0;
    vif.cnt=0;
    vif.Last<=0;
    ren<=0;
    cnt<=0;
    while(~vif.rstn)begin@(posedge vif.clk);$display("waiting rst");end
    while(1)begin
        seq_item_port.get_next_item(req);//req是uvm_driver中预先定义好的成员变量,所以可以直接拿来用
                                            //当然这里也可以给req换一个名字,但是这样的话就需要重新声明了
        drive_one_pkg(req);
        seq_item_port.item_done();
        $display("seq_item_port.item_done()");
    end
   

    
endtask

task driver::drive_one_pkg(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);//加入field_automation之前
    bit[63:0]data_q[$];
    byte unsigned test[];
    int data_size;
    data_size=tr.pack_bytes(test)/8;//需要注意这里返回的是bit数（小b)，所以为了获取字节数，还需要除以8
    $display("data_size is %d",data_size);
    $display("data_size is %d",data_size);
    $display("data_size is %d",data_size);
    
    // bit[63:0]Matrix[0:4096];
    // $readmemh("Softmax_tensors.txt",Matrix);
    for(int i=0;i<Matrix_Row*div_ceil(Matrix_Col,8);i=i+1)begin
        data_q.push_back(tr.Matrix[i]);
    end

    
    while(data_q.size()>0)begin
        // `uvm_info("data size is%d",data_q.size(),UVM_LOW);
        @(posedge vif.clk);
        vif.Valid<=1;
        if(vif.Ready)begin//如果ready拉低，则不往外面吐数据
            vif.Data<=data_q.pop_front();
        end
    end
    vif.Last<=1;//#todo--关于仿真时间的问题
    @(posedge vif.clk)
    vif.Valid<=0;
    vif.Last<=0;
    for(int i=0;i<div_ceil(Matrix_Col,8)*10;i=i+1)begin
        @(posedge vif.clk);
    end

endtask
task driver::drive_one_pkg_field_automation(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);//加入field_automation之前
    bit[63:0]data_q[$];
   
    // bit[63:0]Matrix[0:4096];
    // $readmemh("Softmax_tensors.txt",Matrix);
    

    for(int i=0;i<Matrix_Row*div_ceil(Matrix_Col,8);i=i+1)begin
        data_q.push_back(tr.Matrix[i]);
    end

    while(~vif.rstn)@(posedge vif.clk);
    while(data_q.size()>0)begin
        // `uvm_info("data size is%d",data_q.size(),UVM_LOW);
        @(posedge vif.clk);
        vif.Valid<=1;
        if(vif.Ready)begin//如果ready拉低，则不往外面吐数据
            vif.Data<=data_q.pop_front();
        end
    end
    vif.Last<=1;//#todo--关于仿真时间的问题
    @(posedge vif.clk)
    vif.Valid<=0;
    vif.Last<=0;
    for(int i=0;i<div_ceil(Matrix_Col,8)*10;i=i+1)begin
        @(posedge vif.clk);
    end

endtask


`endif
