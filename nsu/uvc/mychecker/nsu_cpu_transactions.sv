// ------------------------------
// cpu2nsu_unmap_cmd_transaction
// ------------------------------
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
class cpu2nsu_unmap_cmd_transaction extends uvm_sequence_item;
  rand bit [31:0] cpu2nsu_unmap_cmd[];
  rand bit [1:0]  rsv0_31_30;    // index0[31:30] rsv
  rand bit [29:0] nsu_addr;      // index0[29:0] LBA
  rand bit [15:0] rsv1_31_16;    // index1[31:16] rsv
  rand bit [7:0]  rd_length;     // index1[15:8] read length(1=4KB)
  rand bit [2:0]  rsv1_7_5;      // index1[7:5] rsv
  rand bit [4:0]  ost_id;        // index1[4:0]

  `uvm_object_utils_begin(cpu2nsu_unmap_cmd_transaction)
    `uvm_field_int(rsv0_31_30, UVM_ALL_ON)
    `uvm_field_int(nsu_addr, UVM_ALL_ON)
    `uvm_field_int(rsv1_31_16, UVM_ALL_ON)
    `uvm_field_int(rd_length, UVM_ALL_ON)
    `uvm_field_int(rsv1_7_5, UVM_ALL_ON)
    `uvm_field_int(ost_id, UVM_ALL_ON)
    `uvm_field_array_int(cpu2nsu_unmap_cmd, UVM_ALL_ON)
  `uvm_object_utils_end

  function void fields_assignment();
    if(cpu2nsu_unmap_cmd.size() != 2) `uvm_fatal("ARR_ERR", $sformatf("size=%0d", cpu2nsu_unmap_cmd.size()));
    // index0
    rsv0_31_30  = cpu2nsu_unmap_cmd[0][31:30];
    nsu_addr    = cpu2nsu_unmap_cmd[0][29:0];
    // index1
    rsv1_31_16  = cpu2nsu_unmap_cmd[1][31:16];
    rd_length   = cpu2nsu_unmap_cmd[1][15:8];
    rsv1_7_5    = cpu2nsu_unmap_cmd[1][7:5];
    ost_id      = cpu2nsu_unmap_cmd[1][4:0];
  endfunction

  constraint c_arr_bitmap {
    cpu2nsu_unmap_cmd.size() == 2;
    cpu2nsu_unmap_cmd[0] == {rsv0_31_30, nsu_addr};
    cpu2nsu_unmap_cmd[1] == {rsv1_31_16, rd_length, rsv1_7_5, ost_id};
    // rsv0_31_30 == 2'b00;
    // rsv1_31_16 == 16'h0000;
    // rsv1_7_5 == 3'b000;
  };

  function new(string name="cpu2nsu_unmap_cmd_transaction");
    super.new(name);
    cpu2nsu_unmap_cmd=new[2];
  endfunction
endclass


