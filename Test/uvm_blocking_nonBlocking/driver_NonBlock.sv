`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

interface mAxis#(parameter width=64)(input clk,input rstn);//数据接口：data interface
    logic [width-1:0]mData;
    logic mValid;
    logic mReady;
endinterface



class driver extends uvm_driver;//所有的driver均需要继承自uvm_driver
    
    virtual mAxis vif;
    `uvm_component_utils(driver)//factory机制，注册
    function new(string name="Mydriver",uvm_component parent=null);//首先实现构造函数
        super.new(name,parent);//调用父类的构造函数
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Mydriver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual mAxis)::get(this, "", "vif", vif))
           `uvm_fatal("Mydriver", "virtual interface must be set for vif!!!")
     endfunction
    extern virtual task main_phase(uvm_phase phase);//main phase来自uvm_component
endclass

task driver::main_phase(uvm_phase phase);
    logic [31:0]cnt;
    int dataNums=197;
    phase.raise_objection(this);
    `uvm_info("start drive data","main_phase is called",UVM_LOW);
    vif.mData<='d0;
    vif.mValid<='d0;
    cnt=0;

    while(!vif.rstn)begin
        @(posedge vif.clk);
        
    end

    while(cnt<dataNums)begin
        int sim_timeout = 10000; // 设置超时时间为100个时间单位
        if ($time >= sim_timeout) begin
            `uvm_warning("SIM_TIMEOUT", $sformatf("Simulation timeout (%0t) reached!", $time));
            // 触发超时操作，例如报警或执行清理操作
            $finish; // 结束仿真
        end


        vif.mData <= $urandom_range(255, 0);

        if(vif.mReady&&vif.mValid)begin
            cnt=cnt+1;
        end
        if(cnt<dataNums)
            vif.mValid<=1'b1;
        else
            vif.mValid<=1'b0;

        @(posedge vif.clk);//等待一个时钟上升沿
    end
    vif.mValid<=1'b0;
    @(posedge vif.clk);
    @(posedge vif.clk);
    @(posedge vif.clk);
    @(posedge vif.clk);
    phase.drop_objection(this);
    
endtask



module Tb;
//生成激励
reg clk;
reg rstn;
   
initial begin
    clk=0;
    rstn=1'b0;

    #1000
    rstn=1'b1;

end


//例化VIF
mAxis input_if(clk,rstn);


always#5 clk=~clk;//100M时钟

initial begin
    run_test("driver");
    
end
initial begin
    // run_test("my_dirver");
    uvm_config_db#(virtual mAxis)::set(null,"uvm_test_top","vif",input_if);//初始化interface
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,Tb);
   
    $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
    $dumpvars(0,Tb);
end

//对从driver拿到的数据打一拍

logic mValid_dly;
logic mReady_dly;
logic [63:0]mData_dly;

always@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        mValid_dly<=0;
        mData_dly<=0;
        mReady_dly<=0;
    end
    else begin
        mValid_dly<=input_if.mValid;
        mData_dly<=input_if.mData;
        input_if.mReady<=1'b1;
    end
end


endmodule
