class memory_trans;
    rand bit [31:0] payload_num;
    rand bit [31:0] src_addr;
    rand bit [31:0] dest_addr;
    // 基础约束
    constraint rw_addr {
        payload_num>=1;
        payload_num<=64;
        src_addr>='h24_0000;
        src_addr<='h24_0000+(256-payload_num)*1024;
        src_addr[6:0]==0;
        (src_addr>>12)!=((src_addr+payload_num*1024-1)>>12);//强制跨越4k边界

        dest_addr>='h24_0000;
        dest_addr<='h24_0000+(256-payload_num)*1024;
        dest_addr+payload_num*1024<=src_addr||dest_addr>=src_addr+payload_num*1024;
        dest_addr[6:0]==0;
        (dest_addr>>12)!=((dest_addr+payload_num*1024-1)>>12);//强制跨越4k边界
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
