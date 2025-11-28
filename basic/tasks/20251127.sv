//请分析以下 SystemVerilog 代码，并预测 initial 块执行完成后，控制台会打印出哪些行结果？
module test_automatic_lifetime;

    // 任务默认为 static [3]
    task static_task();
        // 静态任务中的变量默认是 static 生命周期 [1]
        int static_default_var = 1; 
        automatic int automatic_explicit_var = 1; 

        static_default_var = static_default_var + 1;
        automatic_explicit_var = automatic_explicit_var + 1;

        $display("S_Task_Output: static_default_var=%0d, automatic_explicit_var=%0d", static_default_var, automatic_explicit_var);
    endtask

    // 任务显式声明为 automatic [5]
    task automatic automatic_task();
        // 自动任务中的变量默认是 automatic 生命周期 [1]
        int automatic_default_var = 10;
        static int static_explicit_var = 10; // 显式声明为 static [1]

        automatic_default_var = automatic_default_var + 1;
        static_explicit_var = static_explicit_var + 1;

        $display("A_Task_Output: automatic_default_var=%0d, static_explicit_var=%0d", automatic_default_var, static_explicit_var);
    endtask

    initial begin
        $display("--- First Call Set ---");
        static_task();
        automatic_task();

        $display("--- Second Call Set ---");
        static_task();
        automatic_task();
    end

endmodule

/*
核心概念：静态（Static）与自动（Automatic）
1. 静态变量 (Static Lifetime): 存储在固定的内存位置，其初始化（如果在声明时给出）只在仿真开始时执行一次。变量的值在任务或函数调用结束后被保留。
2. 自动变量 (Automatic Lifetime): 存储在堆栈中，每当任务、函数或过程块被调用/进入时，它们会被重新创建和初始化。变量在调用/块结束时被销毁。
详细步骤分析
1. 第一次调用 static_task()： static_task 默认是静态的，因此其中的变量默认也是静态的。
• static_default_var = 1;：此变量为默认静态，初始化 1 只在第一次调用前发生（或在第一次调用时作为单次事件发生）。它被递增到 2。
• automatic_explicit_var = 1;：此变量被显式声明为 automatic。在每次调用 static_task 时都会被初始化为 1。它被递增到 2。
结果 1： S_Task_Output: static_default_var=2, automatic_explicit_var=2
2. 第一次调用 automatic_task()： automatic_task 被显式声明为 automatic，因此其中的变量默认也是自动的。
• automatic_default_var = 10;：此变量为默认自动，每次调用时都会被初始化为 10。它被递增到 11。
• static_explicit_var = 10;：此变量被显式声明为 static。初始化 10 只在第一次调用前发生。它被递增到 11。
结果 2： A_Task_Output: automatic_default_var=11, static_explicit_var=11
3. 第二次调用 static_task()：
• static_default_var：它是静态的，保留了上一次的值 2。被递增到 3。
• automatic_explicit_var：它是自动的，重新初始化为 1。被递增到 2。
结果 3： S_Task_Output: static_default_var=3, automatic_explicit_var=2
4. 第二次调用 automatic_task()：
• automatic_default_var：它是自动的，重新初始化为 10。被递增到 11。
• static_explicit_var：它是静态的，保留了上一次的值 11。被递增到 12。
结果 4： A_Task_Output: automatic_default_var=11, static_explicit_var=12

--------------------------------------------------------------------------------
SystemVerilog 关键洞察
在 SystemVerilog 中，变量的生命周期（Lifetime） 决定了其存储和初始化行为：
• 默认规则： 默认情况下，在 module、interface 或 program 内定义的任务和函数是 静态 的，其内部未显式指定生命周期的变量也默认为 静态。
• 显式声明： 使用 automatic 关键字可以强制任务、函数或其中的变量具有自动生命周期。
• 例外情况：
    ◦ 在 class（类）中定义的 方法（Methods），以及在 for 循环初始化中声明的循环变量，默认都是 automatic 的，无论其外部范围如何。
    ◦ automatic 任务或函数中的变量，默认是 automatic 的，但可以显式声明为 static。
这就像一个酒店的比喻：
• 静态变量 就像酒店的保险箱：它们在酒店（仿真）开始时被分配一次，并且可以存储数值，直到酒店关闭。即使不同的客人在不同的时间段访问同一个任务（客房），他们共享同一个保险箱，并使用上一个客人留下的值。
• 自动变量 就像一次性用品：每次客人进入房间（调用任务）时，都会提供一套全新的用品（重新初始化），并分配给当前这次调用独享。客人离开后，这些用品就会被清除，不保留状态。
*/