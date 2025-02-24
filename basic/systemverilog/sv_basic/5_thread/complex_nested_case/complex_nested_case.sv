module task_execution;

  // 声明事件，用于fork join any模式
  event e_A_done, e_B_done, e_C_done,e_trigger_E;

  // 任务A
  task A;
    begin
      $display("Task A starts");
      #5;  // 模拟任务执行的延迟
      $display("Task A done");
      -> e_A_done;  // 触发A完成的事件
    end
  endtask

  // 任务B
  task B;
    begin
      $display("Task B starts");
      #7;  // 模拟任务执行的延迟
      $display("Task B done");
      -> e_B_done;  // 触发B完成的事件
    end
  endtask

  // 任务C
  task C;
    begin
      $display("Task C starts");
      #10;  // 模拟任务执行的延迟
      $display("Task C done");
      -> e_C_done;  // 触发C完成的事件
    end
  endtask

  // 任务D
  task D;
    begin
      $display("Task D starts");
      #8;  // 模拟任务执行的延迟
      $display("Task D done");
    end
  endtask

  // 任务E
  task E;
    begin
      $display("Task E starts");
      #6;  // 模拟任务执行的延迟
      $display("Task E done");
    end
  endtask

  // 主执行块
  initial begin
    // 任务A和任务B并行执行，等待两者完成
    fork
      A();
      B();
    join

    // 任务C必须等A和B完成后执行
    C();

    // 任务D在A和B完成后执行，但不等待它们完成
    fork
      D();
    join_none

    // 任务E等待A、B或C任意一个完成后执行
    // 使用独立的 always 块触发事件 e_trigger_E
    fork

    join_none // 让 always 块在后台运行
        
    fork
      wait (e_A_done.triggered | e_B_done.triggered | e_C_done.triggered);
      E();
    join_any
  end

endmodule

