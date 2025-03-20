CUR_PROJ_HOME=
COMPILE_HOME=$(CUR_PROJ_HOME)/simulation/build#编译目录，默认为项目主目录


#路径控制
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))#makefile的绝对路径
cur_makefile_path := $(dir $(mkfile_path))#当前makefile所在的文件夹

CM_NAME_STR=simv

TEST_NAME=
ifeq ($(strip $(TEST_NAME)),)  # $(strip ...) 用于去掉 A 的前后空格
    UVM_TEST_CMD=
else
    UVM_TEST_CMD=+UVM_TESTNAME=$(TEST_NAME)
endif

FILE_LIST=filelist.f
FILE_NAME:=top.sv
ifeq ($(FILE_LIST),)
	FILE_LISTS_OPTIONS=
else
	FILE_LISTS_OPTIONS=-f $(FILE_LIST)
endif
VCS_COMPILE_OPTIONS :=

#coverage
# code coverage command
CM = -cm line+cond+fsm+branch+tgl+assert
CM_NAME = -cm_name ${CM_NAME_STR}
CM_DIR = -cm_dir ./covdir.vdb
COVERAGE_CMD:=${CM} ${CM_NAME} ${CM_DIR}
cov:	
	./simv -l run.log \
	-f filelist.f \
	${COVERAGE_CMD}
cov_gui:
	dve -full64 -covdir *.vdb &


#-fsdb
FSDB_FLAG=-fsdb
FSDB_FLAG=1
ifeq ($(FSDB_FLAG),1)
	FSDB_CMD=-fsdb
else
	FSDB_CMD := 
endif


#是否dump多维数组
DUMP_ARRAY_FLAG=1
ifeq ($(DUMP_ARRAY_FLAG),1)
	DUMP_ARRAY_CMD :=+vcs+dumpfile+waves.vcd +memcbk +vcs+dumparrays
else
	DUMP_ARRAY_CMD := 
endif
#是否使用uvm
UVM_FLAG=0
ifeq ($(UVM_FLAG),1)
	UVM_CMD :=$(UVM_HOME)/src/dpi/uvm_dpi.cc
else
	UVM_CMD := 
endif




#VCS编译命令
VCS_CMD=vcs $(FILE_NAME) -sverilog -full64 $(UVM_CMD) \
-kdb \
-CFLAGS -DVCS \
-timescale=1ns/1ns \
-Xrawtokens=debug_macros \
+incdir+$(UVM_HOME)/src\
$(FSDB_CMD) \
-l compile.log \
-LDFLAGS -Wl,--no-as-needed \
-debug_all  -debug_accsss\
-assert svaext\
$(FILE_LISTS_OPTIONS)\
$(VCS_COMPILE_OPTIONS)\
$(DUMP_ARRAY_CMD)\
+lint=TFIPC-L\
${COVERAGE_CMD}


# -LDFLAGS -Wl,--no-as-needed--是为了解决libvcsnew.so: undefined reference的问题

CLEAN_CMD=rm -rf *~ core csrc  vc_hdrs.h ucli.key urg* *.log *.fsdb *.vcd inter.vpd *.out DVEfiles/ .inter.vpd.uvm \
.restartSimSession.tcl.old novas.* waves.* simv.daidir verdiLog/ *.vpd covdir.vdb/ cov_test.daidir/

move_file:
	cd $(CUR_PROJ_HOME) && pwd &&\
	if test -f waves.vcd; then \
		mv waves.vcd ../waves/; \
	fi &&\
	mv *.fsdb *.vcd ../waves/
print_info:
	@echo "CUR_PROJ_HOME is $(CUR_PROJ_HOME)"
compile:print_info
	cd $(COMPILE_HOME) && \
	$(VCS_CMD) 

	@echo $(CUR_PROJ_HOME)$(FILE_LIST)
	@echo $(MAKECMDGOALS)
	pwd


#清理工作空间
clean:
	cd $(CUR_PROJ_HOME) && \
	$(CLEAN_CMD) simv

#路径测试
path_test:
	echo $(mkfile_path)
	echo $(cur_makefile_path)
verdi:
	verdi -ssf waves.fsdb -sswr signal.rc


run:clean compile 
	./simv -l log.log $(UVM_TEST_CMD) $(DUMP_ARRAY_CMD)\
	&& rm -rf *~ core csrc  vc_hdrs.h ucli.key urg*  inter.vpd *.out DVEfiles/  .inter.vpd.uvm .restartSimSession.tcl.old \