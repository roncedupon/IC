import uvm_pkg::*;

// Token transaction for identifying ondec2nsu_group_transaction
class token_transaction extends uvm_object;
    `uvm_object_utils(token_transaction)
    
    bit [15:0] instruction_index;
    bit [4:0] group0_ost_id;
    bit [4:0] group1_ost_id;
    
    function new(string name = "token_transaction");
        super.new(name);
    endfunction
    
    // Compare method for associative array indexing
    virtual function bit compare(token_transaction other);
        if (other == null) return 0;
        return (instruction_index == other.instruction_index &&
                group0_ost_id == other.group0_ost_id &&
                group1_ost_id == other.group1_ost_id);
    endfunction
    
    // Hash method for associative array indexing
    virtual function int unsigned hash();
        return {8'b0, instruction_index, group0_ost_id, group1_ost_id};
    endfunction
    
    // Convert to string for debugging
    virtual function string convert2string();
        return $sformatf("token_transaction(instr_idx=0x%0h, group0_ost_id=0x%0h, group1_ost_id=0x%0h)", 
                        instruction_index, group0_ost_id, group1_ost_id);
    endfunction
endclass
