module top;

    reg [31:0]data[128];
    reg clk;
    always #5 clk=~clk;

    initial begin
        clk=0;
        $readmemh("/mnt/disk_0/IC/basic/systemverilog/sv_basic/15_readmemh/data.txt",data);
        foreach(data[i])begin
            $display("%x",data[i]);
        end
        #1000
        $finish;
    end

    `define WAVES_FSDB
    `ifdef WAVES_FSDB
      initial begin
        
        $fsdbDumpfile($sformatf("waves.fsdb"));
        $fsdbDumpvars("+all");
        $fsdbDumpSVA();
        $fsdbDumpMDA(0,top);
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
endmodule