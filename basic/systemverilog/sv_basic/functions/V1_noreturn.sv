function int fun1(int a);
    int b;
    b=a;

endfunction
module top;

    initial begin
        $display("return is %0d",fun1(1024));
    end
endmodule