// 改用ref参数传递结果，函数返回void（兼容所有版本）
function int get_highest_bit_idx(logic [31:0] mask);
  if(mask == '0) return 0;
  for(int i=31;i>0;i--) begin
    if(mask[i]) begin
      return i+1;
    end
  end
endfunction

function void get_plane_sel(bit [7:0] mask, int nsu_addr, ref bit [7:0] plane_sel_list[$]);
  // 所有变量提前到函数开头定义（适配老旧编译器）
    bit [7:0] temp_plane_sel;
    int start_addr_4k;
    int end_addr_4k;
    int current_addr_4k;
    int plane_idx;
    int i;
    int curr_4k;
    int mask_bit;
    int length_4k;
    length_4k = get_highest_bit_idx(mask) * 4; // 计算长度（4KB粒度）
    // 清空结果数组
    plane_sel_list.delete();

    // 地址换算：nsu_addr(4KB粒度) → 起始/结束4KB地址
    start_addr_4k = nsu_addr;
    end_addr_4k = nsu_addr + length_4k - 1;
    current_addr_4k = start_addr_4k;

    // 循环处理：每次最多处理8个4KB（32KB），直到读完所有长度
    while (current_addr_4k <= end_addr_4k) begin
        temp_plane_sel = 8'h00; // 初始化当前组plane_sel
        plane_idx = 0;          // plane索引（0~7）

        // 处理当前32KB段内的每个4KB地址
        i = 0;
        while (i < 8) begin
            curr_4k = current_addr_4k + i;
            if (curr_4k > end_addr_4k) break; // 超出总长度则停止

            // 计算curr_4k所属的mask bit（16KB粒度 = 4个4KB）
            mask_bit = curr_4k / 4;
            if (mask_bit > 7) break; // 超出8个mask bit（128KB）则停止

            // mask允许时，选中对应plane
            if (mask[mask_bit] == 1'b1) begin
                temp_plane_sel[plane_idx] = 1'b1;
            end

            plane_idx = plane_idx + 1;
            i = i + 1;
        end

        // 将当前组plane_sel加入结果列表
        plane_sel_list.push_back(temp_plane_sel);
        // 移动到下一个32KB段
        current_addr_4k = current_addr_4k + 8;
    end
endfunction

// 测试模块：所有变量提前定义，适配老旧编译器
module test_plane_sel;
  // 变量提前定义（不内联）
  bit [7:0] result[$];
  int test_case;

  initial begin
    // 测试用例1：mask=8'h01（0~16KB允许），nsu_addr=0，length_4k=8（32KB）
    get_plane_sel(8'h01, 0, result);
    $display("Test1 plane_sel list:");
    test_case = 0;
    while (test_case < result.size()) begin
      $display("  Group %0d: 0x%02x", test_case, result[test_case]);
      test_case = test_case + 1;
    end

    // 测试用例2：mask=8'h03（0~32KB允许），nsu_addr=2，length_4k=9（36KB）
    get_plane_sel(8'h03, 2, result);
    $display("\nTest2 plane_sel list:");
    test_case = 0;
    while (test_case < result.size()) begin
      $display("  Group %0d: 0x%02x", test_case, result[test_case]);
      test_case = test_case + 1;
    end
  end
endmodule