`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class hex_txt_parser extends uvm_object;
  `uvm_object_utils(hex_txt_parser)
  
  function new(string name = "hex_txt_parser");
    super.new(name);
  endfunction

  // ========== 原有功能：解析为一维数组（所有字节合并） ==========
  virtual task parse_hex_txt(string txt_path, ref bit[7:0] data[]);
    int file_hdl;
    string line, temp_line;
    int unsigned hex_val;
    int line_num = 0;
    int idx, ret;
    
    data.delete(); // 清空原有数据
    
    if (txt_path == "") begin
      `uvm_error(get_full_name(), "File path is empty");
      return;
    end
    
    file_hdl = $fopen(txt_path, "r");
    if (file_hdl == 0) begin
      `uvm_error(get_full_name(), $sformatf("Cannot open file: %s", txt_path));
      return;
    end
    
    while (!$feof(file_hdl)) begin
      line_num++;
      if ($fgets(line, file_hdl) == 0) continue;
      clean_line(line);
      if (line.len() == 0) continue;
      
      temp_line = line;
      idx = 0;
      while (1) begin
        ret = $sscanf(temp_line.substr(idx, temp_line.len()-1), "0x%2h", hex_val);
        if (ret == 1) begin
          data = new[data.size() + 1] (data);
          data[data.size()-1] = hex_val[7:0];
          idx += 4;
          while (idx < temp_line.len() && temp_line[idx] == " ") idx++;
        end else begin
          if (idx < temp_line.len()) begin
            `uvm_warning(get_full_name(), 
                        $sformatf("Line %0d: Ignored characters: %s", 
                                 line_num, temp_line.substr(idx, temp_line.len()-1)));
          end
          break;
        end
      end
    end
    
    $fclose(file_hdl);
    `uvm_info(get_full_name(), 
              $sformatf("Successfully parsed %0d bytes (1D array) from %s", 
                       data.size(), txt_path), 
              UVM_MEDIUM);
  endtask

  // ========== 新增功能：按行解析为二维队列（每行一个内层队列） ==========
  virtual task parse_hex_txt_by_line(string txt_path, ref bit[7:0] data[$][$]);
    int file_hdl;
    string line, temp_line;
    int unsigned hex_val;
    int line_num = 0;
    int idx, ret;
    
    data.delete(); // 清空原有二维队列
    
    if (txt_path == "") begin
      `uvm_error(get_full_name(), "File path is empty");
      return;
    end
    
    file_hdl = $fopen(txt_path, "r");
    if (file_hdl == 0) begin
      `uvm_error(get_full_name(), $sformatf("Cannot open file: %s", txt_path));
      return;
    end
    
    // 逐行解析：每行对应二维队列的一行
    while (!$feof(file_hdl)) begin
      // 解析当前行的所有字节，存入内层队列
      bit[7:0] line_data[$]; // 存储当前行的字节      
      line_num++;
      if ($fgets(line, file_hdl) == 0) continue;
      
      // 清理当前行（去换行、去首尾空格）
      clean_line(line);
      if (line.len() == 0) begin
        `uvm_info(get_full_name(), $sformatf("Line %0d: Empty line, skip", line_num), UVM_LOW);
        continue;
      end
      

      temp_line = line;
      idx = 0;
      
      while (1) begin
        // 提取当前行的单个0xXX格式数据
        ret = $sscanf(temp_line.substr(idx, temp_line.len()-1), "0x%2h", hex_val);
        if (ret == 1) begin
          line_data.push_back(hex_val[7:0]); // 加入当前行的队列
          idx += 4; // 跳过"0xXX"（4个字符：0、x、两位十六进制）
          
          // 跳过空格（多个数据间的分隔）
          while (idx < temp_line.len() && temp_line[idx] == " ") idx++;
        end else begin
          // 该行解析完毕，处理剩余无效字符
          if (idx < temp_line.len()) begin
            `uvm_warning(get_full_name(), 
                        $sformatf("Line %0d: Ignored characters: %s", 
                                 line_num, temp_line.substr(idx, temp_line.len()-1)));
          end
          break;
        end
      end
      
      // 将当前行的解析结果加入二维队列
      data.push_back(line_data);
      `uvm_info(get_full_name(), 
                $sformatf("Line %0d parsed: %0d bytes", line_num, line_data.size()), 
                UVM_LOW);
    end
    
    $fclose(file_hdl);
    `uvm_info(get_full_name(), 
              $sformatf("Successfully parsed %0d lines (2D queue) from %s", 
                       data.size(), txt_path), 
              UVM_MEDIUM);
  endtask
  
  // 辅助函数：清理行（去换行、去首尾空格）
  function void clean_line(ref string line);
    int len = line.len();
    
    // 移除换行符(\n)和回车符(\r)
    if (len > 0 && line[len-1] == "\n") 
      line = line.substr(0, len-2);
    if (line.len() > 0 && line[line.len()-1] == "\r")
      line = line.substr(0, line.len()-2);
      
    // 移除开头和结尾的空格
    trim_string(line);
  endfunction
  
  // 辅助函数：移除字符串首尾空格
  function void trim_string(ref string s);
    int start = 0, end_pos = s.len() - 1;
    
    while (start < s.len() && s[start] == " ") start++;
    while (end_pos >= 0 && s[end_pos] == " ") end_pos--;
      
    if (end_pos >= start)
      s = s.substr(start, end_pos);
    else
      s = "";
  endfunction
  
endclass
module test;
  // 一维数组（原有功能）
  bit[7:0] mem_data_1d[];
  // 二维队列（新增按行解析）
  bit[7:0] mem_data_2d[$][$];
  
  hex_txt_parser parser = new("parser");
  // 替换为你的测试文件路径
  string test_file = "/mnt/disk_0/IC/uvm_lib/common_tools/hex_data.txt";
  
  initial begin
    $display("=== 开始解析文件: %s ===", test_file);
    
    // 1. 验证原有一维解析功能
    $display("\n----- 1. 一维数组解析结果 -----");
    parser.parse_hex_txt(test_file, mem_data_1d);
    if (mem_data_1d.size() > 0) begin
      $display("总字节数: %0d", mem_data_1d.size());
      for (int i = 0; i < mem_data_1d.size() && i < 32; i++) begin // 只打印前32个
        if (i % 16 == 0) $write("\n[%03d]: ", i);
        $write("%02h ", mem_data_1d[i]);
      end
    end else begin
      $display("一维解析无数据");
    end
    
    // 2. 验证新增按行解析功能（核心）
    $display("\n\n----- 2. 二维队列（按行）解析结果 -----");
    parser.parse_hex_txt_by_line(test_file, mem_data_2d);
    
    if (mem_data_2d.size() > 0) begin
      $display("总行数: %0d", mem_data_2d.size());
      // 逐行打印
      foreach(mem_data_2d[i]) begin
        $display("\n第%0d行 (共%0d字节):", i+1, mem_data_2d[i].size());
        $write("  ");
        foreach(mem_data_2d[i][j]) begin
          if (j % 16 == 0 && j != 0) $write("\n  ");
          $write("%02h ", mem_data_2d[i][j]);
        end
        $display("");
      end
    end else begin
      $display("二维解析无数据");
    end
    
    // 3. 验证特定行/列的数据
    if (mem_data_2d.size() >= 2) begin
      $display("\n----- 3. 数据验证 -----");
      $display("第1行第1个字节: 0x%02h", mem_data_2d[0][0]);
      $display("第2行最后1个字节: 0x%02h", mem_data_2d[1][mem_data_2d[1].size()-1]);
    end
  end
endmodule

