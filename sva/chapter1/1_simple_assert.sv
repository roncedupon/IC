module m(input logic c,clk);
    logic a=1'b0;
    logic b=1'b0;
    always@(posedge clk)begin
        a<=c;
        b<=~c;
    end

    //assertion 
    a1: assert property(@(posedge clk) a!=b)
        else $error("a != b doesn't hold");
endmodule :m

module reqgranted1(input logic req,grant,clk);
    bit [2:0]ctr='0;
    always@(posedge clk)begin
        if(req)ctr<=1;
        else if (ctr>0 && ctr<4)ctr<=ctr+1;
        else if (ctr==4)begin
            if(!grant)$display("Request not granted");
            ctr<='0;
        end
    end
endmodule

module top;
 reg clk;
 initial begin
    clk=0;
 end
 always #5 clk=~clk;
 
endmodule