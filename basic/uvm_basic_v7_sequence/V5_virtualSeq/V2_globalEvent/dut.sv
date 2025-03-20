interface delay_interface #(parameter WIDTH = 8, parameter MAX_DELAY = 16)(input clk,rst_n);


    // 输入信号
    logic [WIDTH-1:0] data;
    logic valid;
    logic [$clog2(MAX_DELAY)-1:0] delay_times;
    logic ready;
endinterface


module dynamic_delay #(
    parameter WIDTH = 8,           // 数据宽度
    parameter MAX_DELAY = 16       // 最大延时周期数
)(
    input logic clk,               // 时钟信号
    input logic rst_n,             // 复位信号
    input logic [WIDTH-1:0] data_in, // 输入数据
    input logic data_valid,        // 输入数据有效信号
    input logic [$clog2(MAX_DELAY)-1:0] delay_times, // 延时周期数
    output logic [WIDTH-1:0] data_out, // 输出数据
    output logic data_out_valid,   // 输出数据有效信号
    output logic ready             // 模块准备好接收新数据
);

    typedef struct {
        logic [WIDTH-1:0] data;
        logic [$clog2(MAX_DELAY)-1:0] delay;
    } fifo_entry_t;

    fifo_entry_t fifo [MAX_DELAY-1:0];
    logic [$clog2(MAX_DELAY)-1:0] read_ptr;
    logic [$clog2(MAX_DELAY)-1:0] write_ptr;
    logic [$clog2(MAX_DELAY):0] fifo_count;
    logic [WIDTH-1:0] output_buffer;
    logic data_ready;
    logic [$clog2(MAX_DELAY)-1:0] delay_counter;

    assign ready = (fifo_count < MAX_DELAY);
    assign data_out = output_buffer;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_ptr <= 0;
            write_ptr <= 0;
            fifo_count <= 0;
            data_out_valid <= 0;
            data_ready <= 0;
            delay_counter <= 0;
        end else begin
            // 写数据到FIFO
            if (data_valid && ready) begin
                fifo[write_ptr].data <= data_in;
                fifo[write_ptr].delay <= delay_times;
                write_ptr <= (write_ptr + 1) % MAX_DELAY;
                fifo_count <= fifo_count + 1;
            end

            // 处理延时数据
            if (fifo_count > 0) begin
                if (data_ready) begin
                    output_buffer <= fifo[read_ptr].data;
                    data_out_valid <= 1;
                    read_ptr <= (read_ptr + 1) % MAX_DELAY;
                    fifo_count <= fifo_count - 1;
                    data_ready <= 0;
                end else begin
                    if (delay_counter == 0) begin
                        data_ready <= 1;
                        delay_counter <= fifo[read_ptr].delay;
                    end else begin
                        delay_counter <= delay_counter - 1;
                    end
                    data_out_valid <= 0;
                end
            end else begin
                data_out_valid <= 0;
            end
        end
    end
endmodule



module dual_dut#(
    parameter WIDTH = 8,           // 数据宽度
    parameter MAX_DELAY = 16       // 最大延时周期数
)(
    input logic clk,               // 时钟信号
    input logic rst_n,             // 复位信号
    input logic [WIDTH-1:0] data1, // 输入数据
    input logic valid1,        // 输入数据有效信号
    input logic [$clog2(MAX_DELAY)-1:0] delay_times1, // 延时周期数
    output logic ready1 ,

    input logic [WIDTH-1:0] data2, // 输入数据
    input logic valid2,        // 输入数据有效信号
    input logic [$clog2(MAX_DELAY)-1:0] delay_times2, // 延时周期数
    output logic ready2
);

    dynamic_delay dut1(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data1),
        .data_valid(valid1),
        .delay_times(delay_times1),
        .ready(ready1)
      );

    dynamic_delay dut2(
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data2),
        .data_valid(valid2),
        .delay_times(delay_times2),
        .ready(ready2)
      );
endmodule

// module top;
//     reg clk;
//     always #5 clk=~clk;
//     delay_interface#(8,16) inf(clk,0);
//     dut dut(.sData(inf),.mData(inf));
//     initial begin
//         #1000
//         $finish;
//     end
// endmodule