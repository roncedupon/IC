module task_in_fork;//interprocess communication
    initial begin
        task1;
        task2;
    end

endmodule

task task1;
    #10 $display("in task1 [%0t]",$time);
    #10 $display("in task1 [%0t]",$time);
    #10 $display("in task1 [%0t]",$time);
endtask
task task2;
    #5 $display("in task2 [%0t]",$time);
    #5 $display("in task2 [%0t]",$time);
    #5 $display("in task2 [%0t]",$time);
endtask
// in task1 [10000]
// in task1 [20000]
// in task1 [30000]
// in task2 [35000]
// in task2 [40000]
// in task2 [45000]