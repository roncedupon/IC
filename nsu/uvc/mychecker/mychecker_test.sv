`ifndef MYCHECKER_TEST_SV
`define MYCHECKER_TEST_SV

//=============================================================================
// mychecker_test.sv - 测试修复后的offwbf处理逻辑
//=============================================================================
// 测试场景：
// 1. 模拟8个plane_pair的transaction，其中Group 0的plane 0和plane 1都需要offwbf
// 2. 模拟2个offwbf命令，每个对应一个plane
// 3. 验证checker是否能正确处理每个offwbf命令
//=============================================================================

module mychecker_test;
    
    import uvm_pkg::*;
    import ondec2nsu_checker_pkg::*;
    
    // 实例化checker
    ondec2nsu_checker checker;
    
    // 时钟
    bit clk;
    always #5 clk = ~clk;
    
    initial begin
        // 初始化UVM
        run_test();
    end
    
endmodule

class my_test extends uvm_test;
    
    `uvm_component_utils(my_test)
    
    ondec2nsu_checker checker;
    
    // 队列处理线程
    task send_ondec_transactions();
        ondec2nsu_transaction ondec_tr [7:0];
        
        // 创建8个transaction，Group 0的plane 0和plane 1需要offwbf
        for (int i = 0; i < 8; i++) begin
            ondec_tr[i] = ondec2nsu_transaction::type_id::create($sformatf("ondec_tr_%0d", i));
            
            // 随机化并设置共同字段
            ondec_tr[i].instruction_index = 16'h1234;
            ondec_tr[i].nsu_ost_id = 5'h01;
            ondec_tr[i].deep_read_sel = 1'b0;
            ondec_tr[i].read_mode = 1'b0;  // safe read模式
            ondec_tr[i].dest_memory_addr = 32'h10000000;
            ondec_tr[i].dec_fail_dest_addr = 32'h20000000;
            ondec_tr[i].plane_group_block_addr = 16'h0000;
            ondec_tr[i].page_addr_plane_group = 12'h000;
            ondec_tr[i].plane_sel = 1'b1;
            ondec_tr[i].crc_pass = 1'b1;
            ondec_tr[i].flip_threshold_sel = 1'b1;
            ondec_tr[i].syn_weight_over_threshold = 1'b0;
            ondec_tr[i].descramble_en = 1'b1;
            ondec_tr[i].descramble_seed = 16'hABCD;
            ondec_tr[i].write_pos_jdg = 1'b0;
            
            // Group 0的plane 0和plane 1需要offwbf
            if (i < 2) begin
                ondec_tr[i].dec_suc = 1'b0;  // 译码失败
                ondec_tr[i].data_out_en = 1'b1;  // 数据输出
                ondec_tr[i].offline_wbf_work_en = 1'b1;  // 需要offwbf
            end else begin
                ondec_tr[i].dec_suc = 1'b1;  // 译码成功
                ondec_tr[i].data_out_en = 1'b0;  // 数据不输出
                ondec_tr[i].offline_wbf_work_en = 1'b0;  // 不需要offwbf
            end
            
            // 发送到对应的FIFO
            checker.ondec_fifo[i].write(ondec_tr[i]);
            `uvm_info("TEST", $sformatf("Sent ondec transaction to FIFO[%0d]: dec_suc=%0b, data_out_en=%0b, offline_wbf_work_en=%0b", 
                i, ondec_tr[i].dec_suc, ondec_tr[i].data_out_en, ondec_tr[i].offline_wbf_work_en), UVM_LOW)
        end
    endtask
    
    // 发送offwbf命令
    task send_offwbf_commands();
        offdec2nsu_transaction offwbf_tr;
        
        // 等待一段时间，确保checker处理了ondec命令
        #100ns;
        
        // 发送第一个offwbf命令（对应plane 0）
        offwbf_tr = offdec2nsu_transaction::type_id::create("offwbf_tr_0");
        offwbf_tr.plane_num = 0;  // 对应plane 0
        offwbf_tr.ost_id_nsu2offline = 5'h01;
        offwbf_tr.dest_sel = 1'b0;  // 与ondec.write_pos_jdg对应
        offwbf_tr.flip_threshold_sel = 1'b1;  // 与ondec.flip_threshold_sel对应
        offwbf_tr.over_threshold = 1'b0;  // 与ondec.syn_weight_over_threshold对应
        offwbf_tr.descramble_en = 1'b1;  // 与ondec.descramble_en对应
        offwbf_tr.descramble_seed_0 = 8'hCD;  // 与ondec.descramble_seed对应
        offwbf_tr.descramble_seed_1 = 8'hAB;
        offwbf_tr.src_mem_addr_0 = 8'h00;
        offwbf_tr.src_mem_addr_1 = 8'h00;
        offwbf_tr.src_mem_addr_2 = 8'h00;
        offwbf_tr.src_mem_addr_3 = 8'h10;
        offwbf_tr.dest_mem_addr_0 = 8'h00;
        offwbf_tr.dest_mem_addr_1 = 8'h00;
        offwbf_tr.dest_mem_addr_2 = 8'h00;
        offwbf_tr.dest_mem_addr_3 = 8'h20;
        offwbf_tr.offline_wbf_out_flag = 1'b1;
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        `uvm_info("TEST", "Sent first offwbf command for plane 0", UVM_LOW)
        
        // 等待一段时间
        #50ns;
        
        // 发送第二个offwbf命令（对应plane 1）
        offwbf_tr = offdec2nsu_transaction::type_id::create("offwbf_tr_1");
        offwbf_tr.plane_num = 1;  // 对应plane 1
        offwbf_tr.ost_id_nsu2offline = 5'h01;
        offwbf_tr.dest_sel = 1'b0;  // 与ondec.write_pos_jdg对应
        offwbf_tr.flip_threshold_sel = 1'b1;  // 与ondec.flip_threshold_sel对应
        offwbf_tr.over_threshold = 1'b0;  // 与ondec.syn_weight_over_threshold对应
        offwbf_tr.descramble_en = 1'b1;  // 与ondec.descramble_en对应
        offwbf_tr.descramble_seed_0 = 8'hCD;  // 与ondec.descramble_seed对应
        offwbf_tr.descramble_seed_1 = 8'hAB;
        offwbf_tr.src_mem_addr_0 = 8'h00;
        offwbf_tr.src_mem_addr_1 = 8'h00;
        offwbf_tr.src_mem_addr_2 = 8'h00;
        offwbf_tr.src_mem_addr_3 = 8'h10;
        offwbf_tr.dest_mem_addr_0 = 8'h00;
        offwbf_tr.dest_mem_addr_1 = 8'h00;
        offwbf_tr.dest_mem_addr_2 = 8'h00;
        offwbf_tr.dest_mem_addr_3 = 8'h20;
        offwbf_tr.offline_wbf_out_flag = 1'b1;
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        `uvm_info("TEST", "Sent second offwbf command for plane 1", UVM_LOW)
    endtask
    
    function new(string name = "my_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        checker = ondec2nsu_checker::type_id::create("checker", this);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        `uvm_info("TEST", "Starting test: multiple offwbf commands per plane", UVM_LOW)
        
        // 并行发送ondec transaction和offwbf命令
        fork
            send_ondec_transactions();
            send_offwbf_commands();
        join
        
        // 等待一段时间，确保checker处理完所有命令
        #500ns;
        
        `uvm_info("TEST", "Test completed", UVM_LOW)
        phase.drop_objection(this);
    endtask
    
endclass

`endif