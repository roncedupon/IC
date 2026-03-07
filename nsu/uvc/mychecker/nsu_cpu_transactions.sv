`ifndef NSU_CPU_TRANSACTIONS
`define NSU_CPU_TRANSACTIONS

//=============================================================================
// nsu_cpu_transactions.sv
// NSU-CPU 交互 Transaction 定义
// 
// 参考：升维 MP-NSU-spec PN85.docx 第 6.4 节 CPU 交互指令
// 
// 包含 10 个 transaction 类：
// 1. nsu2cpu_deep_resp_transaction      - 6.4.11 Deep read 上报 resp
// 2. cpu2nsu_unmap_cmd_transaction      - 6.4.8 Sw unmap req 指令
// 3. nsu2cpu_rcmd_transaction           - 6.4.10 输出 read 状态 (4 个队列)
// 4. cpu2nsu_write_addr_transaction     - 6.4.3 Io write addr queue
// 5. nsu2cpu_write_req_transaction      - 6.4.1 Io write req queue
// 6. nsu2cpu_write_addr_resp_transaction - 6.4.4 Io write addr resp queue
// 7. nsu2cpu_write_resp_transaction     - 6.4.5 Io write resp queue
// 8. cpu2nsu_msa_write_req_transaction  - 6.4.6 Msa write req que
// 9. nsu2cpu_msa_resp_transaction       - 6.4.7 MSA resp que
// 10. nsu2cpu_resp_transaction          - 通用响应 (用于其他未分类响应)
//=============================================================================

