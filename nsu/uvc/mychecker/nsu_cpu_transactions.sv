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
  rand bit [7:0] instruction_index;
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

// ------------------------------
// nsu2cpu_deep_resp_transaction
// ------------------------------
class nsu2cpu_deep_resp_transaction extends uvm_sequence_item;
  rand bit [31:0] nsu2cpu_deep_resp[];
  rand bit [7:0]  plane_pair_en;
  rand bit [7:0]  nand_index;
  rand bit [15:0] instruction_index;
  rand bit [7:0]  plane_crc_err;
  rand bit [7:0]  plane_pair_err_flag_comp;
  rand bit [7:0]  plane_pair_lba_comp;
  rand bit [7:0]  plane_pair_ondec_flag;
  rand bit        deep_read_sel;
  rand bit        read_mode;
  rand bit [1:0]  rsv0;
  rand bit [11:0] page_address_plane_group_1;
  rand bit [3:0]  rsv1;
  rand bit [11:0] page_address_plane_group_0;
  rand bit [15:0] group1_block_addr;
  rand bit [15:0] group0_block_addr;
  rand bit [31:0] group0_meta_addr;
  rand bit [31:0] group1_meta_addr;
  rand bit [31:0] group_0_dest_memory_addr;
  rand bit [31:0] group_1_dest_memory_addr;
  rand bit [31:0] dec_fail_dest_addr_0;
  rand bit [31:0] dec_fail_dest_addr_1;
  rand bit [31:0] dec_fail_dest_addr_2;
  rand bit [31:0] dec_fail_dest_addr_3;
  rand bit [31:0] dec_fail_dest_addr_4;
  rand bit [31:0] dec_fail_dest_addr_5;
  rand bit [31:0] dec_fail_dest_addr_6;
  rand bit [31:0] dec_fail_dest_addr_7;
  rand bit [4:0]  group1_ost_id;
  rand bit [12:0] plane_pair1_alter_bit;
  rand bit        plane3_empty;
  rand bit        plane2_empty;
  rand bit [4:0]  group0_ost_id;
  rand bit [8:0]  plane_pair0_alter_bit;
  rand bit        plane1_empty;
  rand bit        plane0_empty;
  rand bit [15:0] plane1_01bit;
  rand bit [15:0] plane0_01bit;
  rand bit [15:0] plane3_01bit;
  rand bit [15:0] plane2_01bit;
  rand bit [4:0]  rsv2;
  rand bit [8:0]  plane_pair3_alter_bit;
  rand bit        plane7_empty;
  rand bit        plane6_empty;
  rand bit [4:0]  rsv3;
  rand bit [8:0]  plane_pair2_alter_bit;
  rand bit        plane5_empty;
  rand bit        plane4_empty;
  rand bit [15:0] plane5_01bit;
  rand bit [15:0] plane4_01bit;
  rand bit [15:0] plane7_01bit;
  rand bit [15:0] plane6_01bit;
  rand bit [4:0]  rsv4;
  rand bit [8:0]  plane_pair5_alter_bit;
  rand bit        plane11_empty;
  rand bit        plane10_empty;
  rand bit [4:0]  rsv5;
  rand bit [8:0]  plane_pair4_alter_bit;
  rand bit        plane9_empty;
  rand bit        plane8_empty;
  rand bit [15:0] plane9_01bit;
  rand bit [15:0] plane8_01bit;
  rand bit [15:0] plane11_01bit;
  rand bit [15:0] plane10_01bit;
  rand bit [4:0]  rsv6;
  rand bit [8:0]  plane_pair7_alter_bit;
  rand bit        plane15_empty;
  rand bit        plane14_empty;
  rand bit [4:0]  rsv7;
  rand bit [8:0]  plane_pair6_alter_bit;
  rand bit        plane13_empty;
  rand bit        plane12_empty;
  rand bit [15:0] plane13_01bit;
  rand bit [15:0] plane12_01bit;
  rand bit [15:0] plane15_01bit;
  rand bit [15:0] plane14_01bit;

  function new(string name="nsu2cpu_deep_resp_transaction");
    super.new(name);
    nsu2cpu_deep_resp=new[28];
  endfunction

  function void fields_assignment();
    // Index 0
    plane_pair_en      = nsu2cpu_deep_resp[0][31:24];
    nand_index          = nsu2cpu_deep_resp[0][23:16];
    instruction_index   = nsu2cpu_deep_resp[0][15:0];

    // Index 1
    plane_crc_err       = nsu2cpu_deep_resp[1][31:24];
    plane_pair_err_flag_comp = nsu2cpu_deep_resp[1][23:16];
    plane_pair_lba_comp = nsu2cpu_deep_resp[1][15:8];
    plane_pair_ondec_flag = nsu2cpu_deep_resp[1][7:0];

    // Index 2
    deep_read_sel       = nsu2cpu_deep_resp[2][31];
    read_mode           = nsu2cpu_deep_resp[2][30];
    rsv0                = nsu2cpu_deep_resp[2][29:28];
    page_address_plane_group_1 = nsu2cpu_deep_resp[2][27:16];
    rsv1                = nsu2cpu_deep_resp[2][15:12];
    page_address_plane_group_0 = nsu2cpu_deep_resp[2][11:0];

    // Index 3
    group1_block_addr   = nsu2cpu_deep_resp[3][31:16];
    group0_block_addr   = nsu2cpu_deep_resp[3][15:0];

    // Index 4-7
    group0_meta_addr    = nsu2cpu_deep_resp[4];
    group1_meta_addr    = nsu2cpu_deep_resp[5];
    group_0_dest_memory_addr = nsu2cpu_deep_resp[6];
    group_1_dest_memory_addr = nsu2cpu_deep_resp[7];

    // Index 8-15
    dec_fail_dest_addr_0 = nsu2cpu_deep_resp[8];
    dec_fail_dest_addr_1 = nsu2cpu_deep_resp[9];
    dec_fail_dest_addr_2 = nsu2cpu_deep_resp[10];
    dec_fail_dest_addr_3 = nsu2cpu_deep_resp[11];
    dec_fail_dest_addr_4 = nsu2cpu_deep_resp[12];
    dec_fail_dest_addr_5 = nsu2cpu_deep_resp[13];
    dec_fail_dest_addr_6 = nsu2cpu_deep_resp[14];
    dec_fail_dest_addr_7 = nsu2cpu_deep_resp[15];

    // Index 16
    group1_ost_id       = nsu2cpu_deep_resp[16][31:27];
    plane_pair1_alter_bit = nsu2cpu_deep_resp[16][26:18];
    plane3_empty        = nsu2cpu_deep_resp[16][17];
    plane2_empty        = nsu2cpu_deep_resp[16][16];
    group0_ost_id       = nsu2cpu_deep_resp[16][15:11];
    plane_pair0_alter_bit = nsu2cpu_deep_resp[16][10:2];
    plane1_empty        = nsu2cpu_deep_resp[16][1];
    plane0_empty        = nsu2cpu_deep_resp[16][0];

    // Index 17-18
    plane1_01bit        = nsu2cpu_deep_resp[17][31:16];
    plane0_01bit        = nsu2cpu_deep_resp[17][15:0];
    plane3_01bit        = nsu2cpu_deep_resp[18][31:16];
    plane2_01bit        = nsu2cpu_deep_resp[18][15:0];

    // Index 19
    rsv2                = nsu2cpu_deep_resp[19][31:27];
    plane_pair3_alter_bit = nsu2cpu_deep_resp[19][26:18];
    plane7_empty        = nsu2cpu_deep_resp[19][17];
    plane6_empty        = nsu2cpu_deep_resp[19][16];
    rsv3                = nsu2cpu_deep_resp[19][15:11];
    plane_pair2_alter_bit = nsu2cpu_deep_resp[19][10:2];
    plane5_empty        = nsu2cpu_deep_resp[19][1];
    plane4_empty        = nsu2cpu_deep_resp[19][0];

    // Index 20-21
    plane5_01bit        = nsu2cpu_deep_resp[20][31:16];
    plane4_01bit        = nsu2cpu_deep_resp[20][15:0];
    plane7_01bit        = nsu2cpu_deep_resp[21][31:16];
    plane6_01bit        = nsu2cpu_deep_resp[21][15:0];

    // Index 22
    rsv4                = nsu2cpu_deep_resp[22][31:27];
    plane_pair5_alter_bit = nsu2cpu_deep_resp[22][26:18];
    plane11_empty       = nsu2cpu_deep_resp[22][17];
    plane10_empty       = nsu2cpu_deep_resp[22][16];
    rsv5                = nsu2cpu_deep_resp[22][15:11];
    plane_pair4_alter_bit = nsu2cpu_deep_resp[22][10:2];
    plane9_empty        = nsu2cpu_deep_resp[22][1];
    plane8_empty        = nsu2cpu_deep_resp[22][0];

    // Index 23-24
    plane9_01bit        = nsu2cpu_deep_resp[23][31:16];
    plane8_01bit        = nsu2cpu_deep_resp[23][15:0];
    plane11_01bit       = nsu2cpu_deep_resp[24][31:16];
    plane10_01bit       = nsu2cpu_deep_resp[24][15:0];

    // Index 25
    rsv6                = nsu2cpu_deep_resp[25][31:27];
    plane_pair7_alter_bit = nsu2cpu_deep_resp[25][26:18];
    plane15_empty       = nsu2cpu_deep_resp[25][17];
    plane14_empty       = nsu2cpu_deep_resp[25][16];
    rsv7                = nsu2cpu_deep_resp[25][15:11];
    plane_pair6_alter_bit = nsu2cpu_deep_resp[25][10:2];
    plane13_empty       = nsu2cpu_deep_resp[25][1];
    plane12_empty       = nsu2cpu_deep_resp[25][0];

    // Index 26-27
    plane13_01bit       = nsu2cpu_deep_resp[26][31:16];
    plane12_01bit       = nsu2cpu_deep_resp[26][15:0];
    plane15_01bit       = nsu2cpu_deep_resp[27][31:16];
    plane14_01bit       = nsu2cpu_deep_resp[27][15:0];

    `uvm_info("FIELDS_EXTRACTION", "All variables extracted successfully!", UVM_LOW);
  endfunction

  function void array_assignment();
    nsu2cpu_deep_resp = new[28];

    nsu2cpu_deep_resp[0] = {
      plane_pair_en[7:0],
      nand_index[7:0],
      instruction_index[15:0]
    };

    nsu2cpu_deep_resp[1] = {
      plane_crc_err[7:0],
      plane_pair_err_flag_comp[7:0],
      plane_pair_lba_comp[7:0],
      plane_pair_ondec_flag[7:0]
    };

    nsu2cpu_deep_resp[2] = {
      deep_read_sel,
      read_mode,
      rsv0[1:0],
      page_address_plane_group_1[11:0],
      rsv1[3:0],
      page_address_plane_group_0[11:0]
    };

    nsu2cpu_deep_resp[3] = {
      group1_block_addr[15:0],
      group0_block_addr[15:0]
    };

    nsu2cpu_deep_resp[4]  = group0_meta_addr;
    nsu2cpu_deep_resp[5]  = group1_meta_addr;
    nsu2cpu_deep_resp[6]  = group_0_dest_memory_addr;
    nsu2cpu_deep_resp[7]  = group_1_dest_memory_addr;

    nsu2cpu_deep_resp[8]  = dec_fail_dest_addr_0;
    nsu2cpu_deep_resp[9]  = dec_fail_dest_addr_1;
    nsu2cpu_deep_resp[10] = dec_fail_dest_addr_2;
    nsu2cpu_deep_resp[11] = dec_fail_dest_addr_3;
    nsu2cpu_deep_resp[12] = dec_fail_dest_addr_4;
    nsu2cpu_deep_resp[13] = dec_fail_dest_addr_5;
    nsu2cpu_deep_resp[14] = dec_fail_dest_addr_6;
    nsu2cpu_deep_resp[15] = dec_fail_dest_addr_7;

    nsu2cpu_deep_resp[16] = {
      group1_ost_id[4:0],
      plane_pair1_alter_bit[8:0],
      plane3_empty,
      plane2_empty,
      group0_ost_id[4:0],
      plane_pair0_alter_bit[8:0],
      plane1_empty,
      plane0_empty
    };

    nsu2cpu_deep_resp[17] = {plane1_01bit[15:0], plane0_01bit[15:0]};
    nsu2cpu_deep_resp[18] = {plane3_01bit[15:0], plane2_01bit[15:0]};

    nsu2cpu_deep_resp[19] = {
      rsv2[4:0],
      plane_pair3_alter_bit[8:0],
      plane7_empty,
      plane6_empty,
      rsv3[4:0],
      plane_pair2_alter_bit[8:0],
      plane5_empty,
      plane4_empty
    };

    nsu2cpu_deep_resp[20] = {plane5_01bit[15:0], plane4_01bit[15:0]};
    nsu2cpu_deep_resp[21] = {plane7_01bit[15:0], plane6_01bit[15:0]};

    nsu2cpu_deep_resp[22] = {
      rsv4[4:0],
      plane_pair5_alter_bit[8:0],
      plane11_empty,
      plane10_empty,
      rsv5[4:0],
      plane_pair4_alter_bit[8:0],
      plane9_empty,
      plane8_empty
    };

    nsu2cpu_deep_resp[23] = {plane9_01bit[15:0], plane8_01bit[15:0]};
    nsu2cpu_deep_resp[24] = {plane11_01bit[15:0], plane10_01bit[15:0]};

    nsu2cpu_deep_resp[25] = {
      rsv6[4:0],
      plane_pair7_alter_bit[8:0],
      plane15_empty,
      plane14_empty,
      rsv7[4:0],
      plane_pair6_alter_bit[8:0],
      plane13_empty,
      plane12_empty
    };

    nsu2cpu_deep_resp[26] = {plane13_01bit[15:0], plane12_01bit[15:0]};
    nsu2cpu_deep_resp[27] = {plane15_01bit[15:0], plane14_01bit[15:0]};
  endfunction

endclass