// ------------------------------
// nsu2cpu_rcmd_transaction
// ------------------------------
class nsu2cpu_rcmd_transaction extends uvm_sequence_item;
  typedef struct {
    int           round_num;
    logic [7:0]  plane_sel_que[$];
    int           nsu_addr_que[$];
    int           gp0_nsu_addr_que[$]; //only for cmd merge mode
    int           gp1_nsu_addr_que[$]; //only for cmd merge mode
  } plane_sel_result_t;

  plane_sel_result_t plane_sel_all;
  bit [1:0] core_id; //cpu core id
  rand bit [31:0] nsu_cmd_arr[];

  // index0
  rand bit [1:0]  rsv0;        // index0[31:30]
  rand bit [29:0] nsu_addr;    // index0[29:0] LBA

  // index1
  rand bit [15:0] rsv1;        // index1[31:16]
  rand bit [7:0]  length;      // index1[15:8](1=4KB)
  rand bit        end_flag;    // index1[7]
  rand bit        start_flag;  // index1[6]
  rand bit        fast_read_flag; // index1[5]
  rand bit [4:0]  ost_id;      // index1[4:0]

  bit cmd_merge_mode;
  bit [4:0] group0_ost_id;
  bit [4:0] group1_ost_id;
  bit [29:0] group0_nsu_addr;
  bit [29:0] group1_nsu_addr;
  rand logic [5:0] rcmd_vld_num;  // index5[5:0]
  // index2
  rand bit [31:0] mask;      // index2[31:0] cacheline

  function void fields_assignment();
    if(nsu_cmd_arr.size() != 3) `uvm_fatal("ARR_ERR", $sformatf("size:%0d!=3", nsu_cmd_arr.size()));
    // index0
    rsv0      = nsu_cmd_arr[0][31:30];
    nsu_addr  = nsu_cmd_arr[0][29:0];

    // index1
    rsv1          = nsu_cmd_arr[1][31:16];
    length        = nsu_cmd_arr[1][15:8];
    end_flag      = nsu_cmd_arr[1][7];
    start_flag    = nsu_cmd_arr[1][6];
    fast_read_flag= nsu_cmd_arr[1][5];
    ost_id        = nsu_cmd_arr[1][4:0];

    mask          = nsu_cmd_arr[2][31:0];
    rcmd_vld_num  = $countones(mask);
    update_plane_sel();
  endfunction

  function automatic plane_sel_result_t calc_plane_sel(int nsu_addr, logic [31:0] mask);
    int tmp_addr;
    bit [7:0] temp_plane_sel;
    plane_sel_result_t result;
    int plane_offset;
    // ==============================
    tmp_addr=nsu_addr;

    plane_offset = nsu_addr % 8;      // nsu_addr=0->0 , nsu_addr=4->4 , nsu_addr=8->0

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
          result.plane_sel_que.push_back(temp_plane_sel);
          result.round_num=result.round_num+1;
          result.nsu_addr_que.push_back(tmp_addr);
        end
        tmp_addr=tmp_addr+8;
      end
    end
    else begin
      if(mask[0])begin
        temp_plane_sel=8'hf0;
        result.plane_sel_que.push_back(temp_plane_sel);
        result.round_num=result.round_num+1;
        result.nsu_addr_que.push_back(tmp_addr);
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
          result.plane_sel_que.push_back((temp_plane_sel >> plane_offset) | (temp_plane_sel << (8 - plane_offset)));
          result.round_num=result.round_num+1;
          result.nsu_addr_que.push_back(tmp_addr);
        end
        tmp_addr=tmp_addr+8;
      end
    end
    return result;
  endfunction

  task automatic print_result(int nsu_addr, logic [31:0] mask, plane_sel_result_t res);
    $display("=== nsu_addr=%0d (0x%0h), mask=32'b%0b ===",
           nsu_addr, nsu_addr, mask);
    $display("total round:%0d", res.round_num);
    for (int i=0; i<res.round_num; i++) begin
      $display("round[%0d] - start_addr: 0x%0h, plane_sel:%8b",
              i+1, res.nsu_addr_que[i], res.plane_sel_que[i]);
    end
    $display("----------------------------------------");
  endtask

  function void update_plane_sel();
    this.plane_sel_all=calc_plane_sel(nsu_addr,mask);
    print_result(this.nsu_addr,this.mask,this.plane_sel_all);
  endfunction

  constraint c_arr_bitmap {
    nsu_cmd_arr.size() == 3;
    nsu_cmd_arr[0] == {rsv0, nsu_addr};
    nsu_cmd_arr[1] == {rsv1, length, end_flag, start_flag, fast_read_flag, ost_id};
    nsu_cmd_arr[2] == mask;
    rcmd_vld_num  ==$countones(mask);
    // rsv0 == '0;
    // rsv1 == '0;
  }

  function new(string name="nsu2cpu_rcmd_transaction");
    super.new(name);
    nsu_cmd_arr=new[3];
  endfunction

  `uvm_object_utils_begin(nsu2cpu_rcmd_transaction)
    `uvm_field_int(rsv0,UVM_ALL_ON)
    `uvm_field_int(nsu_addr,UVM_ALL_ON)
    `uvm_field_int(rsv1,UVM_ALL_ON)
    `uvm_field_int(length,UVM_ALL_ON)
    `uvm_field_int(end_flag,UVM_ALL_ON)
    `uvm_field_int(start_flag,UVM_ALL_ON)
    `uvm_field_int(fast_read_flag,UVM_ALL_ON)
    `uvm_field_int(ost_id,UVM_ALL_ON)
    `uvm_field_int(mask,UVM_ALL_ON)
    `uvm_field_int(rcmd_vld_num,UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// cpu2nsu_write_addr_transaction
// ------------------------------
class cpu2nsu_write_addr_transaction extends uvm_sequence_item;
  rand bit [31:0] cmd_arr[];
  // index0
  rand bit [11:0] rsv;
  rand bit [3:0]  ost_id;
  rand bit [15:0] transaction_index;
  // index1
  rand bit [31:0] write_addr;

  function new(string name="cpu2nsu_write_addr_transaction");
    super.new(name);
    cmd_arr=new[2];
  endfunction

  `uvm_object_utils_begin(cpu2nsu_write_addr_transaction)
    `uvm_field_int(rsv, UVM_ALL_ON)
    `uvm_field_int(ost_id, UVM_ALL_ON)
    `uvm_field_int(transaction_index, UVM_ALL_ON)
    `uvm_field_int(write_addr, UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// nsu2cpu_write_req_transaction
// ------------------------------
class nsu2cpu_write_req_transaction extends uvm_sequence_item;
  // index0
  rand bit [15:0] err_bitmap;
  rand bit [15:0] rsv;
  rand bit [3:0]  wr_length;
  rand bit        cmd_type;
  rand bit [3:0]  ost_id;
  rand bit [1:0]  rsv1;
  rand bit [29:0] nsu_addr;
  rand bit [31:0] wr_memory_addr;

  function new(string name="nsu2cpu_write_req_transaction");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(nsu2cpu_write_req_transaction)
    `uvm_field_int(err_bitmap,UVM_ALL_ON)
    `uvm_field_int(rsv,UVM_ALL_ON)
    `uvm_field_int(wr_length,UVM_ALL_ON)
    `uvm_field_int(cmd_type,UVM_ALL_ON)
    `uvm_field_int(ost_id,UVM_ALL_ON)
    `uvm_field_int(rsv1,UVM_ALL_ON)
    `uvm_field_int(nsu_addr,UVM_ALL_ON)
    `uvm_field_int(wr_memory_addr,UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// nsu2cpu_write_addr_resp_transaction
// ------------------------------
class nsu2cpu_write_addr_resp_transaction extends uvm_sequence_item;
  // index0
  rand bit [15:0] rsv;
  rand bit [15:0] instruction_index;

  function new(string name="nsu2cpu_write_addr_transaction");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(nsu2cpu_write_addr_resp_transaction)
    `uvm_field_int(rsv, UVM_ALL_ON)
    `uvm_field_int(instruction_index, UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// nsu2cpu_write_resp_transaction
// ------------------------------
class nsu2cpu_write_resp_transaction extends uvm_sequence_item;
  // index0
  rand bit [27:0] rsv;
  rand bit [3:0]  ost_id;

  function new(string name="nsu2cpu_write_resp_transaction");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(nsu2cpu_write_resp_transaction)
    `uvm_field_int(rsv,UVM_ALL_ON)
    `uvm_field_int(ost_id,UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// cpu2nsu_msa_write_req_transaction
// ------------------------------
class cpu2nsu_msa_write_req_transaction extends uvm_sequence_item;
  rand logic [1:0]  rsv0;
  rand logic [29:0] nsu_addr;
  rand logic [31:0] err_flag;
  rand logic [15:0] instruction_index;
  rand logic [10:0] rsv1;
  rand logic [4:0]  ost_id;
  rand logic [31:0] src_mem_addr;
  rand logic [31:0] msa_write_req[];

  function new(string name="cpu2nsu_msa_write_req_transaction");
    super.new(name);
    msa_write_req=new[4];
  endfunction

  `uvm_object_utils_begin(cpu2nsu_msa_write_req_transaction)
    `uvm_field_int(rsv0,UVM_ALL_ON)
    `uvm_field_int(nsu_addr,UVM_ALL_ON)
    `uvm_field_int(err_flag,UVM_ALL_ON)
    `uvm_field_int(instruction_index,UVM_ALL_ON)
    `uvm_field_int(rsv1,UVM_ALL_ON)
    `uvm_field_int(ost_id,UVM_ALL_ON)
    `uvm_field_int(src_mem_addr,UVM_ALL_ON)
    `uvm_field_array_int(msa_write_req,UVM_ALL_ON)
  `uvm_object_utils_end

  constraint c_msa_write_req_fields {
    // Index 0
    msa_write_req[0] == {rsv0, nsu_addr};
    // Index 1
    msa_write_req[1] == err_flag;
    // Index 2
    msa_write_req[2] == {instruction_index, rsv1, ost_id};
    // Index 3
    msa_write_req[3] == src_mem_addr;
  }
endclass


// ------------------------------
// nsu2cpu_msa_resp_transaction
// ------------------------------
class nsu2cpu_msa_resp_transaction extends uvm_sequence_item;
  rand bit [15:0] rsv;
  rand bit [15:0] instruction_index;

  function new(string name="nsu2cpu_msa_resp_transaction");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(nsu2cpu_msa_resp_transaction)
    `uvm_field_int(rsv,UVM_ALL_ON)
    `uvm_field_int(instruction_index,UVM_ALL_ON)
  `uvm_object_utils_end
endclass


// ------------------------------
// nsu2cpu_resp_transaction
// ------------------------------
class nsu2cpu_resp_transaction extends uvm_sequence_item;
  rand bit [7:0] error_plane_pair_sel;
  rand bit [7:0] nand_index;
  rand bit [15:0] instruction_index;
  rand bit [31:0] nsu2cpu_resp[];

  function new(string name="nsu2cpu_resp_transaction");
    super.new(name);
    nsu2cpu_resp=new[1];
  endfunction

  virtual function void fields_assignment(bit from_fields_to_cmd = 1'b1);
    if(from_fields_to_cmd) begin
      nsu2cpu_resp[0][31:24] = error_plane_pair_sel;
      nsu2cpu_resp[0][23:16] = nand_index;
      nsu2cpu_resp[0][15:0]  = instruction_index;
    end else begin
      error_plane_pair_sel = nsu2cpu_resp[0][31:24];
      nand_index           = nsu2cpu_resp[0][23:16];
      instruction_index    = nsu2cpu_resp[0][15:0];
    end
  endfunction

  `uvm_object_utils_begin(nsu2cpu_resp_transaction)
    `uvm_field_int(error_plane_pair_sel, UVM_ALL_ON)
    `uvm_field_int(nand_index, UVM_ALL_ON)
    `uvm_field_int(instruction_index, UVM_ALL_ON)
  `uvm_object_utils_end
endclass

class nsu2cpu_deep_resp_transaction extends uvm_sequence_item;
  `uvm_object_utils(nsu2cpu_deep_resp_transaction)
  logic [31:0]nsu2cpu_deep_resp[];
  // --------------------------
  // Index 0 fields
  // --------------------------
  logic [7:0]  plane_pair_en;
  logic        req_type;
  logic [6:0]  request_id;
  logic [15:0] instruction_index;

  // --------------------------
  // Index 1 fields
  // --------------------------
  logic [7:0]  error_injection_plane_pair_bitmap;
  logic [7:0]  plane_pair_dec_result;
  logic [7:0]  group1_block_addr;
  logic [7:0]  group0_block_addr;

  // --------------------------
  // Index 2 fields
  // --------------------------
  logic [3:0]  rsv_idx2;
  logic [4:0]  group0_ost_id;
  logic [22:0] group0_meta_index_LBA;

  // --------------------------
  // Index 3 fields
  // --------------------------
  logic [3:0]  rsv_idx3;
  logic [4:0]  group1_ost_id;
  logic [22:0] group1_meta_index_LBA;

  // --------------------------
  // Index 4 fields
  // --------------------------
  logic [1:0]  meta_mode;
  logic        deep_read_data_discard;
  logic        rsv_idx4_28;
  logic        off_wbf_err_output_en;
  logic        safe_fast_read;
  logic        deep_read_sel;
  logic        rsv_idx4_24;
  logic [11:0] group1_page_addr;
  logic [11:0] group0_page_addr;

  // --------------------------
  // Index 5 fields
  // --------------------------
  logic [7:0]  plane_pair_lba_comp;
  logic [7:0]  plane_pair_error_flag_comp;
  logic [7:0]  plane_pair_crc_result;
  logic [7:0]  plane_pair_ecc_result;

  // --------------------------
  // Index 6 fields
  // --------------------------
  logic [15:0] rsv_idx6;
  logic [15:0] plane_empty;

  // --------------------------
  // Index 7 fields
  // --------------------------
  logic [4:0]  rsv_idx7;
  logic [8:0]  plane_pair2_alter_bit_buf_id_for_msa;
  logic [8:0]  plane_pair1_alter_bit_buf_id_for_msa;
  logic [8:0]  plane_pair0_alter_bit_buf_id_for_msa;

  // --------------------------
  // Index 8 fields
  // --------------------------
  logic [4:0]  rsv_idx8;
  logic [8:0]  plane_pair5_alter_bit_buf_id_for_msa;
  logic [8:0]  plane_pair4_alter_bit_buf_id_for_msa;
  logic [8:0]  plane_pair3_alter_bit_buf_id_for_msa;

  // --------------------------
  // Index 9 fields
  // --------------------------
  logic [13:0] rsv_idx9;
  logic [8:0]  plane_pair7_alter_bit_buf_id_for_msa;
  logic [8:0]  plane_pair6_alter_bit_buf_id_for_msa;

  // --------------------------
  // Index 10 fields
  // --------------------------
  logic [15:0] plane_pair1_0_1_bit_cnt;
  logic [15:0] plane_pair0_0_1_bit_cnt;

  // --------------------------
  // Index 11 fields
  // --------------------------
  logic [15:0] plane_pair3_0_1_bit_cnt;
  logic [15:0] plane_pair2_0_1_bit_cnt;

  // --------------------------
  // Index 12 fields
  // --------------------------
  logic [15:0] plane_pair5_0_1_bit_cnt;
  logic [15:0] plane_pair4_0_1_bit_cnt;

  // --------------------------
  // Index 13 fields
  // --------------------------
  logic [15:0] plane_pair7_0_1_bit_cnt;
  logic [15:0] plane_pair6_0_1_bit_cnt;
  logic [15:0] plane_pair5_0_1_bit_cnt_dup; // 避免重名

  function new(string name = "nsu2cpu_deep_resp_transactionaction");
    super.new(name);
    nsu2cpu_deep_resp=new[14];    
  endfunction


function void fields_assignment();
  // --------------------------
  // Index 0 assignment
  // --------------------------
  plane_pair_en    = nsu2cpu_deep_resp[0][31:24];
  req_type         = nsu2cpu_deep_resp[0][23];
  request_id       = nsu2cpu_deep_resp[0][22:16];
  instruction_index = nsu2cpu_deep_resp[0][15:0];

  // --------------------------
  // Index 1 assignment
  // --------------------------
  error_injection_plane_pair_bitmap = nsu2cpu_deep_resp[1][31:24];
  plane_pair_dec_result             = nsu2cpu_deep_resp[1][23:16];
  group1_block_addr                 = nsu2cpu_deep_resp[1][15:8];
  group0_block_addr                 = nsu2cpu_deep_resp[1][7:0];

  // --------------------------
  // Index 2 assignment
  // --------------------------
  rsv_idx2              = nsu2cpu_deep_resp[2][31:28];
  group0_ost_id      = nsu2cpu_deep_resp[2][27:23];
  group0_meta_index_LBA  = nsu2cpu_deep_resp[2][22:0];

  // --------------------------
  // Index 3 assignment
  // --------------------------
  rsv_idx3              = nsu2cpu_deep_resp[3][31:28];
  group1_ost_id      = nsu2cpu_deep_resp[3][27:23];
  group1_meta_index_LBA  = nsu2cpu_deep_resp[3][22:0];

  // --------------------------
  // Index 4 assignment
  // --------------------------
  meta_mode              = nsu2cpu_deep_resp[4][31:30];
  deep_read_data_discard = nsu2cpu_deep_resp[4][29];
  rsv_idx4_28            = nsu2cpu_deep_resp[4][28];
  off_wbf_err_output_en  = nsu2cpu_deep_resp[4][27];
  safe_fast_read         = nsu2cpu_deep_resp[4][26];
  deep_read_sel          = nsu2cpu_deep_resp[4][25];
  rsv_idx4_24            = nsu2cpu_deep_resp[4][24];
  group1_page_addr       = nsu2cpu_deep_resp[4][23:12];
  group0_page_addr       = nsu2cpu_deep_resp[4][11:0];

  // --------------------------
  // Index 5 assignment
  // --------------------------
  plane_pair_lba_comp        = nsu2cpu_deep_resp[5][31:24];
  plane_pair_error_flag_comp = nsu2cpu_deep_resp[5][23:16];
  plane_pair_crc_result      = nsu2cpu_deep_resp[5][15:8];
  plane_pair_ecc_result      = nsu2cpu_deep_resp[5][7:0];

  // --------------------------
  // Index 6 assignment
  // --------------------------
  rsv_idx6    = nsu2cpu_deep_resp[6][31:16];
  plane_empty = nsu2cpu_deep_resp[6][15:0];

  // --------------------------
  // Index 7 assignment
  // --------------------------
  rsv_idx7                             = nsu2cpu_deep_resp[7][31:27];
  plane_pair2_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[7][26:18];
  plane_pair1_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[7][17:9];
  plane_pair0_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[7][8:0];

  // --------------------------
  // Index 8 assignment
  // --------------------------
  rsv_idx8                             = nsu2cpu_deep_resp[8][31:27];
  plane_pair5_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[8][26:18];
  plane_pair4_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[8][17:9];
  plane_pair3_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[8][8:0];

  // --------------------------
  // Index 9 assignment
  // --------------------------
  rsv_idx9                             = nsu2cpu_deep_resp[9][31:18];
  plane_pair7_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[9][17:9];
  plane_pair6_alter_bit_buf_id_for_msa = nsu2cpu_deep_resp[9][8:0];

  // --------------------------
  // Index 10 assignment
  // --------------------------
  plane_pair1_0_1_bit_cnt = nsu2cpu_deep_resp[10][31:16];
  plane_pair0_0_1_bit_cnt = nsu2cpu_deep_resp[10][15:0];

  // --------------------------
  // Index 11 assignment
  // --------------------------
  plane_pair3_0_1_bit_cnt = nsu2cpu_deep_resp[11][31:16];
  plane_pair2_0_1_bit_cnt = nsu2cpu_deep_resp[11][15:0];

  // --------------------------
  // Index 12 assignment
  // --------------------------
  plane_pair5_0_1_bit_cnt = nsu2cpu_deep_resp[12][31:16];
  plane_pair4_0_1_bit_cnt = nsu2cpu_deep_resp[12][15:0];

  // --------------------------
  // Index 13 assignment
  // --------------------------
  plane_pair7_0_1_bit_cnt   = nsu2cpu_deep_resp[13][31:16];
  plane_pair6_0_1_bit_cnt   = nsu2cpu_deep_resp[13][15:0];
  plane_pair5_0_1_bit_cnt_dup = nsu2cpu_deep_resp[13][15:0]; // 表中重复项
endfunction

endclass