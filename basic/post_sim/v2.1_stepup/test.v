`timescale 1ns/1ns

`define LOGIC_BUF

module test ;
   wire         co ;

   parameter    CYCLE_10NS = 10ns;
   reg          clk ;
   initial begin
      clk = 0 ;
      # 111 ;
      forever begin
          #(CYCLE_10NS/2) clk = ~clk ;
      end
   end

   reg          slow_flag = 0 ;
   always @(posedge clk) begin
`ifdef LOGIC_BUF
      slow_flag <= ~slow_flag ;
`else
      slow_flag <= 1'b1 ;
`endif
   end

   reg  [7:0]    num = 0 ;
   always @(posedge clk) begin
      if(slow_flag)
        num[3:0] <= num[3:0] + 1 ;
   end

   wire [7:0]    adder1 ;
   full_adder8  u1_adder8(
               .a      (num<<2),
               .b      (num<<3),
               .c      (1'b0),
               .so     (adder1),
               .co     ());

   wire [7:0]    adder2 ;
   full_adder8  u2_adder8(
               .a      (num<<1),
               .b      (num),
               .c      (1'b0),
               .so     (adder2),
               .co     ());

   //======================= for better time ============================
   //adding buffer

   wire [7:0]    adder1_r, adder2_r ;
   D8   adder1_buf(
               .d       (adder1),
               .clk     (clk),
               .q       (adder1_r));
   D8   adder2_buf(
               .d       (adder2),
               .clk     (clk),
               .q       (adder2_r));

`ifdef LOGIC_BUF
   wire [7:0]         adder1_t       = adder1_r ;
   wire [7:0]         adder2_t       = adder2_r ;
`else
   wire [7:0]         adder1_t       = adder1 ;
   wire [7:0]         adder2_t       = adder2 ;
`endif


   wire [7:0]    adder3 ;
   full_adder8  u3_adder8(
               .a      (adder1_t),
               .b      (adder2_t),
               .c      (1'b0),
               .so     (adder3),
               .co     ());

   wire [7:0]    res_mul15 ;
   D8   data_store(
               .d       (adder3),
               .clk     (clk),
               .q       (res_mul15));

   initial begin
      forever begin
         #100;
         if ($time >= 1000)  $finish ;
      end
   end

endmodule // test
