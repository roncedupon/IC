`timescale 1ns/1ps
module tb;

// 定义32bit无符号mask变量
bit [31:0] rcmd_mask;

initial begin
  $display("===== 循环随机生成10个32bit rcmd_mask =====");
  // 循环10次，每次随机赋值rcmd_mask
  for(int i=0; i<10; i++) begin
    // 核心：用randomize()随机化变量（SV标准随机函数）
    // void'() 忽略randomize()的布尔返回值，避免仿真警告
    void'(randomize(rcmd_mask));
    
    // 打印每次的随机结果（验证）
    $display("第%02d次随机：0x%08h (十进制：%0d)", 
             i+1, rcmd_mask, rcmd_mask);
  end
  $finish;
end

endmodule