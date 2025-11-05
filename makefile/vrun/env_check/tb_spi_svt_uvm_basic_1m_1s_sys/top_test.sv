
/**
 * Abstract:  This file serve as a top-level test file, which just
 * pulls in the individual tests by including them.
 */

`include "spi_base_test.sv"
`include "spi_basic_env.sv"

`include "ts.base_test.sv"
`include "ts.master_tx_slave_rx_test.sv"
`include "ts.master_rx_slave_tx_test.sv"
`include "ts.eeprom_test.sv"
`include "ts.reset_test.sv"
`include "ts.master_txrx_slave_txrx_with_reconfigurable_data_frame_width_test.sv"
`include "ts.master_tx_slave_rx_with_reconfigurable_data_frame_width_test.sv"
`include "ts.master_rx_slave_tx_with_reconfigurable_data_frame_width_test.sv"
`include "ts.eeprom_mode_with_reconfigurable_data_frame_width_test.sv"
`include "ts.exception_idle_phase_clock_toggle_master_txrx_slave_txrx_test.sv"
`include "ts.exception_override_idle_phase_tristate_master_txrx_slave_txrx_test.sv"
`include "ts.exception_override_data_phase_tristate_master_tx_slave_rx_test.sv"
`include "ts.exception_override_data_phase_tristate_master_rx_slave_tx_test.sv"
`include "ts.baud_rate_mismatch_error_test.sv"
`include "ts.exception_minimum_leading_timer_test.sv"
`include "ts.exception_minimum_idle_timer_test.sv"
`include "ts.exception_minimum_trailing_timer_test.sv"
`include "ts.exception_clock_period_test.sv"
`include "ts.exception_clock_period_with_sclk_pause_test.sv"
`include "ts.disable_clock_period_check_on_sclk_pause_test.sv"
`include "ts.master_txrx_slave_txrx_with_sclk_pause_test.sv"

