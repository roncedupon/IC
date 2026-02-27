// 定义结构体：存储每轮的plane_sel结果
typedef struct {
    int         round_num;       // 总读取轮次（动态计算）
    logic [7:0] plane_sel[$];     // 每轮的plane_sel（8位，bit0=plane0，bit7=plane7）
    int         nsu_addr_que[$];    // 每轮对应的起始nsu_addr（便于验证地址）
} plane_sel_result_t;

// 核心函数：动态计算轮数+通用plane映射（无硬编码）
function automatic plane_sel_result_t calc_plane_sel(int nsu_addr, logic [31:0] mask);
    // ===================== 所有变量集中在函数开头声明 =====================

    int tmp_addr;
    bit [7:0] temp_plane_sel;
    plane_sel_result_t result;          // 最终结果结构体
    // ====================================================================
    // 1. 预处理：统计有效mask位及其位置
    tmp_addr=nsu_addr;
    for(int i=0;i<32;i+=2)begin
        temp_plane_sel=8'h00;
        if(mask[i])begin
            temp_plane_sel[3:0]='hf;
        end
        if(mask[i+1])begin
            temp_plane_sel[7:4]='hf;
        end
      
        if(mask[i]||mask[i+1])begin
            result.plane_sel.push_back(temp_plane_sel);
            result.round_num=result.round_num+1;
            result.nsu_addr_que.push_back(tmp_addr);
        end
        tmp_addr=tmp_addr+8;  
    end
    return result;
endfunction

// 测试用例：动态适配输入参数
module tb_plane_sel_final;
    plane_sel_result_t res;
    bit [31:0] mask;
    int        nsu_addr;

    // 封装动态打印函数
    task automatic print_result(int nsu_addr, logic [31:0] mask, plane_sel_result_t res);
        $display("=== 测试用例：nsu_addr=%0d (0x%0h), mask=32'b%0b ===", 
                 nsu_addr, nsu_addr, mask);
        $display("总轮次：%0d", res.round_num);
        for (int i=0; i<res.round_num; i++) begin
            $display("第%0d轮 - 起始地址：0x%0h, plane_sel：%8b", 
                     i+1, res.nsu_addr_que[i], res.plane_sel[i]);
        end
        $display("----------------------------------------");
    endtask

    initial begin
        // 测试用例1：mask=1100001 → 动态计算3轮
        nsu_addr = 0;
        mask     = 32'b1100001;
        res      = calc_plane_sel(nsu_addr, mask);
        print_result(nsu_addr, mask, res);

        nsu_addr = 4;
        mask     = 32'b1100001;
        res      = calc_plane_sel(nsu_addr, mask);
        print_result(nsu_addr, mask, res);

        // 测试用例2：mask=10011 → 动态计算1轮（有效位0-4，覆盖1个64KB段）
        nsu_addr = 0;
        mask     = 32'b10011;
        res      = calc_plane_sel(nsu_addr, mask);
        print_result(nsu_addr, mask, res);

        nsu_addr = 0;
        mask     = 32'h800;
        res      = calc_plane_sel(nsu_addr, mask);
        print_result(nsu_addr, mask, res);

        $finish;
    end
endmodule