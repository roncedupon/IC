`define ONDEC2NSU_CMD_WIDTH 32
`define ONDEC2NSU_DATA_WIDTH 512
`define ONDEC2NSU_DATA_LENGTH 4096*8/512
`define ONDEC2NSU_CMD_LENGTH 11
`define ONDEC2NSU_REQ_ADDR_WIDTH 8

class ondec2nsu_transaction extends uvm_sequence_item;

    rand int on_dec_cmd_delay[];
    rand int on_dec_data_delay[];
    rand logic [`ONDEC2NSU_CMD_WIDTH-1 :0] on_dec_cmd[];
    rand logic [`ONDEC2NSU_DATA_WIDTH-1:0] on_dec_data[];//512b--64B
    rand logic [`ONDEC2NSU_REQ_ADDR_WIDTH-1:0]nsu_online_addr;
    // bit [31:0] on_dec_cmd[];
    rand logic[31:0] lba;//meta_data0
    rand logic[31:0] meta_addr;
    // -------------------------
    // index0 (32bit)
    // -------------------------
    rand logic [1:0]   rsv0_31_30;
    rand logic         discard_read_data;
    rand logic [4:0]   rsv0_28_24;
    rand logic [7:0]   nand_index;
    rand logic [15:0]  instruction_index;

    // -------------------------
    // index1 (32bit)
    // -------------------------
    rand logic [2:0]   rsv1_31;
    rand logic         off_wbf_err_output_en;
    rand logic         deep_read_data_discard;
    rand logic [4:0]   nsu_ost_id;
    rand logic         deep_read_status_sel;
    rand logic         crc_pass;//0 --> crc error
    rand logic         program_verify_read;
    rand logic         read_mode;//0-->save read/1-->fast read
    rand logic [1:0]   response_sel_que;
    rand logic [1:0]   meta_mode;
    rand logic         deep_read_sel;
    rand logic         write_pos_jdg;//0:nsu 1:sharemem
    rand logic         error_flag;
    rand logic         plane_sel;
    rand logic         dec_suc;//1-->decode success
    rand logic [8:0]   decode_correct_bit_num;
    rand logic         plane1_empty;
    rand logic         plane0_empty;

    // -------------------------
    // index2 (32bit)
    // -------------------------
    rand logic [15:0]  plane1_bit_cnt;
    rand logic [15:0]  plane0_bit_cnt;

    // -------------------------
    // index3~5 (32bit)
    // -------------------------
    rand logic [31:0]  meta_buffer_id;
    rand logic [31:0]  dest_memory_addr;
    rand logic [31:0]  dec_fail_dest_addr;

    // -------------------------
    // index6 (32bit)
    // -------------------------
    rand logic [15:0]  plane_group_block_addr;
    rand logic [3:0]   rsv6_15_12;
    rand logic [11:0]  page_addr_plane_group;

    // -------------------------
    // index7~10 (32bit) (meta_data)
    // -------------------------
    rand logic [31:0]  meta_data_0;
    rand logic [31:0]  meta_data_1;
    rand logic [31:0]  meta_data_2;
    rand logic [31:0]  meta_data_3;

    // -------------------------
    // index11 (32bit)
    // -------------------------
    rand logic [10:0]  rsv11_31_21;
    rand logic         data_out_en;
    rand logic         offline_wbf_work_en;
    rand logic         flip_threshold_sel;
    rand logic         syn_weight_over_threshold;
    rand logic [15:0]  descramble_seed;
    rand logic         descramble_en;
    rand logic         done_occur;

    constraint c_done_occur{
        if (plane_sel == 0) {
            done_occur == 0;
        } else if (data_out_en == 0) {
            done_occur == 0;
        } else if (write_pos_jdg == 1) {//data_out_en==1 ,write_pos_jdg=1-->to sharemem
            done_occur == 1;
        } else if (offline_wbf_work_en == 1) {//data_out_en==1,offline_wbf_work_en=1 --> to sharemem
            done_occur == 1;
        } else {
            done_occur == 0;
        }
    }

    constraint c_rsv{
        rsv0_31_30==0;
        rsv0_28_24==0;
        rsv1_31==0;
        rsv6_15_12==0;
        rsv11_31_21==0;
    }

    constraint meta_mode_range{
        meta_mode inside {[0:2]};
    }

    constraint dec_suc_plane_sel{
        (!plane_sel) -> dec_suc==1;//plane pair should do this!
        // (plane_sel==1&& crc_pass==1'b0)->dec_suc==0;
    }

    constraint c_off_wbf_err_output_en{
        soft off_wbf_err_output_en==1'b1;//offwbf error,data will be output
    }

    constraint c_on_dec_cmd {
        // 1.
        on_dec_cmd.size() == 12;

        // -------------------------
        // index 0
        // -------------------------
        on_dec_cmd[0][31:30] == rsv0_31_30;
        on_dec_cmd[0][29]    == discard_read_data;
        on_dec_cmd[0][28:24] == rsv0_28_24;
        on_dec_cmd[0][23:16] == nand_index;
        on_dec_cmd[0][15:0]  == instruction_index;

        // -------------------------
        // index 1
        // -------------------------
        on_dec_cmd[1][31]   == rsv1_31;
        on_dec_cmd[1][30]   == off_wbf_err_output_en;
        on_dec_cmd[1][29]   == deep_read_data_discard;
        on_dec_cmd[1][28:24] == nsu_ost_id;
        on_dec_cmd[1][23]   == deep_read_status_sel;
        on_dec_cmd[1][22]   == crc_pass;
        on_dec_cmd[1][21]   == program_verify_read;
        on_dec_cmd[1][20]   == read_mode;
        on_dec_cmd[1][19:18] == response_sel_que;
        on_dec_cmd[1][17:16] == meta_mode;
        on_dec_cmd[1][15]   == deep_read_sel;
        on_dec_cmd[1][14]   == write_pos_jdg;
        on_dec_cmd[1][13]   == error_flag;
        on_dec_cmd[1][12]   == plane_sel;
        on_dec_cmd[1][11]   == dec_suc;
        on_dec_cmd[1][10:2] == decode_correct_bit_num;
        on_dec_cmd[1][1]    == plane1_empty;
        on_dec_cmd[1][0]    == plane0_empty;

        // -------------------------
        // index 2
        // -------------------------
        on_dec_cmd[2][31:16] == plane1_bit_cnt;
        on_dec_cmd[2][15:0]  == plane0_bit_cnt;

        // -------------------------
        // index 3-5
        // -------------------------
        on_dec_cmd[3] == meta_buffer_id;
        on_dec_cmd[4] == dest_memory_addr;
        on_dec_cmd[5] == dec_fail_dest_addr;

        // -------------------------
        // index 6
        // -------------------------
        on_dec_cmd[6][31:16] == plane_group_block_addr;
        on_dec_cmd[6][15:12] == rsv6_15_12;
        on_dec_cmd[6][11:0]  == page_addr_plane_group;

        // -------------------------
        // index 7-10
        // -------------------------
        on_dec_cmd[7]  == meta_data_0;
        on_dec_cmd[8]  == meta_data_1;
        on_dec_cmd[9]  == meta_data_2;
        on_dec_cmd[10] == meta_data_3;

        // -------------------------
        // index 11
        // -------------------------
        on_dec_cmd[11][31:21] == rsv11_31_21;
        on_dec_cmd[11][20]    == data_out_en;
        on_dec_cmd[11][19]    == offline_wbf_work_en;
        on_dec_cmd[11][18]    == flip_threshold_sel;
        on_dec_cmd[11][17]    == syn_weight_over_threshold;
        on_dec_cmd[11][16:1]  == descramble_seed;
        on_dec_cmd[11][0]     == descramble_en;
    }

    virtual function void set_meta_value(bit[1:0] meta_mode);
        if (meta_mode == 2'b01) begin
            this.meta_addr = this.lba;
        end
    endfunction

    function void cmd_fields_assignment();
        rsv0_31_30        = on_dec_cmd[0][31:30];
        discard_read_data = on_dec_cmd[0][29];
        rsv0_28_24        = on_dec_cmd[0][28:24];
        nand_index        = on_dec_cmd[0][23:16];
        instruction_index = on_dec_cmd[0][15:0];

        // index1
        rsv1_31           = on_dec_cmd[1][31];
        off_wbf_err_output_en      = on_dec_cmd[1][30];
        deep_read_data_discard     = on_dec_cmd[1][29];
        nsu_ost_id         = on_dec_cmd[1][28:24];
        deep_read_status_sel = on_dec_cmd[1][23];
        crc_pass           = on_dec_cmd[1][22];
        program_verify_read = on_dec_cmd[1][21];
        read_mode         = on_dec_cmd[1][20];
        response_sel_que  = on_dec_cmd[1][19:18];
        meta_mode         = on_dec_cmd[1][17:16];
        deep_read_sel     = on_dec_cmd[1][15];
        write_pos_jdg     = on_dec_cmd[1][14];
        error_flag        = on_dec_cmd[1][13];
        plane_sel         = on_dec_cmd[1][12];
        dec_suc           = on_dec_cmd[1][11];
        decode_correct_bit_num = on_dec_cmd[1][10:2];
        plane1_empty      = on_dec_cmd[1][1];
        plane0_empty      = on_dec_cmd[1][0];

        // index2
        plane1_bit_cnt    = on_dec_cmd[2][31:16];
        plane0_bit_cnt    = on_dec_cmd[2][15:0];

        // index3~5
        meta_buffer_id    = on_dec_cmd[3];
        dest_memory_addr  = on_dec_cmd[4];
        dec_fail_dest_addr = on_dec_cmd[5];

        // index6
        plane_group_block_addr = on_dec_cmd[6][31:16];
        rsv6_15_12        = on_dec_cmd[6][15:12];
        page_addr_plane_group = on_dec_cmd[6][11:0];

        // index7~10
        meta_data_0       = on_dec_cmd[7];
        meta_data_1       = on_dec_cmd[8];
        meta_data_2       = on_dec_cmd[9];
        meta_data_3       = on_dec_cmd[10];

        // index11
        rsv11_31_21       = on_dec_cmd[11][31:21];
        data_out_en       = on_dec_cmd[11][20];
        offline_wbf_work_en = on_dec_cmd[11][19];
        flip_threshold_sel = on_dec_cmd[11][18];
        syn_weight_over_threshold = on_dec_cmd[11][17];
        descramble_seed   = on_dec_cmd[11][16:1];
        descramble_en     = on_dec_cmd[11][0];
    endfunction

    function void set_ondec_data_length(int length_4k);
        if(length_4k==0)begin
            `uvm_warning("no data situation","length_4k is 0");
        end
        else begin
            on_dec_data = new[length_4k*64];
        end
    endfunction

    constraint delay_range{
        foreach (on_dec_cmd_delay[i])
            on_dec_cmd_delay[i] dist {0:/50, [1:5]:/50};
        foreach (on_dec_data_delay[i])
            on_dec_data_delay[i] dist {0:/50, [1:5]:/50};
    }

    `uvm_object_utils_begin(ondec2nsu_transaction)
        `uvm_field_array_int(on_dec_cmd, UVM_ALL_ON)
        `uvm_field_array_int(on_dec_data, UVM_ALL_ON)
        `uvm_field_int(done_occur, UVM_ALL_ON)
        `uvm_field_int(nsu_online_addr,UVM_ALL_ON)

        `uvm_field_array_int(on_dec_cmd_delay, UVM_ALL_ON)
        `uvm_field_array_int(on_dec_data_delay, UVM_ALL_ON)

        `uvm_field_int(rsv0_31_30,UVM_ALL_ON)
        `uvm_field_int(discard_read_data,UVM_ALL_ON)
        `uvm_field_int(rsv0_28_24,UVM_ALL_ON)
        `uvm_field_int(nand_index,UVM_ALL_ON)
        `uvm_field_int(instruction_index,UVM_ALL_ON)
        `uvm_field_int(rsv1_31,UVM_ALL_ON)
        `uvm_field_int(nsu_ost_id,UVM_ALL_ON)
        `uvm_field_int(deep_read_status_sel,UVM_ALL_ON)
        `uvm_field_int(crc_pass,UVM_ALL_ON)
        `uvm_field_int(program_verify_read,UVM_ALL_ON)
        `uvm_field_int(read_mode,UVM_ALL_ON)
        `uvm_field_int(response_sel_que,UVM_ALL_ON)
        `uvm_field_int(meta_mode,UVM_ALL_ON)
        `uvm_field_int(deep_read_sel,UVM_ALL_ON)
        `uvm_field_int(write_pos_jdg,UVM_ALL_ON)
        `uvm_field_int(error_flag,UVM_ALL_ON)
        `uvm_field_int(plane_sel,UVM_ALL_ON)
        `uvm_field_int(dec_suc,UVM_ALL_ON)
        `uvm_field_int(decode_correct_bit_num,UVM_ALL_ON)
        `uvm_field_int(plane1_empty,UVM_ALL_ON)
        `uvm_field_int(plane0_empty,UVM_ALL_ON)
        `uvm_field_int(plane1_bit_cnt,UVM_ALL_ON)
        `uvm_field_int(plane0_bit_cnt,UVM_ALL_ON)
        `uvm_field_int(meta_buffer_id,UVM_ALL_ON)
        `uvm_field_int(dest_memory_addr,UVM_ALL_ON)
        `uvm_field_int(dec_fail_dest_addr,UVM_ALL_ON)
        `uvm_field_int(plane_group_block_addr,UVM_ALL_ON)
        `uvm_field_int(rsv6_15_12,UVM_ALL_ON)
        `uvm_field_int(page_addr_plane_group,UVM_ALL_ON)
        `uvm_field_int(meta_data_0,UVM_ALL_ON)
        `uvm_field_int(meta_data_1,UVM_ALL_ON)
        `uvm_field_int(meta_data_2,UVM_ALL_ON)
        `uvm_field_int(meta_data_3,UVM_ALL_ON)
        `uvm_field_int(rsv11_31_21,UVM_ALL_ON)
        `uvm_field_int(data_out_en,UVM_ALL_ON)
        `uvm_field_int(offline_wbf_work_en,UVM_ALL_ON)
        `uvm_field_int(flip_threshold_sel,UVM_ALL_ON)
        `uvm_field_int(syn_weight_over_threshold,UVM_ALL_ON)
        `uvm_field_int(descramble_seed,UVM_ALL_ON)
        `uvm_field_int(descramble_en,UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name = "ondec2nsu_transaction");
        super.new(name);
        on_dec_cmd=new[12];
    endfunction

    function bit is_done();
        if (!this.plane_sel)
            this.done_occur = 0;
        else if (!this.dec_suc & !this.read_mode)
            this.done_occur = 0;
        else if (this.discard_read_data)
            this.done_occur = 0;
        else
            this.done_occur = 1;
    endfunction

    // data_out_en
    constraint c_data_out_en {
        // CRC success -> data output enable
        (plane_sel == 1'b1 && crc_pass == 1'b1 && dec_suc==1'b1) -> (data_out_en == 1'b1);
        // Program verify read -> data output enable
        (plane_sel == 1'b1 && program_verify_read == 1'b1) -> (data_out_en == 1'b1);
        // Fast read -> data output enable
        (plane_sel == 1'b1 && read_mode == 1'b1) -> (data_out_en == 1'b1);
        // Offline WBF enable -> data output enable
        (plane_sel == 1'b1 && offline_wbf_work_en == 1'b1) -> (data_out_en == 1'b1);
        // Plane not selected -> no data output
        (plane_sel == 1'b0) -> (data_out_en == 1'b0);
        (data_out_en==1'b0) -> (offline_wbf_work_en==1'b0);

        /**If the ONDEC WBF fails and the address space is sufficient, data will be output to sharemem(wbf_pass=0&offwbf_flag=1),
        otherwise, no data will be output.(wbf_pass=0&offwbf_flag=0->data_out_en=0); **/
        ((dec_suc==0&&crc_pass==1) && offline_wbf_work_en==0)->(data_out_en==1'b0);
        (offline_wbf_work_en==1)->(data_out_en==1'b1);
    }

    // offline_wbf_work_en
    constraint c_offline_wbf_work_en {
        // Offline WBF -> safe read mode
        (plane_sel == 1'b1 && offline_wbf_work_en == 1'b1) -> (read_mode == 1'b0);
        // Offline WBF -> decode fail
        (plane_sel == 1'b1 && offline_wbf_work_en == 1'b1) -> (dec_suc == 1'b0);
        // Offline WBF -> CRC no error [TODO confirmed]
        (plane_sel == 1'b1 && offline_wbf_work_en == 1'b1) -> (crc_pass == 1'b1);
    }

    // deep_read_sel
    constraint c_deep_read_sel {
        // Force error -> deep read enable
        // (plane_sel == 1'b1 && error_flag == 1'b1) -> (deep_read_sel == 1'b1);
        // // CRC error -> deep read enable
        // (plane_sel == 1'b1 && crc_pass == 1'b1) -> (deep_read_sel == 1'b1);
        // (plane_sel == 1'b1 && crc_pass == 1'b0 && dec_suc==1'b1) -> (deep_read_sel == 1'b0);//crc pass
        soft deep_read_sel ==0;//TODO,controlled by cpu
    }

    // // dec_suc & error_flag
    // constraint c_dec_suc_error_flag {
    //     // CRC success -> no force error
    //     (plane_sel == 1'b1 && crc_pass == 1'b1) -> (error_flag == 1'b0);
    // }

    // meta_mode
    constraint c_meta_mode {
        // IO read (nsu) -> meta mode != 2'b10
        (plane_sel == 1'b1 && write_pos_jdg == 1'b1) -> (meta_mode != 2'b10);
    }

    // safe read
    constraint c_safe_read {
        // Deep read -> safe read mode
        (plane_sel == 1'b1 && deep_read_sel == 1'b1) -> (read_mode == 1'b0);
    }

    // // address alignment (64B)
    // constraint c_addr_alignment {
    //     dest_memory_addr[5:0] == 6'b0;    // 64B aligned
    //     dec_fail_dest_addr[5:0] == 6'b0;  // 64B aligned
    // }

    constraint c_dec_fail_dest_addr{
        // (data_out_en==0)->(dec_fail_dest_addr=='hFFFFFFFF);
        // (crc_pass==1'b1)->(dec_fail_dest_addr=='hFFFFFFFF);
        (dec_suc==1'b1)->(dec_fail_dest_addr=='hFFFFFFFF);
    }

    // constraint c_wbf_pass{
    //     wbf_pass==0->crc_pass!=0;
    //     crc_pass==0->wbf_pass!=0;
    // }

endclass


class ondec2nsu_group_transaction extends uvm_sequence_item;
    `uvm_object_utils(ondec2nsu_group_transaction)

    rand ondec2nsu_transaction tr[8];

    function new(string name = "ondec2nsu_group_transaction");
        super.new(name);
        foreach(tr[i]) begin
            tr[i] = ondec2nsu_transaction::type_id::create($sformatf("tr[%0d]", i));
        end
    endfunction

    constraint c_tr_array_size {
        tr.size() == 8;
    }

    constraint all_fields_consistent {
        foreach(tr[i]){
            if(i > 0) {
                tr[i].discard_read_data    == tr[0].discard_read_data;
                tr[i].nand_index            == tr[0].nand_index;
                tr[i].instruction_index     == tr[0].instruction_index;
                tr[i].deep_read_status_sel  == tr[0].deep_read_status_sel;
                // tr[i].crc_flag == tr[0].crc_flag;
                tr[i].program_verify_read   == tr[0].program_verify_read;
                tr[i].read_mode             == tr[0].read_mode;
                tr[i].response_sel_que      == tr[0].response_sel_que;
                tr[i].meta_mode             == tr[0].meta_mode;
                tr[i].deep_read_sel         == tr[0].deep_read_sel;
                tr[i].descramble_en         == tr[0].descramble_en;
                soft tr[i].write_pos_jdg    == tr[0].write_pos_jdg;
                if(i==4){
                    soft tr[i].meta_buffer_id      == tr[0].meta_buffer_id+4;
                }
            }
        }
    }

    constraint group_consistent {
        foreach(tr[i]){
            if(i != (i < 4 ? 0 : 4)){//i!=0 or i!=4
                tr[i].nsu_ost_id           == tr[(i < 4) ? 0 : 4].nsu_ost_id;
                tr[i].plane_group_block_addr == tr[(i < 4) ? 0 : 4].plane_group_block_addr;
                tr[i].page_addr_plane_group == tr[(i < 4) ? 0 : 4].page_addr_plane_group;
                tr[i].meta_buffer_id       == tr[(i < 4) ? 0 : 4].meta_buffer_id;//+meta_buffer_id[0]+0,1,2,3 and meta_buffer_id[4]+4,5,6,7
            }
        }
    }

    // Print function for group transaction with bit field differentiation
    function void print();
        `uvm_info(get_name(), $sformatf("=== ondec2nsu_group_transaction: %s ===", get_name()), UVM_LOW);
        
        // Print common fields from first transaction (since they should be consistent)
        `uvm_info(get_name(), $sformatf("Common fields:"), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  discard_read_data: %b (bit 29)", tr[0].discard_read_data), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  nand_index: 0x%0h (bits 23:16)", tr[0].nand_index), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  instruction_index: 0x%0h (bits 15:0)", tr[0].instruction_index), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  deep_read_status_sel: %b (bit 23)", tr[0].deep_read_status_sel), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  program_verify_read: %b (bit 21)", tr[0].program_verify_read), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  read_mode: %b (bit 20)", tr[0].read_mode), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  response_sel_que: %b (bits 19:18)", tr[0].response_sel_que), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  meta_mode: %b (bits 17:16)", tr[0].meta_mode), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  deep_read_sel: %b (bit 15)", tr[0].deep_read_sel), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  descramble_en: %b (bit 0)", tr[0].descramble_en), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  write_pos_jdg: %b (bit 14)", tr[0].write_pos_jdg), UVM_LOW);
        
        // Print individual transaction fields with bit field information
        for (int i = 0; i < 8; i++) begin
            `uvm_info(get_name(), $sformatf("\nTransaction[%0d]:", i), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  nsu_ost_id: %d (bits 28:24)", tr[i].nsu_ost_id), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane_sel: %b (bit 12)", tr[i].plane_sel), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  dec_suc: %b (bit 11)", tr[i].dec_suc), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  crc_pass: %b (bit 22)", tr[i].crc_pass), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  error_flag: %b (bit 13)", tr[i].error_flag), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  data_out_en: %b (bit 20)", tr[i].data_out_en), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  offline_wbf_work_en: %b (bit 19)", tr[i].offline_wbf_work_en), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  decode_correct_bit_num: %d (bits 10:2)", tr[i].decode_correct_bit_num), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane0_empty: %b (bit 0)", tr[i].plane0_empty), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane1_empty: %b (bit 1)", tr[i].plane1_empty), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane0_bit_cnt: %d (bits 15:0)", tr[i].plane0_bit_cnt), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane1_bit_cnt: %d (bits 31:16)", tr[i].plane1_bit_cnt), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  plane_group_block_addr: 0x%0h (bits 31:16)", tr[i].plane_group_block_addr), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  page_addr_plane_group: 0x%0h (bits 11:0)", tr[i].page_addr_plane_group), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  meta_buffer_id: 0x%0h", tr[i].meta_buffer_id), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  dest_memory_addr: 0x%0h", tr[i].dest_memory_addr), UVM_LOW);
            `uvm_info(get_name(), $sformatf("  dec_fail_dest_addr: 0x%0h", tr[i].dec_fail_dest_addr), UVM_LOW);
            
            // Print command fields with bit positions
            `uvm_info(get_name(), $sformatf("  Command fields breakdown:"), UVM_LOW);
            `uvm_info(get_name(), $sformatf("    index0: 0x%08h", tr[i].on_dec_cmd[0]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 31:30: %b (rsv0_31_30)", tr[i].on_dec_cmd[0][31:30]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 29: %b (discard_read_data)", tr[i].on_dec_cmd[0][29]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 28:24: %b (rsv0_28_24)", tr[i].on_dec_cmd[0][28:24]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 23:16: %b (nand_index)", tr[i].on_dec_cmd[0][23:16]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 15:0: %b (instruction_index)", tr[i].on_dec_cmd[0][15:0]), UVM_LOW);
            
            `uvm_info(get_name(), $sformatf("    index1: 0x%08h", tr[i].on_dec_cmd[1]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 31: %b (rsv1_31)", tr[i].on_dec_cmd[1][31]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 30: %b (off_wbf_err_output_en)", tr[i].on_dec_cmd[1][30]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 29: %b (deep_read_data_discard)", tr[i].on_dec_cmd[1][29]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 28:24: %b (nsu_ost_id)", tr[i].on_dec_cmd[1][28:24]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 23: %b (deep_read_status_sel)", tr[i].on_dec_cmd[1][23]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 22: %b (crc_pass)", tr[i].on_dec_cmd[1][22]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 21: %b (program_verify_read)", tr[i].on_dec_cmd[1][21]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 20: %b (read_mode)", tr[i].on_dec_cmd[1][20]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 19:18: %b (response_sel_que)", tr[i].on_dec_cmd[1][19:18]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 17:16: %b (meta_mode)", tr[i].on_dec_cmd[1][17:16]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 15: %b (deep_read_sel)", tr[i].on_dec_cmd[1][15]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 14: %b (write_pos_jdg)", tr[i].on_dec_cmd[1][14]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 13: %b (error_flag)", tr[i].on_dec_cmd[1][13]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 12: %b (plane_sel)", tr[i].on_dec_cmd[1][12]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 11: %b (dec_suc)", tr[i].on_dec_cmd[1][11]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bits 10:2: %b (decode_correct_bit_num)", tr[i].on_dec_cmd[1][10:2]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 1: %b (plane1_empty)", tr[i].on_dec_cmd[1][1]), UVM_LOW);
            `uvm_info(get_name(), $sformatf("      bit 0: %b (plane0_empty)", tr[i].on_dec_cmd[1][0]), UVM_LOW);
        end
        
        `uvm_info(get_name(), $sformatf("=== End of ondec2nsu_group_transaction ==="), UVM_LOW);
    endfunction
    
    // Print function for group transaction with merged 1-bit fields
    function void print_key_fields();
        `uvm_info(get_name(), $sformatf("=== ondec2nsu_group_transaction: %s (Key Fields) ===", get_name()), UVM_LOW);
        
        // Print common fields from first transaction (since they should be consistent)
        `uvm_info(get_name(), $sformatf("Common fields:"), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  instruction_index: 0x%0h", tr[0].instruction_index), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  nand_index: 0x%0h", tr[0].nand_index), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  read_mode: %b", tr[0].read_mode), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  meta_mode: %b", tr[0].meta_mode), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  deep_read_sel: %b", tr[0].deep_read_sel), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  write_pos_jdg: %b", tr[0].write_pos_jdg), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  descramble_en: %b", tr[0].descramble_en), UVM_LOW);
        
        // Merge and print 1-bit fields across all 8 planes
        bit [7:0] plane_sel_bits;
        bit [7:0] dec_suc_bits;
        bit [7:0] crc_pass_bits;
        bit [7:0] error_flag_bits;
        bit [7:0] data_out_en_bits;
        bit [7:0] offline_wbf_work_en_bits;
        bit [7:0] plane0_empty_bits;
        bit [7:0] plane1_empty_bits;
        
        for (int i = 0; i < 8; i++) begin
            plane_sel_bits[i] = tr[i].plane_sel;
            dec_suc_bits[i] = tr[i].dec_suc;
            crc_pass_bits[i] = tr[i].crc_pass;
            error_flag_bits[i] = tr[i].error_flag;
            data_out_en_bits[i] = tr[i].data_out_en;
            offline_wbf_work_en_bits[i] = tr[i].offline_wbf_work_en;
            plane0_empty_bits[i] = tr[i].plane0_empty;
            plane1_empty_bits[i] = tr[i].plane1_empty;
        end
        
        `uvm_info(get_name(), $sformatf("Merged 1-bit fields (planes 0-7):"), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  plane_sel:         %8b", plane_sel_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  dec_suc:           %8b", dec_suc_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  crc_pass:          %8b", crc_pass_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  error_flag:        %8b", error_flag_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  data_out_en:       %8b", data_out_en_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  offline_wbf_work_en: %8b", offline_wbf_work_en_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  plane0_empty:      %8b", plane0_empty_bits), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  plane1_empty:      %8b", plane1_empty_bits), UVM_LOW);
        
        // Print descramble_seed for all 8 planes
        `uvm_info(get_name(), $sformatf("Descramble seeds (planes 0-7):"), UVM_LOW);
        for (int i = 0; i < 8; i++) begin
            `uvm_info(get_name(), $sformatf("  plane %0d: 0x%04h", i, tr[i].descramble_seed), UVM_LOW);
        end
        
        // Print group-specific fields
        `uvm_info(get_name(), $sformatf("Group 0 fields (planes 0-3):"), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  nsu_ost_id: %d", tr[0].nsu_ost_id), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  plane_group_block_addr: 0x%0h", tr[0].plane_group_block_addr), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  page_addr_plane_group: 0x%0h", tr[0].page_addr_plane_group), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  meta_buffer_id: 0x%0h", tr[0].meta_buffer_id), UVM_LOW);
        
        `uvm_info(get_name(), $sformatf("Group 1 fields (planes 4-7):"), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  nsu_ost_id: %d", tr[4].nsu_ost_id), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  plane_group_block_addr: 0x%0h", tr[4].plane_group_block_addr), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  page_addr_plane_group: 0x%0h", tr[4].page_addr_plane_group), UVM_LOW);
        `uvm_info(get_name(), $sformatf("  meta_buffer_id: 0x%0h", tr[4].meta_buffer_id), UVM_LOW);
        
        `uvm_info(get_name(), $sformatf("=== End of ondec2nsu_group_transaction (Key Fields) ==="), UVM_LOW);
    endfunction

    // Override do_print to support UVM print methods
    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        
        printer.print_string("group_transaction", get_name());
        
        // Print common fields
        printer.print_int("discard_read_data", tr[0].discard_read_data, 1);
        printer.print_int("nand_index", tr[0].nand_index, 8);
        printer.print_int("instruction_index", tr[0].instruction_index, 16);
        
        // Print individual transactions
        for (int i = 0; i < 8; i++) begin
            printer.print_object($sformatf("transaction[%0d]", i), tr[i]);
        end
    endfunction

endclass


