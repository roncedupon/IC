function automatic void erase_array_automatic(int phy_row_addr,int ph,int ns,int l0_id=0);

    string NS="N";
    int NS_int=1;
    int row_addr;

    $display("logic row_addr %0d |ph %0d |ns %0d |l0_id %0d",row_addr,ph,ns,l0_id);
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%0d\"", NS_int);
    if (!ns) begin
        NS = "S";
        NS_int=0;
    end    
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%0d\"", NS_int);
    if (ph) begin
        $error("[Function Not Implemented] Erase operation for PH area is not implemented!!!!");
    end
    else begin
        if(NS=="N")begin
            $display("starting erase N area");
        end
        else begin
            $display("starting erase S area");
        end
    end
endfunction
//==============================================================================================
function void erase_array(int phy_row_addr,int ph,int ns,int l0_id=0);

    string NS="N";
    int NS_int=1;
    int row_addr;

    $display("logic row_addr %0d |ph %0d |ns %0d |l0_id %0d",row_addr,ph,ns,l0_id);
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%0d\"", NS_int);
    if (!ns) begin
        NS = "S";
        NS_int=0;
    end    
    $display("[DEBUG] NS = \"%s\"", NS);
    $display("[DEBUG] NS = \"%0d\"", NS_int);
    if (ph) begin
        $error("[Function Not Implemented] Erase operation for PH area is not implemented!!!!");
    end
    else begin
        if(NS=="N")begin
            $display("starting erase N area");
        end
        else begin
            $display("starting erase S area");
        end
    end
endfunction

module tb_top();
    reg clk;
    initial begin
        clk=0;
        #10000;
        $finish();
    end

    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,$sformatf("%m"),"+mda");
        #1000
        $finish;
    end

    initial begin
        erase_array(1,0,0);
        #100;
        erase_array(1,0,1);
        #100;
        erase_array(2,0,0);
        #100;
        erase_array(2,0,1);

        $display("==============automatic start=================");
        erase_array_automatic(1,0,0);
        #100;
        erase_array_automatic(1,0,1);
        #100;
        erase_array_automatic(2,0,0);
        #100;
        erase_array_automatic(2,0,1);
        $display("==============automatic end=================");
    end    
    always #5 clk=~clk;


endmodule
