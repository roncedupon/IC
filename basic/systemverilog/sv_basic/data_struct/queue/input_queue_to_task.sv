module queue_pass_example;

    // 定义一个task，接收队列参数（值传递）
    task print_queue(ref int q[$]);
        $display("Queue contents (size=%0d):", q.size());
        foreach(q[i]) begin
            $display("q[%0d] = %0d", i, q[i]);
        end
        q.push_front(123);
        q.push_front(123);
        q.push_front(123);
        q.push_front(123);
    endtask

    initial begin
        int my_queue[$] = {10, 20, 30, 40}; // 已初始化的队列
        print_queue(my_queue); // 传递队列副本
        foreach(my_queue[i]) begin
            $display("my_queue[%0d] = %0d", i, my_queue[i]);
        end        
    end

endmodule