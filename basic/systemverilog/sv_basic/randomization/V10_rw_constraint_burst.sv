//需要考虑到即使数据整体跨了4k边界,但是每个burst可能都不会跨越4k边界
class axi_trans;
    // 协议参数
    localparam DATA_WIDTH = 256;     // 位宽
    localparam BEATS      = 4;       // burst长度
    localparam BYTES_PER_BEAT = DATA_WIDTH/8;  // 32B

    rand bit [31:0] addr;
    rand int size;  // 总传输字节数
    rand int bursts;// burst数量

    // 计算总传输量约束
    constraint size_calc {
        size == bursts * BEATS * BYTES_PER_BEAT;
        bursts inside {[1:16]};  // 限制burst数量
    };
    constraint burst_level_4k_cross {
        // 计算第一个burst的结束地址
        bit [31:0] first_burst_end = addr + (BEATS * BYTES_PER_BEAT) - 1;
        
        // 关键约束：至少有一个burst跨越4KB页
        (addr >> 12) != (first_burst_end >> 12) ||  // 第一个burst跨越
        (bursts > 1 && (
          (addr + (BEATS * BYTES_PER_BEAT)) >> 12 !=  // 后续burst跨越
          (addr + size - 1) >> 12
        ));
    }    
endclass
module top;
    memory_trans t;
    initial begin
        t = new();
        repeat(50) begin
            assert(t.randomize());
            $display("Read: %0d-%0d | Write: %0d-%0d",
                t.src_addr, t.src_addr+t.payload_num*1024-1,
                t.dest_addr, t.dest_addr+t.payload_num*1024-1);
            // 验证无交织
            assert((t.src_addr + t.payload_num*1024 <= t.dest_addr||
                    t.dest_addr + t.payload_num*1024 <= t.src_addr ));
        end
    end    
    // covergroup mem_cvg;
    //     read_region: coverpoint (100*(t.read_addr - t.base_addr)/t.region_size) {
    //         bins low  = {[ 0 : 33]};
    //         bins mid  = {[34 : 66]};
    //         bins high = {[67 :100]};
    //     }
    //     write_region: coverpoint (100*(t.write_addr - t.base_addr)/t.region_size) {
    //         bins low  = {[ 0 : 33]};
    //         bins mid  = {[34 : 66]};
    //         bins high = {[67 :100]};
    //     }
    //     cross read_region, write_region;
    // endgroup      

endmodule
