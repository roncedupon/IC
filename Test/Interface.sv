// 研究Interface是咋用的
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;



interface my_if(input clk,input rst);//自定义接口
    logic[7:0]data;
    logic valid;
    logic ready;

    modport slave (
        input data,clk,rst,
        output ready,
        input valid
    );
    modport master (
        output data,
        output valid,
        input ready,clk,rst
    );
endinterface

module MyModule(

    my_if.slave sData,
    my_if.master mData
);
    // 在模块内部声明和使用的信号
    logic [7:0] internalData;
    logic internalValid;
    logic internalReady;
    
    // 将接口信号连接到内部信号
    assign  internalData=sData.data;
    assign sData.ready = internalReady;
    assign internalValid=sData.valid ;
    
    assign mData.data = internalData;
    assign mData.valid = internalValid;
    assign internalReady= mData.ready ;
    
    // 其他逻辑和行为
    // ...
endmodule



// //make run PROJECT_HOME=/home/dy/IC_Learning/IC/Test