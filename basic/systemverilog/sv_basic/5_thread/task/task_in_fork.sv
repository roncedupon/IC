module task_in_fork;
    initial begin
        fork
            task1;
            #100 #100
            task2;
        join
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
// in task2 [5000]
// in task1 [10000]
// in task2 [10000]
// in task2 [15000]
// in task1 [20000]
// in task1 [30000]