class myclass;  // 定义类
  int data;
endclass

module test;
  myclass que[$];  // 队列
  myclass inst;    // 句柄，不 new
  myclass tmp;

  initial begin
    // 1. 先往队列放一个对象（必须先放，否则 pop 是 null）
    tmp = new();
    tmp.data = 100;
    que.push_back(tmp);

    // 2. 直接 pop，不 new
    inst = que.pop_front();  // 👈 你的代码

    // 3. 再往队列 push 一个新对象
    tmp = new();
    tmp.data = 999;
    que.push_back(tmp);

    // 4. 看 inst 是什么
    $display("inst.data = %0d", inst.data);
    $display("inst is null? %0d", (inst == null));
  end
endmodule