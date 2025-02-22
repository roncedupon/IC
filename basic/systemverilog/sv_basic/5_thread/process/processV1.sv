module processV1;
initial begin
    //创建2个process
    process p1,p2;
    fork 
        begin
            p1=process::self();
            #20000
            $display("[%0d] p1 done ",$time);
        end
        begin
            p2=process::self();
            #20000
            $display("[%0d] p2 done ",$time);
        end
    join_none

    #500
    $display("[%0d] p1 status is %s p2 status is %s",$time,p1.status(),p2.status());
    #500
    p1.kill();//将p1 kill掉，第9行的代码就无法被打印出来了
    $display("[%0d] p1 status is %s p2 status is %s",$time,p1.status(),p2.status());
    p2.await();//阻塞后面的了
    $display("[%0d] p1 status is %s p2 status is %s",$time,p1.status(),p2.status());
    #1000
    $display("[%0d] done!!",$time);

end
// [500] p1 status is WAITING p2 status is WAITING
// [1000] p1 status is KILLED p2 status is WAITING
// [20000] p2 done 
// [20000] p1 status is KILLED p2 status is FINISHED
// [21000] done!!
    
endmodule