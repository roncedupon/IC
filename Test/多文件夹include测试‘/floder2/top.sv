`include "base.sv"
`include "iverilogTest.sv"

module Test;
    BaseClass base;
    DerivedClass derived;
  
    initial begin
      base = new();
      derived = new();
  
      base.data = 10;
      derived.data = 20;
      derived.moreData = 30;
  
      base.display();
      derived.display();
    end
endmodule;


//iverilog -y /home/dy/IC_Learning/IC/Test/floder1/ -y /home/dy/IC_Learning/IC/Test/floder2/  top.sv
