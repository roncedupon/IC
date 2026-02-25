//[]说明是一个队列，[]有一个成员变量size决定这个队列有多少数据
//
class queue_test;
    rand bit[1023:0] payload[];
    rand bit[15:0]   packet_size=4096;
    constraint const_packet{
        (packet_size>0)->(payload.size==((packet_size-1)/128+1));
        (packet_size==0)->(payload.size==(0));
    }
    


endclass
class my_transaction;
  rand bit        plane_sel;
  rand bit        data_out_en;
  rand bit        write_pos_jdg;
  rand bit        done_occur;
  
  constraint c_done_occur {
    // 求解顺序优化
    solve plane_sel before done_occur;
    solve data_out_en before done_occur;
    solve write_pos_jdg before done_occur;
    
    // 核心逻辑
    (plane_sel == 1) -> (
      // 当 plane_sel==1 时：
      // 情况1：data_out_en==0 → done_occur 必须为 0
      (data_out_en == 0) -> (done_occur == 0);
      
      // 情况2：data_out_en==1 && write_pos_jdg==1 → done_occur 必须为 1
      (data_out_en == 1) && (write_pos_jdg == 1) -> (done_occur == 1);
      
      // ⚠️ 注意：这里没有覆盖 data_out_en==1 && write_pos_jdg==0 的情况
      // 这种情况下 done_occur 可以是 0 或 1
    );
    
    // 当 plane_sel!=1 时
    (plane_sel != 1) -> (done_occur == 0);
  }
  
  // 可选：添加覆盖所有情况的约束
  constraint c_complete {
    (plane_sel == 1) && (data_out_en == 1) && (write_pos_jdg == 0) 
      -> (done_occur == 0);
  }
endclass
module tb_top;
    initial begin
        queue_test queue_test_inst =new();
        queue_test_inst.randomize()with{
            packet_size==8192;
        };
        $display("payload size is %d",queue_test_inst.payload.size);
    end

endmodule
