//20251006
`define WITIN_FLASH_DIE_L2_CORE 24'b000_000_000_000_000_000_000_111

`define IS_FLASH_DIE_EXIST_(hd_id,layer_id) (`WITIN_FLASH_DIE_L2_CORE[layer_id*3+hd_id]==1)


//==================== layer 模块 ====================
module layer #(parameter LAYER_ID = 0) (
  output logic signalA
);
  // 这里随便赋个值，你可以换成其它逻辑
  assign signalA = (LAYER_ID % 2);  // 偶数=0, 奇数=1
endmodule

//==================== hd 模块 =====================
module hd #(parameter HD_ID = 0) (
  // layer 实例在这里生成
);
  // 不提前定义 layer 信号，避免无用路径
endmodule

//==================== DUT =====================
module dut;
  // 声明 hd[0:2]
  hd #(.HD_ID(0)) hd0();
  hd #(.HD_ID(1)) hd1();
  hd #(.HD_ID(2)) hd2();

  // 后面 testbench 里会通过 generate 动态例化 layer
endmodule




// `define LAYER_CHECKER(hd_id,layer_id)s
task layer_checker();
  logic [23:0] FLASH_MAP = `WITIN_FLASH_DIE_L2_CORE; 
  for(int i=0;i<3;i=i+1)begin
    for(int j=0;j<8;j++)begin
      if(FLASH_MAP[i*3+j])
        $display("hd %0d ,layer %0d is existed",i,j);
    end
  end

endtask

module test;
  dut dut();
  initial begin
    layer_checker();
  end
endmodule

