module nested_fork_join;

  initial begin
    $display("Start of process A at time %0t", $time);

    fork  // Outer fork - Process A starts B and C concurrently
      begin  // Process B
        $display("Start of process B at time %0t", $time);
        #10; // Simulate some work in process B
        $display("End of process B at time %0t", $time);
      end

      begin  // Process C
        $display("Start of process C at time %0t", $time);
        fork  // Inner fork - Process C starts D and E concurrently
          begin  // Process D
            $display("Start of process D at time %0t", $time);
            #5;  // Simulate some work in process D
            $display("End of process D at time %0t", $time);
          end
          begin  // Process E
            $display("Start of process E at time %0t", $time);
            #8;  // Simulate some work in process E
            $display("End of process E at time %0t", $time);
          end
        join  // Inner join - Process C waits for both D and E to complete
        $display("Process C continues after D and E at time %0t", $time);
        #7;  // Simulate more work in process C
        $display("End of process C at time %0t", $time);
      end
    join  // Outer join - Process A waits for both B and C to complete
    $display("End of process A after B and C (and D, E within C) at time %0t", $time);

    $finish;
  end

endmodule