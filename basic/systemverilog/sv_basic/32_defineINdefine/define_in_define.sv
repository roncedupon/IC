`define DISPLAY_DEC(i) $display("In define DISPLAY_DEC ,%0d\n",i);
`define DISPLAY_HEX(i) $display("In define DISPLAY_HEX ,%0x\n",i);
`define DISPLAY_BIN(i) $display("In define DISPLAY_BIN ,%0b\n",i);

`define DISPLAY_HEX_DEC(i) `DISPLAY_HEX(``i``) `DISPLAY_DEC(``i``)

module tb_top;
    initial begin
        `DISPLAY_HEX_DEC(456)
    end
endmodule