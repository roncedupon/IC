
`include "uvm_pkg.sv"
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "cust_config.sv"



class my_sequence extends uvm_sequence;
    `uvm_object_utils(my_sequence)
    
    cust_config cfg; 


    // ...
    task body();
        cfg=new("dynamic_cfg.cfg");
        // 1. 从配置数据库中获取配置句柄
        if (!uvm_config_db#(cust_config)::get(get_sequencer(), "", "cfg", cfg)) begin
            `uvm_fatal("CONFIG_ERR", "Could not get configuration object!")
        end
        
        // 2. 检查配置标志，决定是否调用特定任务
        if (cfg.read_from_cfg_file("BACKDOOR_DIE0")) begin
            `uvm_info(get_full_name(), "Executing my_conditional_task...", UVM_LOW)
            my_conditional_task();
        end else begin
            `uvm_info(get_full_name(), "Skipping my_conditional_task based on config.", UVM_LOW)
        end
        
    endtask: body
    
    task my_conditional_task();
        // 实际的任务逻辑，例如执行特定的 SPI 传输
        // ...
    endtask: my_conditional_task
    
endclass: my_sequence