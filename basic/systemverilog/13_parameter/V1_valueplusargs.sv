module tb_top;
integer  wave_dump=0;
string fsdb_name;
initial begin
    if($value$plusargs("wave_dump=%0d", wave_dump)) begin
        if(wave_dump) begin
            $display("start dump fsdb!!!!!");
            `ifdef FSDB_SPLIT
                $fsdbAutoSwitchDumpfile(1024, fsdb_name, 100); // each fsdb limit to 1G, max=200*fsdb
            `else
                $fsdbDumpfile(fsdb_name);
            `endif

            $fsdbDumpvars(0, tb_top);
            $fsdbDumpMDA;
        end
    end

end

endmodule