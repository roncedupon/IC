`timescale 1ns/1ps

module nsu_ip_pluse_level(/*autoarg*/
    // Inputs
    clk, rst_n, pluse_in,
    // Outputs
    level_out
);

//============================Parameter============================
// Width of the shift register for pulse stretching
parameter WIDTH = 3;

//============================In/Out Signal============================
input         clk;          // Clock input
input         rst_n;        // Active-low reset
input         pluse_in;     // Input pulse signal
output        level_out;    // Output level signal (stretched pulse)

//============================Wire/Reg SIGNAL============================
/*autodef*/
reg [WIDTH-2:0] pluse_dly;  // Shift register to delay the input pulse

//============================Process============================
// Shift register to capture and delay the input pulse
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        pluse_dly <= 'd0;          // Reset the shift register
    else
        pluse_dly <= {pluse_dly[WIDTH-3:0], pluse_in}; // Shift in the new pulse
end

// Generate the output level by OR-ing the shift register contents with the current input
assign level_out = (|pluse_dly) | pluse_in;

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule