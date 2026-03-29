module test;
  mailbox#(int)mbx;
  initial begin
    mbx=new();
    fork 
      begin
        forever begin
          #10;
          mbx.put(10);
          mbx.put(11);
        end
      end

      begin
        int data;
        while(1)begin
          mbx.get(data);
          $display("get one data is %0d",data);
          #10;
        end
      
      end

      begin
        #100;
        $display("exit");

      end
    
    join_any
        disable fork;     
    $display("finished");
  end


endmodule