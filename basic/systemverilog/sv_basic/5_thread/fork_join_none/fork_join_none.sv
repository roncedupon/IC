module fork_join_none;
    initial begin
        $display("=============beginning of %m===============");
        #1 $display("[%0t ns]start fork...",$time);

        fork
            //thread1
            #5 $display("[%0t ns] Thread1 start",$time);
            //thread2
            begin
                #2 $display("[%0t ns] Thread2 start:",$time);
                #4 $display("[%0t ns] Thread2 end:",$time);
            end
            // thread3
            #10 $display("[%0t ns] Thread3 end:",$time);
        join_none
        $display("[%0t ns] after fork join_none:",$time);
    end
endmodule

