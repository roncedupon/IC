// 定义一个简单的类（模拟验证环境中的自定义类）
class my_class;
    int data;
    function new(int d);
        this.data = d;
    endfunction
    function void print();
        $display("Class data: %0d", this.data);
    endfunction
endclass

module tb_null_class;
    initial begin
        my_class obj;  // 声明类句柄，默认值就是null
        
        // 1. 检查初始状态（未实例化，句柄为null）
        if (obj == null) begin
            $display("初始状态：obj is null");
        end
        
        // 2. 创建对象，句柄指向实际内存
        obj = new(100);
        obj.print();  // 正常调用方法
        if (obj != null) begin
            $display("创建对象后：obj is not null");
        end
        
        // 3. 将句柄设置为null（核心操作）
        obj = null;
        if (obj == null) begin
            $display("赋值后：obj is null");
        end
        
        // 注意：此时不能访问obj的成员，否则会报运行时错误
        // obj.print();  // 取消注释会报错：Null pointer dereference
        
        // 4. 可选：重新创建对象（句柄可再次指向新对象）
        obj = new(200);
        obj.print();
    end
endmodule