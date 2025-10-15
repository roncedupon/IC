#===========================================================#
# Step1 : Read & elaborate the RTL file list & check        #
#===========================================================#

set TOP_MODULE Top
analyze -format verilog [list Top.v fsm_moore.v counter.v]

elaborate       $TOP_MODULE -architecture verilog
current_design  $TOP_MODULE

if {[link] == 0} {
    echo "Link with error!";
    exit;
}

if {[check_design] == 0} {
    echo "Check design with error!";
    exit;
}

#===========================================================#
#       Step2 : reset the design first#
#===========================================================#
reset_design

#===========================================================#
#               Step3 : write the unmapped ddc file         #
#===========================================================#

uniquify

set uniquify_naming_style "%s_%d"
write -f ddc -hierarchy -output ${UNMAPPED_PATH}/${TOP_MODULE}.ddc

#===========================================================#
#               Step4 : define clock                        #
#===========================================================#

set CLK_NAME        clk_i
set CLK_PERIOD      10

create_clock -period $CLK_PERIOD [get_ports $CLK_NAME]
set_ideal_network       [get_ports $CLK_NAME]
set_dont_touch_network  [get_ports $CLK_NAME]
set_drive   0

#===========================================================#
#               Step4 : Define reset                        #
#===========================================================#

set     RST_NAME        rst_l_i
set_ideal_network       [get_ports $RST_NAME]
set_dont_touch_network  [get_ports $RST_NAME]
set_drive   0


set_app_var verilogout_show_unconnected_pins true
set_app_var bus_naming_style                {%s[%d]}
simplify_constants   -boundary_optimization
set_fix_multiple_port_nets -all -buffer_constants


compile

change_names -rules verilog -hierarchy

write -f verilog -hierarchy -output $MAPPED_PATH/${TOP_MODULE}.v
write_sdf -version 2.1 $MAPPED_PATH/${TOP_MODULE}.sdf








