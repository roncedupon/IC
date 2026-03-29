class MyClass;
    // 类的全局变量（改名了，不用var）
    int my_var;

    task my_task();
        fork
            // Block1：修改全局变量
            begin
                #10;
                my_var = 100;
                $display("[Block1] 全局变量 my_var = %0d", my_var);
            end

            // Block2：定义同名局部变量
            begin
                int my_var = 999;  // 局部变量

                // Block2 的子 block
                begin
                    #20;
                    // 这里访问的是 局部变量 还是 全局变量？
                    $display("[Block2_sub] my_var = %0d", my_var);
                    // 用 this 明确访问全局变量
                    $display("[Block2_sub] this.my_var = %0d", this.my_var);
                end
            end
        join
    endtask
endclass

module test;
    MyClass obj;

    initial begin
        obj = new();
        obj.my_var = 10;
        $display("初始全局变量 obj.my_var = %0d", obj.my_var);

        obj.my_task();

        $display("最终全局变量 obj.my_var = %0d", obj.my_var);
    end
endmodule