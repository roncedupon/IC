interface port(input clk,input rstn);
    // modport sData(input clk,rstn);
    modport mData(output clk,rstn);//再修改port得输出方向会报错
endinterface

module test_md1(
    port port1,
    port port2
    // port port2
);
reg a;
always@(posedge port1.clk)begin
    a<=1;
end
endmodule
module top;
    port port_inst(clk,rstn);
endmodule

