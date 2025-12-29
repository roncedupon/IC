`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

// 先在类中声明（对应 extern 声明）
class mem_utils #(parameter DATA_WIDTH = 32) extends uvm_object;
  `uvm_object_param_utils(mem_utils#(DATA_WIDTH))

  // 端序配置
  typedef enum {BIN_LITTLE_ENDIAN, BIN_BIG_ENDIAN} bin_endian_e;
  bin_endian_e endian_mode = BIN_LITTLE_ENDIAN;

  // 外部声明
  extern virtual task bin2mem(string bin_path, ref bit[31:0] mem_32bit[]);

  function new(string name = "mem_utils");
    super.new(name);
  endfunction
endclass

// 任务实现（核心逻辑）
task mem_utils::bin2mem(string bin_path, ref bit[31:0] mem_32bit[]);
  int file_handle;
  byte byte_buf[$];
  int byte_cnt;
  int word_cnt;
  int remain_byte;
  int c;
  bit[31:0] temp_word;
  bit[31:0] temp_queue[$];  // 使用队列临时存储
  
  // 参数检查
  if (bin_path == "") begin
    `uvm_fatal(get_full_name(), "bin2mem: Binary file path is empty!")
    return;
  end

  // 打开二进制文件
  file_handle = $fopen(bin_path, "rb");
  if (file_handle == 0) begin
    `uvm_fatal(get_full_name(), $sformatf("bin2mem: Open file %s failed!", bin_path))
    return;
  end

  // 读取所有字节数据（使用 $fgetc 循环，二进制更可靠）
  byte_buf.delete();
  while ((c = $fgetc(file_handle)) != -1) begin
    // $fgetc 返回 -1 表示 EOF
    byte_buf.push_back(byte'(c & 8'hFF));
  end
  byte_cnt = byte_buf.size();
  for (int i = 0; i < byte_cnt; i++) begin
    $display("byte_buf[%0d] = 0x%02h", i, byte_buf[i]);
  end
  $display("byte_cnt = %0d", byte_cnt);
  `uvm_info(get_full_name(), $sformatf("bin2mem: Read %0d bytes from %s (fgetc)", byte_cnt, bin_path), UVM_MEDIUM)
  $fclose(file_handle);

  if (byte_cnt == 0) begin
    `uvm_warning(get_full_name(), "bin2mem: Binary file is empty!")
    mem_32bit = '{};
    return;
  end

  word_cnt = byte_buf.size() / 4;
  remain_byte = byte_buf.size() % 4;
  temp_queue.delete();  // 清空队列

  // 处理完整的32bit字
  for (int i = 0; i < word_cnt; i++) begin
    temp_word = '0;
    case (endian_mode)
      BIN_LITTLE_ENDIAN: begin
        temp_word[7:0]   = byte_buf[i*4 + 0];
        temp_word[15:8]  = byte_buf[i*4 + 1];
        temp_word[23:16] = byte_buf[i*4 + 2];
        temp_word[31:24] = byte_buf[i*4 + 3];
      end
      BIN_BIG_ENDIAN: begin
        temp_word[31:24] = byte_buf[i*4 + 0];
        temp_word[23:16] = byte_buf[i*4 + 1];
        temp_word[15:8]  = byte_buf[i*4 + 2];
        temp_word[7:0]   = byte_buf[i*4 + 3];
      end
    endcase
    temp_queue.push_back(temp_word);
    $display("temp_word = 0x%08h", temp_word);
  end

  // 处理剩余不足4字节的情况
  if (remain_byte > 0) begin
    temp_word = '0;
    `uvm_warning(get_full_name(), $sformatf("bin2mem: File length(%0d) not multiple of 4, pad 0 for remaining %0d bytes", byte_cnt, remain_byte))
    for (int j = 0; j < remain_byte; j++) begin
      case (endian_mode)
        BIN_LITTLE_ENDIAN: temp_word[j*8 +: 8] = byte_buf[word_cnt*4 + j];
        BIN_BIG_ENDIAN:    temp_word[31 - j*8 -: 8] = byte_buf[word_cnt*4 + j];
      endcase
    end
    temp_queue.push_back(temp_word);
  end

  // 将队列转换为动态数组
  mem_32bit = new[temp_queue.size()];
  for (int i = 0; i < temp_queue.size(); i++) begin
    mem_32bit[i] = temp_queue[i];
  end

  `uvm_info(get_full_name(), $sformatf("bin2mem: Convert to %0d 32bit words (endian: %0s)", mem_32bit.size(), endian_mode.name()), UVM_MEDIUM)
endtask

// 测试模块
module tb_top;
  initial begin
    mem_utils#(32) mem_util = new("mem_util");
    bit[31:0] mem_array[];
    string bin_file = "/mnt/disk_0/IC/uvm_lib/common_tools/test.bin";
    
    mem_util.endian_mode = mem_util.BIN_LITTLE_ENDIAN;
    mem_util.bin2mem(bin_file, mem_array);
    
    // 打印结果验证
    if (mem_array.size() > 0) begin
      $display("\n=== 解析结果 (共 %0d 个32位字) ===", mem_array.size());
      for (int i = 0; i < mem_array.size(); i++) begin
        if (i % 4 == 0) $write("\nmem_array[%03d]: ", i);
        $write("0x%08h ", mem_array[i]);
      end
      $display("\n");
    end else begin
      $display("没有解析到数据");
    end
  end
endmodule