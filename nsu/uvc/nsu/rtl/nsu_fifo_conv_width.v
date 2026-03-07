`timescale 1ns/1ps

module nsu_fifo_conv_width(/*autoarg*/
    //Inputs
    clk, rst_n, fifo_clr,
    fifo_wen, fifo_wdat,
    fifo_ren,
    //Outputs
    fifo_rdat, fifo_remain_vld,
    fifo_remain_rdat,
    fifo_remain_mask, full,
    empty
);

//============================Parameter============================
// 输入输出位宽的公共除数，用于步长计算
parameter COMMON_DIVISOR = 32;
// 输入数据位宽
parameter IN_WIDTH      = 256;
// 输出数据位宽
parameter OUT_WIDTH     = 160;
// FIFO深度，按输入位宽设置
parameter FIFO_DEPTH    = 2;
// 输出是否打拍寄存器
parameter OUT_RESIGTER  = 1;

// 输入步长 = 输入位宽 / 公共除数
localparam IN_STEP      = IN_WIDTH/COMMON_DIVISOR;
// 输出步长 = 输出位宽 / 公共除数
localparam OUT_STEP     = OUT_WIDTH/COMMON_DIVISOR;
// 存储器总容量 = 输入位宽 * FIFO深度
localparam MEM_SUM      = IN_WIDTH*FIFO_DEPTH;
// 存储器位宽 = 公共除数
localparam MEM_WIDTH    = COMMON_DIVISOR;
// 存储器深度 = 总容量 / 存储器位宽
localparam MEM_DEPTH    = MEM_SUM/COMMON_DIVISOR;
// 地址位宽 = log2(存储器深度) + 1
localparam ADDR_WIDTH   = $clog2(MEM_DEPTH)+1;
// 输出全掩码 = (1 << 输出步长) - 1
localparam OUT_MASK_ALL = (1<<OUT_STEP) - 1;

//============================In/Out Signal============================
input                           clk;
input                           rst_n;
input                           fifo_clr;
input                           fifo_wen;
input      [IN_WIDTH-1:0]       fifo_wdat;
input                           fifo_ren;
output     [OUT_WIDTH-1:0]      fifo_rdat;
output                          fifo_remain_vld;
output     [OUT_WIDTH-1:0]      fifo_remain_rdat;
output     [OUT_STEP-1:0]       fifo_remain_mask;
output                          full;
output                          empty;

//============================Wire/Reg SIGNAL============================
/*autodef*/
reg        [MEM_SUM   -1:0]     mem;        // 存储阵列
reg        [ADDR_WIDTH-1:0]     waddr;      // 写地址
wire       [ADDR_WIDTH-1:0]     waddr_next; // 下一拍写地址
reg        [ADDR_WIDTH-1:0]     raddr;      // 读地址
wire       [ADDR_WIDTH-1:0]     raddr_next; // 下一拍读地址
wire       [MEM_SUM*2 -1:0]     mem_exp;    // 存储器扩展（用于循环读取）
wire       [OUT_WIDTH -1:0]     rdat_temp;  // 读数据临时值
reg        [ADDR_WIDTH-1:0]     deep;       // FIFO深度计数

//============================Process============================
// 写地址生成：复位/清零时归零，写使能时按输入步长递增，越界则归零
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        waddr <= 'h0 ;
    else if(fifo_clr)
        waddr <= 'h0 ;
    else if (fifo_wen) begin
        if(waddr_next > MEM_DEPTH - 'b1)
            waddr <= 'b0;
        else
            waddr <= waddr + IN_STEP;
    end
end

assign raddr_next = raddr + OUT_STEP ; // 下一拍读地址 = 当前读地址 + 输出步长
assign waddr_next = waddr + IN_STEP ;  // 下一拍写地址 = 当前写地址 + 输入步长

// 读地址生成：复位/清零时归零，读使能时按输出步长递增，越界则循环
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        raddr <= 'h0 ;
    else if(fifo_clr)
        raddr <= 'h0 ;
    else if (fifo_ren) begin
        if(raddr_next > MEM_DEPTH - 'b1)
            raddr <= raddr_next - MEM_DEPTH;
        else
            raddr <= raddr_next ;
    end
end

// 存储器扩展：将mem拼接为两倍长度，实现循环读取
assign mem_exp = {2{mem}};
// 读数据临时值：从扩展存储器中按读地址和输出位宽取值
assign rdat_temp = mem_exp[raddr*MEM_WIDTH+:OUT_WIDTH];
// 剩余数据有效：空且深度>0
assign fifo_remain_vld = empty & deep >'d0;
// 剩余读数据 = 读数据临时值
assign fifo_remain_rdat = rdat_temp;
// 剩余数据掩码：全掩码右移(输出步长-深度)位
assign fifo_remain_mask = OUT_MASK_ALL >> (OUT_STEP - deep);

// 输出寄存器打拍：根据OUT_RESIGTER选择是否打拍
generate
if(OUT_RESIGTER) begin
    reg [OUT_WIDTH -1:0] fifo_rdat_tmp;

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)begin
            fifo_rdat_tmp <= 'b0;
        end
        else if(fifo_clr)begin
            fifo_rdat_tmp <= 'b0;
        end
        else if(fifo_ren) begin
            fifo_rdat_tmp <= rdat_temp;
        end
    end

    assign fifo_rdat = fifo_rdat_tmp;
end
else begin
    assign fifo_rdat = rdat_temp;
end
endgenerate

// 写操作：复位/清零时清空mem，写使能且未满时按写地址写入数据
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        mem <= 'b0;
    end
    else if(fifo_clr) begin
        mem <= 'b0;
    end
    else if (fifo_wen & ~full) begin
        mem[(MEM_WIDTH*waddr)+:MEM_WIDTH*IN_STEP] <= fifo_wdat;
    end
end

// 深度计数：根据读写使能更新深度，同时读写时深度变化为输入步长-输出步长
always@(posedge clk or negedge rst_n)
begin
    if(~rst_n)
        deep <= 'h0 ;
    else if(fifo_clr)
        deep <= 'h0 ;
    else if (fifo_wen & ~fifo_ren)
        deep <= deep + IN_STEP ;
    else if (~fifo_wen & fifo_ren)
        deep <= deep - OUT_STEP ;
    else if (fifo_wen & fifo_ren)
        deep <= deep + IN_STEP - OUT_STEP;
end

// 空标志：深度 < 输出步长
assign empty = deep < OUT_STEP;
// 满标志：深度 > 存储器深度 - 输入步长
assign full  = deep > MEM_DEPTH - IN_STEP;

endmodule