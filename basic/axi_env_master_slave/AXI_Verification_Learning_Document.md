# AXI Master-Slave Verification Environment - Learning Document

## 1. Introduction

### 1.1 Purpose
This document provides comprehensive guidance for understanding and using the AXI Master-Slave verification environment. It covers AXI protocol basics, UVM methodology, and practical implementation details.

### 1.2 Target Audience
- IC Verification Engineers
- AXI Protocol Learners
- UVM Methodology Practitioners
- Hardware-Software Co-verification Engineers

## 2. AXI Protocol Fundamentals

### 2.1 AXI4 Protocol Overview
AXI (Advanced eXtensible Interface) is ARM's on-chip communication protocol designed for high-performance, high-frequency system designs.

#### Key Characteristics:
- **Separate address/control and data phases**
- **Support for unaligned data transfers**
- **Multiple outstanding addresses**
- **Out-of-order transaction completion**
- **Easy addition of register stages for timing closure**

### 2.2 AXI Channels
AXI4 uses five independent channels:

#### 1. Write Address Channel (AW)
- Carries address and control information for write transactions
- Signals: `awid`, `awaddr`, `awlen`, `awsize`, `awburst`, `awlock`, `awcache`, `awprot`, `awqos`, `awregion`, `awuser`, `awvalid`, `awready`

#### 2. Write Data Channel (W)
- Carries write data and strobes
- Signals: `wdata`, `wstrb`, `wlast`, `wuser`, `wvalid`, `wready`

#### 3. Write Response Channel (B)
- Provides response for write transactions
- Signals: `bid`, `bresp`, `buser`, `bvalid`, `bready`

#### 4. Read Address Channel (AR)
- Carries address and control information for read transactions
- Signals: `arid`, `araddr`, `arlen`, `arsize`, `arburst`, `arlock`, `arcache`, `arprot`, `arqos`, `arregion`, `aruser`, `arvalid`, `arready`

#### 5. Read Data Channel (R)
- Carries read data
- Signals: `rid`, `rdata`, `rresp`, `rlast`, `ruser`, `rvalid`, `rready`

### 2.3 Burst Types

#### FIXED Burst
- Address remains constant throughout the burst
- Used for accessing FIFOs or circular buffers

#### INCR (Incrementing) Burst
- Address increments after each transfer
- Most common burst type
- Used for sequential memory access

#### WRAP (Wrapping) Burst
- Address wraps around within a defined boundary
- Used for cache line fills

### 2.4 Burst Length and Size

#### Burst Length
- Number of data transfers in a burst (1-256)
- Encoded as 0-255 in `awlen`/`arlen`

#### Burst Size
- Number of bytes transferred in each beat
- 2^`awsize`/`arsize` bytes per transfer
- Supports 1, 2, 4, 8, 16, 32, 64, 128 byte transfers

## 3. UVM Verification Methodology

### 3.1 UVM Component Hierarchy

```
uvm_test (axi_write_read_test)
└── uvm_env (axi_basic_env)
    ├── svt_axi_system_env
    │   ├── svt_axi_master_agent
    │   │   ├── svt_axi_master_sequencer
    │   │   ├── svt_axi_master_driver
    │   │   └── svt_axi_master_monitor
    │   └── svt_axi_slave_agent
    │       ├── svt_axi_slave_sequencer
    │       ├── svt_axi_slave_driver
    │       └── svt_axi_slave_monitor
    ├── axi_virtual_sequencer
    ├── axi_scoreboard
    └── axi_coverage
```

### 3.2 Key UVM Concepts in This Environment

#### Virtual Sequencer
Coordinates sequences across multiple agents:
```systemverilog
class axi_virtual_sequencer extends uvm_sequencer;
  svt_axi_master_sequencer m_master_seqr;
  svt_axi_slave_sequencer m_slave_seqr;
endclass
```

#### Scoreboard
Verifies data integrity between write and read operations:
```systemverilog
class axi_scoreboard extends uvm_scoreboard;
  bit [63:0] memory_model [bit [31:0]];
  // Tracks expected data and verifies against actual
endclass
```

#### Coverage Collector
Collects functional coverage for protocol features:
```systemverilog
covergroup axi_cg;
  xact_type_cp: coverpoint tr.xact_type;
  burst_type_cp: coverpoint tr.burst_type;
  // Cross coverage for comprehensive verification
endgroup
```

