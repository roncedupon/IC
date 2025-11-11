//=======================================================================
// COPYRIGHT (C) 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

/**
 * Abstract:  This file serve as a top-level test file, which just
 * pulls in the individual tests by including them.
 */

`include "ts.base_test.sv"
`include "ts.directed_test.sv"
`include "ts.random_test.sv"
`include "ts.directed_test_for_10_bit_addressing_test.sv"
`include "ts.general_call_test.sv"
`include "ts.start_byte_with_repeated_start_test.sv"
`include "ts.start_byte_with_repeated_start_10bit_test.sv"
`include "ts.directed_test_for_retry_if_nack_test.sv"
`include "ts.directed_test_for_nack_for_data_test.sv"
`include "ts.directed_test_to_send_nack_after_1st_byte_of_deviceid_test.sv"
`include "ts.directed_test_to_send_nack_after_2nd_byte_of_deviceid_test.sv"
`include "ts.directed_test_to_send_nack_after_3rd_byte_of_deviceid_test.sv"
`include "ts.directed_test_to_send_nack_after_3rd_byte_of_deviceid_with_rollback_iteration_enable_test.sv"
`include "ts.directed_test_to_send_nack_after_5th_byte_of_deviceid_with_rollback_iteration_enable_test.sv"
`include "ts.directed_test_to_send_nack_after_6th_byte_of_deviceid_with_rollback_iteration_enable_test.sv"
`include "ts.i2c_mst_generate_stop_insted_of_repeatedstart_after_10bit_slave_address_deviceid_test.sv"
`include "ts.i2c_mst_generate_stop_insted_of_repeatedstart_after_slave_address_deviceid_test.sv"
`include "ts.enable_exact_timing_checks_test.sv"
`include "ts.set_tolerance_limit_test.sv"
`include "ts.directed_min_dat_su_time_ss_test.sv"
`include "ts.directed_min_dat_su_time_fs_test.sv"
`include "ts.directed_min_dat_su_time_fm_test.sv"
`include "ts.directed_min_dat_su_time_hs_test.sv"
`include "ts.set_tolerance_scl_high_ss_test.sv"
`include "ts.set_tolerance_scl_high_fs_test.sv"
`include "ts.set_tolerance_scl_high_hs_test.sv"
`include "ts.set_tolerance_scl_high_fm_test.sv"
`include "ts.set_tolerance_scl_low_ss_test.sv"
`include "ts.set_tolerance_scl_low_fs_test.sv"
`include "ts.set_tolerance_scl_low_hs_test.sv"
`include "ts.set_tolerance_scl_low_fm_test.sv"
`include "ts.i2c_mst_10_bit_100_read_test.sv"
`include "ts.i2c_mst_10_bit_001_read_test.sv"
`include "ts.i2c_mst_10_bit_002_read_test.sv"
`include "ts.i2c_mst_10_bit_005_read_test.sv"
`include "ts.i2c_mst_10_bit_006_read_test.sv"
`include "ts.i2c_mst_10_bit_009_read_test.sv"
`include "ts.i2c_mst_10_bit_0f7_read_test.sv"
`include "ts.i2c_mst_10_bit_0f9_read_test.sv"
`include "ts.start_byte_in_hs_mode_test.sv"
`include "ts.start_byte_in_hs_mode_10_bit_test.sv"
`include "ts.i2c_mst_10_bit_000_read_test.sv"
`include "ts.ten_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_test.sv"
`include "ts.ten_bit_addr_rd_wr_p_3_bytes_10_bit_enabled_test.sv"
`include "ts.ten_bit_addr_rd_wr_sr_3_bytes_10_bit_disabled_test.sv"
`include "ts.ten_bit_addr_rd_wr_sr_3_bytes_10_bit_enabled_test.sv"
`include "ts.general_call_uvm_event_test.sv"
`include "ts.directed_reset_in_ten_bit_rd_test.sv"
`include "ts.directed_long_reset_test.sv"
`include "ts.eeprom_2_bit_paging_wr_rd_test.sv"
`include "ts.corrupt_10b_rd_test.sv"
`include "ts.directed_test_for_slv_nack_for_data_byte_more_than_255_test.sv"
`include "ts.i2c_master_insert_stop_after_8b_read_data_test.sv"
`include "ts.i2c_master_insert_stop_before_1b_read_data_test.sv"
`include "ts.i2c_master_insert_stop_after_master_code_in_hs_mode_test.sv"
`include "ts.i2c_master_miss_rep_start_after_master_code_test.sv"
`include "ts.i2c_master_insert_repeated_start_after_8b_read_data_test.sv"
`include "ts.i2c_master_insert_repeated_start_before_1b_read_data_test.sv"
`include "ts.i2c_cbus_10bit_addressing_coverage_test.sv"

`include "ts.i2c_master_miss_rep_start_after_start_byte_test.sv"
`include "ts.i2c_master_miss_rep_start_after_start_byte_with_hs_mode_test.sv"
`include "ts.i2c_master_start_txn_wo_start_test.sv"
`include "ts.i2c_master_send_rsvd_1111xxx_to_slv_test.sv"
`include "ts.i2c_master_send_cbus_addr_and_found_ack_test.sv"
`include "ts.i2c_master_send_rsvd_addr_and_slv_ack_test.sv"
`include "ts.i2c_master_send_rsvd_10bit_addr_and_slv_ack_test.sv"
`include "ts.i2c_master_send_wr_rd_to_7bit_addr_and_slv_nack_test.sv"
`include "ts.i2c_master_send_wr_rd_to_10bit_addr_and_slv_nack_test.sv"
`include "ts.i2c_master_insert_stop_in_10bit_addr_in_cmd_byte_test.sv"
`include "ts.i2c_random_all_cmd_scenario_with_ack_nack_test.sv"
`include "ts.i2c_mst_send_wr_rd_device_id_with_unknown_addr_test.sv"
