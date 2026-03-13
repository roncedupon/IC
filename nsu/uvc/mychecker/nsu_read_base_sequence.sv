class nsu_read_base_sequence extends uvm_sequence;
    
    `uvm_object_utils(nsu_read_base_sequence)
    
    int exit_flag;
    extern virtual task TSU_RDATA_RECEIVER(int LOOP_NUM=2);
    function new(string name = "nsu_read_base_sequence");
        super.new(name);
        exit_flag = 0;
    endfunction
    

endclass
task nsu_read_base_sequence::TSU_RDATA_RECEIVER(int LOOP_NUM=2);
    //tsu receive rdata from nsu
    nsu_environment env;
    uvm_component parent_comp;
    tsu2nsu_transaction rcmd_tr;
    nsu2tsu_transaction rdata_tr;
    int TOTAL_LEN_4K_NUM;
    
    parent_comp = p_sequencer.get_parent();
    if(!$cast(env, parent_comp)) begin
        `uvm_fatal("CAST_ERR", "p_sequencer's father is not nsu_environment!")
    end
    
    fork
    begin
        for(int i=0;i<LOOP_NUM;i++)begin
            `uvm_info(get_full_name(),$sformatf("Loop[%0d] waiting for tsu reading start ",i),UVM_LOW)
            env.tsu2nsu_agt[0].tsu_nsu_rcmd_que.get(rcmd_tr);
            TOTAL_LEN_4K_NUM = rcmd_tr.rcmd_vld_num*4;
            while(TOTAL_LEN_4K_NUM !=0)begin
                env.nsu2tsu_agt[0].nsu_tsu_rdata_que.get(rdata_tr);
                if(rdata_tr.rdata_vld)begin
                    `uvm_info(get_full_name(),$sformatf("4k num: [currently: %0d]--[total: %0d]",rcmd_tr.rcmd_vld_num*4-TOTAL_LEN_4K_NUM,rcmd_tr.rcmd_vld_num*4),UVM_LOW)
                    TOTAL_LEN_4K_NUM=TOTAL_LEN_4K_NUM-1;
                end
            end
            `uvm_info(get_full_name(),$sformatf("Loop[%0d] waiting for tsu reading done",i),UVM_LOW)
        end
    end
    begin
        #1s;
        `uvm_error(get_full_name(),"After 1s, still not receive enough rdata")
    end
    join_any
    `uvm_info(get_full_name(),$sformatf("tsu read done"),UVM_LOW)
    exit_flag=1;
endtask