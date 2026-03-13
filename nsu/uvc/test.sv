`include "uvm_pkg.sv"
module nsu_fifo_full_demo;
  import uvm_pkg::*;

  // 你的 is_full 函数（放在类里，符合 UVM sequence 风格）
  class nsu_base_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(nsu_base_virtual_sequence)
    
    function new(string name = "nsu_base_virtual_sequence");
      super.new(name);
    endfunction

    // --------------------------
    // 核心 is_full 函数
    // --------------------------
    function bit is_full(
      int rd_ptr,  // 读指针
      int wr_ptr,  // 写指针
      int buf_depth // FIFO 深度
    );
      logic [31:0] next_wr_ptr;
      next_wr_ptr = (wr_ptr + 1) % buf_depth;
      is_full     = (next_wr_ptr == rd_ptr);
    endfunction

    // 测试函数：在 sequence 中调用 is_full
    task body();
      int buf_depth = 8;
      int rd_ptr, wr_ptr;
      bit full_flag;

      // 测试场景1：FIFO 满（wr_ptr=7, rd_ptr=0, buf_depth=8）
      rd_ptr = 0;
      wr_ptr = 7;
      full_flag = is_full(rd_ptr, wr_ptr, buf_depth);
      `uvm_info("TEST", $sformatf("wr_ptr=%0d, rd_ptr=%0d, buf_depth=%0d → is_full=%0d",
                                 wr_ptr, rd_ptr, buf_depth, full_flag), UVM_LOW)

      // 测试场景2：FIFO 未满（wr_ptr=2, rd_ptr=5, buf_depth=8）
      rd_ptr = 5;
      wr_ptr = 2;
      full_flag = is_full(rd_ptr, wr_ptr, buf_depth);
      `uvm_info("TEST", $sformatf("wr_ptr=%0d, rd_ptr=%0d, buf_depth=%0d → is_full=%0d",
                                 wr_ptr, rd_ptr, buf_depth, full_flag), UVM_LOW)

      // 测试场景3：FIFO 满（wr_ptr=6, rd_ptr=7, buf_depth=8）
      rd_ptr = 7;
      wr_ptr = 6;
      full_flag = is_full(rd_ptr, wr_ptr, buf_depth);
      `uvm_info("TEST", $sformatf("wr_ptr=%0d, rd_ptr=%0d, buf_depth=%0d → is_full=%0d",
                                 wr_ptr, rd_ptr, buf_depth, full_flag), UVM_LOW)

      // 测试场景4：FIFO 空（wr_ptr=0, rd_ptr=0, buf_depth=8）
      rd_ptr = 0;
      wr_ptr = 0;
      full_flag = is_full(rd_ptr, wr_ptr, buf_depth);
      `uvm_info("TEST", $sformatf("wr_ptr=%0d, rd_ptr=%0d, buf_depth=%0d → is_full=%0d",
                                 wr_ptr, rd_ptr, buf_depth, full_flag), UVM_LOW)
    endtask
  endclass

  // 测试环境入口
  initial begin
    nsu_base_virtual_sequence seq;
    seq = nsu_base_virtual_sequence::type_id::create("seq");
    seq.start(null); // 启动 sequence 执行测试
  end
endmodule