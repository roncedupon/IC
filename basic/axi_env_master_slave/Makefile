#=======================================================================
# AXI Master-Slave Environment Makefile
# Description: Build and run simulation using Synopsys VCS
#=======================================================================

# Compiler settings
VCS = vcs
VERDI = verdi

# VIP paths
VIP_HOME ?= $(HOME)/vip/svt_axi
UVM_HOME ?= $(VCS_HOME)/packages/uvm-1.2

# Source directories
ENV_DIR = env
TEST_DIR = tests
HDL_DIR = hdl_interconnect

# Compiler options
COMPILE_OPTS = -full64 -sverilog +incdir+$(VIP_HOME)/include +incdir+$(UVM_HOME)/src
COMPILE_OPTS += -ntb_opts uvm-1.2
COMPILE_OPTS += -timescale=1ns/1ps
COMPILE_OPTS += -debug_access+all
COMPILE_OPTS += -kdb -lca

# Source files
SV_SOURCES = $(HDL_DIR)/axi_dut.v
SV_SOURCES += top.sv

# Default target
all: compile run

# Compile target
compile:
	@echo "=========================================="
	@echo "Compiling AXI Master-Slave Environment..."
	@echo "=========================================="
	$(VCS) $(COMPILE_OPTS) $(SV_SOURCES) -o simv_axi_tb

# Run target
run:
	@echo "=========================================="
	@echo "Running Simulation..."
	@echo "=========================================="
	./simv_axi_tb +UVM_VERBOSITY=UVM_LOW -l sim.log

# Debug run with Verdi
debug:
	@echo "=========================================="
	@echo "Running Debug Simulation with Verdi..."
	@echo "=========================================="
	$(VCS) $(COMPILE_OPTS) -debug_all $(SV_SOURCES) -o simv_axi_tb
	./simv_axi_tb +UVM_VERBOSITY=UVM_HIGH -gui -l sim_debug.log

# Waveform dump
wave:
	@echo "=========================================="
	@echo "Running Simulation with Waveforms..."
	@echo "=========================================="
	$(VCS) $(COMPILE_OPTS) +define+WAVES_VCD $(SV_SOURCES) -o simv_axi_tb_wave
	./simv_axi_tb_wave +UVM_VERBOSITY=UVM_LOW -l sim_wave.log

# Verdi waveform viewer
verdi:
	$(VERDI) -ssf axi_tb.vcd &

# Clean target
clean:
	rm -rf *.log *.key *.vpd *.vdb DVEfiles AN.DB csrc simv* *.vcd *.fsdb *.key *.vpd
	rm -rf $(HDL_DIR)/*.log

# Help target
help:
	@echo "Available targets:"
	@echo "  make compile  - Compile the testbench"
	@echo "  make run      - Run the simulation"
	@echo "  make debug    - Run with GUI debug"
	@echo "  make wave     - Run with waveform dump"
	@echo "  make verdi    - Open Verdi waveform viewer"
	@echo "  make clean    - Clean generated files"
	@echo "  make all      - Compile and run"

.PHONY: all compile run debug wave verdi clean help
