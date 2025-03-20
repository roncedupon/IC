`ifdef TOP2
    module top1;
        initial begin
            fork
                begin
                    while(1)begin
                        $display("in while[1]");
                        #1;
                    end
                end
                begin
                    while(1)begin
                        $display("in while[2]");
                        #1;
                    end
                end
            join
        end
        initial begin
            #1000
            $finish;
        end

    endmodule

`else
    module top2;
        initial begin
            fork
                begin
                    while(1)begin
                        $display("in while[1]");
                        // #1;
                    end
                end
                begin
                    while(1)begin
                        $display("in while[2]");
                        #1;
                    end
                end
            join
        end
        initial begin
            #1000
            $finish;
        end
    endmodule
`endif 