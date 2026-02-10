module test;
  int word_num;
  int counter;
  initial begin
    counter=0;
    word_num  = 6*32*1024/4;//length=1-->32KB
    
    for(int i=0;i<word_num/32;i++) begin
        for(int j=0;j<4;j++) begin
            for(int k=0;k<8;k++) begin
                counter=counter+1;
                $display("counter = %0d", counter);
            end
        end
    end
    $display("word_num = %0d", word_num);    
  end
endmodule