#MAKE_FILE_MAIN_PATH=/home/dy/IC/makefile#全局makefile的主路径
PROJECT_HOME=$(shell pwd)#获取当前项目路径，相当于./
CREATE_FILELIST_FLAG=1#是否要创建filelist.f,有时候需要手动修改filelist.f的文件，就不让他自动创建filelist了
FILE_NAME=top.sv
VCS_COMPILE_OPTIONS=

run:check_env
	make -f $(MAKE_FILE_MAIN_PATH)/makefile run PROJECT_HOME=$(PROJECT_HOME) CREATE_FILELIST_FLAG=$(CREATE_FILELIST_FLAG) FILE_NAME=$(FILE_NAME) \
	VCS_COMPILE_OPTIONS=$(VCS_COMPILE_OPTIONS)
clean:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile clean PROJECT_HOME=$(PROJECT_HOME)
verdi:
	make -f $(MAKE_FILE_MAIN_PATH)/makefile PROJECT_HOME=$(PROJECT_HOME) verdi
cov:run
	make -f $(MAKE_FILE_MAIN_PATH)/makefile cov
check_env:
	@if [ -z "$$MAKE_FILE_MAIN_PATH" ]; then \
		echo "Error: MAKE_FILE_MAIN_PATH is not set."; \
		exit 1; \
	fi