/*
    Simple DUT for relative_path_include test
    File: dir1/dut1.sv
*/

module dut2_1 #(parameter WIDTH = 8) (
    input  logic                 clk,
    input  logic                 rst_n,   // active low reset
    input  logic                 en,      // enable sample
    input  logic [WIDTH-1:0]     data_in,
    output logic [WIDTH-1:0]     data_out,
    output logic [31:0]          tick_count
);

    // internal register to hold sampled input
    logic [WIDTH-1:0] sample_q;

    // simple synchronous logic: sample data_in when en is high,
    // and a free-running 32-bit tick counter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sample_q   <= '0;
            tick_count <= 32'd0;
        end else begin
            if (en)
                sample_q <= data_in;
            tick_count <= tick_count + 1;
        end
    end

    assign data_out = sample_q;

endmodule