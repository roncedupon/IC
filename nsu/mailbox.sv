module tb_simple_mailbox;
  // 1. 定义mailbox（传递整型数据，最简化）
  mailbox #(int) mbx = new(); 

  // 2. 生产者：往mailbox中PUT 7个数据（模拟你的7次PUT）
  initial begin
    int put_cnt = 0;
    int data;
    while(put_cnt < 7) begin
      data = put_cnt; // 数据值=计数（0~6）
      mbx.put(data);  // 阻塞PUT：队列满时等待（这里mailbox无容量限制）
      put_cnt++;
      $display("[PRODUCER] 第%0d次PUT，数据=%0d", put_cnt, data);
      #100; // 模拟PUT速率（每100ns一次）
    end
    $display("[PRODUCER] PUT完成！总计PUT %0d次", put_cnt);
  end

  // 3. 消费者：从mailbox中GET数据（模拟你的GET逻辑）
  initial begin
    int get_cnt = 0;
    int data;
    forever begin
      mbx.get(data); // 阻塞GET：队列空时等待生产者PUT
      get_cnt++;
      $display("[CONSUMER] 第%0d次GET，数据=%0d", get_cnt, data);
      
      // 模拟GET速率（比PUT快，每80ns一次）
      #80; 

      // 终止条件：GET到7个数据后退出（和PUT次数匹配）
      if(get_cnt == 7) begin
        $display("[CONSUMER] GET完成！总计GET %0d次", get_cnt);
        break;
      end
    end
  end

endmodule