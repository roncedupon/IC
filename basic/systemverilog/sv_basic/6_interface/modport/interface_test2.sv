interface port(input clk,input rstn);
    modport sData(input clk,rstn);
    // modport mData(output clk,rstn);//再修改port得输出方向会报错
endinterface


module test_md1(
    port.sData port1,
    port.sData port2
    // port port2
);
reg a;
always@(posedge port1.clk)begin
    a<=1;
end
endmodule
module top(input clk,input rstn);
    port port_inst(clk,rstn);
    test_md1 test_md1(.port1(port_inst),.port2(port_inst));//打开verdi可以看到test_md1包含了两个clk和rst

endmodule
module tb;
    reg clk;
    reg rstn;
    always#5 clk=~clk;
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,tb);
        #1000
        $finish;
    end
    top top(.clk(clk),.rstn(rstn));
endmodule
