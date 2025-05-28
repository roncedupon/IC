//使用%p打印结构体
module struct_print_example;

  // 定义你的结构体 (与你图片中的类似)
  typedef struct packed {
    bit [5:0]  rsv;         // bit[47:42]
    bit        tia_en;      // bit[41:41]
    bit        proc_id;     // bit[40:40]
    bit [7:0]  start_id;    // bit[39:32]
    bit [7:0]  end_id;      // bit[31:24]
    bit [11:0] tia_start_id; // bit[23:12]
    bit [11:0] tia_end_id;   // bit[11:0]
  } dscarrayctrl_t;
    // 原始的命名聚合赋值
  dscarrayctrl_t new_ctrl_data;
  initial begin
        new_ctrl_data = '{
        6'h05,
        1'b1,
        1'b1,
        8'h10,
        8'h20,
        12'h300,
        12'h400
    };
    $display("\n----------------------------------------");
    $display("Printing struct initialized with positional aggregate assignment:");
    $display("new_ctrl_data = %p", new_ctrl_data);
    $display("----------------------------------------");
  end

endmodule