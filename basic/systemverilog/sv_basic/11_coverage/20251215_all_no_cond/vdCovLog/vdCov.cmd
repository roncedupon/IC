verdiWindowResize -win $_vdCoverage_1 "250" "175" "1040" "711"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_column_config -id   -list  covtblCcexList  -col  C  -show 
gui_column_config -id   -list  covtblCcexList  -col  C  -on   -show 
gui_column_config -id   -list  covtblCcexList  -col  X  -on   -show 
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier /mnt/disk_0/IC/basic/systemverilog/sv_basic/11_coverage/20251215_all_no_cond/simulation/2025-12-15/tb_top/simv.vdb -testdir {} -test {/mnt/disk_0/IC/basic/systemverilog/sv_basic/11_coverage/20251215_all_no_cond/simulation/2025-12-15/tb_top/simv/test_name} -merge MergedTest -db_max_tests 10 -fsm transition
gui_set_pref_value -category {ColumnCfg} -key {covtblAssertList_Assert} -value {true}
gui_set_pref_value -category {ColumnCfg} -key {covtblAssertList_Match} -value {false}
gui_set_pref_value -category {ColumnCfg} -key {covtblAssertList_Success} -value {false}
verdiWindowResize -win $_vdCoverage_1 "250" "175" "1040" "711"
vdCovExit -noprompt
