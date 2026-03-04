// ===================== 结构体定义（保持不变） =====================
typedef struct {
    int         round_num;                 // 总读取轮次
    logic [7:0] plane_sel[$];               // 每轮的plane_sel
    int         group0_nsu_addr_que[$];     // 每轮的group0起始地址
    int         group1_nsu_addr_que[$];     // 每轮的group1起始地址
    int         group0_ost_id_que[$];        // 每轮的group0_ost_id
    int         group1_ost_id_que[$];        // 每轮的group1_ost_id
} plane_sel_result_t;

// ===================== 原有核心函数（完全未修改） =====================
function automatic plane_sel_result_t calc_plane_sel(
    int group0_ost_id,   
    int group1_ost_id,   
    int nsu_addr, 
    logic [31:0] mask
);
    int tmp_addr;
    bit [7:0] temp_plane_sel;
    plane_sel_result_t result;
    int plane_offset;
    
    tmp_addr=nsu_addr;
    plane_offset = nsu_addr % 8;
    
    if(plane_offset==0)begin
        for(int i=0;i<=30;i+=2)begin
            temp_plane_sel=8'h00;
            if(mask[i])begin
                temp_plane_sel[3:0]='hf;
            end
            if(mask[i+1])begin
                temp_plane_sel[7:4]='hf;
            end
        
            if(mask[i]||mask[i+1])begin
                result.plane_sel.push_back(temp_plane_sel);
                result.group0_nsu_addr_que.push_back(tmp_addr);
                result.group1_nsu_addr_que.push_back(tmp_addr);
                result.group0_ost_id_que.push_back(group0_ost_id);
                result.group1_ost_id_que.push_back(group1_ost_id);
                result.round_num=result.round_num+1;
            end
            tmp_addr=tmp_addr+8;  
        end
    end
    else begin
        if(mask[0])begin
            temp_plane_sel=8'hf0;
            result.plane_sel.push_back(temp_plane_sel);
            result.group0_nsu_addr_que.push_back(tmp_addr);
            result.group1_nsu_addr_que.push_back(tmp_addr);
            result.group0_ost_id_que.push_back(group0_ost_id);
            result.group1_ost_id_que.push_back(group1_ost_id);
            result.round_num=result.round_num+1;
        end
        tmp_addr=tmp_addr+4;
        for(int i=1;i<=30;i+=2)begin
            temp_plane_sel=8'h00;
            if(mask[i])begin
                temp_plane_sel[3:0]='hf;
            end
            if(mask[i+1])begin
                temp_plane_sel[7:4]='hf;
            end
        
            if(mask[i]||mask[i+1])begin
                result.plane_sel.push_back((temp_plane_sel >> plane_offset) | (temp_plane_sel << (8 - plane_offset)));
                result.group0_nsu_addr_que.push_back(tmp_addr);
                result.group1_nsu_addr_que.push_back(tmp_addr);
                result.group0_ost_id_que.push_back(group0_ost_id);
                result.group1_ost_id_que.push_back(group1_ost_id);
                result.round_num=result.round_num+1;
            end
            tmp_addr=tmp_addr+8;  
        end
    end
    return result;
endfunction

