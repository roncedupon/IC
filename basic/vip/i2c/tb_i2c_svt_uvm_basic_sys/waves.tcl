# Open design
gui_open_db -design V1 -file verilog.dump -nosource
gui_list_expand -id Hier.1    test_top
gui_list_select -id Hier.1 {  test_top.i2c_if   }
gui_list_select -id Hier.1 {  test_top.i2c_if   }
gui_open_window Wave
gui_list_add -id Wave.1 -from Hier.1 {  
					test_top.i2c_if.CLK 
					test_top.i2c_if.SCL 
					test_top.i2c_if.SDA 
					test_top.i2c_if.RST
				        test_top.interconnect_wrapper.hdl_interconnect_instance.scl_master 
                                        test_top.interconnect_wrapper.hdl_interconnect_instance.scl_slave
                                        test_top.interconnect_wrapper.hdl_interconnect_instance.sda_master
				        test_top.interconnect_wrapper.hdl_interconnect_instance.sda_slave
				     } -insertionbar
