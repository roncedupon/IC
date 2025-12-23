//在前面调用后面定义的task
task test0();
    test1();
    $display("this is task0");
endtask

task test1();
    $display("this is task1");
endtask

module top;
    initial begin
        test0();
    end

endmodule