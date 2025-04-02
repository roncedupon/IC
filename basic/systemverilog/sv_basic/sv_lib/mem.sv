module ram_test;

  // 参数化定义
  parameter ADDR_WIDTH = 8;
  parameter DATA_WIDTH = 32;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH; // RAM 的深度

  // RAM 模型 (使用 reg 数组)
  reg [DATA_WIDTH-1:0] ram [RAM_DEPTH-1:0];

  // 后门初始化随机数
  task backdoor_init_random(input [RAM_DEPTH-1:0] ram_size);
    for (int i = 0; i < ram_size; i++) begin
      ram[i] = $random();
    end
    $display("[BACKDOOR] RAM initialized with random values.");
  endtask

  // 后门写入数据并对比 payload
  task backdoor_write_and_compare(
    input logic [ADDR_WIDTH-1:0] target_address,
    input logic [DATA_WIDTH-1:0] payload_data,
    input logic [DATA_WIDTH-1:0] expected_payload,
    output bit compare_result
  );
    // Bypass 写入到目标地址
    ram[target_address] = payload_data;
    $display("[BACKDOOR] Payload 0x%h written to address 0x%h.", payload_data, target_address);

    // 后门读取进行 payload 数据对比
    if (ram[target_address] === expected_payload) begin
      compare_result = 1'b1;
      $display("[BACKDOOR] Payload comparison successful at address 0x%h. Expected: 0x%h, Found: 0x%h",
               target_address, expected_payload, ram[target_address]);
    end else begin
      compare_result = 1'b0;
      $display("[BACKDOOR] Payload comparison failed at address 0x%h. Expected: 0x%h, Found: 0x%h",
               target_address, expected_payload, ram[target_address]);
    end
  endtask

//   initial begin
//     bit compare_result;

    
    

//     // 1. 定义目标地址和 payload 数据
//     logic [ADDR_WIDTH-1:0] target_addr = 8'h10;
//     logic [DATA_WIDTH-1:0] write_payload = 32'hAABBCCDD;
//     logic [DATA_WIDTH-1:0] expected_payload_success = 32'hAABBCCDD;
//     logic [DATA_WIDTH-1:0] expected_payload_fail = 32'h11223344;
//     // 2. 后门初始化 RAM
//     backdoor_init_random(RAM_DEPTH);
//     // 3. 使用 bypass 写入并进行成功对比
//     backdoor_write_and_compare(target_addr, write_payload, expected_payload_success, compare_result);
//     $display("Comparison Result (Success): %b", compare_result);

//     // 4. 再次使用 bypass 写入并进行失败对比
//     backdoor_write_and_compare(target_addr, write_payload, expected_payload_fail, compare_result);
//     $display("Comparison Result (Fail): %b", compare_result);

//     $finish;
//   end
    initial begin
        bit[31:0]data_buffer[$];
        for(int i=0;i<16;i++)begin
            data_buffer.push_back($random());
            $display("data_buffer[%d] is %x\n",i,data_buffer[0]);
            if (data_buffer.pop_front()!='h123) begin
                $display("error");
            end
        end
    end

endmodule