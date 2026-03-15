`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "nsu_cpu_transactions.sv"

module nsu2cpu_deep_resp_demo;
  initial begin
    // 创建多个transaction实例
    nsu2cpu_deep_resp_transaction deep_resp_arr[2];
    
    // 初始化并随机化每个transaction
    foreach(deep_resp_arr[i]) begin
      deep_resp_arr[i] = nsu2cpu_deep_resp_transaction::type_id::create($sformatf("deep_resp_%0d", i));
    //   deep_resp_arr[i] = new("aa");//nsu2cpu_deep_resp_transaction::type_id::create($sformatf("deep_resp_%0d", i));
      
      // 随机化数据
    //   for(int j=0; j<14; j++) begin
    //     deep_resp_arr[i].nsu2cpu_deep_resp[j] = $random;
    //   end
    deep_resp_arr[i].randomize();  
      // 调用fields_assignment更新字段
      deep_resp_arr[i].fields_assignment();

        deep_resp_arr[i].group0_ost_id='h10;
        deep_resp_arr[i].group1_ost_id='h10;

      // 打印transaction
      $display("\n=== Transaction %0d ===", i);
      deep_resp_arr[i].print();
    end
  end
endmodule