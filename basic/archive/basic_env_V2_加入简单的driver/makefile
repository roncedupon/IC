
# SoftMax_Home=/home/dy/IC_Learning/IC/Softmax   #step1
SoftMax_Home=/home/dy/IC/Softmax/main
PROJECT_HOME:=./



FILE_LIST=filelist.f
FSDB_FLAG=-fsdb

#是否dump多维数组
DUMP_ARRAY_FLAG=1
ifeq ($(DUMP_ARRAY_FLAG),1)
	DUMP_ARRAY_CMD :=+vcs+dumpfile+waves.vcd +memcbk +vcs+dumparrays
else
	DUMP_ARRAY_CMD := 
endif

VCS_CMD=vcs -sverilog -full64 $(UVM_HOME)/src/dpi/uvm_dpi.cc \
-CFLAGS -DVCS \
-timescale=1ns/1ps \
+incdir+$(UVM_HOME)/src\
-f $(PROJECT_HOME)/$(FILE_LIST) \
$(FSDB_FLAG) \
-LDFLAGS -Wl,--no-as-needed \
-debug_all  \
-assert svaext\
$(DUMP_ARRAY_CMD) \
# -LDFLAGS -Wl,--no-as-needed--是为了解决libvcsnew.so: undefined reference的问题

CLEAN_CMD=rm -rf *~ core csrc  vc_hdrs.h ucli.key urg* *.log *.fsdb *.vcd inter.vpd *.out DVEfiles/ .inter.vpd.uvm \
.restartSimSession.tcl.old novas.* waves.* simv.daidir

move_file:
	cd $(PROJECT_HOME) && pwd &&\
	if test -f waves.vcd; then \
		mv waves.vcd ../waves/; \
	fi &&\
	mv *.fsdb *.vcd ../waves/

compile:
	cd $(PROJECT_HOME) && \
	$(VCS_CMD) \
	&& ./simv -l log.log $(DUMP_ARRAY_CMD)\
	&& rm -rf *~ core csrc  vc_hdrs.h ucli.key urg*  inter.vpd *.out DVEfiles/  .inter.vpd.uvm .restartSimSession.tcl.old \

	@echo $(PROJECT_HOME)$(FILE_LIST)
	@echo $(MAKECMDGOALS)
	pwd
run:compile move_file

clean:
	cd $(PROJECT_HOME) && \
	$(CLEAN_CMD) simv

