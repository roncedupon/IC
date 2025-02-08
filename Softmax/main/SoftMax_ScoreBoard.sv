`ifndef SOFTMAX_SCOREBOARD
`define SOFTMAX_SCOREBOARD
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction_Out.sv"
class SoftMax_ScoreBoard extends uvm_scoreboard;//uvm 验证平台中最后一步加入scoreboard
    SoftMax_Transaction_Out expect_queue[$];
    uvm_blocking_get_port#(SoftMax_Transaction_Out) exp_port;
    uvm_blocking_get_port#(SoftMax_Transaction_Out) act_port;
    `uvm_component_utils(SoftMax_ScoreBoard);

    extern function new(string name,uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
    
endclass


function SoftMax_ScoreBoard::new(string name,uvm_component parent=null);
    super.new(name,parent);
endfunction

function void SoftMax_ScoreBoard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port=new("exp_port",this);
    act_port=new("act_port",this);
endfunction

task SoftMax_ScoreBoard::main_phase(uvm_phase phase);
    SoftMax_Transaction_Out get_expect,get_actual,tmp_tran;
    bit result=0;
    super.main_phase(phase);

    fork
        while(1)begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
            // get_expect.printhhh();
            // get_expect.printhhh();
            // get_expect.printhhh();
            // get_expect.printhhh();
        end

        while(1)begin
            act_port.get(get_actual);
            if(expect_queue.size()>0)begin

                tmp_tran=expect_queue.pop_front();
                result=tmp_tran.Mycompare(get_actual);
                tmp_tran.DumpData(197*25,"tmp_tran.txt");
                get_actual.DumpData(197*25,"get_actual.txt");
                if(result)begin
                    `uvm_info("ScoreBoard", "Compare Successful", UVM_LOW);
                end
                else begin
                    `uvm_error("ScoreBoard","Compare Falieed");
                end
            end
            else begin
                `uvm_error("my_scoreboard", "Received from DUT, while Expect Queue is empty");
                $display("the unexpected pkt is");
            end

        end
    join

endtask


`endif
