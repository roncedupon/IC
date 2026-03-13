//
// timescale 1ns/1ps
//
/*
⚠️ 需要注意的点 （未修改，保持原样）：

- L133: assign temp_vld[0] = tempvld; - 这里 tempvld 可能是笔误，应该是 temp_vld_i ，但我没有修改
- L135: 实例化参数语法 #("autoins1param"( 看起来不太标准，但保持原样
- L97: reg [CMD_PIPE_NUM-1:0] rcmd_que0_wen; 定义了但后续逻辑中似乎还定义了 rcmd_que1_wen , rcmd_que2_wen , rcmd_que3_wen 为 wire

*/
module nsu_rd_cmd_sw_ctrl(/*autoarg*/
    //Inputs
    clk,
    rst_n,
    sw_cmd_in_vld,
    sw_cmd_in,
    read_rcmd_que_start,
    read_rcmd_que_end,
    read_rcmd_que_ready,
    rcmd_que0_ready,
    rcmd_que1_ready,
    rcmd_que2_ready,
    rcmd_que3_ready,
    rcmd_que0_start_addr,
    rcmd_que1_start_addr,
    rcmd_que2_start_addr,
    rcmd_que3_start_addr,
    rcmd_que0_len,
    rcmd_que1_len,
    rcmd_que2_len,
    rcmd_que3_len,
    //Outputs
    sw_cmd_in_rdy,
    rcmd_que_wcen,
    rcmd_que_wdat,
    rcmd_que0_wptr_wen,
    rcmd_que1_wptr_wen,
    rcmd_que2_wptr_wen,
    rcmd_que3_wptr_wen
);
    //////////////////////////////////////////////////////////////
    //Parameter
    //////////////////////////////////////////////////////////////
    parameter NSU_RCMDATA_WIDTH = 26;
    parameter CPU_CMD_MH = 32;
    parameter READ_CMD_ADDR = 7;
    parameter READ_QUE_LEN = 6;
    parameter CMD_PIPE_NUM = 6;
    localparam TSU_NSU_RCMD_WIDTH = NSU_RCMDATA_WIDTH + CMD_PIPE_NUM;
    localparam END_FLAG = 3;
    localparam CMD_MH = TSU_NSU_RCMD_MH + 2*2;
    localparam SW_CMD_MH = 34;
    
    //////////////////////////////////////////////////////////////
    //Input Signal
    //////////////////////////////////////////////////////////////
    input clk;
    input rst_n;
    input [1:0] read_rcmd_que_start;
    input [1:0] read_rcmd_que_end;
    input sw_cmd_in_vld;
    output [TSU_NSU_RCMD_MH-1:0] sw_cmd_in;
    input sw_cmd_in_ready;
    input rcmd_que0_ready;
    input rcmd_que1_ready;
    input rcmd_que2_ready;
    input rcmd_que3_ready;
    input [READ_CMD_ADDR-1:0] rcmd_que0_start_addr;
    input [READ_CMD_ADDR-1:0] rcmd_que1_start_addr;
    input [READ_CMD_ADDR-1:0] rcmd_que2_start_addr;
    input [READ_CMD_ADDR-1:0] rcmd_que3_start_addr;
    input [READ_QUE_LEN-1:0] rcmd_que0_len;
    input [READ_QUE_LEN-1:0] rcmd_que1_len;
    input [READ_QUE_LEN-1:0] rcmd_que2_len;
    input [READ_QUE_LEN-1:0] rcmd_que3_len;
    
    //////////////////////////////////////////////////////////////
    //Output Signal
    //////////////////////////////////////////////////////////////
    output sw_cmd_in_rdy;
    output rcmd_que_wcen;
    output [CPU_CMD_MH-1:0] rcmd_que_wdat;
    output rcmd_que0_wptr_wen;
    output rcmd_que1_wptr_wen;
    output rcmd_que2_wptr_wen;
    output rcmd_que3_wptr_wen;
    
    //////////////////////////////////////////////////////////////
    //WIRE/REG SIGNAL
    //////////////////////////////////////////////////////////////
    //automaticwire
    //Start of automatic wire
    //Define instance wires here
    wire wen;
    wire [CPU_CMD_MH-1:0] wdata;
    wire ren;
    wire [SW_CMD_MH-1:0] rdata;
    wire full;
    wire empty;
    
    //End of automatic wire
    reg [1:0] queue_sel;
    reg [1:0] write_cmd_cnt;
    reg [CMD_PIPE_NUM-1:0] rcmd_que0_wen;
    wire rcmd_que1_wen;
    wire rcmd_que2_wen;
    wire rcmd_que3_wen;
    reg [READ_CMD_ADDR-1:0] rcmd_que0_cnt;
    reg [READ_CMD_ADDR-1:0] rcmd_que1_cnt;
    reg [READ_CMD_ADDR-1:0] rcmd_que2_cnt;
    reg [READ_CMD_ADDR-1:0] rcmd_que3_cnt;
    reg [READ_QUE_LEN-1:0] rcmd_que0_len_cnt;
    reg [READ_QUE_LEN-1:0] rcmd_que1_len_cnt;
    reg [READ_QUE_LEN-1:0] rcmd_que2_len_cnt;
    reg [READ_QUE_LEN-1:0] rcmd_que3_len_cnt;
    wire [1:0] temp_vld;
    wire [1:0] temp_rdy;
    reg [1:0] temp_que_sel;
    reg [CPU_CMD_MH-1:0] temp_dat;
    wire temp_vld_i;
    wire temp_rdy_i;
    reg [3:0] ram_addr;
    reg [CPU_CMD_MH-1:0] temp_addr;
    reg [CPU_CMD_MH-1:0] ran_dat;
    reg [1:0] ran_cnt;
    reg read_rcmd_que_start_dly;
    reg read_rcmd_que_start_dly2;
    reg read_rcmd_que_start_dly3;
    reg [1:0] read_rcmd_que_start_dly_vec;
    reg [1:0] read_rcmd_que_end_dly_vec;
    
    //Process
    //////////////////////////////////////////////////////////////
    //Process
    //////////////////////////////////////////////////////////////
    assign sw_cmd_in_rdy = !full;
    assign wen = sw_cmd_in_vld & sw_cmd_in_rdy;
    assign wdata = {queue_sel, sw_cmd_in[63:32], queue_sel, sw_cmd_in[31:0]};
    assign ren = temp_vld[0] & temp_rdy[0];
    assign temp_vld[0] = tempvld;
    
    nsu_fifo_cone_with_if #("autoins1param"(
        .COMMON_DIVISOR (SW_CMD_MH),
        .IN_WIDTH (CMD_MH),
        .OUT_WIDTH (SW_CMD_MH),
        .FIFO_DEPTH (8),
        .OUT_REGISTER (0)
    )) u0_fifo_cone_with_if (
        .clk (clk),
        .rst_n (rst_n),
        .fifo_clr (1'b0),
        .fifo_wen (wen),
        .fifo_wdat (wdata),
        .fifo_wrem (),
        .rdata (rdata),
        .fifo_remain_vld (),
        .fifo_remain_rst (),
        .fifo_remain_mask (),
        .full (full),
        .empty (empty)
    );
    
    assign cfg_start = read_rcmd_que_start_dly3 | read_rcmd_que_start;
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            queue_sel <= 'd0;
        else if(cfg_start) begin
            queue_sel <= read_rcmd_que_start_dly_vec;
        end
        else if(read_rcmd_que_end) begin
            queue_sel <= queue_sel + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            read_rcmd_que_start_dly <= 'd0;
        else
            read_rcmd_que_start_dly <= read_rcmd_que_start;
    end
    
    wilson_in_judgepipe u0_wilson_in_judgepipe(/*autoinst*/
        .clk (clk),
        .rst_n (rst_n),
        .s_ready (temp_rdy[0]),
        .s_valid (temp_vld[0]),
        .m_ready (sw_cmd_in_vld),
        .m_valid (temp_vld_i),
        .s_data (rdata),
        .m_data (temp_dat)
    );
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            temp_rdy[0] <= 'd0;
        else
            temp_rdy[0] <= sw_cmd_in_ready;
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            temp_vld[1] <= 'd0;
        else
            temp_vld[1] <= temp_vld_i;
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            temp_rdy[1] <= 'd0;
        else if(rcmd_que_wcen == 1'b1)begin
            temp_rdy[1] <= 1'b1;
        end
        else begin
            temp_rdy[1] <= 1'b0;
        end
    end
    
    assign rcmd_que_wcen = (temp_vld[1] & temp_rdy[1]) ? 1'b1 : 1'b0;
    
    assign rcmd_que0_wptr_wen = (temp_dat[33:32] == 'd0 ? rcmd_que_wcen : 1'b0);
    assign rcmd_que1_wptr_wen = (temp_dat[33:32] == 'd1 ? rcmd_que_wcen : 1'b0);
    assign rcmd_que2_wptr_wen = (temp_dat[33:32] == 'd2 ? rcmd_que_wcen : 1'b0);
    assign rcmd_que3_wptr_wen = (temp_dat[33:32] == 'd3 ? rcmd_que_wcen : 1'b0);
    
    assign rcmd_que_wdat = temp_dat[31:0];
    
    assign temp_que_sel = temp_dat[33:32];
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            write_cmd_cnt <= 'd0;
        else if(rcmd_que_wcen == 1'b1)begin
            if(write_cmd_cnt == 'd1)
                write_cmd_cnt <= 'd0;
            else
                write_cmd_cnt <= write_cmd_cnt + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            ram_addr <= 'd0;
        else if(rcmd_que_wcen == 1'b1)begin
            case(temp_que_sel)
                2'd0: ram_addr <= rcmd_que0_cnt;
                2'd1: ram_addr <= rcmd_que1_cnt;
                2'd2: ram_addr <= rcmd_que2_cnt;
                2'd3: ram_addr <= rcmd_que3_cnt;
                default: ram_addr <= rcmd_que0_cnt;
            endcase
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rcmd_que0_cnt <= 'd0;
        else if(rcmd_que0_wen == 1'b1)begin
            if(rcmd_que0_cnt == (rcmd_que0_len_cnt - 1'b1))
                rcmd_que0_cnt <= 'd0;
            else
                rcmd_que0_cnt <= rcmd_que0_cnt + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rcmd_que1_cnt <= 'd0;
        else if(rcmd_que1_wen == 1'b1)begin
            if(rcmd_que1_cnt == (rcmd_que1_len_cnt - 1'b1))
                rcmd_que1_cnt <= 'd0;
            else
                rcmd_que1_cnt <= rcmd_que1_cnt + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rcmd_que2_cnt <= 'd0;
        else if(rcmd_que2_wen == 1'b1)begin
            if(rcmd_que2_cnt == (rcmd_que2_len_cnt - 1'b1))
                rcmd_que2_cnt <= 'd0;
            else
                rcmd_que2_cnt <= rcmd_que2_cnt + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rcmd_que3_cnt <= 'd0;
        else if(rcmd_que3_wen == 1'b1)begin
            if(rcmd_que3_cnt == (rcmd_que3_len_cnt - 1'b1))
                rcmd_que3_cnt <= 'd0;
            else
                rcmd_que3_cnt <= rcmd_que3_cnt + 1'b1;
        end
    end
    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n) begin
            rcmd_que0_len_cnt <= 'd0;
            rcmd_que1_len_cnt <= 'd0;
            rcmd_que2_len_cnt <= 'd0;
            rcmd_que3_len_cnt <= 'd0;
        end
        else if(cfg_start) begin
            case(queue_sel)
                2'd0: rcmd_que0_len_cnt <= rcmd_que0_len;
                2'd1: rcmd_que1_len_cnt <= rcmd_que1_len;
                2'd2: rcmd_que2_len_cnt <= rcmd_que2_len;
                2'd3: rcmd_que3_len_cnt <= rcmd_que3_len;
                default: ;
            endcase
        end
    end
    
    //Local Variables:
    //verilog-library-directories:("/ELEVATION001/Proj_Digital/shiyu.wang/common_ip/tifo/rtl", "." )
    //verilog-library-directories-recursive:0
endmodule
