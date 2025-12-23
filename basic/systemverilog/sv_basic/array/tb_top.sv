module tb_top();
    reg clk;
    initial begin
        clk=0;
        #10000;
        $finish();
    end
    initial begin
        #1000;
        
    end
    initial begin
        tb_top.u_se.u_inner_trunk_ram_south.mem[0]='h12344;
        $display("%p==========",tb_top.u_se.u_inner_trunk_ram_south.mem[0]);
        $display("%p==========",`SE_ARRAY_INNER_TRUNK_S_PATH(0)[0]);
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,$sformatf("%m"),"+mda");
        #1000
        $finish;
    end        
    initial begin
        $display("11//3 %d 11mod3 %d",11/3,11%3);
        erase_array(1,0,0);
        #100;
        erase_array(1,0,1);
        #100;
        erase_array(2,0,0);
        #100;
        erase_array(2,0,1);
    end    
    always #5 clk=~clk;
    inner_trunk u_ne(
        .clk(clk),
        // south port
        .en_south('h0),
        .we_south('h0),
        .addr_south('h0),
        .din_south('h0),
        .dout_south(),
        // north port
        .en_north('h0),
        .we_north('h0),
        .addr_north('h0),
        .din_north('h0),
        .dout_north()
    );
    inner_trunk u_nw(
        .clk(clk),
        // south port
        .en_south('h0),
        .we_south('h0),
        .addr_south('h0),
        .din_south('h0),
        .dout_south(),
        // north port
        .en_north('h0),
        .we_north('h0),
        .addr_north('h0),
        .din_north('h0),
        .dout_north()
    );
    inner_trunk u_se(
        .clk(clk),
        // south port
        .en_south('h0),
        .we_south('h0),
        .addr_south('h0),
        .din_south('h0),
        .dout_south(),
        // north port
        .en_north('h0),
        .we_north('h0),
        .addr_north('h0),
        .din_north('h0),
        .dout_north()
    );
    inner_trunk u_sw(
        .clk(clk),
        // south port
        .en_south('h0),
        .we_south('h0),
        .addr_south('h0),
        .din_south('h0),
        .dout_south(),
        // north port
        .en_north('h0),
        .we_north('h0),
        .addr_north('h0),
        .din_north('h0),
        .dout_north()
    );
    initial begin
        string testcase;

        if ($value$plusargs("TESTCASE=%s", testcase)) begin
            $display("Running test case: %s", testcase);
        end else begin
            $display("No TESTCASE provided, using default");
        end
    end
endmodule
