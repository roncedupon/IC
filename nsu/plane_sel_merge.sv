// ===================== 定义全局偏移量常量（确保一致性） =====================
localparam int GROUP0_OFFSET = 0; // group0（bit0-3）偏移0
localparam int GROUP1_OFFSET = 4; // group1（bit4-7）偏移4

// ===================== 结构体定义（保持不变） =====================
typedef struct {
    int         round_num;                 // 总读取轮次
    logic [7:0] plane_sel[$];               // 每轮的plane_sel
    int         group0_nsu_addr_que[$];     // 每轮的group0起始地址
    int         group1_nsu_addr_que[$];     // 每轮的group1起始地址
    int         group0_ost_id_que[$];        // 每轮的group0_ost_id
    int         group1_ost_id_que[$];        // 每轮的group1_ost_id
} plane_sel_result_t;

// ===================== 【核心修改】calc_plane_sel：生成时就区分group地址 =====================
function automatic plane_sel_result_t calc_plane_sel(
    int ost_id,              
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
            if(mask[i])
                temp_plane_sel[3:0]='hf;
            if(mask[i+1])
                temp_plane_sel[7:4]='hf;
        
            if(mask[i]||mask[i+1])begin
                result.plane_sel.push_back(temp_plane_sel);
                // 核心修改：生成时就加上偏移量
                result.group0_nsu_addr_que.push_back(tmp_addr + GROUP0_OFFSET);
                result.group1_nsu_addr_que.push_back(tmp_addr + GROUP1_OFFSET);
                result.group0_ost_id_que.push_back(ost_id);
                result.group1_ost_id_que.push_back(ost_id);
                result.round_num++;
            end
            tmp_addr=tmp_addr+8;  
        end
    end
    else begin
        if(mask[0])begin
            temp_plane_sel=8'hf0;
            result.plane_sel.push_back(temp_plane_sel);
            // 核心修改：生成时就加上偏移量
            result.group0_nsu_addr_que.push_back(tmp_addr + GROUP0_OFFSET);
            result.group1_nsu_addr_que.push_back(tmp_addr + GROUP1_OFFSET);
            result.group0_ost_id_que.push_back(ost_id);
            result.group1_ost_id_que.push_back(ost_id);
            result.round_num++;
        end
        tmp_addr=tmp_addr+4;
        for(int i=1;i<=30;i+=2)begin
            temp_plane_sel=8'h00;
            if(mask[i])
                temp_plane_sel[3:0]='hf;
            if(mask[i+1])
                temp_plane_sel[7:4]='hf;
        
            if(mask[i]||mask[i+1])begin
                result.plane_sel.push_back((temp_plane_sel >> plane_offset) | (temp_plane_sel << (8 - plane_offset)));
                // 核心修改：生成时就加上偏移量
                result.group0_nsu_addr_que.push_back(tmp_addr + GROUP0_OFFSET);
                result.group1_nsu_addr_que.push_back(tmp_addr + GROUP1_OFFSET);
                result.group0_ost_id_que.push_back(ost_id);
                result.group1_ost_id_que.push_back(ost_id);
                result.round_num++;
            end
            tmp_addr=tmp_addr+8;  
        end
    end
    return result;
endfunction

// ===================== 【简化】merge函数：直接使用已计算好的地址 =====================
function automatic plane_sel_result_t merge_plane_sel_results(
    plane_sel_result_t res1,
    plane_sel_result_t res2
);
    plane_sel_result_t merged_res;
    int max_rounds;

    max_rounds = (res1.round_num > res2.round_num) ? res1.round_num : res2.round_num;

    for(int round_idx = 0; round_idx < max_rounds; round_idx++) begin
        logic [7:0] res1_plane = 8'h00;
        logic [7:0] res2_plane = 8'h00;
        logic [7:0] merged_plane = 8'h00;
        int res1_g0_addr = 0, res1_g1_addr = 0;
        int res2_g0_addr = 0, res2_g1_addr = 0;
        int merged_g0_addr = 0, merged_g1_addr = 0;
        int merged_g0_ost = 0, merged_g1_ost = 0;

        if(round_idx < res1.round_num) begin
            res1_plane = res1.plane_sel[round_idx];
            res1_g0_addr = res1.group0_nsu_addr_que[round_idx];
            res1_g1_addr = res1.group1_nsu_addr_que[round_idx];
        end

        if(round_idx < res2.round_num) begin
            res2_plane = res2.plane_sel[round_idx];
            res2_g0_addr = res2.group0_nsu_addr_que[round_idx];
            res2_g1_addr = res2.group1_nsu_addr_que[round_idx];
        end

        // ===================== 处理group0（直接使用已有的地址） =====================
        if(res1_plane[3:0] != 4'h0 && res2_plane[3:0] != 4'h0) begin
            merged_plane[3:0] = res1_plane[3:0] | res2_plane[3:0];
            merged_g0_addr = res1_g0_addr; // 都选中时默认用res1的地址
            merged_g0_ost = res1.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] 两者都选中，合并：%4b | %4b = %4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, res1_plane[3:0], res2_plane[3:0], merged_plane[3:0], merged_g0_addr, merged_g0_ost);
        end
        else if(res1_plane[3:0] == 4'h0 && res2_plane[3:0] != 4'h0) begin
            merged_plane[3:0] = res2_plane[3:0];
            merged_g0_addr = res2_g0_addr; // 直接使用res2已计算好的地址
            merged_g0_ost = res2.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] res1未选中，res2选中，采用res2：%4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[3:0], merged_g0_addr, merged_g0_ost);
        end
        else if(res1_plane[3:0] != 4'h0 && res2_plane[3:0] == 4'h0) begin
            merged_plane[3:0] = res1_plane[3:0];
            merged_g0_addr = res1_g0_addr; // 直接使用res1已计算好的地址
            merged_g0_ost = res1.group0_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group0] res1选中，res2未选中，保留res1：%4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[3:0], merged_g0_addr, merged_g0_ost);
        end
        else begin
            merged_plane[3:0] = 4'h0;
            merged_g0_addr = 0;
            merged_g0_ost = 0;
        end

        // ===================== 处理group1（直接使用已有的地址） =====================
        if(res1_plane[7:4] != 4'h0 && res2_plane[7:4] != 4'h0) begin
            merged_plane[7:4] = res1_plane[7:4] | res2_plane[7:4];
            merged_g1_addr = res1_g1_addr; // 都选中时默认用res1的地址
            merged_g1_ost = res1.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] 两者都选中，合并：%4b | %4b = %4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, res1_plane[7:4], res2_plane[7:4], merged_plane[7:4], merged_g1_addr, merged_g1_ost);
        end
        else if(res1_plane[7:4] == 4'h0 && res2_plane[7:4] != 4'h0) begin
            merged_plane[7:4] = res2_plane[7:4];
            merged_g1_addr = res2_g1_addr; // 直接使用res2已计算好的地址
            merged_g1_ost = res2.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] res1未选中，res2选中，采用res2：%4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[7:4], merged_g1_addr, merged_g1_ost);
        end
        else if(res1_plane[7:4] != 4'h0 && res2_plane[7:4] == 4'h0) begin
            merged_plane[7:4] = res1_plane[7:4];
            merged_g1_addr = res1_g1_addr; // 直接使用res1已计算好的地址
            merged_g1_ost = res1.group1_ost_id_que[round_idx];
            $display("[MERGE] [round=%0d] [group1] res1选中，res2未选中，保留res1：%4b，addr=0x%0h，ost_id=%0d", 
                     round_idx, merged_plane[7:4], merged_g1_addr, merged_g1_ost);
        end
        else begin
            merged_plane[7:4] = 4'h0;
            merged_g1_addr = 0;
            merged_g1_ost = 0;
        end

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
task automatic print_result(int ost_id, int nsu_addr, logic [31:0] mask, plane_sel_result_t res);
    $display("\n=== 测试用例：ost_id=%0d, nsu_addr=%0d (0x%0h), mask=32'b%0b ===", 
             ost_id, nsu_addr, nsu_addr, mask);
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


