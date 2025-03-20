//注意在for循环中变量类型必须一致
module test_forloop;

    logic nums_logic=10;
    int nums_int=10;
    int a;
    int a = int '(signal);
    // https://stackoverflow.com/questions/38880579/system-verilog-casting-from-logic-to-int#:~:text=You%20should%20not%20need%20a%20cast%20to%20go,Z%2C%20then%20the%20value%20gets%20converted%20to%200.
    initial begin
        for(int i=0;i<nums_int;i=i+1)begin
            $display("int %0d",i);
        end
        for(int i=0;i<nums_logic;i=i+1)begin
            $display("logic %0d",i);
        end



        if(signal=== 3'b000) begin
           a = 0;
        end else if(signal=== 3'b001) begin
           a = 1;
        end else if(signal=== 3'b010) begin
           a = 2;
        end else if(signal=== 3'b011) begin
           a = 3;
        end else begin
           assert(0);
        end
    end

endmodule

