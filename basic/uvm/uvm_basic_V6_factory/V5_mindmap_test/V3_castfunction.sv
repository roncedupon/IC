function string test(string str);
    if (!$cast(test, str)) begin
        $display("cast failed!!!!!!!!");
      end  
endfunction


module top;
    initial begin
        $display("this is output of function [%s]",test("12345"));
    end
endmodule