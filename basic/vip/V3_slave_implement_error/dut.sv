`ifndef __DUT
`define __DUT
`include "svt_ahb_if.svi"
// module dut(svt_ahb_if.master_if[0] m_if,svt_ahb_if.slave_if[0] s_if);
//     //slave-->master
//     assign m_if.hwdata=s_if.hrdata;
//     assign m_if.haddr=s_if.haddr;
//     assign m_if.hburst=s_if.hburst;
//     assign m_if.hburst=s_if.hburst;
//     assign m_if.hsize=s_if.hsize;
//     assign m_if.htrans=s_if.htrans;
//     assign m_if.hprot=s_if.hprot;
//     assign m_if.hwrite=s_if.hwrite;

//     //master-->slave
//     assign s_if.hready=m_if.hready;
//     assign s_if.hresp=m_if.hresp;
// endmodule
//step1 create a slave2master that gets data from ahb_master_agent,and drives data to ahb_slave_agent
module dut(svt_ahb_slave_if s_if,svt_ahb_master_if m_if);
    // assign s_if.internal_hresetn=rstn;
    // assign m_if.internal_hresetn=rstn;

    assign m_if.hrdata  =s_if.hrdata;
    assign m_if.hready  =s_if.hready;
    assign m_if.hgrant  =1;
    assign m_if.hresp   =s_if.hresp;
    assign m_if.hrdata_huser   =s_if.hrdata_huser;

    assign s_if.haddr=m_if.haddr;
    assign s_if.hburst=m_if.hburst;
    assign s_if.hprot=m_if.hprot;
    assign s_if.hnonsec=m_if.hnonsec;
    assign s_if.hsize=m_if.hsize;
    assign s_if.htrans=m_if.htrans;
    assign s_if.hwdata=m_if.hwdata;
    assign s_if.hwrite=m_if.hwrite;
    assign s_if.control_huser=m_if.control_huser;
    assign s_if.hwdata_huser=m_if.hwdata_huser;
    assign s_if.hsel=1'b1;
    assign s_if.hmastlock=1'b0;
    assign s_if.hready_in =s_if.hready;
    
endmodule

// moudle dut_1(svt_ahb_if m_if,svt_ahb_if s_if);
//     assign m_if.hrdata  =s_if.hrdata;
//     assign m_if.hready  =s_if.hready;
//     assign m_if.hgrant  =1;
//     assign m_if.hresp   =s_if.hresp;
//     assign m_if.hrdata_huser   =s_if.hrdata_huser;

//     assign s_if.haddr=m_if.haddr;
//     assign s_if.hburst=m_if.hburst;
//     assign s_if.hprot=m_if.hprot;
//     assign s_if.hnonsec=m_if.hnonsec;
//     assign s_if.hsize=m_if.hsize;
//     assign s_if.htrans=m_if.htrans;
//     assign s_if.hwdata=m_if.hwdata;
//     assign s_if.hwrite=m_if.hwrite;
//     assign s_if.control_huser=m_if.control_huser;
//     assign s_if.hwdata_huser=m_if.hwdata_huser;
// endmodule


`endif


