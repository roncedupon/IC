module queue_init_example;

  int int_q1[];          // 声明一个整数队列
  int int_q2[4];          // 声明一个整数队列
  string string_q[$];     // 声明一个字符串队列
  bit [7:0] byte_q[$];   // 声明一个字节队列

  initial begin
    // 使用赋值模式初始化
    int_q1 = {10, 20, 30, 40};
    int_q2 = '{10, 20, 30, 40};
    string_q = {"apple", "banana", "cherry"};
    byte_q ='{8'hA1, 8'hB2, 8'hC3};

    // $display("int_q1: %d", int_q1.size());
    // $display("int_q2: %d", int_q2.size());
    foreach(int_q1[i])begin
        $display("q1 is %d",int_q1[i]);
        $display("size of q1 is %d",$size(int_q1));
    end
    foreach(int_q2[i])begin
        $display("q2 is %d",int_q2[i]);
    end

    
    $display("string_q: %p", string_q);
    $display("byte_q: %p", byte_q);

    // 也可以初始化为空队列
    // int_q1 = {};
    // $display("int_q after empty init: %p", int_q1); // 输出: int_q after empty init: '{}'
  end

endmodule