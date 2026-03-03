`timescale 1ns/1ps

module tb_dec_suc_bracket;

  // 模拟local变量：与你场景一致的取值（导致0xF4的关键值）
  bit[7:0] plane_sel  = 8'h0F;  // 0000 1111
  bit[7:0] crc_pass   = 8'hFF;  // 1111 1111
  bit[7:0] wbf_pass   = 8'hFE;  // 1111 1110
    bit[7:0] final_dec_suc;  
  // 定义事务数组（模拟你的tr[i]）
  typedef struct {
    bit[7:0] dec_suc;
  } trans_t;
  trans_t tr[8];  // tr[0]~tr[7]
    // 打印最终8位合并值

  // 任务1：测试“带括号”的正确写法
  task test_with_bracket();
    $display("[TEST_WITH_BRACKET] === Start Test: dec_suc == (plane_sel[i] ? (crc&wbf) : 1) ===");
    foreach(tr[i]) begin
      // 你预期的写法：括号包裹三元运算
      tr[i].dec_suc = (plane_sel[i] ? (crc_pass[i] & wbf_pass[i]) : 1'b1);
      $display("[TEST_WITH_BRACKET] i=%0d: plane_sel[%0d]=%0b, crc_pass[%0d]=%0b, wbf_pass[%0d]=%0b → dec_suc=%0b",
               i, i, plane_sel[i], i, crc_pass[i], i, wbf_pass[i], tr[i].dec_suc);
    end

    foreach(tr[i]) final_dec_suc[i] = tr[i].dec_suc;
    $display("[TEST_WITH_BRACKET] Final dec_suc (binary)=%8b (hex)=0x%02h", final_dec_suc, final_dec_suc);
  endtask

  // 任务2：测试“缺括号”的错误写法
  task test_without_bracket();
    bit[7:0] final_dec_suc;  
    $display("[TEST_WITHOUT_BRACKET] === Start Test: dec_suc == plane_sel[i] ? (crc&wbf) : 1 ===");
    foreach(tr[i]) begin
      // 错误写法：无括号包裹三元运算（优先级错误）
      tr[i].dec_suc = (tr[i].dec_suc == plane_sel[i]) ? (crc_pass[i] & wbf_pass[i]) : 1'b1;
      // 注：SV中赋值号=优先级最低，这里显式加()还原编译器解析逻辑
      $display("[TEST_WITHOUT_BRACKET] i=%0d: plane_sel[%0d]=%0b, crc_pass[%0d]=%0b, wbf_pass[%0d]=%0b → dec_suc=%0b",
               i, i, plane_sel[i], i, crc_pass[i], i, wbf_pass[i], tr[i].dec_suc);
    end
    // 打印最终8位合并值

    foreach(tr[i]) final_dec_suc[i] = tr[i].dec_suc;
    $display("[TEST_WITHOUT_BRACKET] Final dec_suc (binary)=%8b (hex)=0x%02h", final_dec_suc, final_dec_suc);
  endtask

  // 主流程：运行两个测试对比
  initial begin
    // 测试1：正确括号写法
    test_with_bracket();
    $display("--------------------------------------------------");
    // 测试2：错误缺括号写法
    test_without_bracket();

    $finish;
  end

endmodule