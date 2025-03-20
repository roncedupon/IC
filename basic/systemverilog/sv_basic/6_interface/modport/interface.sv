interface apb_if(input clk);
    logic [31:0] paddr;
    logic [31:0] pwdata;
    logic [31:0] prdata;
    logic penable;
    logic pwrite;
    logic psel;
endinterface
interface myBus(input clk);
    logic [7:0]data;
    logic enable;
    modport TB(input data,clk,output enable);
    modport DUT(output data,input enable,clk);
endinterface
//使用port并对port进行连接
module dut(myBus busIf);
    always@(posedge busIf.clk)begin
        if(busIf.enable)
            busIf.data<=busIf.data+1;
        else
            busIf.data<=0;
    end
endmodule

module tb_top;
    bit clk;
    always#10 clk=~clk;
    myBus busIf(clk);

    dut dut0(busIf.DUT);

    initial begin  
        busIf.enable<=0;
        #10 busIf.enable<=1;
        #40 busIf.enable<=0;
        #20 busIf.enable<=1;
        #100 $finish;
    end
endmodule