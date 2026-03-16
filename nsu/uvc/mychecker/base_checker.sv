class base_checker #(type T = uvm_object) extends uvm_component;
  `uvm_component_param_utils(base_checker#(T))

  function new(string name = "base_checker", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Delete items from source queue that match items in delete queue
  function void delete_queue_items(ref T src_que[$], const ref T del_que[$]);
    int del_cnt = 0;
    int idx_que[$];
    if(src_que.size() == 0 || del_que.size() == 0) return;
    
    foreach(del_que[i]) begin
      if(del_que[i] == null) `uvm_fatal("NULL_ITEM", "item in del_que is null");
      idx_que = src_que.find_index with(item == del_que[i]);
      if(idx_que.size() > 0) begin
        idx_que.sort();
        idx_que.reverse();
        foreach(idx_que[idx]) begin
          src_que.delete(idx_que[idx]);
          del_cnt++;
        end
      end
    end
    `uvm_info("DELETE_ITEMS", $sformatf("Deleted %0d matched queue items", del_cnt), UVM_MEDIUM);
  endfunction

  // Find items in queue that match the specified condition
  function void find_queue_items(ref T src_que[$], ref T res_que[$], function bit condition(T item));
    res_que.delete();
    foreach(src_que[i]) begin
      if(condition(src_que[i])) begin
        res_que.push_back(src_que[i]);
      end
    end
  endfunction

  // Compare two transactions for equality
  virtual function bit compare_transactions(T t1, T t2);
    if(t1 == null || t2 == null) return 0;
    // Default comparison: reference equality
    return (t1 == t2);
  endfunction

  // Print queue content
  function void print_queue(ref T que[$], string queue_name = "queue");
    `uvm_info("QUEUE_CONTENT", $sformatf("=== %s content (%0d items) ===", queue_name, que.size()), UVM_MEDIUM);
    foreach(que[i]) begin
      if(que[i] != null) begin
        `uvm_info("QUEUE_ITEM", $sformatf("Item %0d:", i), UVM_MEDIUM);
        que[i].print();
      end else begin
        `uvm_info("QUEUE_ITEM", $sformatf("Item %0d: null", i), UVM_MEDIUM);
      end
    end
    `uvm_info("QUEUE_CONTENT", "==============================", UVM_MEDIUM);
  endfunction

  // Clear queue and release memory
  function void clear_queue(ref T que[$]);
    foreach(que[i]) begin
      if(que[i] != null) begin
        // Memory release logic can be added here if needed
      end
    end
    que.delete();
    `uvm_info("CLEAR_QUEUE", "Queue cleared", UVM_MEDIUM);
  endfunction

  // Find transactions by field value
  function void find_transactions_by_field(ref T src_que[$], ref T res_que[$], string field_name, uvm_object field_value);
    res_que.delete();
    foreach(src_que[i]) begin
      if(src_que[i] != null) begin
        // Field-based search logic can be implemented here
        // Example: if(src_que[i].field_name == field_value) res_que.push_back(src_que[i]);
      end
    end
  endfunction

endclass
