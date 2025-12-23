module fork_join_noneV2;
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
            
            repeat(10)begin//repeat也是一个线程啊
                #1
                $display("[%0t ns] Thread5 end:",$time);
            end

            //thread4
            // begin
            //     repeat(10)begin
            //         #10
            //         $display("[%0t ns] Thread4 end:",$time);
            //     end
            // end
            // //thread5
            

            
        join_none
        $display("[%0t ns] after fork join_none:",$time);
    end
endmodule