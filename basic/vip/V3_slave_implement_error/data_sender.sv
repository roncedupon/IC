`include "svt_ahb_if.svi"
`include "mydefine.sv"
// module data_sender(
//   input clk,
//   input rstn,
//   input  [`SVT_AHB_MAX_NUM_MASTERS-1:0] hsplit,
//   input  [`SVT_AHB_MAX_DATA_WIDTH-1:0] hrdata,
//   input  [`SVT_AHB_HRESP_PORT_WIDTH-1:0] hresp,
//   input  hready,
//   output hsel,
//   output reg[`SVT_AHB_MAX_ADDR_WIDTH-1:0] haddr,
//   output reg[`SVT_AHB_HBURST_PORT_WIDTH-1:0] hburst,
//   output reg[`SVT_AHB_HSIZE_PORT_WIDTH-1:0] hsize,
//   output reg[`SVT_AHB_HTRANS_PORT_WIDTH-1:0] htrans,
//   output reg[`SVT_AHB_HPROT_PORT_WIDTH-1:0] hprot,
//   output reg hwrite,
//   output reg[`SVT_AHB_MAX_DATA_WIDTH-1:0] hwdata,
//   output reg[`SVT_AHB_HMASTER_PORT_WIDTH-1:0] hmaster,
//   output hmastlock,
//   output [`SVT_AHB_MAX_USER_WIDTH-1:0] control_huser
// );
// // assign hgrant_m1=1'b1;
// assign hsplit=16'b0;
// assign hsel=1'b1; 
// assign hmastlock=1'b0;
// assign hmaster=4'h0;

// always@(posedge clk or negedge rstn)begin
//   if(rstn)begin
//     haddr<='d0;
//   end
//   else begin
//     haddr<=32'h0000_5678;
//   end
// end



// endmodule


module test_top;

  /** Signal to generate the clock */
  bit clk;
  reg rst_n;
  svt_ahb_master_if mvif(clk,rst_n);//create one vif


  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,test_top);
  end

  initial begin
    clk = 0 ;
    forever begin
      #(10/2)
        clk = ~clk ;
    end
  end
  initial begin
    rst_n=0;
    #1000
    rst_n=1;
    #10000
    $finish;
  end

  data_senderV2 data_sender(.m_if(mvif.svt_ahb_bus_modport));
endmodule

