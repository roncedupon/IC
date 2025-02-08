//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

/** 
 * Abstract: A HDL Interconnect wrapper that connects the Verilog HDL
 * Interconnect to the SystemVerilog interface.
 */

`ifndef GUARD_AXI_SVT_DUT_SV_WRAPPER_SV
`define GUARD_AXI_SVT_DUT_SV_WRAPPER_SV

`include "axi_svt_dut.v"
`include "svt_axi_if.svi"

module axi_svt_dut_sv_wrapper (svt_axi_if axi_if);

  /** 
   * HDL Interconnect Instantiation: Example HDL Interconnect is just
   * pass-through connection. 
   */
  axi_svt_dut axi_svt_dut (
    .aclk (axi_if.master_if[0].internal_aclk) ,
    .aresetn (axi_if.master_if[0].aresetn) ,

    /**
     * axi4 stream signals
     */

    /**
     * master side
     */
    .tvalid_m1(axi_if.master_if[0].tvalid),
    .tdata_m1(axi_if.master_if[0].tdata),
    .tstrb_m1(axi_if.master_if[0].tstrb),
    .tkeep_m1(axi_if.master_if[0].tkeep),
    .tlast_m1(axi_if.master_if[0].tlast),
    .tid_m1(axi_if.master_if[0].tid),
    .tdest_m1(axi_if.master_if[0].tdest),
    .tuser_m1(axi_if.master_if[0].tuser),
    .tready_m1(axi_if.master_if[0].tready), 

    /**
     * slave side
     */
    .tvalid_s1(axi_if.slave_if[0].tvalid),
    .tdata_s1(axi_if.slave_if[0].tdata),
    .tstrb_s1(axi_if.slave_if[0].tstrb),
    .tkeep_s1(axi_if.slave_if[0].tkeep),
    .tlast_s1(axi_if.slave_if[0].tlast),
    .tid_s1(axi_if.slave_if[0].tid),
    .tdest_s1(axi_if.slave_if[0].tdest),
    .tuser_s1(axi_if.slave_if[0].tuser),
    .tready_s1(axi_if.slave_if[0].tready) 

  );

endmodule
`endif // GUARD_AXI_SVT_DUT_SV_WRAPPER_SV
