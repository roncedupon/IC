function bit test(int width=32);
    bit[width-1:0]rtn;
    test=rtn;
endfunction
module test;
    bit [31:0]A;
    assign A=test(32);
endmodule