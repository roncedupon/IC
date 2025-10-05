`timescale 1ns/1ps

`define LOGIC_BUF

module tb_top ;
   wire              co ;
   reg[0:0]          data;
   reg               rst_n;
   wire [31:0]       counter;

   parameter    CYCLE_10NS = 10ns;
   reg          clk ;
   initial begin
      clk      = 0 ;
      data     = 0;
      rst_n    = 0;
      # 3000 ;
      rst_n    = 1;
      forever begin
          #(CYCLE_10NS/2) clk = ~clk ;
      end
   end
   counter u_counter(
      .clk(clk),
      .rst_n(rst_n),
      .counter(counter)
   );
   always@(posedge clk)begin
      if (counter==128-1)data<=~data;
   end
   d_gate d_gate_inst(
      .Q(),
      .D(data),
      .CP(clk)
   );

   initial begin
      $sdf_annotate("/mnt/disk_0/IC/basic/post_sim/v2.1_stepup/sim_test.sdf",tb_top,"/mnt/disk_0/IC/basic/post_sim/v2.1_stepup/sdf_config.cfg","sdf_annotate.log");//[, module_instance] [,'sdf_configfile'][,'sdf_logfile'][,'mtm_spec'] [,'scale_factors'][,'scale_type'] 
   end

   initial begin
      forever begin
         #100000;
         if ($time >= 1000)  $finish ;
      end
   end
   `define WAVES_FSDB
   `ifdef WAVES_FSDB
      initial begin
            $fsdbDumpfile($sformatf("waves.fsdb"));
            $fsdbDumpvars("+all");
            $fsdbDumpSVA();
            $fsdbDumpMDA(0,$sformatf("%m"));
      end
   `elsif WAVES_VCD
      initial begin
            $dumpvars;
      end
   `elsif WAVES
      initial begin
            $vcdpluson;
      end
   `endif   
endmodule // test
