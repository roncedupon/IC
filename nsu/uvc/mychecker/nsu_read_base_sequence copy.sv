class nsu_read_base_sequence extends uvm_sequence;
    
    `uvm_object_utils(nsu_read_base_sequence)
    
    int exit_flag;
    
    function new(string name = "nsu_read_base_sequence");
        super.new(name);
        exit_flag = 0;
    endfunction
    
    task TSU_RDATA_RECEIVER(int LOOP_NUM=2);
        // TSU receives rdata from NSU with out-of-order handling
        nsu_environment env;
        uvm_component parent_comp;
        tsu2nsu_transaction rcmd_tr;
        nsu2tsu_transaction rdata_tr;
        int TOTAL_LEN_4K_NUM;
        bit [7:0] expected_ost_id;
        
        // Queue for out-of-order rdata transactions
        nsu2tsu_transaction out_of_order_rdata[$];
        
        parent_comp = p_sequencer.get_parent();
        if(!$cast(env, parent_comp)) begin
            `uvm_fatal("CAST_ERR", "p_sequencer's father is not nsu_environment!")
        end
        
        fork
        begin
            for(int i=0; i<LOOP_NUM; i++) begin
                `uvm_info(get_full_name(), $sformatf("Loop[%0d] waiting for TSU read start", i), UVM_LOW)
                
                // Get rcmd and record ost_id
                env.tsu2nsu_agt[0].tsu_nsu_rcmd_que.get(rcmd_tr);
                expected_ost_id = rcmd_tr.ost_id; // Assume rcmd_tr has ost_id field
                TOTAL_LEN_4K_NUM = rcmd_tr.rcmd_vld_num * 4;
                
                `uvm_info(get_full_name(), $sformatf("Processing rcmd ost_id=0x%0h, expecting %0d*4K data", expected_ost_id, rcmd_tr.rcmd_vld_num), UVM_LOW)
                
                while (TOTAL_LEN_4K_NUM != 0) begin
                    nsu2tsu_transaction current_rdata;
                    bit found_match = 1'b0;
                    
                    // Check out-of-order queue first
                    for (int j = 0; j < out_of_order_rdata.size(); j++) begin
                        if (out_of_order_rdata[j].ost_id == expected_ost_id) begin // Assume rdata_tr has ost_id field
                            current_rdata = out_of_order_rdata[j];
                            out_of_order_rdata.delete(j);
                            found_match = 1'b1;
                            `uvm_info(get_full_name(), $sformatf("Found out-of-order rdata for ost_id=0x%0h", expected_ost_id), UVM_LOW)
                            break;
                        end
                    end
                    
                    // Get from queue if no match
                    if (!found_match) begin
                        env.nsu2tsu_agt[0].nsu_tsu_rdata_que.get(rdata_tr);
                        
                        // Check ost_id match
                        if (rdata_tr.ost_id == expected_ost_id) begin
                            current_rdata = rdata_tr;
                        end else begin
                            // Store out-of-order rdata
                            out_of_order_rdata.push_back(rdata_tr);
                            `uvm_info(get_full_name(), $sformatf("Received out-of-order rdata ost_id=0x%0h, storing", rdata_tr.ost_id), UVM_LOW)
                            continue; // Get next rdata
                        end
                    end
                    
                    // Process matched rdata
                    if (current_rdata.rdata_vld) begin
                        `uvm_info(get_full_name(), $sformatf("4k num: [%0d/%0d] for ost_id=0x%0h", 
                            rcmd_tr.rcmd_vld_num*4 - TOTAL_LEN_4K_NUM, rcmd_tr.rcmd_vld_num*4, expected_ost_id), UVM_LOW)
                        TOTAL_LEN_4K_NUM--;
                    end
                end
                `uvm_info(get_full_name(), $sformatf("Loop[%0d] TSU read done for ost_id=0x%0h", i, expected_ost_id), UVM_LOW)
            end
            
            // Handle remaining out-of-order rdata
            if (out_of_order_rdata.size() > 0) begin
                `uvm_info(get_full_name(), $sformatf("Remaining out-of-order rdata: %0d transactions", out_of_order_rdata.size()), UVM_LOW)
                // Handle remaining data if needed
            end
        end
        begin
            #1s;
            `uvm_error(get_full_name(), "After 1ns, still not receive enough rdata")
        end
        join_any
        
        `uvm_info(get_full_name(), "TSU read done", UVM_LOW)
        exit_flag = 1;
    endtask
endclass
