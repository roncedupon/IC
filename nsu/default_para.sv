// 定义父类
class Parent;
  // 被重载的核心task，默认参数val=10
  virtual task do_something(int val = 10);
    $display("[Parent] do_something: val = %0d", val);
  endtask

  // 父类的另一个task，内部调用do_something
  task wrapper_task(input bit[31:0] a=0);
   int b;
   if(a==0)begin
    b[31:16]=5;
   end
   else begin
    b[15:0]=10;
   end
    $display("[Parent] wrapper_task start: a = %0x, b = %0x", a, b);
    // // 调用被重载的do_something（无参，使用默认值）
    // do_something();
    // $display("[Parent] wrapper_task end");
  endtask
endclass

// 定义子类，继承父类并重载do_something
class Child extends Parent;
  // 重载do_something，修改默认参数为20
  virtual task do_something(int val = 20);
    super.do_something(20); // 调用父类的do_something，传递新的默认值
    $display("[Child] do_something: val = %0d", val);
  endtask
endclass

// 测试模块
module test;
  initial begin
    Parent p;       // 父类引用
    Child c;        // 子类引用

    // 1. 父类实例化：调用wrapper_task，执行父类的do_something
    p = new();
    $display("\n=== Parent instance ===");
    p.wrapper_task(0);
    p.wrapper_task(1);
    p.wrapper_task(0);        

    // // 2. 子类实例化：父类的wrapper_task会调用子类重载后的do_something
    // c = new();
    // $display("\n=== Child instance (direct call) ===");
    // c.wrapper_task();

    // // 3. 父类引用指向子类对象（多态）：仍执行子类的do_something
    // p = c;
    // $display("\n=== Parent ref -> Child instance (polymorphism) ===");
    // p.wrapper_task();


  end
endmodule