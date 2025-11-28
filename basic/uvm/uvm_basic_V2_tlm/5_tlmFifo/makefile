MAKE_FILE_MAIN_PATH=/home/dy/IC/makefile#全局makefile的主路径
PROJECT_HOME=$(shell pwd)#获取当前项目路径，相当于./
CREATE_FILELIST_FLAG=0#是否要创建filelist.f,有时候需要手动修改filelist.f的文件，就不让他自动创建filelist了
FILE_NAME=tlm_blocking_put_port.sv
run:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile run PROJECT_HOME=$(PROJECT_HOME) CREATE_FILELIST_FLAG=$(CREATE_FILELIST_FLAG) FILE_NAME=$(FILE_NAME)
clean:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile clean PROJECT_HOME=$(PROJECT_HOME)