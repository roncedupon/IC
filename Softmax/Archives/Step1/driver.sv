`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
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
endclass

task driver::main_phase(uvm_phase phase);
    // logic [31:0]cnt;
    int dataNums=197;
    
    phase.raise_objection(this);//所有局部变量必须定义在这句话之前
    `uvm_info("start drive data","main_phase is called",UVM_LOW);
    vif.mData<='d0;
    vif.mValid<='d0;
    vif.cnt=0;
    ren<=0;
    cnt<=0;
    
    
    while(!vif.rstn)begin
        @(posedge vif.clk);
        
    end

    while(cnt<dataNums)begin
        int sim_timeout = 10000; // 设置超时时间为100个时间单位
        if(cnt==dataNums-1&&ren)begin
            ren<=0;
        end
        else if(cnt<dataNums)ren<=$random%2;
        @(posedge vif.clk);//等待一个时钟上升沿
        if ($time >= sim_timeout) begin
            `uvm_warning("SIM_TIMEOUT", $sformatf("Simulation timeout (%0t) reached!", $time));
            // 触发超时操作，例如报警或执行清理操作
            $finish; // 结束仿真
        end
        
        // $display("%d  [valid]%d  [cnt]%d  [vif.cnt]%d  %d",$time,vif.mValid, cnt,vif.cnt,vif.mData);
        

        // $display("%d",ren);
        vif.mValid<=ren;
        
        if(vif.mReady&ren)begin
            cnt<=cnt+1;
            vif.mData <= {{$random},{$random}};
        end
        else begin
            vif.mData<=vif.mData;
        end
        vif.cnt=cnt;
        
        
    end
    @(posedge vif.clk);
    vif.mValid<=1'b0;
    @(posedge vif.clk);
    @(posedge vif.clk);
    @(posedge vif.clk);
    @(posedge vif.clk);
    phase.drop_objection(this);
    
endtask
