module packet_checker (
    input  logic        clk,        // 时钟
    input  logic        rst_n,      // 异步复位（低有效）
    input  logic        din,        // 串行输入数据
    output logic [7:0]  dout,       // 并行输出数据
    output logic        valid,      // 输出有效标志
    output logic        err         // 错误标志（起始/校验/停止位错误）
);

// -------------------------- FSM状态定义 --------------------------
typedef enum logic [2:0] {
    IDLE   = 3'b000,  // 空闲态
    START  = 3'b001,  // 检测起始位
    DATA   = 3'b010,  // 接收8bit数据
    CHECK  = 3'b011,  // 校验奇校验位
    STOP   = 3'b100,  // 检测停止位
    ERROR  = 3'b101   // 错误态
} fsm_state_t;

fsm_state_t curr_state, next_state;

// -------------------------- 内部寄存器 --------------------------
logic [2:0]  data_cnt;    // 数据位计数（0-7）
logic [7:0]  data_reg;    // 数据暂存寄存器
logic        parity_calc; // 计算的奇校验值

// -------------------------- 时序逻辑：状态寄存器 --------------------------
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_state <= IDLE;
    end else begin
        curr_state <= next_state;
    end
end

// -------------------------- 组合逻辑：FSM状态转移 --------------------------
always_comb begin
    next_state = curr_state; // 默认保持当前状态
    case (curr_state)
        IDLE: begin
            // 检测到起始位（din=0）则进入START
            if (din == 1'b0) begin
                next_state = START;
            end else begin
                next_state = IDLE;
            end
        end

        START: begin
            // 起始位稳定为0则进入DATA，否则ERROR
            if (din == 1'b0) begin
                next_state = DATA;
            end else begin
                next_state = ERROR;
            end
        end

        DATA: begin
            // 8bit数据接收完成则进入CHECK，否则保持DATA
            if (data_cnt == 3'd7) begin
                next_state = CHECK;
            end else begin
                next_state = DATA;
            end
        end

        CHECK: begin
            // 奇校验正确则进入STOP，否则ERROR
            if (din == parity_calc) begin
                next_state = STOP;
            end else begin
                next_state = ERROR;
            end
        end

        STOP: begin
            // 停止位正确（din=1）则返回IDLE，否则ERROR
            if (din == 1'b1) begin
                next_state = IDLE;
            end else begin
                next_state = ERROR;
            end
        end

        ERROR: begin
            // 错误态停留1拍后返回IDLE
            next_state = IDLE;
        end

        default: next_state = IDLE; // 防综合器告警
    endcase
end

// -------------------------- 时序逻辑：数据接收与校验计算 --------------------------
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        data_cnt   <= 3'd0;
        data_reg   <= 8'd0;
        parity_calc<= 1'b0;
        dout       <= 8'd0;
        valid      <= 1'b0;
        err        <= 1'b0;
    end else begin
        // 默认值
        data_cnt   <= data_cnt;
        data_reg   <= data_reg;
        parity_calc<= parity_calc;
        dout       <= 8'd0;
        valid      <= 1'b0;
        err        <= 1'b0;

        case (curr_state)
            IDLE: begin
                data_cnt   <= 3'd0;
                data_reg   <= 8'd0;
                parity_calc<= 1'b0;
            end

            START: begin
                // 起始位确认后，重置计数器和校验值
                data_cnt   <= 3'd0;
                parity_calc<= 1'b0;
            end

            DATA: begin
                // 移位接收数据，计算奇校验（累加异或）
                data_reg   <= {din, data_reg[7:1]};
                data_cnt   <= data_cnt + 3'd1;
                parity_calc<= parity_calc ^ din;
                // 奇校验：最终结果取反
                if (data_cnt == 3'd7) begin
                    parity_calc<= ~parity_calc;
                end
            end

            CHECK: begin
                // 校验位错误则置位err
                if (din != parity_calc) begin
                    err <= 1'b1;
                end
            end

            STOP: begin
                // 停止位正确则输出有效数据，否则置位err
                if (din == 1'b1) begin
                    dout  <= data_reg;
                    valid <= 1'b1;
                end else begin
                    err   <= 1'b1;
                end
            end

            ERROR: begin
                // 错误态置位err
                err <= 1'b1;
            end
        endcase
    end
end



endmodule