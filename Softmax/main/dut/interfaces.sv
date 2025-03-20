//一些接口

`ifndef Interface
    `define Interface
interface Axis#(parameter width=64)(input clk,input rstn);//数据接口：data interface
    logic [width-1:0]Data;
    logic Valid;
    logic Ready;
    logic Last;
    logic [31:0]cnt;
endinterface

// interface sAxis#(parameter width=64)(input clk,input rstn);//数据接口：data interface
//     logic [width-1:0]sData;
//     logic sValid;
//     logic sReady;
//     logic sLast;
//     logic [31:0]cnt;
// endinterface
`endif 
