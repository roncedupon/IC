module fsm_moore(
    input wire clk_i,
    input wire rst_l_i,

    output reg [3:0] dout
); 

parameter [1:0] idle = 2'd0,
                  s1 = 2'd1,
                  s2 = 2'd2,
                  s3 = 2'd3;

reg [1:0] state, next;

always@(posedge clk_i or negedge rst_l_i) 
begin
    if(!rst_l_i)
        state <= idle;
    else
        state <= next;
end

always@(*) begin: BLOCK3
    next = idle;
    dout = 4'd0;
    case(state)
        idle:begin
            dout = 4'd0;
            next = s1;
        end

        s1:begin
            dout = 4'd2;
            next = s2;
        end

        s2:begin
            dout = 4'd4;
            next = s3;
        end

        s3:begin
            dout = 4'd8;
            next = idle;
        end
    endcase
end

endmodule
