`timescale 1ns/1ps
module test ();
reg [255:0] testname;
reg [31:0] num;
initial begin
   if ($value$plusargs("TESTNAME=%s", testname))
       $display("Running test {%0s}......", testname);
    else 
        testname="123_str";
   if ($value$plusargs("num=%d", num))
       $display("num= {%0d}......", num);
    else
        num=456;
    $display("%s---%0d",testname,num+3);

end
endmodule