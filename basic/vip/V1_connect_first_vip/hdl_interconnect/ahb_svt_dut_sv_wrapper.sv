
/** 
 * Abstract: A HDL Interconnect wrapper that connects the Verilog HDL
 * Interconnect to the SystemVerilog interface.
 */

`ifndef GUARD_AHB_SVT_DUT_SV_WRAPPER_SV
`define GUARD_AHB_SVT_DUT_SV_WRAPPER_SV

`include "ahb_svt_dut.v"
`include "svt_ahb_if.svi"

module ahb_svt_dut_sv_wrapper (svt_ahb_if ahb_if);
  /**
   * hgrant for dummy master, hsel for default slave
   */
  wire hgrant_m0_val = 1'b0;
  wire hsel_s0_val = 1'b0;
  wire local_hgrant;
  wire local_hsel;

  /**
   * In Implicit connections, all the signals that are common to all masters/slaves
   * should be connected to '_bus' suffixed signals of top level interface instance ahb_if.
   *
   */

`ifndef SVT_AHB_DISABLE_IMPLICIT_BUS_CONNECTION
  /** 
   * HDL Interconnect Instantiation: Example HDL Interconnect is just
   * pass-through connection. 
   */
  ahb_svt_dut ahb_svt_dut (

    .hclk           (ahb_if.hclk),
    .hresetn        (ahb_if.hresetn),
  
    /* Master side of ahb protocol interface signals.
     * hready_bus will be automatically connected to
     * ahb_if.slave_if[0].hready_in. 
     */
    .haddr_m1       (ahb_if.master_if[0].haddr),
    .hburst_m1      (ahb_if.master_if[0].hburst),
    .hbusreq_m1     (ahb_if.master_if[0].hbusreq),
    .hlock_m1       (ahb_if.master_if[0].hlock),
    .hsize_m1       (ahb_if.master_if[0].hsize),
    .htrans_m1      (ahb_if.master_if[0].htrans),
    .hwdata_m1      (ahb_if.master_if[0].hwdata),
    .hwrite_m1      (ahb_if.master_if[0].hwrite),
    .hprot_m1       (ahb_if.master_if[0].hprot),
    .hgrant_m1      (ahb_if.master_if[0].hgrant),
    .control_huser_m1 (ahb_if.master_if[0].control_huser),
    .hready_m1      (ahb_if.hready_bus),
    .hresp          (ahb_if.hresp_bus),
    .hrdata         (ahb_if.hrdata_bus),
    .hgrant_m0      (hgrant_m0_val),

   /* Slave side of ahb protocol interface signals.
    */
    .hsplit_s1      (ahb_if.slave_if[0].hsplit),
    .hrdata_s1      (ahb_if.slave_if[0].hrdata),
    .hresp_s1       (ahb_if.slave_if[0].hresp),
    .hready_s1      (ahb_if.slave_if[0].hready),
    .hsel_s1        (ahb_if.slave_if[0].hsel),
    .haddr          (ahb_if.haddr_bus),
    .hburst         (ahb_if.hburst_bus),
    .hsize          (ahb_if.hsize_bus),
    .htrans         (ahb_if.htrans_bus),
    .hprot          (ahb_if.hprot_bus),
    .hwrite         (ahb_if.hwrite_bus),
    .hwdata         (ahb_if.hwdata_bus),
    .hmaster        (ahb_if.hmaster_bus),
    .hmastlock      (ahb_if.hmastlock_bus),
    .control_huser  (ahb_if.control_huser_bus),
    .hsel_s0        (hsel_s0_val)
    );

`else

  ahb_svt_dut ahb_svt_dut (
    .hclk           (ahb_if.hclk),
    .hresetn        (ahb_if.hresetn),
    
    /* Master side of ahb protocol interface signals.
     */
    .haddr_m1       (ahb_if.master_if[0].haddr),
    .hburst_m1      (ahb_if.master_if[0].hburst),
    .hbusreq_m1     (ahb_if.master_if[0].hbusreq),
    .hlock_m1       (ahb_if.master_if[0].hlock),
    .hsize_m1       (ahb_if.master_if[0].hsize),
    .htrans_m1      (ahb_if.master_if[0].htrans),
    .hwdata_m1      (ahb_if.master_if[0].hwdata),
    .hwrite_m1      (ahb_if.master_if[0].hwrite),
    .hprot_m1       (ahb_if.master_if[0].hprot),
    .hgrant_m1      (local_hgrant),
    .control_huser_m1 (ahb_if.master_if[0].control_huser),
    .hready_m1      (ahb_if.master_if[0].hready),
    .hresp          (ahb_if.master_if[0].hresp),
    .hrdata         (ahb_if.master_if[0].hrdata),
    .hgrant_m0      (hgrant_m0_val),

    /* Slave side of ahb protocol interface signals.
     */
    .hsplit_s1      (ahb_if.slave_if[0].hsplit),
    .hrdata_s1      (ahb_if.slave_if[0].hrdata),
    .hresp_s1       (ahb_if.slave_if[0].hresp),
    .hready_s1      (ahb_if.slave_if[0].hready),
    .hsel_s1        (local_hsel),
    .haddr          (ahb_if.slave_if[0].haddr),
    .hburst         (ahb_if.slave_if[0].hburst),
    .hsize          (ahb_if.slave_if[0].hsize),
    .htrans         (ahb_if.slave_if[0].htrans),
    .hprot          (ahb_if.slave_if[0].hprot),
    .hwrite         (ahb_if.slave_if[0].hwrite),
    .hwdata         (ahb_if.slave_if[0].hwdata),
    .hmaster        (ahb_if.slave_if[0].hmaster),
    .hmastlock      (ahb_if.slave_if[0].hmastlock),
    .control_huser  (ahb_if.slave_if[0].control_huser),
    .hsel_s0        (hsel_s0_val)
    );

   assign ahb_if.slave_if[0].hready_in = ahb_svt_dut.hready_s1;
   always @ (*) ahb_if.master_if[0].hgrant = local_hgrant;
   always @ (*) ahb_if.slave_if[0].hsel = local_hsel;

`endif

endmodule
`endif // GUARD_AHB_SVT_DUT_SV_WRAPPER_SV
