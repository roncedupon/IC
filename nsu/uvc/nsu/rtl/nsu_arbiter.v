module nsu_arbiter
#(parameter N=16)
(
    input wire          clk,
    input wire          rst_n,
    input wire [N-1:0]  req,
    output wire [N-1:0] grant  // 注释补全
);

wire [N-1:0] mask_hg;
wire [N-1:0] unmask_hg;
reg  [N-1:0] last_req;
wire [N-1:0] last_req_pre;
wire [N-1:0] grant_masked;
wire [N-1:0] grant_unmasked;
wire [N-1:0] req_masked;
wire         no_req_masked;

assign req_masked = req & last_req;

assign mask_hg[N-1:1] = mask_hg[N-2:0] | req_masked[N-2:0];
assign mask_hg[0]     = 1'b0;

assign grant_masked[N-1:0] = req_masked[N-1:0] & ~mask_hg[N-1:0];

assign unmask_hg[N-1:1] = unmask_hg[N-2:0] | req[N-2:0];
assign unmask_hg[0]     = 1'b0;

assign grant_unmasked[N-1:0] = req[N-1:0] & ~unmask_hg[N-1:0];

assign no_req_masked = ~(|req_masked);

assign grant = ({N{no_req_masked}} & grant_unmasked) | grant_masked;

assign last_req_pre = (|req_masked) ? mask_hg : 
                     (|req)       ? unmask_hg : last_req;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        last_req <= {N{1'b1}};
    end else if(|req_masked) begin
        last_req <= last_req_pre;
    end
end

endmodule