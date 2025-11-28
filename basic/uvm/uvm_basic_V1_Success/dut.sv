module dut(
input clk,
input rstn,
input data_in,
input en_i,
output reg data_out,
output reg en_o);
//对所有输入的信号打一拍后输出
always@(posedge clk or negedge rstn)begin
    if(~rstn)begin
        data_out<=1'b0;
    end
    else if(en_i)begin
        data_out<=data_in;
    end
    else data_out<=data_out;
end
always_ff@(posedge clk or negedge rstn)begin
        if(~rstn)begin
        en_o<=1'b0;
    end
    else en_o<=en_i;
end
endmodule

