module demo;
  // 模拟你的原始数据：1个2048bit的数组（8个256bit块）
  bit [2047:0] tsu_nsu_rdata[1];

  // 模拟你的目标结构体
  typedef struct packed {
    bit [7:0]  ost_id;
    bit [7:0]  offset_id;
    bit [31:0] err;
    bit [29:0] nsu_addr;
    bit        vld;
  } pp_struct;

  pp_struct pp[8]; // 8个结构体实例

  initial begin
    // 初始化测试数据
    tsu_nsu_rdata[0] = 2048'hDEADBEEF_CAFE_BABE_12345678;
    $display("Original data: 0x%0h", tsu_nsu_rdata[0]);

    // 调用两种方法
    rdata_assignment_base_var();

  end

  // 方法1：基址变量法（最常用，兼容性最好）
  function void rdata_assignment_base_var();
    bit [255:0] slice_data;

    $display("\n--- Method 1: Base Variable Method ---");
    for(int i=0; i<8; i++) begin
        // slice_data = tsu_nsu_rdata[0][(i+1)*256 - 1 : i*256];//Error-[IRIPS] Illegal range in part select
        slice_data = (tsu_nsu_rdata[0]>>i*256)&({256{1'b1}});

        pp[i].ost_id      = slice_data[7:0];
        pp[i].offset_id   = slice_data[15:8];
        pp[i].err         = slice_data[47:16];
        pp[i].nsu_addr    = slice_data[83:54];
        pp[i].vld         = slice_data[255];

      $display("i=%0d: ost_id=0x%0h, offset_id=0x%0h, vld=%0b",
               i, pp[i].ost_id, pp[i].offset_id, pp[i].vld);
    end
  endfunction



endmodule