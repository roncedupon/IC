module sv_toolbox;
    logic [255:0]instr[$]={
        'h00000000000000000000000100f830000000000000000022000003e400000000,
        'h0000000000000000000000010001300000000000000000220000000800000000
    };
    initial begin
        foreach(instr[i])begin
            $display("opcode       :%x",instr[i][71:64]);
            $display("PacketSize   :%d",instr[i][45:32]);
            $display("---------------------------------");
        end
    end

endmodule