module sharp_in_fork;
    initial begin
        fork
            #10 $display("[%0t]op 1",$time);
            #10 $display("[%0t]op 2",$time);
            #10 $display("[%0t]op 3",$time);
            #10 $display("[%0t]op 4",$time);
            #10 $display("[%0t]op 5",$time);
            #10 $display("[%0t]op 6",$time);
        join
    end
endmodule