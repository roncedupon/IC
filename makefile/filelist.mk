# Makefile to generate filelist.f from all .sv files in current directory

# Define the filelist file
FILELIST := filelist.f
FILE_NAME:=
SV_FILES := $(wildcard *.sv *.v)
ifeq ($(FILE_NAME),)
	SV_FILES := $(wildcard *.sv *.v)
else
	SV_FILES = $(FILE_NAME)
endif
#这里SV_FILES = $(FILE_NAME) 就行，:=就不行


# Rule to generate filelist.f
$(FILELIST): 
	@echo "Generating filelist.f..."
	@echo $(SV_FILES)
	@echo $(SV_FILES) > $(FILELIST)
	@echo "Filelist generated."

# # Phony target to prevent conflicts with file named 'clean'
# .PHONY: clean

# Clean target to remove generated filelist.f
cleanf:
	@rm -f $(FILELIST)
	@echo "remove old filelist.f"

# Default target
all:cleanf $(FILELIST)
	
test:
	@echo $(FILE_NAME)
	@echo $(FILELIST)
	@echo $(SV_FILES)
