task array_output(logic[31:0]array[]);
    foreach(array[i])
        $display("%x ",array[i]);

endtask
module tb_top;

    initial begin
        logic[31:0]array[10];
        int transfer_bytes=8;
        logic [31:0]tmp[]=new[transfer_bytes>>2];
        foreach (array[i])
            array[i]=i;
        // for(int i=0;i<10;i=i+1)
        //     array_output(array[0:i]);
        //     $display("=======================");
        foreach(tmp[i])
        array_output(tmp);

    end


endmodule

