interface nsu_if(input clk, input rst_n);
  logic [5:0] offline_wbf_cur_state;
  logic [3:0] rd_cmd_hw_cur_state;
  logic [2:0] nand_rd_cmd_cur_state;

  // 时钟周期任务
  task automatic wait_cycles(int cycles = 1);
    repeat(cycles) @(posedge clk);
  endtask

  // 重置任务
  task automatic reset();
    @(negedge rst_n);
    @(posedge rst_n);
  endtask
endinterface
