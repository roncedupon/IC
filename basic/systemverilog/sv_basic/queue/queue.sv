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

module tb_top;
    initial begin
        queue_test queue_test_inst =new();
        queue_test_inst.randomize()with{
            packet_size==8192;
        };
        $display("payload size is %d",queue_test_inst.payload.size);
    end

endmodule
