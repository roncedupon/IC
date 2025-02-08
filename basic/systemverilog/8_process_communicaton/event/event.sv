module event_test;
    event eventA;
    initial begin
        fork
            waitForTrigger(eventA);
            begin
                #5 $display("[%0t] op 1",$time);
                #5 $display("[%0t] op 2",$time);
                #5 $display("[%0t] op 3",$time);
                #5 ->eventA;
                $display("[%0t] trigger now",$time);
                #5 $display("[%0t] op 4",$time);
                #5 $display("[%0t] op 5",$time);
                #5 $display("[%0t] op 6",$time);
            end
        join
    end
endmodule
task waitForTrigger(event eventA);
    $display("[%0t] waiting for EventA to be triggered",$time);
    wait(eventA.triggered);
    $display("[%0t] EventA has been triggered",$time);
    #5 $display("[%0t]post_trigger op 1",$time);
    #5 $display("[%0t]post_trigger op 2",$time);
    #5 $display("[%0t]post_trigger op 3",$time);
    #5 $display("[%0t]post_trigger op 4",$time);
endtask