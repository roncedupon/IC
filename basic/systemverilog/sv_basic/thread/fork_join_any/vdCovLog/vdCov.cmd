verdiWindowResize -win $_vdCoverage_1 "250" "175" "900" "700"
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
gui_open_cov  -hier /mnt/disk_0/IC/basic/systemverilog/sv_basic/5_thread/fork_join_any/simulation/2025-12-15/build/covdir.vdb -testdir {} -test {/mnt/disk_0/IC/basic/systemverilog/sv_basic/5_thread/fork_join_any/simulation/2025-12-15/build/covdir/simv} -merge MergedTest -db_max_tests 10 -fsm transition
gui_list_select -id CoverageTable.1 -list covtblInstancesList { fork_join_any   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} fork_join_any  -column {Toggle} 
vdCovExit -noprompt
