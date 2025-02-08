MAKE_FILE_MAIN_PATH=/home/dy/IC/makefile#全局makefile的主路径
PROJECT_HOME=$(shell pwd)#获取当前项目路径，相当于./
CREATE_FILELIST_FLAG=1#是否要创建filelist.f,有时候需要手动修改filelist.f的文件，就不让他自动创建filelist了
FILE_NAME=

#coverage
# code coverage command
CM = -cm line+cond+fsm+branch+tgl+assert
CM_NAME = -cm_name simv
CM_DIR = -cm_dir ./covdir.vdb

cov:	
	./simv -l run.log \
	-f filelist.f \
	${CM} \
	${CM_NAME} \
	${CM_DIR} \
	&& dve -full64 -covdir *.vdb &
VCS_COMPILE_OPTIONS="${CM} ${CM_NAME} ${CM_DIR}"
run:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile run PROJECT_HOME=$(PROJECT_HOME) CREATE_FILELIST_FLAG=$(CREATE_FILELIST_FLAG) FILE_NAME=$(FILE_NAME) \
	VCS_COMPILE_OPTIONS=$(VCS_COMPILE_OPTIONS)
clean:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile clean PROJECT_HOME=$(PROJECT_HOME)
verdi:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile PROJECT_HOME=$(PROJECT_HOME) verdi

#先编译生成vpd波形文件，然后用make rung打开dve，并且右键选择左边的module，add to new waveform，点击下箭run一下，最后make cov
#也就是说，想要看覆盖率，得先用dve看一下波形