module semaphoreA;
    semaphore key;
    initial begin
        key=new(1);//创建一个钥匙，当然也能创建多把钥匙
        fork
            personA();
            personB();
            #25 
            personA();
        join_none
    end
    task getRoom(bit [1:0] id);
        $display("[%0t] Trying to get a room for id[%d] ...",$time,id);
        key.get(1);
        $display("[%0t] Room Key retrieved for id[%0d]",$time, id);
    endtask
    task putRoom(bit [1:0] id);
        $display("[%0t] Leaving room id[%0d] ...",$time, id);
        key.put(1);
        $display("[%0t] Room Key put back id[%0d]",$time, id);
    endtask
    // This person tries to get the room immediately and puts' it back 20 time units later
    task personA();
        getRoom(1);
        #20 
        putRoom(1);
    endtask
    // This person tries to get the room after 5 time units and puts it back after'10 time units
    task personB();
        #5
        getRoom(2);
        #10
        putRoom(2);
    endtask
endmodule