// ===================== 【精简】测试用例：调用时只传一个ost_id =====================
module tb_plane_sel_final;
    plane_sel_result_t res1, res2, merged_res;
    bit [31:0] mask;
    int        ost_id, nsu_addr;

    initial begin
        // 1. 生成第一个测试用例（精简：只传一个ost_id=10）
        ost_id   = 10;
        nsu_addr = 0;
        mask     = 32'b0000001;
        res1     = calc_plane_sel(ost_id, nsu_addr, mask);
        print_result(ost_id, nsu_addr, mask, res1);

        // 2. 生成第二个测试用例（精简：只传一个ost_id=20）
        ost_id   = 20;
        nsu_addr = 8;
        mask     = 32'b0000110;
        res2     = calc_plane_sel(ost_id, nsu_addr, mask);
        print_result(ost_id, nsu_addr, mask, res2);

        // 3. 调用merge函数合并两个结果
        merged_res = merge_plane_sel_results(res1, res2);

        // 4. 打印合并后的结果
        print_merged_result(merged_res);

        //-----------------------------------------------------------
        $display("\n\n=== 额外测试用例：验证不同ost_id的处理 ===");
        // 1. 生成第一个测试用例（精简：只传一个ost_id=10）
        ost_id   = 10;
        nsu_addr = 0;
        mask     = 32'b0000010;
        res1     = calc_plane_sel(ost_id, nsu_addr, mask);
        print_result(ost_id, nsu_addr, mask, res1);

        // 2. 生成第二个测试用例（精简：只传一个ost_id=20）
        ost_id   = 20;
        nsu_addr = 8;
        mask     = 32'b0000101;
        res2     = calc_plane_sel(ost_id, nsu_addr, mask);
        print_result(ost_id, nsu_addr, mask, res2);

        // 3. 调用merge函数合并两个结果
        merged_res = merge_plane_sel_results(res1, res2);

        // 4. 打印合并后的结果
        print_merged_result(merged_res);        

        $finish;
    end
endmodule