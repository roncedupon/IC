module counter (
    input clk,
    input rst_n,
    output [31:0]counter
);
    reg [31:0]counter_reg;
    always@(posedge clk or negedge rst_n)begin
        if(~rst_n)
            counter_reg<=0;
        else if (counter_reg=='d1024-1)
            counter_reg<=0;
        else
            counter_reg<=counter_reg+1'b1;
    end
    assign counter=counter_reg;

    specify
        specparam tCQ = 0.4;
            (posedge clk => counter[0])  = tCQ;
            (posedge clk => counter[1])  = tCQ;
            (posedge clk => counter[2])  = tCQ;
            (posedge clk => counter[3])  = tCQ;
            (posedge clk => counter[4])  = tCQ;
            (posedge clk => counter[5])  = tCQ;
            (posedge clk => counter[6])  = tCQ;
            (posedge clk => counter[7])  = tCQ;
            (posedge clk => counter[8])  = tCQ;
            (posedge clk => counter[9])  = tCQ;
            (posedge clk => counter[10]) = tCQ;
            (posedge clk => counter[11]) = tCQ;
            (posedge clk => counter[12]) = tCQ;
            (posedge clk => counter[13]) = tCQ;
            (posedge clk => counter[14]) = tCQ;
            (posedge clk => counter[15]) = tCQ;
            (posedge clk => counter[16]) = tCQ;
            (posedge clk => counter[17]) = tCQ;
            (posedge clk => counter[18]) = tCQ;
            (posedge clk => counter[19]) = tCQ;
            (posedge clk => counter[20]) = tCQ;
            (posedge clk => counter[21]) = tCQ;
            (posedge clk => counter[22]) = tCQ;
            (posedge clk => counter[23]) = tCQ;
            (posedge clk => counter[24]) = tCQ;
            (posedge clk => counter[25]) = tCQ;
            (posedge clk => counter[26]) = tCQ;
            (posedge clk => counter[27]) = tCQ;
            (posedge clk => counter[28]) = tCQ;
            (posedge clk => counter[29]) = tCQ;
            (posedge clk => counter[30]) = tCQ;
            (posedge clk => counter[31]) = tCQ;
    endspecify

endmodule