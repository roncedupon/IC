
`ifndef SPRAM_MODEL
  `define SPRAM_MODEL

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

function [31:0] log2;
    input [31:0] value;
    begin
        log2 = 1;
        while (value > (2**log2)) begin
            log2 = log2 + 1;
        end
    end
endfunction

endmodule
`endif
