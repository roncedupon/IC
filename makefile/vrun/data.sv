//object template
class data extends uvm_component;
    function new(string name="data");
        super.new(name);        
    endfunction
    `uvm_object_utils(data)
endclass
