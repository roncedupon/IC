/**********************************
copyright@FPGA OPEN SOURCE STUDIO
微信公众号：FPGA开源工作室
***********************************/
`timescale 1ns / 1ps

module heart(
       input                clk,
	   input                reset_n,
	   output signed [31:0] heart
	   );
	   
reg [8:0] addr1;
reg [8:0] addr2;
reg       flag;

wire signed [31:0] h1,h2;

assign heart=(flag==1'b1)?h1:h2;

always @(posedge clk or negedge reset_n) begin
  if(!reset_n) begin
     addr1<=9'd0;
	 addr2<=9'd251;
	 flag<=1'b0;
  end
  else begin
    if(addr2==9'd250||addr1==9'd511) begin
	  flag<=~flag;
	end
	
	if(flag==1'b0) begin
	  addr2<=addr2+9'd1;
	  addr1<=addr1;
	end
	else begin
	  addr2<=addr2;
	  addr1<=addr1+9'd1;
	end
  
  end
end

rom_heart Urom_heart(
         .clk(clk),
         .addr(addr1),
         .dout(h1)
		 );

rom_sw Urom_sw(
      .clk(clk),
      .addr(addr2),
      .dout(h2)
	  );
	  
endmodule


