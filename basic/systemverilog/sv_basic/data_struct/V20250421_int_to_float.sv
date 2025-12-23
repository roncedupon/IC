//实际项目中想做两个int类型的除法，没想到会出现负数
class int_to_float;
int a;
int b;
    function new();
        a=1234;
        b=5;
        $display("%0d",a/b);
        
        
    endfunction
endclass
module top;
    int_to_float inst;
    initial begin
        inst=new();

    end
endmodule