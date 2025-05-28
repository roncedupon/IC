
`ifndef SPRAM_MODEL
  `define SPRAM_MODEL
function [31:0] log2;
input [31:0] value;
begin
    log2 = 1;
    while (value > (2**log2)) begin
        log2 = log2 + 1;
    end
end
endfunction
module spram_model #(
    parameter WIDTH       = 32 ,
    parameter DEPTH       = 4  ,
    parameter ADDR_WIDTH  = log2(DEPTH)
)(
    input                       clka  ,
    input                       ena   ,
    input                       wea   ,
    input   [ADDR_WIDTH-1:0]    addra ,
    input   [WIDTH-1:0]         dina  ,
    output  reg [WIDTH-1:0]     douta
);

reg [WIDTH-1:0] mem [DEPTH-1:0];

always @ (posedge clka) begin
    if (ena & wea)
        mem[addra] <= dina;
end

always @ (posedge clka) begin
    if (ena & (wea == 1'b0))
        douta <= mem[addra];
end

endmodule


module inner_trunk #(
    parameter WIDTH       = 32,
    parameter DEPTH       = 4,
    parameter ADDR_WIDTH  = log2(DEPTH)
)(
    input                       clk,

    // south port
    input                       en_south,
    input                       we_south,
    input  [ADDR_WIDTH-1:0]     addr_south,
    input  [WIDTH-1:0]          din_south,
    output [WIDTH-1:0]          dout_south,

    // north port
    input                       en_north,
    input                       we_north,
    input  [ADDR_WIDTH-1:0]     addr_north,
    input  [WIDTH-1:0]          din_north,
    output [WIDTH-1:0]          dout_north
);

// Internal wires
wire [WIDTH-1:0] ram_out_south;
wire [WIDTH-1:0] ram_out_north;

// Instantiate south SPRAM
spram_model #(
    .WIDTH(16896),
    .DEPTH(2066)
) u_inner_trunk_ram_south (
    .clka   (clk),
    .ena    (en_south),
    .wea    (we_south),
    .addra  (addr_south),
    .dina   (din_south),
    .douta  (ram_out_south)
);

// Instantiate north SPRAM
spram_model #(
    .WIDTH(16896),
    .DEPTH(2066)
) u_inner_trunk_ram_north (
    .clka   (clk),
    .ena    (en_north),
    .wea    (we_north),
    .addra  (addr_north),
    .dina   (din_north),
    .douta  (ram_out_north)
);

// Output assignments
assign dout_south = ram_out_south;
assign dout_north = ram_out_north;

endmodule

`endif
