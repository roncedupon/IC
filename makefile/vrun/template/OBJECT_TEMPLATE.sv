`ifndef GURD_<CLASS_NAME>_SV
`define GURD_<CLASS_NAME>_SV

//object template
class <CLASS_NAME> extends uvm_component;
    function new(string name="<CLASS_NAME>");
        super.new(name);        
    endfunction
    `uvm_object_utils(<CLASS_NAME>)
endclass

`endif 