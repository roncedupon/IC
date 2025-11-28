interface myBus#(parameter WIDTH = 8, parameter MAX_DELAY = 16)(input clk);
    logic [WIDTH-1:0]data;
    logic enable;
    modport TB(input data,clk,output enable);
    modport DUT(output data,input enable,clk);
endinterface
module dut(myBus.DUT busIf);
    always@(posedge busIf.clk)begin
        if(busIf.enable)
            busIf.data<=busIf.data+1;
        else
            busIf.data<=0;
    end
    initial begin
        $display("=======%0d",$bits(busIf.data));
    end
endmodule
module top;
    reg clk;
    always #5 clk=~clk;
    myBus#(16,24) inf(clk);
    dut dut(inf);
    initial begin
        #1000
        $finish;
    end
endmodule