`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 通用数据载体类：承载int/string/bit等基础类型数据
class uvm_event_data_carrier extends uvm_object;
  // 可扩展支持多种类型，这里先加int（你需要的）
  int int_data;      
  string str_data;    // 可选扩展
  bit [31:0] bit_data;// 可选扩展

  `uvm_object_utils_begin(uvm_event_data_carrier)
    `uvm_field_int(int_data, UVM_ALL_ON)
    `uvm_field_string(str_data, UVM_ALL_ON)
    `uvm_field_int(bit_data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "uvm_event_data_carrier");
    super.new(name);
  endfunction

  // 便捷方法：快速设置int数据
  function void set_int_data(int data);
    this.int_data = data;
  endfunction

  // 便捷方法：快速获取int数据
  function int get_int_data();
    return this.int_data;
  endfunction
endclass

// 完整测试代码
module tb;
  initial begin
    // 1. 创建uvm_event
    uvm_event ev = new("int_data_ev");

    // 2. 生产者：触发event并传递int数据
    fork
      begin
        int send_data = 100; // 要传递的int数据
        uvm_event_data_carrier carrier = new();
        carrier.set_int_data(send_data); // 把int数据存入载体

        #10;
        ev.trigger(carrier); // 触发event，传递载体对象
        `uvm_info("PRODUCER", $sformatf("触发event，传递int数据: %0d", send_data), UVM_MEDIUM);
      end
    join_none

    // 3. 消费者：等待event并提取int数据
    fork
      begin
        uvm_object tmp_obj;
        uvm_event_data_carrier recv_carrier;        
        // 等待event触发并获取携带的对象
        ev.wait_trigger_data(tmp_obj);
        
        // 类型转换（从uvm_object转为载体类）

        if(!$cast(recv_carrier, tmp_obj)) begin
          `uvm_error("CAST_ERR", "类型转换失败！")
        end else begin
          // 提取int数据
          int recv_data = recv_carrier.get_int_data();
          `uvm_info("CONSUMER", $sformatf("收到event，提取int数据: %0d", recv_data), UVM_MEDIUM);
        end
      end
    join

    // 4. 扩展：传递多个int数据（载体类可承载多个）
    fork
      begin
        uvm_event_data_carrier carrier2 = new();
        carrier2.int_data = 200;
        carrier2.bit_data = 32'h12345678;
        #20 ev.trigger(carrier2);
        `uvm_info("PRODUCER", "传递多个类型数据: int=200, bit=0x12345678", UVM_MEDIUM);
      end
    join_none

    fork
      begin
        uvm_object tmp_obj2;
        uvm_event_data_carrier recv_carrier2;        
        ev.wait_trigger_data(tmp_obj2);

        $cast(recv_carrier2, tmp_obj2);
        `uvm_info("CONSUMER", $sformatf("收到多类型数据：int=%0d, bit=0x%0h", 
                 recv_carrier2.int_data, recv_carrier2.bit_data), UVM_MEDIUM);
      end
    join
  end
endmodule