module top;
    //想实现动态位宽选择，但是不行error
    localparam int DFS = 5; // 使用 localparam
    logic [7:0] tx_data;

    initial begin
        // 使用 DFS 选择 tx_data 的位宽
        logic [DFS-1:0] tmp = tx_data[DFS-1:0];
        
        // 输出 tmp 的值
        $display("Selected data: %b", tmp);

        DFS=4;
        // 使用 DFS 选择 tx_data 的位宽
        tmp = tx_data[DFS-1:0];
        
        // 输出 tmp 的值
        $display("Selected data: %b", tmp);
    end
endmodule
