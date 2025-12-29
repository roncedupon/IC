`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

class hex_txt_parser extends uvm_object;
  `uvm_object_utils(hex_txt_parser)
  
  function new(string name = "hex_txt_parser");
    super.new(name);
  endfunction
  
  // 解析0xXX格式txt文件
  virtual task parse_hex_txt(string txt_path, ref bit[7:0] data[]);
    int file_hdl;
    string line, temp_line;
    int unsigned hex_val;
    int line_num = 0;
    int idx, ret;
    string token;
    
    // 清空数组
    data.delete();
    
    // 打开文件
    if (txt_path == "") begin
      `uvm_error(get_full_name(), "File path is empty");
      return;
    end
    
    file_hdl = $fopen(txt_path, "r");
    if (file_hdl == 0) begin
      `uvm_error(get_full_name(), $sformatf("Cannot open file: %s", txt_path));
      return;
    end
    
    // 逐行读取
    while (!$feof(file_hdl)) begin
      line_num++;
      if ($fgets(line, file_hdl) == 0) continue;
      
      // 移除换行符
      clean_line(line);
      
      if (line.len() == 0) continue;
      
      temp_line = line;
      idx = 0;
      
      // 分割token
      while (1) begin
        // 使用$sscanf提取token
        ret = $sscanf(temp_line.substr(idx, temp_line.len()-1), 
                     "0x%2h", hex_val);
        
        if (ret == 1) begin
          // 成功解析到一个十六进制数
          data = new[data.size() + 1] (data);
          data[data.size()-1] = hex_val[7:0];
          idx += 4;  // 跳过"0xXX"
          
          // 跳过空格
          while (idx < temp_line.len() && temp_line[idx] == " ")
            idx++;
        end else begin
          // 没有更多token，跳出循环
          if (idx < temp_line.len()) begin
            // 有剩余字符但不是十六进制格式
            `uvm_warning(get_full_name(), 
                        $sformatf("Line %0d: Ignored characters: %s", 
                                 line_num, 
                                 temp_line.substr(idx, temp_line.len()-1)));
          end
          break;
        end
      end
    end
    
    $fclose(file_hdl);
    `uvm_info(get_full_name(), 
              $sformatf("Successfully parsed %0d bytes from %s", 
                       data.size(), txt_path), 
              UVM_MEDIUM);
  endtask
  
  // 辅助函数：清理行
  function void clean_line(ref string line);
    int len = line.len();
    
    // 移除换行符
    if (len > 0 && line[len-1] == "\n") 
      line = line.substr(0, len-2);
    if (line.len() > 0 && line[line.len()-1] == "\r")
      line = line.substr(0, line.len()-2);
      
    // 移除开头和结尾的空格
    trim_string(line);
  endfunction
  
  // 移除字符串开头和结尾的空格
  function void trim_string(ref string s);
    int start = 0, end_pos = s.len() - 1;
    
    // 找到第一个非空格字符
    while (start < s.len() && s[start] == " ")
      start++;
      
    // 找到最后一个非空格字符
    while (end_pos >= 0 && s[end_pos] == " ")
      end_pos--;
      
    if (end_pos >= start)
      s = s.substr(start, end_pos);
    else
      s = "";
  endfunction
  
endclass

// 测试模块
module test;
  bit[7:0] mem_data[];
  hex_txt_parser parser = new("parser");
  string test_file = "/mnt/disk_0/IC/uvm_lib/common_tools/hex_data.txt";
  
  initial begin
    $display("=== 开始解析文件: %s ===", test_file);
    
    // 解析文件
    parser.parse_hex_txt(test_file, mem_data);
    
    // 打印结果
    if (mem_data.size() > 0) begin
      $display("\n解析结果 (共 %0d 个字节):", mem_data.size());
      for (int i = 0; i < mem_data.size(); i++) begin
        if (i % 16 == 0) $write("\n[%03d]: ", i);
        $write("%02h ", mem_data[i]);
      end
      $display("\n");
    end else begin
      $display("没有解析到数据");
    end
    
    // 验证特定值
    if (mem_data.size() >= 2) begin
      $display("前两个字节: 0x%02h 0x%02h", mem_data[0], mem_data[1]);
    end
  end
endmodule