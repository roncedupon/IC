.PHONY:com sim debug cov clean

OUTPUT = cov_test
ALL_DEFINE = +define+DUMP_VPD+NET_SIM

#code coverage command
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name ${OUTPUT}
CM_DIR = -cm_dir ./${OUTPUT}.vdb

#netlist-simulation
LIB_FILE = -v /mnt/hgfs/LINUX_EDA_Share/DC_Projects/digital_lib/TSMC_013/verilog/tsmc13.v


VPD_NAME = +vpdfile+${OUTPUT}.vpd

VCS = vcs -sverilog +v2k -timescale=1ns/1ns \
	  -o ${OUTPUT}							\
	  -l compile.log						\
	  ${VPD_NAME}							\
	  ${ALL_DEFINE}							\
	  ${CM}									\
	  ${CM_NAME}							\
	  ${CM_DIR}								\
	  -debug_pp 							\
	  -Mupdate								\
	  ${LIB_FILE}


SIM = ./${OUTPUT} ${VPD_NAME} 				\
	  ${CM}									\
	  ${CM_NAME}							\
	  ${CM_DIR}								\
      -l ${OUTPUT}.log

com:
	${VCS} -f filelist.f

sim:
	${SIM}

#show the coverage
cov:
	dve -covdir *.vdb &

debug:
	dve -vpd ${OUTPUT}.vpd &
	
clean:
	rm -rf ./csrc *.daidir *.log simv* *.key *.vpd ./DVEfiles ${OUTPUT} *.vdb