## 4. Environment Architecture

### 4.1 Top-Level Integration

```systemverilog
module test_top;
  // Clock and reset generation
  logic aclk, aresetn;
  
  // AXI interface instance
  svt_axi_if axi_if();
  
  // DUT wrapper
  axi_dut_wrapper dut_wrapper(axi_if);
  
  // UVM configuration and test execution
  initial begin
    uvm_config_db#(svt_axi_vif)::set(null, "uvm_test_top.env.axi_system_env", "vif", axi_if);
    run_test("axi_write_read_test");
  end
endmodule
```

### 4.2 DUT Architecture

The DUT is a pass-through interconnect that directly connects master and slave interfaces:

```verilog
module axi_dut #(
  parameter DATA_WIDTH = 64,
  parameter ADDR_WIDTH = 32,
  parameter ID_WIDTH = 4,
  parameter USER_WIDTH = 8
);
  // Direct signal connections between master and slave
  assign s_awaddr = m_awaddr;
  assign m_awready = s_awready;
  // ... (all AXI signals connected)
endmodule
```

### 4.3 Configuration Flow

```systemverilog
class cust_svt_axi_system_configuration extends svt_axi_system_configuration;
  function new(string name = "cust_svt_axi_system_configuration");
    super.new(name);
    
    // Configure 1 master, 1 slave
    this.num_masters = 1;
    this.num_slaves = 1;
    
    // Master configuration
    this.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4;
    this.master_cfg[0].data_width = 64;
    this.master_cfg[0].addr_width = 32;
    
    // Slave configuration
    this.slave_cfg[0].enable_mem_model = 1;
    this.slave_cfg[0].mem_size = 32'h10000; // 64KB
  endfunction
endclass
```

## 5. Test Sequences

### 5.1 Master Write-Read Sequence

```systemverilog
class axi_master_write_read_sequence extends svt_axi_master_base_sequence;
  rand int unsigned sequence_length = 10;
  
  virtual task body();
    for (int i = 0; i < sequence_length; i++) begin
      // Write transaction
      `uvm_create(write_tran)
      `uvm_rand_send_with(write_tran, {
        xact_type == WRITE;
        addr == (base_addr + ('h10 * i));
        burst_length == 4;
        data.size() == 4;
        foreach (data[j]) {
          data[j] == (32'hDEAD_BEEF + i + j);
        }
      })
      
      // Read transaction
      `uvm_create(read_tran)
      `uvm_rand_send_with(read_tran, {
        xact_type == READ;
        addr == (base_addr + ('h10 * i));
        burst_length == 4;
      })
      
      // Verify data
      if (rsp.data[j] != expected_data) begin
        `uvm_error("DATA_MISMATCH", "...")
      end
    end
  endtask
endclass
```

### 5.2 Slave Response Sequence

```systemverilog
class axi_slave_response_sequence extends svt_axi_slave_base_sequence;
  virtual task body();
    forever begin
      // Get request from monitor
      p_sequencer.response_request_port.peek(req_resp);
      
      // Randomize response
      status = req_resp.randomize with {
        bresp == OKAY;
        foreach (rresp[idx]) rresp[idx] == OKAY;
      };
      
      // Handle memory operations
      if (req_resp.xact_type == WRITE) begin
        put_write_transaction_data_to_mem(req_resp);
      end else begin
        get_read_data_from_mem_to_transaction(req_resp);
      end
      
      `uvm_send(req)
    end
  endtask
endclass
```

### 5.3 Virtual Sequence

```systemverilog
class axi_virtual_sequence extends uvm_sequence;
  virtual task body();
    // Start slave sequence (runs forever)
    fork
      s_seq = axi_slave_response_sequence::type_id::create("s_seq");
      s_seq.start(p_sequencer.m_slave_seqr);
    join_none
    
    // Wait for slave to be ready
    #100;
    
    // Run master sequence
    m_seq = axi_master_write_read_sequence::type_id::create("m_seq");
    m_seq.start(p_sequencer.m_master_seqr);
  endtask
endclass
```

## 6. Verification Components

### 6.1 Scoreboard Implementation

The scoreboard maintains a memory model to track expected data:

