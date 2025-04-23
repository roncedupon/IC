class automatic_test;
    function new();
        change_input_value(0);
        change_input_value1(768);
    endfunction
    task change_input_value(int data=123);
        if (data==0)begin
            data=1;
        end
       
        $display("no input ,data is %0d",data);
    endtask
    task change_input_value1(input int data=123);
        data=456;
        $display("with input ,data is %0d",data);
    endtask    
endclass

module top;
    automatic_test test1;
    initial begin
        test1=new();
    end

endmodule
