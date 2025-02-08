// `include "svt_ahb_if.svi"
// module data_sender(
//   svt_ahb_master_if.ahb_master_cb m_if
// );
// // assign m_if.haddr='b0;

// endmodule

// module test_top;

//   /** Signal to generate the clock */
//   bit clk;
//   reg rst_n;
//   svt_ahb_master_if mvif(clk,rst_n);//create one vif


//   initial begin
//     $fsdbDumpfile("waves.fsdb");
//     $fsdbDumpvars(0,test_top);
//   end

//   initial begin
//     clk = 0 ;
//     forever begin
//       #(10/2)
//         clk = ~clk ;
//     end
//   end
//   initial begin
//     rst_n=0;
//     #1000
//     rst_n=1;
//     #10000
//     $finish;
//   end

//   data_sender data_sender(.m_if(mvif));
// endmodule

interface adder_interface(input bit clk);
    logic     a;      // declare port signal
    logic     b;
    logic     cin;
    logic     cout;
    logic     sum;
    
    clocking cp @(posedge clk);  // declare which signals are triggered at the rising edge of the clk
      default input #1 output #2;
      output  a, b, cin;
    endclocking
  
    clocking cn @(negedge clk);  // declare which signals are triggered at the falling edge og the clk
      input   a, b, cin, cout, sum;
    endclocking
  
    modport simulus (clocking cp);
    modport adder   (input a, b, cin, output cout, sum);
    modport monitor (clocking cn);
  
  endinterface
  module simulus(adder_interface.simulus port);
    always @(port.cp.clk) begin
      port.cp.a   <= $random() % 2;
      port.cp.b   <= $random() % 2;
      port.cp.cin <= $random() % 2;
    end
  endmodule
  module adder(adder_interface.adder port);
    assign {port.cout, port.sum} = port.a + port.b + port.cin;
  endmodule
  module monitor(adder_interface.monitor mon);
    always @(mon.cn) begin
      $display("%0t: %d + %d + %d = %d %d", $time, mon.cn.a, mon.cn.b, mon.cn.cin, mon.cn.cout, mon.cn.sum);
    end
  endmodule
  
  module test_top();
    bit clk = 0;
    always #10 clk = ~clk;
    initial begin
      $fsdbDumpfile("waves.fsdb");
      $fsdbDumpvars(0,test_top);
    end
    initial begin
      #10000
      $finish;
    end
    adder_interface adder_vif(clk);  // 在test中例化接口
  
    simulus sim(adder_vif.simulus);
    adder   add(adder_vif.adder);
    monitor mon(adder_vif.monitor);
  
  endmodule
  