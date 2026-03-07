`ifndef NSU2OFFWBF_TRANSACTION_SV
`define NSU2OFFWBF_TRANSACTION_SV

//=============================================================================
// nsu2offwbf_transaction - NSU 下发给 OFFWBF 的指令
//=============================================================================
// 当 ondec 译码失败 (dec_suc=0) 但 CRC 成功 (crc_pass=1) 时，
// NSU 会调用 OFFWBF 进行离线 WBF 纠错，此时需要下发 nsu2offwbf_transaction
//=============================================================================


    class nsu2offwbf_transaction extends uvm_sequence_item;
        //=========================================================
        // 基本字段 (与 ondec2nsu_transaction 保持一致的字段)
        //=========================================================
        rand logic [15:0]  instruction_index;      // 指令索引 (用于匹配)
        rand logic [4:0]   nsu_ost_id;             // OST ID
        rand logic [7:0]   nand_index;             // NAND 索引
        
        //=========================================================
        // 地址相关
        //=========================================================
        rand logic [31:0]  src_mem_addr;           // 源内存地址 (从 dest_memory_addr 来)
        rand logic [31:0]  dec_fail_dest_addr;     // 译码失败目标地址
        rand logic [15:0]  plane_group_block_addr; // 块地址
        rand logic [11:0]  page_addr_plane_group;  // 页地址
        
        //=========================================================
        // 状态和控制字段
        //=========================================================
        rand logic [1:0]   response_sel_que;       // 响应选择队列
        rand logic         read_mode;              // 读模式 (0=safe, 1=fast)
        rand logic         deep_read_sel;          // deep read 选择
        rand logic         descramble_en;          // 解扰使能
        rand logic [15:0]  descramble_seed;        // 解扰种子
        
        //=========================================================
        // OFFWBF 特有字段
        //=========================================================
        rand logic         offwbf_start;           // offwbf 启动标志
        rand logic         offwbf_done;            // offwbf 完成标志
        rand logic         offwbf_success;         // offwbf 成功标志 (1=成功)
        rand logic [7:0]   offwbf_retry_cnt;       // offwbf 重试次数
        rand logic         offwbf_err_output_en;   // offwbf 错误时数据输出使能
        
        //=========================================================
        // Meta 数据
        //=========================================================
        rand logic [31:0]  meta_buffer_id;         // Meta 缓冲区 ID
        rand logic [1:0]   meta_mode;              // Meta 模式
        
        //=========================================================
        // 约束
        //=========================================================
        constraint c_offwbf_start {
            soft offwbf_start == 1'b1;
        }
        
        constraint c_addr_alignment {
            src_mem_addr[5:0] == 6'b0;             // 64B 对齐
            dec_fail_dest_addr[5:0] == 6'b0;       // 64B 对齐
        }
        
        //=========================================================
        // UVM 字段注册
        //=========================================================
        `uvm_object_utils_begin(nsu2offwbf_transaction)
            `uvm_field_int(instruction_index, UVM_ALL_ON)
            `uvm_field_int(nsu_ost_id, UVM_ALL_ON)
            `uvm_field_int(nand_index, UVM_ALL_ON)
            `uvm_field_int(src_mem_addr, UVM_ALL_ON)
            `uvm_field_int(dec_fail_dest_addr, UVM_ALL_ON)
            `uvm_field_int(plane_group_block_addr, UVM_ALL_ON)
            `uvm_field_int(page_addr_plane_group, UVM_ALL_ON)
            `uvm_field_int(response_sel_que, UVM_ALL_ON)
            `uvm_field_int(read_mode, UVM_ALL_ON)
            `uvm_field_int(deep_read_sel, UVM_ALL_ON)
            `uvm_field_int(descramble_en, UVM_ALL_ON)
            `uvm_field_int(descramble_seed, UVM_ALL_ON)
            `uvm_field_int(offwbf_start, UVM_ALL_ON)
            `uvm_field_int(offwbf_done, UVM_ALL_ON)
            `uvm_field_int(offwbf_success, UVM_ALL_ON)
            `uvm_field_int(offwbf_retry_cnt, UVM_ALL_ON)
            `uvm_field_int(offwbf_err_output_en, UVM_ALL_ON)
            `uvm_field_int(meta_buffer_id, UVM_ALL_ON)
            `uvm_field_int(meta_mode, UVM_ALL_ON)
        `uvm_object_utils_end
        
        function new(string name = "nsu2offwbf_transaction");
            super.new(name);
        endfunction
        
    endclass


`endif
