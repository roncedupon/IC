`ifndef virtual_sequencer_SV
`define virtual_sequencer_SV

class virtual_sequencer extends uvm_component;
    function new(string name="virtual_sequencer", uvm_component parent);
        super.new(name, parent);        
    endfunction
    `uvm_component_utils(virtual_sequencer)
endclass

`endif virtual_sequencer_SV