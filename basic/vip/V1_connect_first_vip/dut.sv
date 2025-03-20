interface my_ahb_if();
    logic hclk;
    logic hrestn;
    logic hwdata;
    logic hrdata;
    logic hready;
    logic htrans;
    logic hburst;
    logic hwrite;
    logic hsize;
    logic hprot;


    modport master_if(
        input hclk,hrestn,hrdata,hready,
        output hwdata,htrans,hburst,hwrite,hsize,hprot
    );

    modport slave_if(
        input hclk,hrestn,hwdata,htrans,hburst,hwrite,hsize,hprot,
        output hrdata,hready
    );
endinterface


module  ahb_slave(my_ahb_if.slave_if port);
    assign port.hready=1'b1;
    assign port.hrdata='hffffffff;
endmodule