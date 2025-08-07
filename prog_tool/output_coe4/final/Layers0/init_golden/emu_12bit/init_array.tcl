proc init_array {} {
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_nw.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_n.mem ../cfgfile/init_file/nw_x0y0_inner_trunk_n.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_ne.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_n.mem ../cfgfile/init_file/ne_x0y0_inner_trunk_n.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_sw.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_n.mem ../cfgfile/init_file/sw_x0y0_inner_trunk_n.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_se.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_n.mem ../cfgfile/init_file/se_x0y0_inner_trunk_n.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_nw.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_s.mem ../cfgfile/init_file/nw_x0y0_inner_trunk_s.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_ne.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_s.mem ../cfgfile/init_file/ne_x0y0_inner_trunk_s.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_sw.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_s.mem ../cfgfile/init_file/sw_x0y0_inner_trunk_s.data
	memory -load -defval 0 %readmenh cim_hw_top.u_cim_core_pld_top.u_flase_die_l2_top.u_array_model.u_se.i_buffer.u_inner_trunk_0_.u_inner_trunk_ram_s.mem ../cfgfile/init_file/se_x0y0_inner_trunk_s.data
	puts "array_init_trunk_done"
}