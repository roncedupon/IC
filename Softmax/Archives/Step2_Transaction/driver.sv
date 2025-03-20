`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction.sv"
import uvm_pkg::*;
//driver从Trnasaction中获取一张图片，然后再将该图片打到dut内
class driver extends uvm_driver;//所有的driver均需要继承自uvm_driver
    
    virtual mAxis vif;
    logic ren;//读使能
    logic [31:0]cnt;
    
    `uvm_component_utils(driver)//factory机制，注册
    function new(string name="SoftMax_Driver",uvm_component parent=null);//首先实现构造函数
        super.new(name,parent);//调用父类的构造函数
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("SoftMax_Driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual mAxis)::get(this, "", "vif", vif))
           `uvm_fatal("SoftMax_Driver", "virtual interface must be set for vif!!!")
     endfunction
    extern virtual task main_phase(uvm_phase phase);//main phase来自uvm_component
    extern task drive_one_pkg(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);//main phase来自uvm_component
endclass

task driver::main_phase(uvm_phase phase);
    // logic [31:0]cnt;
    int dataNums=197;
    SoftMax_Transaction Matrix_In;//Transcation 从txt中读取一段完整的矩阵数据
                        //driver将这笔数据打到dut中
    Matrix_In=new("SoftMax_Input");
    phase.raise_objection(this);//所有局部变量必须定义在这句话之前
    `uvm_info("start drive data","main_phase is called",UVM_LOW);
    drive_one_pkg(Matrix_In);
    phase.drop_objection(this);
    
endtask

task driver::drive_one_pkg(SoftMax_Transaction tr,int Matrix_Row=197,int Matrix_Col=197);
    bit[63:0]data_q[$];
    // bit[63:0]Matrix[0:4096];
    // $readmemh("Softmax_tensors.txt",Matrix);
    for(int i=0;i<Matrix_Row*(Matrix_Col/8+1);i=i+1)begin
        data_q.push_back(tr.Matrix[i]);
    end

    while(~vif.rstn)@(posedge vif.clk);
    while(data_q.size()>0)begin
        // `uvm_info("data size is%d",data_q.size(),UVM_LOW);
        @(posedge vif.clk);
        vif.mValid<=1;
        if(vif.mReady)begin//如果ready拉低，则不往外面吐数据
            vif.mData<=data_q.pop_front();
        end
    end

endtask
