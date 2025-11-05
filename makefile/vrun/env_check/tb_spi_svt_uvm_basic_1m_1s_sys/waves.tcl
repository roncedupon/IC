# Open design
gui_open_db -design V1 -file verilog.dump -nosource
gui_list_expand -id  Hier.1   test_top
gui_list_select -id Hier.1 {  test_top.spi_master_if   }
gui_list_select -id Hier.1 {  test_top.spi_slave_if   }
gui_open_window Wave

gui_list_add -id Wave.1 -from Hier.1 {test_top.spi_master_if.bus_clk test_top.spi_master_if.reset test_top.spi_master_if.sclk test_top.spi_master_if.miso test_top.spi_master_if.mosi test_top.spi_master_if.ss_n}  -insertionbar
