


`define DIE(i) TB.DIE[i].u_dig
`define DIGITAL_TOP_PATH `"DIE(0).core_top`"



program automatic test;

    initial begin
        $display( `DIE(0));
    end
endprogram

/* Example 1.1 */
`define append_front_bad(MOD) "MOD.master"
`define append_front_good(MOD) `"MOD.master`"

program automatic test;
    initial begin
        $display(`append_front_bad(clock1));
        $display(`append_front_good(clock1));
    end
endprogram: test
