
//test running order of different phases
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class CTRL0 extends uvm_reg;
    `uvm_object_utils(CTRL0)
    uvm_reg_file CFS;//control frame size
    uvm_reg_file SRL;//shift register loop
    uvm_reg_file SLV_OE;//slave output enable
    uvm_reg_file TMOD;//00=tx & rx ; 01=tx only ; 10=rx only ;11=E2prom read;
    uvm_reg_file CFS;
    uvm_reg_file SCPOL;
    uvm_reg_file SCPH;
    uvm_reg_file SFRF;
    uvm_reg_file DFS;
    uvm_reg_file SCPOL;
    uvm_reg_file SCPH;
    uvm_reg_file FRF;
    uvm_reg_file DFS;
    
    
    function new(input string name="CTRL0");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
    function void build();
        int size,lsb_pos,reset_value;
        // CFS = uvm_reg_field::type_id::create("CFS");//control frame size
        // // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        // CFS.configure(this, 4, 0, "RW", 1, 'h7, 1, 0, 0);

        size=4;
        lsb_pos=0;
        reset_value='h7;
        DFS = uvm_reg_field::type_id::create("DFS");
        DFS.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=2;
        lsb_pos=4;
        reset_value=0;
        FRF = uvm_reg_field::type_id::create("FRF");
        FRF.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=1;
        lsb_pos=6;
        reset_value=0;
        SCPH = uvm_reg_field::type_id::create("SCPH");
        SCPH.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=1;
        lsb_pos=7;
        reset_value=0;
        SCPOL = uvm_reg_field::type_id::create("SCPOL");
        SCPOL.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=2;
        lsb_pos=8;
        reset_value=0;
        TMOD = uvm_reg_field::type_id::create("TMOD");
        TMOD.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=1;
        lsb_pos=10;
        reset_value=0;
        SLV_OE = uvm_reg_field::type_id::create("SLV_OE");
        SLV_OE.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=1;
        lsb_pos=11;
        reset_value=0;
        SRL = uvm_reg_field::type_id::create("SRL");
        SRL.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

        size=4;
        lsb_pos=12;
        reset_value=0;
        CFS = uvm_reg_field::type_id::create("CFS");
        CFS.configure(this, size, lsb_pos, "RW", 1, reset_value, 1, 0, 0);

    endfunction
endclass

class apb_reg extends uvm_reg_block;
    CTRL0 ctrl0;
    virtual function void build();
        default_map=create_map("default_map",0,2,UVM_BIG_ENDIAN,0);
        ctrl0=CTRL0::type_id::create("ctrl0", ,get_full_name());//这里的第二个参数是regfile的路径，可以暂时不用管他
        ctrl0.build();
        default_map.add_reg(ctr1,'h0,"RW");
    endfunction
endclass

class myadapter extends uvm_reg_adapter;
    `uvm_object_utils(myadapter)
    function new(string name="myadapter");
        super.new(name);
    endfunction

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        bus_transaction tr;
        tr=new("tr");
    endfunction
endclass