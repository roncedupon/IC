
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

PROJECT_HOME:=

CREATE_FILELIST_FLAG=1#是否创建filelist.f文件
FILE_LIST=filelist.f
FILE_NAME:=
ifeq ($(CREATE_FILELIST_FLAG),1)
	CREATE_FILELIST_CMD =$(MAKE) -f $(cur_makefile_path)/filelist.mk FILELIST=$(FILE_LIST) FILE_NAME=$(FILE_NAME) all
else
	CREATE_FILELIST_CMD = 
endif


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
FSDB_FLAG=-debug_access
# FSDB_FLAG=1
# ifeq ($(FSDB_FLAG),1)
# 	FSDB_CMD=-fsdb
# else
# 	FSDB_CMD := 
# endif


#是否dump多维数组
DUMP_ARRAY_FLAG=1
ifeq ($(DUMP_ARRAY_FLAG),1)
	DUMP_ARRAY_CMD :=+vcs+dumpfile+waves.vcd +memcbk +vcs+dumparrays
else
	DUMP_ARRAY_CMD := 
endif
#是否使用uvm
UVM_FLAG=1
ifeq ($(UVM_FLAG),1)
	UVM_CMD :=$(UVM_HOME)/src/dpi/uvm_dpi.cc
else
	UVM_CMD := 
endif
VCS_COMPILE_OPTIONS=-f $(PROJECT_HOME)/$(FILE_LIST)
#vcs 编译增加的选项
#VCS编译命令
VCS_CMD=vcs -sverilog -full64 $(UVM_CMD) \
-CFLAGS -DVCS \
-timescale=1ns/1ns \
+incdir+$(UVM_HOME)/src\
$(FSDB_CMD) \
-LDFLAGS -Wl,--no-as-needed \
-debug_all  \
-assert svaext\
$(VCS_COMPILE_OPTIONS)\
$(DUMP_ARRAY_CMD)\
+lint=TFIPC-L\
${COVERAGE_CMD}


# -LDFLAGS -Wl,--no-as-needed--是为了解决libvcsnew.so: undefined reference的问题

CLEAN_CMD=rm -rf *~ core csrc  vc_hdrs.h ucli.key urg* *.log *.fsdb *.vcd inter.vpd *.out DVEfiles/ .inter.vpd.uvm \
.restartSimSession.tcl.old novas.* waves.* simv.daidir verdiLog/ *.vpd covdir.vdb/ cov_test.daidir/

move_file:
	cd $(PROJECT_HOME) && pwd &&\
	if test -f waves.vcd; then \
		mv waves.vcd ../waves/; \
	fi &&\
	mv *.fsdb *.vcd ../waves/

compile:
	cd $(PROJECT_HOME) && \
	$(VCS_CMD) 

	@echo $(PROJECT_HOME)$(FILE_LIST)
	@echo $(MAKECMDGOALS)
	pwd


#清理工作空间
clean:
	cd $(PROJECT_HOME) && \
	$(CLEAN_CMD) simv

#创建filelist
create_filelist:
	$(CREATE_FILELIST_CMD)


#路径测试
path_test:
	echo $(mkfile_path)
	echo $(cur_makefile_path)
verdi:
	verdi -ssf waves.fsdb -sswr signal.rc

#create component
create_component:
	@echo "creating component file"




run:clean create_filelist compile 
	./simv -l log.log $(UVM_TEST_CMD) $(DUMP_ARRAY_CMD)\
	&& rm -rf *~ core csrc  vc_hdrs.h ucli.key urg*  inter.vpd *.out DVEfiles/  .inter.vpd.uvm .restartSimSession.tcl.old \