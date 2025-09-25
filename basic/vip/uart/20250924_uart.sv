class uart0_boot_sequence extends uvm_sequence #(svt_uart_transaction) ;

    `uvm_object_param_utils(uart0_boot_sequence)
    rand int unsigned sequence_length = 10;
    bit status;
    svt_uart_transaction uart_dte_tr, uart_dte_rx;
    base_vsequence  base_seq;
    sharespace_generic_payload gp;
    extern virtual task pre_trans(svt_uart_transaction tx_tr);
    extern virtual task read_cpu_hex(string hex_str, ref bit[31:0] mem[]);
    extern virtual task width_convert_32To8(bit[31:0]
    function new(string name = "uart0_boot_sequence");
        super.new(name);
        gp =new();
        gp.mem = new[256];
        base_seq = base_vsequence::type_id::create("base_seq"); 
    endfunction    
    virtual task body();
        bit [31:0]hex_dat_32bit[];
        bit [7:0]hex_dat_8bit[];
        $display("*******************************enter body ****************************************"); 
        base_seq.host2sv_req[0].wait_ptrigger();
        base_seq.host2sv_req[0].reset();
        base_seq.host2sv_ack[0].trigger();
        read_cpu_hex("./hex/host.dat",hex_dat_32bit);
        width_convert_32To8(hex_dat_32bit,hex_dat_8bit);
        $display("*******************************before read ****************************************"); 
        `uvm_do_with(uart_dte_tr, 
                {   uart_dte_tr.reasonable_constraint_mode(0);
                    uart_dte_tr.direction == TX;
                    uart_dte_tr.inter_cycle_delay == 80;
                    uart_dte_tr.packet_count ==1000;                
                    //hex_dat_8bit.size()<2000?hex_dat_8bit.size():2000
                    foreach (uart_dte_tr.payload[i]) {
                        uart_dte_tr.payload[i]==hex_dat_8bit[i];
                    }
                });                    
        uart_dte_tr.print();
        pre_trans(uart_dte_tr);
        get_response(rsp);
        rsp.print();
        $display("*******************************exist read ****************************************");
        wait(`TB.c_ready_host[0]);
        $display("*******************************exist trigger ****************************************");
    endtask
endclass
task uart0_boot_sequence::pre_trans(svt_uart_transaction tx_tr);
    
    foreach (tx_tr.payload[i]) begin 
        gp.mem[i] = tx_tr.payload[i];
        $display("*****************payload  %x",tx_tr.payload[i]);
    end

    gp.mem[50] = tx_tr.packet_count;
    base_seq.sv2host_req[0].trigger(gp);
    base_seq.sv2host_ack[0].wait_ptrigger();
    base_seq.sv2host_ack[0].reset();

endtask