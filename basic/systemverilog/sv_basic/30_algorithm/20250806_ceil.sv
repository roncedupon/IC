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


function ceil_fun_error(int a,int b);//这是一个错误例子，因为函数没有返回值类型，导致下面的initial错误
    return (a-1)/b+1;//[(N-1)/M]+1

endfunction

function int ceil_fun(int a, int b);//这个才是对的
    int result;
    result=(a-1)/b+1; // [(N-1)/M]+1
    $display("ceil(%0d/%0d) = %0d", a, b, result);   
    return result;
endfunction

module ceil_example;
 real num;
 real result;
 initial begin
   $display("ceil_fun_error : %d",ceil_fun_error(10,2));
   $display("ceil_fun_error : %d",ceil_fun_error(10,3));
   $display("ceil_fun_error : %d",ceil_fun_error(10,4));
   $display("ceil_fun_error : %d",ceil_fun_error(10,5));
   $display("ceil_fun_error : %d",ceil_fun_error(10,6));
   $display("ceil_fun_error : %d",ceil_fun_error(10,7));

    ceil_fun(10,2);
    ceil_fun(10,3);
    ceil_fun(10,4);
    ceil_fun(10,5);
    ceil_fun(10,6);
    ceil_fun(10,7);
    ceil_fun(4,4);
    ceil_fun(3,4);
    
 end


endmodule

