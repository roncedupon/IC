`ifndef BASIC_SEQUENCE_SV
`define BASIC_SEQUENCE_SV
class basic_sequence extends uvm_sequence;
    function new(string name="basic_sequence");
        super.new(name,parent);        
    endfunction
    `uvm_object_utils(basic_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)
    virtual task body();
        super.body();

    endtask

    extern virtual task AXIM_STREAM_SEND (const ref svt_axi_master_transaction send_tran,input int tran_id);
    extern virtual task AXIM_STREAS_RECV (const ref svt_axi_master_transaction recv_tran,input int tran_id);
    
endclass

task basic_sequence::AXIM_STREAM_SEND(const ref svt_axi_master_transaction send_tran,input int tran_id);
    svt_axi_master_transaction write_tran;
    write_tran=new($sformatf("write_tran_%-d",tran_id));
    fork
        forever begin
            get_response(rsp);
        end
    join_none
    uvm_do_on with (write_tran, p_sequencer.axi_master_sequencer, {
        stream_burst_length                         == send_tran.tdata.size();
        tdest                                       == send_tran.tdest;
        xact_type                                   == svt_axi_transaction::DATA_STREAM;

        foreach (tdata[i])tdata[i]                  == send_tran.tdata[i];
        
        foreach (tvalid_delay[i])tvalid_delay[i]    == send_tran.tvalid_delay[i];
        
        foreach (tstrb[i])tstrb[i]                  == send_tran.tstrb[i];
        
        foreach (tkeep[i])tkeep[i]                  == send_tran.tkeep[i];
        
        enable_interleave                           ==0;
        pattern                                     == svt_axi_transaction::RANDOM_BLOCK;
        
        foreach (random_interleave_array[i])random_interleave_array[i] == 1;
    });
endtask

task basic_sequence::AXIM_STREAS_RECV (const ref svt_axi_master_transaction recv_tran,input int tran_id);

endtask





`endif BASIC_SEQUENCE_SV