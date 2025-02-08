#LAB_DIR = /home/cyl/target/personal/sync_fifo
#LAB_DIR = /home/cyl/target/personal/async_fifo
#LAB_DIR = /home/cyl/target/personal/uart
#LAB_DIR = /home/cyl/target/personal/spi
#LAB_DIR = /home/cyl/target/personal/apb
#LAB_DIR = /home/cyl/target/personal/ahb2apb

DFILES = *.v *.sv

# code coverage command
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name simv
CM_DIR = -cm_dir ./covdir.vdb



all :clean elab rung
all1:clean elab run cov verdi
all2:clean elab run verdi

elab:
	vcs -full64 -LDFLAGS -Wl,-no-as-needed -debug_acc+all -timescale=1ns/1ns \
	-fsdb -sverilog -l comp.log  \
	${DFILES} \
	${CM} \
	${CM_NAME} \
	${CM_DIR} 


run:
	./simv -l run.log \
	${DFILES} \
	${CM} \
	${CM_NAME} \
	${CM_DIR} 



rung:
	./simv -gui -l run.log \
	${DFILES} \
	${CM} \
	${CM_NAME} \
	${CM_DIR} 


verdi:
	verdi ${DFILES} \
	-ssf ./*.fsdb &

cov:
	dve -full64 -covdir *.vdb &

clean:
	rm -rf  AN.DB \
	rm -rf  DVEfiles \
	rm -rf  csrc \
	rm -rf  simv.* \
	rm -rf  *simv \
	rm -rf  inter.vpd \
	rm -rf  ucli.key \
	rm -rf  *.log \
	rm -rf  verdiLog \
	rm -rf  novas* \
	rm -rf  *.fsdb \
	rm -rf  *.vdb
