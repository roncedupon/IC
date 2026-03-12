task print(int cmd);
    bit[7:0] addr[8];
    addr='{default:'hFF};
    if(cmd==0)
        foreach(addr[i])
            $display("%x",addr[i]);
    else begin
        addr[0]=$random();
    end
endtask
module top;
    initial begin
        #10;
        print(0);
        $display("--------");
        #10;        
        print(1);
        $display("--------");
        #10;        
        print(0);
        $display("--------");
    end
endmodule