package nsu_cpu_transactions_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    //=========================================================================
    // 公共参数定义
    //=========================================================================
    
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 32;
    parameter PLANE_PAIR_NUM = 8;
    
    // Queue 深度
    parameter IO_WRITE_REQ_QUEUE_DEPTH    = 32;
    parameter IO_READ_REQ_QUEUE_DEPTH     = 32;
    parameter IO_WRITE_RESP_QUEUE_DEPTH   = 32;
    parameter READ_RESP_QUEUE_DEPTH       = 128;
    parameter DEEP_READ_RESP_QUEUE_DEPTH  = 109;
    parameter MSA_RESP_QUEUE_DEPTH        = 8;
    
    //=========================================================================
    // 1. nsu2cpu_deep_resp_transaction (6.4.11)
    // Deep read 上报 resp - 处理 IO read error 和 deep read
    //=========================================================================
    
    class nsu2cpu_deep_resp_transaction extends uvm_sequence_item;
        
        // DW0: [31:24] plane_pair_en, [23:16] NAND 命令 index, [15:0] Instruction_index
        rand bit [7:0]  plane_pair_en;           // plane_pair 选择
        rand bit [7:0]  nand_cmd_index;          // NAND 的操作命令
        rand bit [15:0] instruction_index;       // 用于标识指令
        
        // DW1: [31:24] plane_crc_err, [23:16] err_flag_comp, [15:8] lba_comp, [7:0] ondec_flag
        rand bit [7:0]  plane_crc_err;           // 0: 表示该 plane pair crc 译码失败
        rand bit [7:0]  plane_pair_err_flag_comp;// meta data 中 error flag 比对结果，0: 成功; 1: 失败
        rand bit [7:0]  plane_pair_lba_comp;     // meta data 中 lba 比对结果，0: 成功; 1: 失败
        rand bit [7:0]  plane_pair_ondec_flag;   // 解码器译码状态，0: 成功; 1: 失败
        
        // DW2: [31] deep_read_sel, [30] mode_sel, [29:28] rsv, [27:16] page_addr_g1, [15:12] rsv, [11:0] page_addr_g0
        rand bit        deep_read_sel;           // 1: resp 走专门的 deep resp que
        rand bit        mode_sel;                // 0: safe read, 1: fast read
        rand bit [1:0]  rsv_dw2;
        rand bit [11:0] page_address_plane_group_0;  // page 的逻辑地址
        rand bit [11:0] page_address_plane_group_1;
        
        // DW3: [31:16] group1 block 地址，[15:0] group0 block 地址
        rand bit [15:0] group0_block_addr;
        rand bit [15:0] group1_block_addr;
        
        // DW4-DW5: Meta address
        rand bit [31:0] group0_meta_addr;
        rand bit [31:0] group1_meta_addr;
        
        // DW6-DW7: Dest memory address
        rand bit [31:0] group0_dest_memory_addr;
        rand bit [31:0] group1_dest_memory_addr;
        
        // DW8-DW15: Decode fail dest addr (8 个 plane pair)
        rand bit [31:0] dec_fail_dest_addr [0:7];
        
        // DW16: [31:27] group1_ost_id, [26:18] pp1_alter_bit, [17] plane3_empty, [16] plane2_empty,
        //       [15:11] group0_ost_id, [10:2] pp0_alter_bit, [1] plane1_empty, [0] plane0_empty
        rand bit [4:0]  group0_ost_id;
        rand bit [4:0]  group1_ost_id;
        rand bit [8:0]  plane_pair0_alter_bit;   // 纠错 bit 数
        rand bit [8:0]  plane_pair1_alter_bit;
        rand bit        plane0_empty;            // 没有 program 就 read 该 plane
        rand bit        plane1_empty;
        rand bit        plane2_empty;
        rand bit        plane3_empty;
        
        // DW17-DW18: Plane 0-3 的 0/1bit 数
        rand bit [15:0] plane0_bit_count;
        rand bit [15:0] plane1_bit_count;
        rand bit [15:0] plane2_bit_count;
        rand bit [15:0] plane3_bit_count;
        
        // DW19-DW27: Plane 4-7 相关信息
        rand bit [4:0]  group2_ost_id;
        rand bit [4:0]  group3_ost_id;
        rand bit [8:0]  plane_pair2_alter_bit;
        rand bit [8:0]  plane_pair3_alter_bit;
        rand bit [8:0]  plane_pair4_alter_bit;
        rand bit [8:0]  plane_pair5_alter_bit;
        rand bit [8:0]  plane_pair6_alter_bit;
        rand bit [8:0]  plane_pair7_alter_bit;
        rand bit        plane4_empty;
        rand bit        plane5_empty;
        rand bit        plane6_empty;
        rand bit        plane7_empty;
        rand bit [15:0] plane4_bit_count;
        rand bit [15:0] plane5_bit_count;
        rand bit [15:0] plane6_bit_count;
        rand bit [15:0] plane7_bit_count;
        
        // 原始数据数组 (用于 fields_assignment)
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_deep_resp_transaction)
            `uvm_field_int(plane_pair_en, UVM_ALL_ON)
            `uvm_field_int(nand_cmd_index, UVM_ALL_ON)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
            `uvm_field_int(plane_crc_err, UVM_ALL_ON)
            `uvm_field_int(plane_pair_err_flag_comp, UVM_ALL_ON)
            `uvm_field_int(plane_pair_lba_comp, UVM_ALL_ON)
            `uvm_field_int(plane_pair_ondec_flag, UVM_ALL_ON)
            `uvm_field_int(deep_read_sel, UVM_ALL_ON)
            `uvm_field_int(mode_sel, UVM_ALL_ON)
            `uvm_field_int(page_address_plane_group_0, UVM_ALL_ON)
            `uvm_field_int(page_address_plane_group_1, UVM_ALL_ON)
            `uvm_field_int(group0_block_addr, UVM_ALL_ON)
            `uvm_field_int(group1_block_addr, UVM_ALL_ON)
            `uvm_field_int(group0_meta_addr, UVM_ALL_ON)
            `uvm_field_int(group1_meta_addr, UVM_ALL_ON)
            `uvm_field_int(group0_dest_memory_addr, UVM_ALL_ON)
            `uvm_field_int(group1_dest_memory_addr, UVM_ALL_ON)
            `uvm_field_array_int(dec_fail_dest_addr, UVM_ALL_ON)
            `uvm_field_int(group0_ost_id, UVM_ALL_ON)
            `uvm_field_int(group1_ost_id, UVM_ALL_ON)
            `uvm_field_int(plane_pair0_alter_bit, UVM_ALL_ON)
            `uvm_field_int(plane_pair1_alter_bit, UVM_ALL_ON)
            `uvm_field_int(plane0_empty, UVM_ALL_ON)
            `uvm_field_int(plane1_empty, UVM_ALL_ON)
            `uvm_field_int(plane0_bit_count, UVM_ALL_ON)
            `uvm_field_int(plane1_bit_count, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_deep_resp_transaction");
            super.new(name);
            data_array = new[28];  // 最多 28 个 DW
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.11)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            plane_pair_en        = data_array[0][31:24];
            nand_cmd_index       = data_array[0][23:16];
            instruction_index    = data_array[0][15:0];
            
            if (data_array.size() < 2) return;
            
            // DW1
            plane_crc_err         = data_array[1][31:24];
            plane_pair_err_flag_comp = data_array[1][23:16];
            plane_pair_lba_comp   = data_array[1][15:8];
            plane_pair_ondec_flag = data_array[1][7:0];
            
            if (data_array.size() < 3) return;
            
            // DW2
            deep_read_sel         = data_array[2][31];
            mode_sel              = data_array[2][30];
            page_address_plane_group_1 = data_array[2][27:16];
            page_address_plane_group_0 = data_array[2][11:0];
            
            if (data_array.size() < 4) return;
            
            // DW3
            group1_block_addr    = data_array[3][31:16];
            group0_block_addr    = data_array[3][15:0];
            
            if (data_array.size() < 5) return;
            
            // DW4
            group0_meta_addr     = data_array[4][31:0];
            
            if (data_array.size() < 6) return;
            
            // DW5
            group1_meta_addr     = data_array[5][31:0];
            
            if (data_array.size() < 7) return;
            
            // DW6
            group0_dest_memory_addr = data_array[6][31:0];
            
            if (data_array.size() < 8) return;
            
            // DW7
            group1_dest_memory_addr = data_array[7][31:0];
            
            if (data_array.size() < 16) return;
            
            // DW8-DW15: dec_fail_dest_addr[0:7]
            for (int i = 0; i < 8; i++) begin
                dec_fail_dest_addr[i] = data_array[8 + i][31:0];
            end
            
            if (data_array.size() < 17) return;
            
            // DW16
            group1_ost_id        = data_array[16][31:27];
            plane_pair1_alter_bit = data_array[16][26:18];
            plane3_empty         = data_array[16][17];
            plane2_empty         = data_array[16][16];
            group0_ost_id        = data_array[16][15:11];
            plane_pair0_alter_bit = data_array[16][10:2];
            plane1_empty         = data_array[16][1];
            plane0_empty         = data_array[16][0];
            
            if (data_array.size() < 19) return;
            
            // DW17
            plane1_bit_count     = data_array[17][31:16];
            plane0_bit_count     = data_array[17][15:0];
            
            if (data_array.size() < 20) return;
            
            // DW18
            plane3_bit_count     = data_array[18][31:16];
            plane2_bit_count     = data_array[18][15:0];
            
            if (data_array.size() < 28) begin
                // 部分数据，设置默认值
                group2_ost_id = 5'b0;
                group3_ost_id = 5'b0;
                plane_pair2_alter_bit = 9'b0;
                plane_pair3_alter_bit = 9'b0;
                plane_pair4_alter_bit = 9'b0;
                plane_pair5_alter_bit = 9'b0;
                plane_pair6_alter_bit = 9'b0;
                plane_pair7_alter_bit = 9'b0;
                plane4_empty = 1'b0;
                plane5_empty = 1'b0;
                plane6_empty = 1'b0;
                plane7_empty = 1'b0;
                plane4_bit_count = 16'b0;
                plane5_bit_count = 16'b0;
                plane6_bit_count = 16'b0;
                plane7_bit_count = 16'b0;
                return;
            end
            
            // DW19-DW27: Plane 4-7 信息
            // DW19
            plane_pair2_alter_bit = data_array[19][10:2];
            plane5_empty         = data_array[19][1];
            plane4_empty         = data_array[19][0];
            
            // DW20
            plane_pair3_alter_bit = data_array[20][26:18];
            plane7_empty         = data_array[20][17];
            plane6_empty         = data_array[20][16];
            
            // DW21
            plane5_bit_count     = data_array[21][31:16];
            plane4_bit_count     = data_array[21][15:0];
            
            // DW22
            plane7_bit_count     = data_array[22][31:16];
            plane6_bit_count     = data_array[22][15:0];
            
            // DW23-DW27 (如有需要可继续解析)
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组 (用于驱动)
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[28];
            
            // DW0
            packed_array[0][31:24] = plane_pair_en;
            packed_array[0][23:16] = nand_cmd_index;
            packed_array[0][15:0]  = instruction_index;
            
            // DW1
            packed_array[1][31:24] = plane_crc_err;
            packed_array[1][23:16] = plane_pair_err_flag_comp;
            packed_array[1][15:8]  = plane_pair_lba_comp;
            packed_array[1][7:0]   = plane_pair_ondec_flag;
            
            // DW2
            packed_array[2][31]    = deep_read_sel;
            packed_array[2][30]    = mode_sel;
            packed_array[2][27:16] = page_address_plane_group_1;
            packed_array[2][11:0]  = page_address_plane_group_0;
            
            // DW3
            packed_array[3][31:16] = group1_block_addr;
            packed_array[3][15:0]  = group0_block_addr;
            
            // DW4-DW7
            packed_array[4][31:0]  = group0_meta_addr;
            packed_array[5][31:0]  = group1_meta_addr;
            packed_array[6][31:0]  = group0_dest_memory_addr;
            packed_array[7][31:0]  = group1_dest_memory_addr;
            
            // DW8-DW15
            for (int i = 0; i < 8; i++) begin
                packed_array[8 + i][31:0] = dec_fail_dest_addr[i];
            end
            
            // DW16
            packed_array[16][31:27] = group1_ost_id;
            packed_array[16][26:18] = plane_pair1_alter_bit;
            packed_array[16][17]    = plane3_empty;
            packed_array[16][16]    = plane2_empty;
            packed_array[16][15:11] = group0_ost_id;
            packed_array[16][10:2]  = plane_pair0_alter_bit;
            packed_array[16][1]     = plane1_empty;
            packed_array[16][0]     = plane0_empty;
            
            // DW17-DW18
            packed_array[17][31:16] = plane1_bit_count;
            packed_array[17][15:0]  = plane0_bit_count;
            packed_array[18][31:16] = plane3_bit_count;
            packed_array[18][15:0]  = plane2_bit_count;
        endfunction : pack_to_array
        
        // 约束
        constraint valid_constraint {
            plane_pair_en inside {[0:255]};
            nand_cmd_index inside {[0:255]};
            mode_sel inside {[0:1]};
            deep_read_sel inside {[0:1]};
        }
        
    endclass : nsu2cpu_deep_resp_transaction
    
    //=========================================================================
    // 2. cpu2nsu_unmap_cmd_transaction (6.4.8)
    // Sw unmap req 指令 - NSU CPU 通知 NSU 给 TSU 返回固定 pattern
    //=========================================================================
    
    class cpu2nsu_unmap_cmd_transaction extends uvm_sequence_item;
        
        // DW0: [31:30] rsv, [29:0] nsu_addr (lba)
        rand bit [1:0]  rsv_dw0;
        rand bit [29:0] nsu_addr;       // lba
        
        // DW1: [31:16] rsv, [15:8] rd_length, [7:5] rsv, [4:0] ost_id
        rand bit [15:0] rsv_dw1;
        rand bit [7:0]  rd_length;      // read 的长度，最大到 32KB，1 代表 4KB
        rand bit [2:0]  rsv_dw1_low;
        rand bit [4:0]  ost_id;         // 读 outstanding 的 id
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(cpu2nsu_unmap_cmd_transaction)
            `uvm_field_int(nsu_addr, UVM_ALL_ON)
            `uvm_field_int(rd_length, UVM_ALL_ON)
            `uvm_field_int(ost_id, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "cpu2nsu_unmap_cmd_transaction");
            super.new(name);
            data_array = new[2];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.8)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0    = data_array[0][31:30];
            nsu_addr   = data_array[0][29:0];
            
            if (data_array.size() < 2) return;
            
            // DW1
            rsv_dw1    = data_array[1][31:16];
            rd_length  = data_array[1][15:8];
            rsv_dw1_low = data_array[1][7:5];
            ost_id     = data_array[1][4:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[2];
            
            // DW0
            packed_array[0][31:30] = rsv_dw0;
            packed_array[0][29:0]  = nsu_addr;
            
            // DW1
            packed_array[1][31:16] = rsv_dw1;
            packed_array[1][15:8]  = rd_length;
            packed_array[1][7:5]   = rsv_dw1_low;
            packed_array[1][4:0]   = ost_id;
        endfunction : pack_to_array
        
        // 约束
        constraint valid_constraint {
            rd_length inside {[1:8]};  // 最大 32KB, 1=4KB
            ost_id inside {[0:31]};
        }
        
    endclass : cpu2nsu_unmap_cmd_transaction
    
    //=========================================================================
    // 3. nsu2cpu_rcmd_transaction (6.4.10)
    // 输出 read 状态 (NSU CPU 发起读，4 个队列)
    //=========================================================================
    
    class nsu2cpu_rcmd_transaction extends uvm_sequence_item;
        
        // DW0: [31:24] error_plane_pair_sel, [23:16] NAND 命令 index, [15:0] Instruction_index
        rand bit [7:0]  error_plane_pair_sel;   // 解码器译码状态，0: 成功; 1: 失败
        rand bit [7:0]  nand_cmd_index;         // NAND 的操作命令
        rand bit [15:0] instruction_index;      // 用于标识指令
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_rcmd_transaction)
            `uvm_field_int(error_plane_pair_sel, UVM_ALL_ON)
            `uvm_field_int(nand_cmd_index, UVM_ALL_ON)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_rcmd_transaction");
            super.new(name);
            data_array = new[1];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.10)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            error_plane_pair_sel = data_array[0][31:24];
            nand_cmd_index       = data_array[0][23:16];
            instruction_index    = data_array[0][15:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[1];
            
            // DW0
            packed_array[0][31:24] = error_plane_pair_sel;
            packed_array[0][23:16] = nand_cmd_index;
            packed_array[0][15:0]  = instruction_index;
        endfunction : pack_to_array
        
        // 约束
        constraint valid_constraint {
            error_plane_pair_sel inside {[0:255]};
            nand_cmd_index inside {[0:255]};
        }
        
    endclass : nsu2cpu_rcmd_transaction
    
    //=========================================================================
    // 4. cpu2nsu_write_addr_transaction (6.4.3)
    // Io write addr queue - NSU CPU 分配 share memory 地址后发送
    //=========================================================================
    
    class cpu2nsu_write_addr_transaction extends uvm_sequence_item;
        
        // DW0: [31:20] rsv, [19:16] ost_id, [15:0] Instruction_index
        rand bit [11:0] rsv_dw0;
        rand bit [3:0]  ost_id;           // 用于标识指令
        rand bit [15:0] instruction_index;
        
        // DW1: [31:0] write_addr - 存放 program 数据的临时缓存地址，256bit 对齐
        rand bit [31:0] write_addr;
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(cpu2nsu_write_addr_transaction)
            `uvm_field_int(ost_id, UVM_ALL_ON)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
            `uvm_field_int(write_addr, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "cpu2nsu_write_addr_transaction");
            super.new(name);
            data_array = new[2];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.3)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0           = data_array[0][31:20];
            ost_id            = data_array[0][19:16];
            instruction_index = data_array[0][15:0];
            
            if (data_array.size() < 2) return;
            
            // DW1
            write_addr        = data_array[1][31:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[2];
            
            // DW0
            packed_array[0][31:20] = rsv_dw0;
            packed_array[0][19:16] = ost_id;
            packed_array[0][15:0]  = instruction_index;
            
            // DW1
            packed_array[1][31:0]  = write_addr;
        endfunction : pack_to_array
        
        // 约束 - 地址 256bit 对齐 (低 5bit 为 0)
        constraint addr_align_constraint {
            write_addr[4:0] == 5'b0;
        }
        
    endclass : cpu2nsu_write_addr_transaction
    
    //=========================================================================
    // 5. nsu2cpu_write_req_transaction (6.4.1)
    // Io write req queue - TSU 下发的 program 指令转发给 NSU CPU
    //=========================================================================
    
    class nsu2cpu_write_req_transaction extends uvm_sequence_item;
        
        // DW0: [31:16] err_bitmap, [15:9] rsv, [8:5] wr_length, [4] cmd_type, [3:0] ost_id
        rand bit [15:0] err_bitmap;     // 每 4KB 有 1bit err_bit_map
        rand bit [6:0]  rsv_dw0;
        rand bit [3:0]  wr_length;      // program 的长度，32KB-128KB，1 代表 32KB
        rand bit        cmd_type;       // 0: program, 1: delet
        rand bit [3:0]  ost_id;         // 写 outstanding 的 id
        
        // DW1: [31:30] rsv, [29:0] nsu_addr (lba)
        rand bit [1:0]  rsv_dw1;
        rand bit [29:0] nsu_addr;       // lba
        
        // DW2: [31:0] wr_memory_addr
        rand bit [31:0] wr_memory_addr;
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_write_req_transaction)
            `uvm_field_int(err_bitmap, UVM_ALL_ON)
            `uvm_field_int(wr_length, UVM_ALL_ON)
            `uvm_field_int(cmd_type, UVM_ALL_ON)
            `uvm_field_int(ost_id, UVM_ALL_ON)
            `uvm_field_int(nsu_addr, UVM_ALL_ON)
            `uvm_field_int(wr_memory_addr, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_write_req_transaction");
            super.new(name);
            data_array = new[3];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.1)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            err_bitmap  = data_array[0][31:16];
            rsv_dw0     = data_array[0][15:9];
            wr_length   = data_array[0][8:5];
            cmd_type    = data_array[0][4];
            ost_id      = data_array[0][3:0];
            
            if (data_array.size() < 2) return;
            
            // DW1
            rsv_dw1     = data_array[1][31:30];
            nsu_addr    = data_array[1][29:0];
            
            if (data_array.size() < 3) return;
            
            // DW2
            wr_memory_addr = data_array[2][31:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[3];
            
            // DW0
            packed_array[0][31:16] = err_bitmap;
            packed_array[0][15:9]  = rsv_dw0;
            packed_array[0][8:5]   = wr_length;
            packed_array[0][4]     = cmd_type;
            packed_array[0][3:0]   = ost_id;
            
            // DW1
            packed_array[1][31:30] = rsv_dw1;
            packed_array[1][29:0]  = nsu_addr;
            
            // DW2
            packed_array[2][31:0]  = wr_memory_addr;
        endfunction : pack_to_array
        
        // 约束
        constraint valid_constraint {
            wr_length inside {[1:4]};  // 32KB-128KB
            cmd_type inside {[0:1]};   // 0=program, 1=delet
        }
        
    endclass : nsu2cpu_write_req_transaction
    
    //=========================================================================
    // 6. nsu2cpu_write_addr_resp_transaction (6.4.4)
    // Io write addr resp queue - NSU 写完数据到 share memory 后返回 resp
    //=========================================================================
    
    class nsu2cpu_write_addr_resp_transaction extends uvm_sequence_item;
        
        // DW0: [31:16] rsv, [15:0] Instruction_index
        rand bit [15:0] rsv_dw0;
        rand bit [15:0] instruction_index;  // 用于标识指令
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_write_addr_resp_transaction)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_write_addr_resp_transaction");
            super.new(name);
            data_array = new[1];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.4)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0           = data_array[0][31:16];
            instruction_index = data_array[0][15:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[1];
            
            // DW0
            packed_array[0][31:16] = rsv_dw0;
            packed_array[0][15:0]  = instruction_index;
        endfunction : pack_to_array
        
    endclass : nsu2cpu_write_addr_resp_transaction
    
    //=========================================================================
    // 7. nsu2cpu_write_resp_transaction (6.4.5)
    // Io write resp queue - NSU CPU program 完成后给 NSU 发送 resp
    //=========================================================================
    
    class nsu2cpu_write_resp_transaction extends uvm_sequence_item;
        
        // DW0: [31:4] rsv, [3:0] ost_id
        rand bit [27:0] rsv_dw0;
        rand bit [3:0]  ost_id;  // outstanding id
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_write_resp_transaction)
            `uvm_field_int(ost_id, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_write_resp_transaction");
            super.new(name);
            data_array = new[1];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.5)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0 = data_array[0][31:4];
            ost_id  = data_array[0][3:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[1];
            
            // DW0
            packed_array[0][31:4] = rsv_dw0;
            packed_array[0][3:0]  = ost_id;
        endfunction : pack_to_array
        
    endclass : nsu2cpu_write_resp_transaction
    
    //=========================================================================
    // 8. cpu2nsu_msa_write_req_transaction (6.4.6)
    // Msa write req que - MSA 解码完成后通知 NSU 取数据
    //=========================================================================
    
    class cpu2nsu_msa_write_req_transaction extends uvm_sequence_item;
        
        // DW0: [31:30] rsv, [29:0] nsu_addr (lba)
        rand bit [1:0]  rsv_dw0;
        rand bit [29:0] nsu_addr;       // lba
        
        // DW1: [31:0] err_flag - 比较后软件 merge 的 error flag
        rand bit [31:0] err_flag;
        
        // DW2: [31:16] Instruction_index, [15:5] rsv, [4:0] ost_id
        rand bit [15:0] instruction_index;
        rand bit [10:0] rsv_dw2;
        rand bit [4:0]  ost_id;         // Rcmd outstanding 队列 id
        
        // DW3: [31:0] src_mem_addr - 解码后数据 sram 地址，256b 对齐
        rand bit [31:0] src_mem_addr;
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(cpu2nsu_msa_write_req_transaction)
            `uvm_field_int(nsu_addr, UVM_ALL_ON)
            `uvm_field_int(err_flag, UVM_ALL_ON)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
            `uvm_field_int(ost_id, UVM_ALL_ON)
            `uvm_field_int(src_mem_addr, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "cpu2nsu_msa_write_req_transaction");
            super.new(name);
            data_array = new[4];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.6)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0   = data_array[0][31:30];
            nsu_addr  = data_array[0][29:0];
            
            if (data_array.size() < 2) return;
            
            // DW1
            err_flag  = data_array[1][31:0];
            
            if (data_array.size() < 3) return;
            
            // DW2
            instruction_index = data_array[2][31:16];
            rsv_dw2           = data_array[2][15:5];
            ost_id            = data_array[2][4:0];
            
            if (data_array.size() < 4) return;
            
            // DW3
            src_mem_addr = data_array[3][31:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[4];
            
            // DW0
            packed_array[0][31:30] = rsv_dw0;
            packed_array[0][29:0]  = nsu_addr;
            
            // DW1
            packed_array[1][31:0]  = err_flag;
            
            // DW2
            packed_array[2][31:16] = instruction_index;
            packed_array[2][15:5]  = rsv_dw2;
            packed_array[2][4:0]   = ost_id;
            
            // DW3
            packed_array[3][31:0]  = src_mem_addr;
        endfunction : pack_to_array
        
        // 约束 - 地址 256bit 对齐
        constraint addr_align_constraint {
            src_mem_addr[4:0] == 5'b0;
        }
        
    endclass : cpu2nsu_msa_write_req_transaction
    
    //=========================================================================
    // 9. nsu2cpu_msa_resp_transaction (6.4.7)
    // MSA resp que - MSA 命令执行完成后返回 resp
    //=========================================================================
    
    class nsu2cpu_msa_resp_transaction extends uvm_sequence_item;
        
        // DW0: [31:16] rsv, [15:0] Instruction_index
        rand bit [15:0] rsv_dw0;
        rand bit [15:0] instruction_index;  // 用于标识指令
        
        // 原始数据数组
        rand bit [31:0] data_array [];
        
        `uvm_object_utils_begin(nsu2cpu_msa_resp_transaction)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_msa_resp_transaction");
            super.new(name);
            data_array = new[1];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域 (Spec 6.4.7)
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data_array.size() < 1) return;
            
            // DW0
            rsv_dw0           = data_array[0][31:16];
            instruction_index = data_array[0][15:0];
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[1];
            
            // DW0
            packed_array[0][31:16] = rsv_dw0;
            packed_array[0][15:0]  = instruction_index;
        endfunction : pack_to_array
        
    endclass : nsu2cpu_msa_resp_transaction
    
    //=========================================================================
    // 10. nsu2cpu_resp_transaction
    // 通用响应 - 用于其他未分类的 NSU->CPU 响应
    //=========================================================================
    
    class nsu2cpu_resp_transaction extends uvm_sequence_item;
        
        // 通用字段
        rand bit [31:0] data [];        // 原始数据
        rand bit [15:0] instruction_index;
        rand bit [3:0]  ost_id;
        rand bit [31:0] status;
        rand bit [31:0] address;
        
        // 响应类型枚举
        typedef enum logic [3:0] {
            RESP_TYPE_GENERIC    = 4'b0000,
            RESP_TYPE_PROGRAM    = 4'b0001,
            RESP_TYPE_READ       = 4'b0010,
            RESP_TYPE_ERROR      = 4'b0011,
            RESP_TYPE_STATUS     = 4'b0100,
            RESP_TYPE_INTERRUPT  = 4'b0101
        } resp_type_e;
        
        rand resp_type_e resp_type;
        
        `uvm_object_utils_begin(nsu2cpu_resp_transaction)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
            `uvm_field_int(ost_id, UVM_ALL_ON)
            `uvm_field_int(status, UVM_ALL_ON)
            `uvm_field_int(address, UVM_ALL_ON)
            `uvm_field_enum(resp_type, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2cpu_resp_transaction");
            super.new(name);
            data = new[1];
        endfunction : new
        
        //---------------------------------------------------------------------
        // fields_assignment - 从数组提取数据到位域
        //---------------------------------------------------------------------
        function void fields_assignment();
            if (data.size() < 1) return;
            
            // 默认解析：根据 resp_type 不同解析方式不同
            case (resp_type)
                RESP_TYPE_PROGRAM, RESP_TYPE_READ: begin
                    // [31:16] rsv, [15:0] instruction_index 或 [31:4] rsv, [3:0] ost_id
                    if (resp_type == RESP_TYPE_PROGRAM) begin
                        ost_id = data[0][3:0];
                    end else begin
                        instruction_index = data[0][15:0];
                    end
                end
                RESP_TYPE_ERROR, RESP_TYPE_STATUS: begin
                    status = data[0][31:0];
                end
                RESP_TYPE_INTERRUPT: begin
                    address = data[0][31:0];
                end
                default: begin
                    // 通用解析
                    instruction_index = data[0][15:0];
                    ost_id = data[0][3:0];
                end
            endcase
        endfunction : fields_assignment
        
        //---------------------------------------------------------------------
        // 将位域打包到数组
        //---------------------------------------------------------------------
        function void pack_to_array(output bit [31:0] packed_array []);
            packed_array = new[1];
            
            case (resp_type)
                RESP_TYPE_PROGRAM: begin
                    packed_array[0][3:0] = ost_id;
                end
                RESP_TYPE_READ: begin
                    packed_array[0][15:0] = instruction_index;
                end
                RESP_TYPE_ERROR, RESP_TYPE_STATUS: begin
                    packed_array[0][31:0] = status;
                end
                RESP_TYPE_INTERRUPT: begin
                    packed_array[0][31:0] = address;
                end
                default: begin
                    packed_array[0][15:0] = instruction_index;
                    packed_array[0][3:0]  = ost_id;
                end
            endcase
        endfunction : pack_to_array
        
    endclass : nsu2cpu_resp_transaction
    
endpackage : nsu_cpu_transactions_pkg


`endif // NSU_CPU_TRANSACTIONS
