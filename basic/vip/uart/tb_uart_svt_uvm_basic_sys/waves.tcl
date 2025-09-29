# Open design
gui_open_db -design V1 -file verilog.dump -nosource
gui_list_expand -id  Hier.1   test_top
gui_list_select -id Hier.1 {  test_top.uart_dte_if   }
gui_list_select -id Hier.1 {  test_top.uart_dce_if   }
gui_open_window Wave
gui_list_add -id Wave.1 -from Hier.1 { test_top.uart_dce_if.rst test_top.uart_dte_if.rst test_top.uart_dte_if.sout test_top.uart_dce_if.sout test_top.uart_dce_if.sin test_top.uart_dte_if.sin test_top.uart_dte_if.rts test_top.uart_dce_if.rts test_top.uart_dce_if.cts test_top.uart_dte_if.cts test_top.uart_dce_if.dsr test_top.uart_dte_if.dsr test_top.uart_dce_if.dtr test_top.uart_dte_if.dtr} -insertionbar