```systemverilog
class axi_scoreboard extends uvm_scoreboard;
  bit [63:0] memory_model [bit [31:0]];
  
  // Track write transactions
  virtual function void write_master(svt_axi_master_transaction tr);
    if (tr.xact_type == WRITE) begin
      store_write_data(tr);
      write_count++;
    end
  endfunction
  
  // Verify read transactions
  virtual function void write_slave(svt_axi_slave_transaction tr);
    if (tr.xact_type == READ) begin
      verify_read_data(tr);
      read_count++;
    end
  endfunction
  
  // Store write data in memory model
  virtual function void store_write_data(svt_axi_master_transaction tr);
    bit [31:0] addr = tr.addr;
    for (int i = 0; i < tr.burst_length; i++) begin
      memory_model[addr] = tr.data[i];
      addr += (1 << tr.burst_size);
    end
  endfunction
endclass
```

### 6.2 Coverage Collection

```systemverilog
covergroup axi_cg;
  // Transaction type coverage
  xact_type_cp: coverpoint tr.xact_type {
    bins write = {WRITE};
    bins read = {READ};
  }
  
  // Burst type coverage
  burst_type_cp: coverpoint tr.burst_type {
    bins fixed = {FIXED};
    bins incr = {INCR};
    bins wrap = {WRAP};
  }
  
  // Cross coverage
  xact_burst_cross: cross xact_type_cp, burst_type_cp;
endgroup
```

## 7. Advanced Features

### 7.1 Multiple Outstanding Transactions
The environment supports multiple outstanding transactions through VIP configuration:

```systemverilog
cfg.master_cfg[0].outstanding_xact = 8;  // Allow 8 concurrent transactions
```

### 7.2 Protocol Checking
Built-in protocol checking ensures AXI compliance:

```systemverilog
cfg.master_cfg[0].protocol_check_enable = 1;
cfg.slave_cfg[0].protocol_check_enable = 1;
```

### 7.3 Timeout Handling
Transaction timeouts prevent simulation hang:

```systemverilog
cfg.master_cfg[0].xact_timeout = 1000;  // 1000 cycles
cfg.slave_cfg[0].xact_timeout = 1000;
```

## 8. Usage Examples

### 8.1 Running Basic Test
```bash
# Set VIP path
export VIP_HOME=/path/to/vip/svt_axi

# Compile and run
make compile
make run
```

### 8.2 Running Advanced Test
```bash
# Run advanced test with coverage
make compile TESTNAME=axi_advanced_test
make run TESTNAME=axi_advanced_test
```

### 8.3 Debug Mode
```bash
# Run with GUI debug
make debug

# Run with waveform dump
make wave

# View waveforms with Verdi
make verdi
```

## 9. Best Practices

### 9.1 Test Development
- Start with simple sequences and gradually add complexity
- Use randomization with proper constraints
- Implement proper error checking and reporting

### 9.2 Coverage Closure
- Monitor functional coverage throughout development
- Create directed tests for hard-to-hit coverage points
- Use cross coverage to verify interactions

### 9.3 Debug Techniques
- Use UVM_HIGH verbosity for detailed debugging
- Check scoreboard reports for data integrity issues
- Monitor protocol checker messages for AXI violations

## 10. Troubleshooting

### 10.1 Common Issues

#### Compilation Errors
- Ensure VIP_HOME environment variable is set correctly
- Check VCS and UVM_HOME paths
- Verify all include paths are correct

#### Simulation Issues
- Check reset timing (minimum 10 cycles)
- Verify clock generation
- Monitor timeout values

#### Coverage Issues
- Ensure all transaction types are being generated
- Check burst length and size distributions
- Verify cross coverage collection

### 10.2 Debug Commands
```bash
# Check compilation
make clean && make compile

# Run with high verbosity
./simv_axi_tb +UVM_VERBOSITY=UVM_HIGH

# Check log files
tail -f sim.log
```

## 11. Conclusion

This AXI verification environment provides a solid foundation for learning and implementing AXI protocol verification. It demonstrates key UVM concepts and provides practical examples that can be extended for real-world verification projects.

The environment is designed to be:
- **Educational**: Clear structure and comprehensive documentation
- **Extensible**: Easy to add new features and test cases
- **Robust**: Includes error checking and coverage collection
- **Practical**: Based on industry-standard methodologies

Use this as a starting point for your AXI verification projects and adapt it to your specific needs.