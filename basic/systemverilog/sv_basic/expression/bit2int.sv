module bit2int;
    int int_data;
    bit[7:0]bit_data;
    initial begin
        bit_data=255;
        int_data=bit_data;
        $display("int is %0d----bit is %0d",int_data,bit_data);
    end
endmodule