module ceiling_division;
    // 向上取整除法函数
    function integer ceil_div(input integer a);
        return (a>>7)+|(a[6:0]);
    endfunction

    // 测试用例
    initial begin
        $display("ceil_div(129) = %0d (应输出2)", ceil_div(129));
        $display("ceil_div(128) = %0d (应输出1)", ceil_div(128));
        $display("ceil_div(127) = %0d (应输出1)", ceil_div(127));
        $display("ceil_div(255) = %0d (应输出2)", ceil_div(255));
        $display("ceil_div(256) = %0d (应输出2)", ceil_div(256));
        $display("ceil_div(257) = %0d (应输出3)", ceil_div(257));
    end
endmodule
