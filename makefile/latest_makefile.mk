VCS_UVM_HOME=$(VCS_HOME)/etc/uvm-1.2
TEST_NAME=txrx_interrupt_test
OPTION=
SEED=
SOLVER=2
VERBOSITY=UVM_LOW
WORKSHOP_MODE=NONE
run_file=$(ST_HOME)/cfgfile/run.ucli
infer_num=10
PWD=$(ST_HOME)/simulation
reg_test=0

CASE_OUT_DIR=$(PWD)/$(TEST_NAME)


#user option
type=rtl
dump=fsdb
trace=off


#coverage option
coverage=offcov_dir_vcs=vcs_coverage

#cmodel option
cmodel=off

#tb file & rtl path
RTL_LIST= -f $(ST_HOME)/filelist/rtl.f
TB_FILE= -f $(ST_HOME)/filelist/tb.f
ENV_LIST= -f $(ST_HOME)/filelist/env.f

USER_COMP_OPTION=+incdir+$(ST_HOME)/design
