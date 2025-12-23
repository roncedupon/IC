class test;
    // 定义变量A
    rand bit [15:0] A;

    // 构造函数
    function new();
        // 随机化A的值
        this.randomize();
    endfunction

    // 随机化函数
    function void randomize_A();
        // 生成随机值
        assert(this.randomize() with { A >= 0; A <= 16'hFFFF; });
    endfunction
endclass

module test_module;
    initial begin
        // 创建多个test类的实例
        test t1 = new();
        test t2 = new();
        test t3 = new();

        // 打印每个实例的A值
        $display("Instance 1 A: %h", t1.A);
        $display("Instance 2 A: %h", t2.A);
        $display("Instance 3 A: %h", t3.A);
    end
endmodule