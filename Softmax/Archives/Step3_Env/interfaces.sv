//一些接口

`ifndef Interface
    `define Interface
interface mAxis#(parameter width=64)(input clk,input rstn);//数据接口：data interface
    logic [width-1:0]mData;
    logic mValid;
    logic mReady;
    logic [31:0]cnt;
endinterface
`endif 
