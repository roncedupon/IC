module Mul#(parameter AWidth = 8,parameter BWidth = 8,parameter CWidth = 16,parameter delay_times = 1)(
    input logic rstn,
    input logic clk,
    input  signed [AWidth-1:0]A,
    input  signed [BWidth-1:0]B,
    output signed [CWidth-1:0]C
);
// if (delay_times==0)begin
//     assign C=A*B;
// end
// else begin

// end
reg signed [AWidth+BWidth-1:0]dly_array[0:delay_times-1];
always_ff @(posedge clk or negedge rstn) begin
    if(rstn)begin
        dly_array[0]<=0;
    end
    else dly_array[0]<=$signed(A)*$signed(B);//打一拍
end
genvar i;
generate;
    for(i=1;i<delay_times;i++)begin
        always_ff @(posedge clk or negedge rstn) begin
            if(rstn)begin
                dly_array[i]<=0;
            end
            else dly_array[i]<=dly_array[i-1];
        end
    end
endgenerate


assign C=dly_array[delay_times-1];
endmodule
