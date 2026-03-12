class myclass;
    extern  virtual task print(int cmd);

endclass
task myclass::print(int cmd);
    bit[7:0] addr[8]='{default:'hFF};
    if(cmd==0)
        foreach(addr[i])
            $display("%x",addr[i]);
    else begin
        addr[0]=$random();
    end
endtask
module top;
    initial begin
        myclass mycls;
        mycls=new();
        #10;
        mycls.print(0);
        $display("--------");
        #10;        
        mycls.print(1);
        $display("--------");
        #10;        
        mycls.print(0);
        $display("--------");
    end
endmodule