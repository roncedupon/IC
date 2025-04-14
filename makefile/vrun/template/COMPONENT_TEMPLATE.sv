`ifndef GURD_<CLASS_NAME>_SV
`define GURD_<CLASS_NAME>_SV

class <CLASS_NAME> extends uvm_component;
    function new(string name="<CLASS_NAME>", uvm_component parent);
        super.new(name, parent);        
    endfunction
    `uvm_component_utils(<CLASS_NAME>)
endclass

`endif 