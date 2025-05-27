module inner_trunk();
    reg clk;
    initial begin
        clk=0;
        #10000;
    end
    initial begin
        #1000;
        
    end
    initial begin
        PATH_OF_ARRAY path_list=array_select(11,128);
        $display("logic addr is %0d",rowAddr_mapper(9999));
        $display("11//3 %d 11mod3 %d",11/3,11%3);
        erase_array(123,0,0);
    end    
    always #5 clk=~clk;
    spram_model u_ne(
        .clka(clk), 
        .ena(0),
        .wea(0), 
        .addra(0), 
        .dina(0), 
        .douta()
    );
    spram_model u_nw(
        .clka(clk), 
        .ena(0),
        .wea(0), 
        .addra(0), 
        .dina(0), 
        .douta()        
    );
    spram_model u_se(
        .clka(clk), 
        .ena(0),
        .wea(0), 
        .addra(0), 
        .dina(0), 
        .douta()        
    );
    spram_model u_sw(
        .clka(clk), 
        .ena(0),
        .wea(0), 
        .addra(0), 
        .dina(0), 
        .douta()        
    );

endmodule
