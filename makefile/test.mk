# Makefile

# Default target
.PHONY: all
all: help

# Help message
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make run FILE=test.sv   - Run simulation with specified FILE"

# Run target
.PHONY: run
run: $(FILE)
	@echo "Running simulation with $(FILE)..."
	# Add your simulation command here, for example:
	# vcs -full64 -sverilog $(FILE) -o simv
	# ./simv
	@echo "Simulation complete."

# Create the specified .sv file if it does not exist
FILE_NAME:=
%.sv:
	@echo "Creating $@..."
	@echo '// Auto-generated $@' > $@
	@echo 'module test;' >> $@
	@echo '  initial begin' >> $@
	@echo '    $display("Hello, World!");' >> $@
	@echo '    $finish;' >> $@
	@echo '  end' >> $@
	@echo 'endmodule' >> $@
	@echo "$@ created."
	FILE_NAME=$($@)
test_name:=123
print:
	echo $(test_name)
# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -f *.sv simv
	@echo "Clean complete."

# 当前 Makefile 所在路径
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

testmake:
	@echo $(MAKEFILE_DIR)


ifeq ($(SKIP_B), 1)
A:
	@echo "Building A without B"
else
A: B
	@echo "Building A with B"
endif

B:
	@echo "Building B"
