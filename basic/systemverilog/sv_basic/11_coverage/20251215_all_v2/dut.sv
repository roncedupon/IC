// packet_checker.sv（极简版，确保条件表达式可被工具识别）
module packet_checker (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        din,
    output logic [7:0]  dout,
    output logic        valid,
    output logic        err
);

typedef enum logic [2:0] {IDLE, START, DATA, CHECK, STOP, ERROR} fsm_state_t;
fsm_state_t curr_state, next_state;
logic [2:0] data_cnt;
logic [7:0] data_reg;
logic parity_calc;

// 时序逻辑：状态寄存器
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) curr_state <= IDLE;  // 条件1：复位判断
    else curr_state <= next_state;
end

// 组合逻辑：FSM状态转移（核心条件表达式，工具自动收集）
always_comb begin
    next_state = IDLE;
    case (curr_state)
        IDLE: begin
            if (din == 1'b0) next_state = START;  // 条件2：起始位检测
            else next_state = IDLE;
        end
        START: begin
            if (din == 1'b0) next_state = DATA;   // 条件3：起始位确认
            else next_state = ERROR;
        end
        CHECK: begin
            if (din == parity_calc) next_state = STOP;  // 条件4：校验位判断
            else next_state = ERROR;
        end
        STOP: begin
            if (din == 1'b1) next_state = IDLE;   // 条件5：停止位判断
            else next_state = ERROR;
        end
        ERROR: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

// 数据处理（补充条件表达式）
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin  // 条件6：复位判断
        data_cnt <= 0; data_reg <= 0; parity_calc <= 0;
        dout <= 0; valid <= 0; err <= 0;
    end else begin
        if (curr_state == DATA) begin  // 条件7：数据态判断
            data_reg <= {din, data_reg[7:1]};
            data_cnt <= data_cnt + 1;
        end
        if (curr_state == CHECK && din != parity_calc) err <= 1'b1;  // 条件8：校验错误
        if (curr_state == STOP && din == 1'b1) valid <= 1'b1;       // 条件9：停止位正确
    end
end

endmodule