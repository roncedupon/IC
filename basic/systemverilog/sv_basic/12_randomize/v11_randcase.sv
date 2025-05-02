module top;
    bit [13:0]addr;
    initial begin
        randcase
            5:begin
                addr=10;
            end 
            5:begin
                addr=11;
            end 
            5:begin
                addr=$urandom_range(19, 12);
            end 
            5:begin
                addr=13;
            end 
        endcase
        $display("addr is %0d",addr);
    end

endmodule   

