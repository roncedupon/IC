//
interface test_if();
    logic clk;
    logic a;
    logic b;
    logic c;
endinterface

module adder(
    input clk,
    input a,
    input b,
    output  c
);
// always@(posedge clk)
//  c=a+b;
 assign  c=a+b;
endmodule

module wrapper(test_if vif,input clk);
    assign vif.clk=clk;
    adder(.a(vif.a));
    adder(.b(vif.b));
    adder(.c(vif.c));
endmodule

module top;
reg clk;
test_if vif();
initial begin
    clk=0;
    #1000
    $finish;
end
always#5 clk=~clk;
;
wrapper(.vif(vif),.clk(clk));
endmodule