// ===================== 【核心修改】merge函数修正地址偏移逻辑 =====================
function automatic plane_sel_result_t merge_plane_sel_results(
    plane_sel_result_t res1,  // 第一个待合并的结果
    plane_sel_result_t res2   // 第二个待合并的结果
);
    plane_sel_result_t merged_res;
    int max_rounds;
    // 定义地址偏移量常量（便于后续调整）
    localparam int GROUP0_OFFSET = 0; // group0（bit0-3）偏移0
    localparam int GROUP1_OFFSET = 4; // group1（bit4-7）偏移4

    // 1. 确定最大轮次数
    max_rounds = (res1.round_num > res2.round_num) ? res1.round_num : res2.round_num;

    // 2. 按轮次遍历，分别处理group0和group1
    for(int round_idx = 0; round_idx < max_rounds; round_idx++) begin
        logic [7:0] res1_plane = 8'h00;
        logic [7:0] res2_plane = 8'h00;
        logic [7:0] merged_plane = 8'h00;
        int res1_g0_addr = 0, res1_g1_addr = 0;
        int res2_g0_addr = 0, res2_g1_addr = 0;
        int merged_g0_addr = 0, merged_g1_addr = 0;
        int merged_g0_ost = 0, merged_g1_ost = 0;

        // 获取res1当前轮次的信息
        if(round_idx < res1.round_num) begin
            res1_plane = res1.plane_sel[round_idx];
            res1_g0_addr = res1.group0_nsu_addr_que[round_idx];
            res1_g1_addr = res1.group1_nsu_addr_que[round_idx];
        end

        // 获取res2当前轮次的信息
        if(round_idx < res2.round_num) begin
            res2_plane = res2.plane_sel[round_idx];
            res2_g0_addr = res2.group0_nsu_addr_que[round_idx];
            res2_g1_addr = res2.group1_nsu_addr_que[round_idx];
        end

        // ===================== 处理group0（plane0-plane3，bit0-3） =====================
        if(res1_plane[3:0] != 4'h0 && res2_plane[3:0] != 4'h0) begin
            merged_plane[3:0] = res1_plane[3:0] | res2_plane[3:0];
            merged_g0_addr = res1_g0_addr + GROUP0_OFFSET; // 核心：原始地址 + group0偏移
            merged_g0_ost = res1.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] 两者都选中，合并：%4b | %4b = %4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, res1_plane[3:0], res2_plane[3:0], merged_plane[3:0], 
                     res1_g0_addr, GROUP0_OFFSET, merged_g0_addr, merged_g0_ost);
        end
        else if(res1_plane[3:0] == 4'h0 && res2_plane[3:0] != 4'h0) begin
            merged_plane[3:0] = res2_plane[3:0];
            merged_g0_addr = res2_g0_addr + GROUP0_OFFSET; // 核心：原始地址 + group0偏移
            merged_g0_ost = res2.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] res1未选中，res2选中，采用res2：%4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[3:0], res2_g0_addr, GROUP0_OFFSET, merged_g0_addr, merged_g0_ost);
        end
        else if(res1_plane[3:0] != 4'h0 && res2_plane[3:0] == 4'h0) begin
            merged_plane[3:0] = res1_plane[3:0];
            merged_g0_addr = res1_g0_addr + GROUP0_OFFSET; // 核心：原始地址 + group0偏移
            merged_g0_ost = res1.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] res1选中，res2未选中，保留res1：%4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[3:0], res1_g0_addr, GROUP0_OFFSET, merged_g0_addr, merged_g0_ost);
        end
        else begin
            merged_plane[3:0] = 4'h0;
            merged_g0_addr = 0;
            merged_g0_ost = 0;
        end

        // ===================== 处理group1（plane4-plane7，bit4-7） =====================
        if(res1_plane[7:4] != 4'h0 && res2_plane[7:4] != 4'h0) begin
            merged_plane[7:4] = res1_plane[7:4] | res2_plane[7:4];
            merged_g1_addr = res1_g1_addr + GROUP1_OFFSET; // 核心：原始地址 + group1偏移
            merged_g1_ost = res1.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] 两者都选中，合并：%4b | %4b = %4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, res1_plane[7:4], res2_plane[7:4], merged_plane[7:4], 
                     res1_g1_addr, GROUP1_OFFSET, merged_g1_addr, merged_g1_ost);
        end
        else if(res1_plane[7:4] == 4'h0 && res2_plane[7:4] != 4'h0) begin
            merged_plane[7:4] = res2_plane[7:4];
            merged_g1_addr = res2_g1_addr + GROUP1_OFFSET; // 核心：原始地址 + group1偏移
            merged_g1_ost = res2.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] res1未选中，res2选中，采用res2：%4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[7:4], res2_g1_addr, GROUP1_OFFSET, merged_g1_addr, merged_g1_ost);
        end
        else if(res1_plane[7:4] != 4'h0 && res2_plane[7:4] == 4'h0) begin
            merged_plane[7:4] = res1_plane[7:4];
            merged_g1_addr = res1_g1_addr + GROUP1_OFFSET; // 核心：原始地址 + group1偏移
            merged_g1_ost = res1.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] res1选中，res2未选中，保留res1：%4b，原始addr=0x%0h，偏移=0x%0h，最终addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[7:4], res1_g1_addr, GROUP1_OFFSET, merged_g1_addr, merged_g1_ost);
        end
        else begin
            merged_plane[7:4] = 4'h0;
            merged_g1_addr = 0;
            merged_g1_ost = 0;
        end

        // ===================== 只有当至少一个group被选中时，才加入合并结果 =====================
        if(merged_plane != 8'h00) begin
            merged_res.plane_sel.push_back(merged_plane);
            merged_res.group0_nsu_addr_que.push_back(merged_g0_addr);
            merged_res.group1_nsu_addr_que.push_back(merged_g1_addr);
            merged_res.group0_ost_id_que.push_back(merged_g0_ost);
            merged_res.group1_ost_id_que.push_back(merged_g1_ost);
            merged_res.round_num++;
        end
    end

    return merged_res;
endfunction

// ===================== 打印函数（保持不变） =====================
task automatic print_result(int group0_ost_id, int group1_ost_id, int nsu_addr, logic [31:0] mask, plane_sel_result_t res);
    $display("\n=== 测试用例：group0_ost_id=%0d, group1_ost_id=%0d, nsu_addr=%0d (0x%0h), mask=32'b%0b ===", 
             group0_ost_id, group1_ost_id, nsu_addr, nsu_addr, mask);
    $display("总轮次：%0d", res.round_num);
    for (int i=0; i<res.round_num; i++) begin
        $display("第%0d轮 - group0: addr=0x%0h, ost_id=%0d; group1: addr=0x%0h, ost_id=%0d; plane_sel：%8b", 
                 i+1, res.group0_nsu_addr_que[i], res.group0_ost_id_que[i], 
                 res.group1_nsu_addr_que[i], res.group1_ost_id_que[i], res.plane_sel[i]);
    end
    $display("----------------------------------------");
endtask

// ===================== 打印合并结果的函数（保持不变） =====================
task automatic print_merged_result(plane_sel_result_t merged_res);
    $display("\n\n=== 合并后的最终结果 ===");
    $display("总轮次：%0d", merged_res.round_num);
    for (int i=0; i<merged_res.round_num; i++) begin
        $display("第%0d轮 - group0: addr=0x%0h, ost_id=%0d; group1: addr=0x%0h, ost_id=%0d; plane_sel：%8b", 
                 i+1, merged_res.group0_nsu_addr_que[i], merged_res.group0_ost_id_que[i], 
                 merged_res.group1_nsu_addr_que[i], merged_res.group1_ost_id_que[i], merged_res.plane_sel[i]);
    end
    $display("----------------------------------------");
endtask

// ===================== 测试用例（验证修正后的地址偏移逻辑） =====================
module tb_plane_sel_final;
    plane_sel_result_t res1, res2, merged_res;
    bit [31:0] mask;
    int        group0_ost_id, group1_ost_id, nsu_addr;

    initial begin
        // 1. 生成第一个测试用例（group0_ost_id=10, group1_ost_id=10, nsu_addr=0, mask=0000001）
        group0_ost_id = 10;
        group1_ost_id = 10;
        nsu_addr     = 0;
        mask         = 32'b0000001;
        res1         = calc_plane_sel(group0_ost_id, group1_ost_id, nsu_addr, mask);
        print_result(group0_ost_id, group1_ost_id, nsu_addr, mask, res1);

        // 2. 生成第二个测试用例（group0_ost_id=20, group1_ost_id=20, nsu_addr=8, mask=0000110）
        group0_ost_id = 20;
        group1_ost_id = 20;
        nsu_addr     = 8;
        mask         = 32'b0000110;
        res2         = calc_plane_sel(group0_ost_id, group1_ost_id, nsu_addr, mask);
        print_result(group0_ost_id, group1_ost_id, nsu_addr, mask, res2);

        // 3. 调用merge函数合并两个结果
        merged_res = merge_plane_sel_results(res1, res2);

        // 4. 打印合并后的结果
        print_merged_result(merged_res);

        $finish;
    end
endmodule