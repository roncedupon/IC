//需求：如果信号a在当前周期拉高，那么信号b也应该在接下来的1~3个周期内必须至少拉高一次。

module top;
    reg clk;
    reg a;
    reg b;
    always #5 clk=~clk;
    initial begin
        a=0;
        b=0;
        clk=0;
        fork
            repeat(3)begin//a 会拉高3 次，每10个周期拉高一次
                repeat(20)@(posedge clk);
                a=1;
                @(posedge clk)a=0;
            end

            begin
                @(posedge a);//a 拉高后的下一个周期拉高
                @(posedge clk)#1 b=1;
                @(posedge clk)#1 b=0;

                @(posedge a);
                repeat(3)@(posedge clk)#1 b=1;//a 拉高后的两个时钟周期再拉高b
                @(posedge clk)#1 b=0;

                @(posedge a);
                repeat(4)@(posedge clk)#1 b=1;//a 拉高后的两个时钟周期再拉高b
                @(posedge clk)#1 b=0;
            end
        join
    end
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,$sformatf("%m"));
        #1000
        $finish;
    end
    always @(posedge a) begin
        repeat(1)@(posedge clk);
        $display("time now is %0d,b is %0d",$time,b);
        fork:a_to_b
            begin
                @(posedge b)$display("SUCCESS:b arrived in time\n",$time);
                disable a_to_b;
            end

            begin
                repeat(3)@(posedge clk);
                $display("ERROR:b didn't arrive in time\n",$time);
                disable a_to_b;
            end
        join
    end
    assert property (@(posedge clk)$rose(a)|-> ##[1:3] $rose(b));
endmodule