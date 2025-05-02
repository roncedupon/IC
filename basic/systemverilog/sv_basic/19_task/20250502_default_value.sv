

module top;
    task test(int a,int b=2,int c=4);
        $display("%0d %0d %0d",a,b,c);
    endtask
    initial begin
        test(10,.c(1024));
    end
endmodule