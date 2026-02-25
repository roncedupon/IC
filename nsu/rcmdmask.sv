`ifndef RCMD_MASK_SCOPE_DEMO_SV
`define RCMD_MASK_SCOPE_DEMO_SV

// 定义包含全局变量 + 函数的类（模拟你的场景）
class transaction;
  // 类全局变量 rcmd_mask
  bit [31:0] rcmd_mask;

  // 构造函数：初始化全局变量（可选）
  function new();
    rcmd_mask = 32'h12345678; // 初始值非0，用于区分
  endfunction

  // 核心函数：函数内定义同名局部变量 rcmd_mask，模拟你的随机化逻辑
  function void randomize_rcmd_mask();
    // 函数内局部变量（和全局变量同名）
    bit [31:0] rcmd_mask=0; // 初始化为特定值，便于区分
    int rand_status;

    $display("\n===== 函数内局部变量随机化 =====");
    // 随机化：约束冲突（和你场景一致）
    rand_status = randomize(rcmd_mask) with {//注意这里随机的是全局变量
      rcmd_mask[0]   == rcmd_mask[1];
      rcmd_mask[2]   == rcmd_mask[3];
      rcmd_mask[4]   == rcmd_mask[5];
      rcmd_mask[6]   == rcmd_mask[7];
      rcmd_mask[8]   == rcmd_mask[9];
      rcmd_mask[10]  == rcmd_mask[11];
      rcmd_mask[12]  == rcmd_mask[13];
      rcmd_mask[14]  == rcmd_mask[15];
      rcmd_mask[16]  == rcmd_mask[17];
      rcmd_mask[18]  == rcmd_mask[19];
      rcmd_mask[20]  == rcmd_mask[21];
      rcmd_mask[22]  == rcmd_mask[23];
      rcmd_mask[24]  == rcmd_mask[25];
      rcmd_mask[26]  == rcmd_mask[27];
      rcmd_mask[28]  == rcmd_mask[29];
      rcmd_mask[30]  == rcmd_mask[31];
      rcmd_mask[31:16] == 0;
      rcmd_mask > 0; // 约束冲突点
    };
        // 打印函数内局部变量结果
    $display("(1)函数内局部变量 rand_status：%0d（0=失败，1=成功）", rand_status);
    $display("(1)函数内局部变量 rcmd_mask：0x%08x", rcmd_mask);
    $display("(1)函数内全局变量 rcmd_mask：0x%08x", this.rcmd_mask);
    do begin
      rcmd_mask=$urandom(); // 随机初始值，增加不确定性
      $display("尝试随机化：rcmd_mask=0x%08x", rcmd_mask);
      rcmd_mask[0]   = rcmd_mask[1];
      rcmd_mask[2]   = rcmd_mask[3];
      rcmd_mask[4]   = rcmd_mask[5];
      rcmd_mask[6]   = rcmd_mask[7];
      rcmd_mask[8]   = rcmd_mask[9];
      rcmd_mask[10]  = rcmd_mask[11];
      rcmd_mask[12]  = rcmd_mask[13];
      rcmd_mask[14]  = rcmd_mask[15];
      rcmd_mask[16]  = rcmd_mask[17];
      rcmd_mask[18]  = rcmd_mask[19];
      rcmd_mask[20]  = rcmd_mask[21];
      rcmd_mask[22]  = rcmd_mask[23];
      rcmd_mask[24]  = rcmd_mask[25];
      rcmd_mask[26]  = rcmd_mask[27];
      rcmd_mask[28]  = rcmd_mask[29];
      rcmd_mask[30]  = rcmd_mask[31];
      rcmd_mask[31:16] = 0;
    end while(rcmd_mask==0);

    // 打印函数内局部变量结果

    $display("(2)函数内局部变量 rcmd_mask：0x%08x", rcmd_mask);
    $display("(2)函数内全局变量 rcmd_mask：0x%08x", this.rcmd_mask);
  endfunction

  // 打印全局变量的函数
//   function void print_global_rcmd_mask();
//     $display("\n===== 类全局变量 =====");
//     $display("类全局变量 rcmd_mask：0x%08x", rcmd_mask);
//   endfunction
endclass

// 测试入口
module demo_tb;
  initial begin
    transaction tr;
    int rand_status;    
    tr = new(); // 创建类实例（全局变量初始化为0x12345678）

    // 1. 调用函数：随机化局部变量
    tr.randomize_rcmd_mask();

    // 2. 打印全局变量：验证是否被修改
    // tr.print_global_rcmd_mask();

  end
endmodule

`endif