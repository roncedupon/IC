
PROJECT_HOME:=$(shell pwd)

FILE_LIST=filelist.f
FSDB_FLAG=-fsdb




run:
	cd $(PROJECT_HOME) && \
	$(VCS_CMD) && ./simv -l log.log
	@echo $(PROJECT_HOME)$(FILE_LIST)
	@echo $(MAKECMDGOALS)
	pwd
	
clean:
	cd $(PROJECT_HOME) && \
	$(CLEAN_CMD)

