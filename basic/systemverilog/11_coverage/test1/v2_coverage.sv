class random_data_c;
                   
    rand logic [7:0] height;
    rand logic [7:0] width;
    constraint arr_c { 
        height inside {[0:5]};
        width inside {[0:5]};
    }                  
    covergroup rd_size_cg;    
    option.per_instance = 1;
    rd_height : coverpoint height {
        bins num[] = {[0:255]};   
        illegal_bins ig[] = default;
    }              
            
    rd_width : coverpoint width {
        bins num[] = {[0:255]};   
        illegal_bins ig[] = default;
    }              
    endgroup

    function new();
        rd_size_cg=new();
    endfunction
           
                       
endclass           
                       
                       
module test1;
    random_data_c rd;  
    integer seed;
    // rd_size_cg rd_size_cg_inst;
                       
    initial begin      
        seed = 123;  // 设置您想要的随机种子
        $srandom(seed); // 应用随机种子
        rd = new();      
        //   rd_size_cg_inst =new();
        //   assert(randomize(rd));//assert(rd.randomize())
        assert(rd.randomize())
        rd.rd_size_cg.sample();
        $display("height:%h", rd.height);
        $display("width:%h", rd.width);
            
    end                
                       
endmodule

module test2;
    random_data_c rd;  
    integer seed;
    // rd_size_cg rd_size_cg_inst;
                       
    initial begin      
      rd = new();      
      seed = 12345;  // 设置您想要的随机种子
      $srandom(seed); // 应用随机种子
    //   rd_size_cg_inst =new();
    //   assert(randomize(rd));//assert(rd.randomize())
      assert(rd.randomize())
      rd.rd_size_cg.sample();
      $display("height:%h", rd.height);
      $display("width:%h", rd.width);
            
    end                
                       
endmodule