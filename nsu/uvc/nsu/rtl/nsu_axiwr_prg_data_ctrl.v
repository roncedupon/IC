`timescale 1ns/1ps

module fifo_conv_width_ip(/*autoarg*/
    //Inputs
    clk,
    rst_n,
    fifo_clr,
    fifo_wen,
    fifo_wdat,
    fifo_ren,
    //Outputs
    fifo_rdat,
    full,
    empty
);

//============================Parameter============================
parameter    COMMON_WIDTH = 32; // common_divisor is in_width or out_width
parameter    IN_WIDTH = 32 ;
parameter    OUT_WIDTH = 128;
parameter    FIFO_DEPTH = 2; //THIS FIFO DEPTH IS SET FOR IN_WIDTH
parameter    OUT_RESIGTER= 1;
localparam   IN_STEP = IN_WIDTH / COMMON_WIDTH;
localparam   OUT_STEP = OUT_WIDTH / COMMON_WIDTH;
localparam   MEM_SUM = IN_WIDTH * FIFO_DEPTH;
localparam   MEM_DEPTH = MEM_SUM / COMMON_WIDTH;
localparam   ADDR_WIDTH = $clog2(MEM_DEPTH);
//============================In/Out Signal============================
input                           clk;
input                           rst_n;
input                           fifo_clr;
input                           fifo_wen;
input      [IN_WIDTH-1:0]       fifo_wdat;
input                           fifo_ren;
output     [OUT_WIDTH-1:0]      fifo_rdat;
output                          full;
output                          empty;

//============================Wire/Reg SIGNAL============================
reg        [MEM_SUM-1:0]        mem;
reg        [ADDR_WIDTH-1:0]     waddr;
reg        [ADDR_WIDTH-1:0]     raddr;
reg        [ADDR_WIDTH:0]       deep;

//============================Process============================
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        waddr <= 'd0;
    else if(fifo_clr)
        waddr <= 'd0;
    else if(fifo_wen)begin
        if(waddr == MEM_DEPTH - IN_STEP)
            waddr <= 'd0;
        else
            waddr <= waddr + IN_STEP;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        raddr <= 'd0;
    else if(fifo_clr)
        raddr <= 'd0;
    else if(fifo_ren)begin
        if(raddr == MEM_DEPTH - OUT_STEP)
            raddr <= 'd0;
        else
            raddr <= raddr + OUT_STEP;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(fifo_wen & !full)
        mem[COMMON_WIDTH*waddr+:IN_WIDTH] <= fifo_wdat;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep <= 'd0;
    else if(fifo_clr)
        deep <= 'd0;
    else if(fifo_wen & fifo_ren)
        deep<= deep + IN_STEP - OUT_STEP;
    else if(fifo_wen & (!fifo_ren))
        deep<= deep + IN_STEP;
    else if(fifo_ren & (!fifo_wen))
        deep<= deep - OUT_STEP;
end

assign empty = deep < OUT_STEP;
assign full  = deep > MEM_DEPTH - IN_STEP;

generate
if(OUT_RESIGTER == 1)begin
    reg [OUT_WIDTH-1:0]           fifo_rdat_temp;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            fifo_rdat_temp <= 'd0;
        else if(fifo_clr)
            fifo_rdat_temp <= 'd0;
        else if(fifo_ren)
            fifo_rdat_temp <= mem[COMMON_WIDTH*raddr+:IN_WIDTH];
    end
    assign fifo_rdat = fifo_rdat_temp;
end
else    begin
    assign fifo_rdat = mem[COMMON_WIDTH*raddr+:IN_WIDTH];
end
endgenerate

endmodule