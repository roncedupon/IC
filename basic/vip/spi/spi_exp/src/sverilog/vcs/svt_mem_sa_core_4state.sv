//--------------------------------------------------------------------------
// COPYRIGHT (C) 2012-2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//--------------------------------------------------------------------------
`ifndef GUARD_SVT_MEM_SA_CORE_4state_SV
`define GUARD_SVT_MEM_SA_CORE_4state_SV

//----------------------------------------------------------------------
// 
// S P A R S E   A R R A Y  S E R V E R
//
//
// System Verilog svt_mem_sa_core class
//
// This class implements a single sparse array class instance
//
// Uses DPI for inter-language control transfer.
//
//----------------------------------------------------------------------

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_mem_sa_defs)
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_mem_sa_dpi)

typedef class svt_mem_backdoor_4state;

//======================================================================
//======================================================================
//
// svt_mem_sa_core class -- "standard" interface for use by models
//
//======================================================================
//======================================================================

class svt_mem_sa_core_4state;


  chandle  inst_handle;    // pointer to C++ sparse array class instance
  int      valid_instance; // 0=invalid instance, 1=valid instance

//======================================================================
//
// S P A R S E   A R R A Y   S E R V E R   C A L L S
//
// Non-instance specific calls
//
//======================================================================


//----------------------------------------------------------------------
// INTERNAL USE ONLY
// Sets the id that corresponds to the SV svt_mem_core instance.
//----------------------------------------------------------------------
  function void set_svt_mem_core_id( input int svt_mem_core_id );

    svt_mem_sa_inst_set_svt_mem_core_id( inst_handle, svt_mem_core_id );

  endfunction


//----------------------------------------------------------------------
// INTERNAL USE ONLY - reset the fatal, error, warning, info, debug,
// and verbose message tracking counts...
//----------------------------------------------------------------------
  function void set_debug_level( input int level );

    svt_mem_sa_inst_set_debug_level( inst_handle, level );

  endfunction


//----------------------------------------------------------------------
// INTERNAL USE ONLY - reset the fatal, error, warning, info, debug,
// and verbose message tracking counts...
//----------------------------------------------------------------------
  function void reset_msg_counts();

    svt_mem_sa_inst_reset_msg_counts( inst_handle );

  endfunction


//----------------------------------------------------------------------
// INTERNAL USE ONLY - fetch the fatal, error, warning, info, debug,
// and verbose message tracking counts...
//----------------------------------------------------------------------
  function void get_msg_counts(
      output int       fatal_count,
      output int       error_count,
      output int       warning_count,
      output int       info_count,
      output int       debug_count,
      output int       verbose_count );

    svt_mem_sa_inst_get_msg_counts(
      inst_handle,
      fatal_count, 
      error_count,
      warning_count,
      info_count,
      debug_count,
      verbose_count );

  endfunction

  //----------------------------------------------------------------------
  // NEW - create a new sparse array instance
  //----------------------------------------------------------------------
  function new(
      input string name,
      input int    addr_width,
      input int    phys_dim_nb,
      input int    max_phys_dim_nb,
      input int    data_width,
      input int    attr_width,
      input int    modes,
      input string load_file_name );

      inst_handle = svt_mem_sa_inst_new( name, 1, addr_width, phys_dim_nb, max_phys_dim_nb, data_width, attr_width, modes, load_file_name, valid_instance);

      if ( inst_handle == null ) begin
        svt_mem_sa_msg(`SVT_MEM_MSG_TYPE_FATAL, "new", "Unable to create memory instance due to memory server not being loaded or not enough system memory"); 
      end

  endfunction

  //----------------------------------------------------------------------
  // define_physical_dimension defines physical dimensions
  //----------------------------------------------------------------------
  function int define_physical_dimension( 
     input string attribute_name, 
     input string dimension_name,
     input int    dimension_size);   

    return svt_mem_sa_define_physical_dimension( inst_handle, attribute_name, dimension_name, dimension_size);   

  endfunction

  //----------------------------------------------------------------------
  // GET INST HANDLE - get the C handle of an instance
  //----------------------------------------------------------------------
  function chandle get_inst_handle();

    return inst_handle;

  endfunction

  //----------------------------------------------------------------------
  // Delete the C handle of an instance
  //----------------------------------------------------------------------
  function int delete_instance();

    return svt_mem_sa_inst_delete(inst_handle);

  endfunction

  //----------------------------------------------------------------------
  // Delete all instances C handle
  //----------------------------------------------------------------------
  function int delete_instance_all();

    return svt_mem_sa_inst_delete_all();

  endfunction

  //----------------------------------------------------------------------
  // CLONE - create an exact copy of a sparse array
  //
  // 1. Create a new instance with the same parameters as the parent
  //    (this) instance.
  // 2. Use the svt_mem_sa_inst_clone() function to copy all internal
  //    data values from the parent instance to the clone instance.
  // 3. Return the clone instance.
  //
  // Clones the following:
  //    o  data
  //    o  attributes / access status
  //    o  patterns
  //
  // Does not clone the following:
  //    o  history file name and enable
  //    o  instance name
  //
  //----------------------------------------------------------------------

  function svt_mem_sa_core_4state clone( input string name, input longint unsigned sim_time );

    svt_mem_sa_core_4state  clone_inst;

    clone_inst = new( name,
                      get_addr_width(),
                      get_nb_phys_dimensions(),
                      `SVT_MEM_SA_CORE_PHYSICAL_DIMENSIONS_MAX, 
                      get_data_width(),
                      get_attr_width(),
                      get_inst_modes(),
                      get_load_file_name() );

    svt_mem_sa_inst_clone( clone_inst.get_inst_handle(), inst_handle, sim_time);

    return clone_inst;

  endfunction


  //----------------------------------------------------------------------
  // COPY - copy from one area of memory to another area either in this
  // instance or in another. When copying between different instances,
  // both instances MUST have the same data and attribute widths.
  //
  // Only "written" (access status is LAST_WR or LAST_RD) memory locations
  // are copied
  //
  // Return 0 if success
  //----------------------------------------------------------------------
  function int copy(
      input svt_mem_sa_core_4state src,
      input longint unsigned         dest_adr,
      input longint unsigned         src_adr,
      input longint unsigned         length,
      input longint unsigned         sim_time  );

    return svt_mem_sa_inst_copy( inst_handle, src.get_inst_handle(), dest_adr, src_adr, length, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // MEMCMP - compare two reqions of memory with each other.
  //
  // Regions are specified by address and a length. If src_adr, dest_adr,
  // and length are 0 the all sparse array locations are compared. In this
  // case the address width of both instances must be the same.
  //
  // src_adr and dest_adr need not be the same for sub-instance sized
  // compares.
  //
  // Both sparse array instances must have the same data width.
  //
  // Return 0 if success
  //       <0 if error
  //       >0 (number of miscompares) if the areas didn not match.
  //----------------------------------------------------------------------
  function int memcmp(
      input  svt_mem_sa_core_4state src,
      input  int                      modes,  // strict, subset, superset, intersect
      input  int                      max_errors,
      output int                      num_errors,
      input  longint unsigned         dest_adr,
      input  longint unsigned         src_adr,
      input  longint unsigned         length,
      output int                      status,
      input  longint unsigned       sim_time );

    return svt_mem_sa_inst_memcmp( inst_handle, src.inst_handle, modes, max_errors, num_errors, dest_adr, src_adr, length, status, sim_time );

  endfunction

  //----------------------------------------------------------------------
  // Get the id of the dataarray used for this memserver instance
  //----------------------------------------------------------------------
  function int get_dataarray_id();

    return svt_mem_sa_inst_get_dataarray_id( inst_handle );

  endfunction
  


  //----------------------------------------------------------------------
  // Did the constructor succeed for this instance?
  //----------------------------------------------------------------------
  function int is_valid();

    return valid_instance;

  endfunction


  //----------------------------------------------------------------------
  // Create and return an instance of a backdoor class for this object
  //----------------------------------------------------------------------
  function svt_mem_backdoor_4state get_backdoor;

    svt_mem_backdoor_4state bd;
    string name;
    int    rc;
    rc = get_name( name ); 
    bd = new( name );

    bd.valid_instance = 1;  // mark the backdoor as a valid connection
    return bd;

  endfunction


  //----------------------------------------------------------------------
  // CONNECT - connect to an existing sparse array instance
  //
  // Returns 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int find(
      input string name );

    int  status;
    inst_handle = svt_mem_sa_find_instance( name, status );
    if (status)
      return -1;
    else 
      return 0;
  endfunction


  //----------------------------------------------------------------------
  // COLLECT ALL STATISTICS - collects statistics for ALL sparse array instances.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function void collect_all_statistics( output svt_mem_sa_statdata stats );

    svt_mem_sa_collect_all_statistics( stats );

  endfunction


  //----------------------------------------------------------------------
  // RESET ALL STATISTICS - collects statistics for ALL sparse array instances.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function void reset_all_statistics;

    svt_mem_sa_reset_all_statistics;

  endfunction



//======================================================================
//
// S P A R S E  A R R A Y   I N S T A N C E   S P E C I F I C   C A L L S 
//
// Instance specific functions
//
//======================================================================


  //----------------------------------------------------------------------
  // GET NAME function
  //
  // NOTE: Cadence irun cant handle a call to a DPI function that returns
  // a string value. This causes a compile time internal error.
  //----------------------------------------------------------------------
  function int get_name( output string name );
    
    return svt_mem_sa_inst_get_name( inst_handle, name );

  endfunction


  //----------------------------------------------------------------------
  // GET STATISTICS - writes the page structure to the 
  // simulation transcript.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function void collect_statistics( inout svt_mem_sa_statdata stats );

    svt_mem_sa_inst_collect_statistics( inst_handle, stats );

  endfunction


  //----------------------------------------------------------------------
  // RESET STATISTICS - writes the page structure to the 
  // simulation transcript.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function void reset_statistics;

    svt_mem_sa_inst_reset_statistics( inst_handle );

  endfunction


  //----------------------------------------------------------------------
  // DISPLAY PAGES - writes the page structure to the 
  // simulation transcript.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function void display_page_map;

    svt_mem_sa_inst_display_page_map( inst_handle );

  endfunction


  function int get_formatters( output string formatter_types);

    return svt_mem_sa_get_formatters( formatter_types );

  endfunction


  function int is_formatter( input string formatter_type );

    return svt_mem_sa_get_formatters( formatter_type );

  endfunction


  function int display_formatters();

    return svt_mem_sa_display_formatters();

  endfunction


  //----------------------------------------------------------------------
  // POKE - test bench write data to sparse array instance. Does
  // NOT modify attribute bits.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int poke(
      input  longint unsigned                          addr,
      input  logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      output int                                       status,
      input  longint unsigned                          sim_time );

    return svt_mem_sa_inst_poke4( inst_handle, addr, data, status, sim_time);

  endfunction


  //----------------------------------------------------------------------
  // PEEK - test bench read data from a sparse array instance.
  // Does NOT modify attribute bits.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int peek(
      input  longint unsigned                       addr,
      output logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      output int                                    status,
      input  longint unsigned                       sim_time );

    return svt_mem_sa_inst_peek4( inst_handle, addr, data, status, sim_time);

  endfunction


  //----------------------------------------------------------------------
  // WRITE functions
  //----------------------------------------------------------------------
  function int write(
      input  longint unsigned                     addr,
      input          `SVT_MEM_SA_PHYSICAL_ADDRESS(physical_address),   
      input  logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      output int                                  attrs,
      output int                                  status,
      input  longint unsigned                     sim_time );

    return svt_mem_sa_inst_write4( inst_handle, addr, physical_address, data, attrs, status, sim_time);

  endfunction


  function int write_masked(
      input  longint unsigned                     addr,
      input          `SVT_MEM_SA_PHYSICAL_ADDRESS(physical_address),   
      input  logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      input  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] mask,
      output int                                  attrs,
      output int                                  status,
      input  longint unsigned                     sim_time );

    return svt_mem_sa_inst_write_masked4( inst_handle, addr, physical_address, data, mask, attrs, status, sim_time);

  endfunction


  //----------------------------------------------------------------------
  // READ functions
  //----------------------------------------------------------------------
  function int read(
      input  longint unsigned                     addr,
      input          `SVT_MEM_SA_PHYSICAL_ADDRESS(physical_address),   
      inout  logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      output int                                  attrs,
      output int                                  status,
      input  longint unsigned                     sim_time );

    data = 0;
    return svt_mem_sa_inst_read4( inst_handle, addr, physical_address, data, attrs, status, sim_time);

  endfunction


  //----------------------------------------------------------------------
  // ATTRIBUTE READ/WRITE functions
  //----------------------------------------------------------------------
  function int poke_attributes(
      input  longint unsigned                     addr_lo,
      input  longint unsigned                     addr_hi,
      input  int                                  attrs,
      input  int                                  modes,
      input  longint unsigned                     sim_time );

    return svt_mem_sa_inst_poke_attr( inst_handle, addr_lo, addr_hi, attrs, modes, sim_time );

  endfunction

  function int peek_attributes(
      input  longint unsigned                     addr_lo,
      input  longint unsigned                     addr_hi,
      output int                                  attrs,
      input  int                                  modes );

    return svt_mem_sa_inst_peek_attr( inst_handle, addr_lo, addr_hi, attrs, modes );

  endfunction

  function int set_attr(
      input  longint unsigned                     addr,
      input  int                                  attrs,
      input  longint unsigned                     sim_time );

    return svt_mem_sa_inst_set_attr( inst_handle, addr, attrs, sim_time );

  endfunction

  function int clear_attr(
      input  longint unsigned                     addr,
      input  int                                  attrs,
      input  longint unsigned                     sim_time );

    return svt_mem_sa_inst_clear_attr( inst_handle, addr, attrs, sim_time );

  endfunction

  function int clear_attr_range(
      input  longint unsigned                     addr_lo,
      input  longint unsigned                     addr_hi,
      input  int                                  attrs,
      input  longint unsigned             sim_time );

    return svt_mem_sa_inst_clear_attr_range( inst_handle, addr_lo, addr_hi, attrs, sim_time );

  endfunction

  function int clear_all(
      input  int                                  attrs,
      input  longint unsigned       sim_time );

    return svt_mem_sa_inst_clear_all( inst_handle, attrs, sim_time );

  endfunction

  function int get_attr(
      input  longint unsigned                     addr,
      output int                                  attrs );

    return svt_mem_sa_inst_get_attr( inst_handle, addr, attrs );

  endfunction


  //----------------------------------------------------------------------
  // ATTRIBUTE ALLOC and FREE functions
  //----------------------------------------------------------------------
  function int alloc_attr( input longint unsigned sim_time );

    return svt_mem_sa_inst_alloc_attr_bit( inst_handle, sim_time );

  endfunction


  function int free_attr( input int attr_bit_mask, input longint unsigned sim_time );

    return svt_mem_sa_inst_free_attr_bit( inst_handle, attr_bit_mask, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // UNLOAD functions
  //----------------------------------------------------------------------
  function int unload_all(input longint unsigned sim_time );

    return svt_mem_sa_inst_unload_all( inst_handle, sim_time );

  endfunction


  function int unload( input longint unsigned adr_lo, input longint unsigned adr_hi, input longint unsigned sim_time );

    return svt_mem_sa_inst_unload( inst_handle, adr_lo, adr_hi, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // RESET return this sparse array instance to as-new condition
  //----------------------------------------------------------------------
  function void reset( input longint unsigned sim_time );

    svt_mem_sa_inst_reset( inst_handle, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // PROTECT / UNPROTECT functions - write protect (or unprotect) a range
  // of memory addresses
  //----------------------------------------------------------------------
  function int protect(
      input  longint unsigned addr_lo,
      input  longint unsigned addr_hi,
      output int              status,
      input  longint unsigned sim_time );

    return svt_mem_sa_inst_protect( inst_handle, addr_lo, addr_hi, status, sim_time);

  endfunction

  function int unprotect(
      input  longint unsigned addr_lo,
      input  longint unsigned addr_hi,
      output int              status,
      input  longint unsigned sim_time );

    return svt_mem_sa_inst_unprotect( inst_handle, addr_lo, addr_hi, status, sim_time);

  endfunction

  //----------------------------------------------------------------------
  // LOAD/DUMP functions
  //----------------------------------------------------------------------
  function int load(
      input  string           filename,
      input  int              modes,
      input  longint unsigned addr_lo,
      input  longint unsigned addr_hi,
      input  longint unsigned src_addr_lo,
      input  longint unsigned src_addr_hi,
      output int              status,
      input  longint unsigned sim_time );

    return svt_mem_sa_inst_load( inst_handle, filename, modes, addr_lo, addr_hi, src_addr_lo, src_addr_hi, status, sim_time);

  endfunction


  function int get_words_loaded();

    return svt_mem_sa_inst_get_words_loaded( inst_handle );

  endfunction


  function int compare(
      input  string           filename,
      input  int              modes,
      output int              num_errors,
      input  int              max_errors,
      output int              status );

    return svt_mem_sa_inst_compare( inst_handle, filename, modes, num_errors, max_errors, status );

  endfunction


  function int compare_range(
      input  string           filename,
      input  longint unsigned addr_lo,
      input  longint unsigned addr_hi,
      input  longint unsigned src_addr_lo,
      input  longint unsigned src_addr_hi,
      input  int              modes,
      output int              num_errors,
      input  int              max_errors,
      output int              status );

    return svt_mem_sa_inst_compare_range( inst_handle, filename, addr_lo, addr_hi, src_addr_lo, src_addr_hi, modes, num_errors, max_errors, status );

  endfunction


  function int get_compare_error(
      output int                                  error_type,
      output longint unsigned                     addr,
      output logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] mem_data,
      output logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] file_data );

    return svt_mem_sa_inst_get_compare_error4( inst_handle, error_type, addr, mem_data, file_data );

  endfunction


  function int dump(
      input  string           filename,
      input  string           filetype,
      input  int              modes,
      input  longint unsigned addr_lo,
      input  longint unsigned addr_hi,
      input  longint unsigned src_addr_lo,
      input  longint unsigned src_addr_hi,
      output int              status );

    return svt_mem_sa_inst_dump( inst_handle, filename, filetype, modes, addr_lo, addr_hi, src_addr_lo, src_addr_hi, status );

  endfunction


  //---------------------------------------------------------------------
  // WIDTH functions
  //----------------------------------------------------------------------
  function int get_addr_width();

    return svt_mem_sa_inst_get_addr_width( inst_handle );

  endfunction

  function int get_nb_phys_dimensions();

    return svt_mem_sa_inst_get_nb_phys_dimensions( inst_handle );

  endfunction

  function int get_data_width();

    return svt_mem_sa_inst_get_data_width( inst_handle );

  endfunction

  function int get_attr_width();

    return svt_mem_sa_inst_get_attr_width( inst_handle );

  endfunction

  function int get_inst_modes();

    return svt_mem_sa_inst_get_inst_modes( inst_handle );

  endfunction


  function string get_load_file_name();

    string load_file_name;
    svt_mem_sa_inst_get_load_file_name( inst_handle, load_file_name );
    return load_file_name;

  endfunction


  function int get_native_page_size();

    return svt_mem_sa_inst_get_native_page_size( inst_handle );

  endfunction

  function int get_default_page_size();

    return svt_mem_sa_inst_get_default_page_size( inst_handle );

  endfunction


  //----------------------------------------------------------------------
  // OPTIMIZE functions
  //----------------------------------------------------------------------
  function int optimize();

    return svt_mem_sa_inst_optimize( inst_handle );

  endfunction


  //----------------------------------------------------------------------
  // WRITE PROTECT functions
  //----------------------------------------------------------------------

  function int get_write_protect_attr();

    return `SVT_MEM_ATTRIBUTE_WR_PROT;

  endfunction



  //----------------------------------------------------------------------
  // ACCESS LOCK functions
  //----------------------------------------------------------------------
  function int start_access(
    input  int                                  mode,
    input  longint unsigned                     addr,
    input  longint unsigned                     access_length,
    output int                                  status,
    input  longint unsigned     sim_time );

    return svt_mem_sa_inst_start_access( inst_handle, mode, addr, access_length, status, sim_time);

  endfunction


  function int end_access(
    input  longint unsigned                     lock_addr,
    output longint unsigned                     actual_access_length,
    output int                                  status,
    input  longint unsigned           sim_time );

    int  rc;

    return svt_mem_sa_inst_end_access( inst_handle, lock_addr, actual_access_length, status, sim_time);

  endfunction


  function int get_access_lock_status();

    return svt_mem_sa_inst_get_access_lock_status( inst_handle );

  endfunction


  function int get_access_lock_attr();

    return `SVT_MEM_ATTRIBUTE_ACC_LOCK;

  endfunction


  //----------------------------------------------------------------------
  // ERROR CHECK enable functions
  //----------------------------------------------------------------------

  function int unsigned get_checks();

    return svt_mem_sa_inst_get_checks( inst_handle );

  endfunction


  function void set_checks( input int unsigned enables, input  longint unsigned sim_time );

    svt_mem_sa_inst_set_checks( inst_handle, enables, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // DISABLE MSG function - DISABLES type of message generation
  // FOR DEBUG USE
  //----------------------------------------------------------------------
  function void set_msg_disables( input int mask );

    svt_mem_sa_inst_set_msg_disables( inst_handle, mask );

  endfunction


  //----------------------------------------------------------------------
  // READ ONLY state functions
  //----------------------------------------------------------------------
  function int is_read_only();

    return svt_mem_sa_inst_is_read_only( inst_handle );

  endfunction

  function void set_read_only( input int read_only, input longint unsigned sim_time );

    svt_mem_sa_inst_set_read_only( inst_handle, read_only, sim_time );

  endfunction



  //----------------------------------------------------------------------
  // PROTOCOL ANALYZER functions
  //----------------------------------------------------------------------
  function int enable_pa_history_collection( input string filename );

    return svt_mem_sa_inst_enable_pa_history_collection( inst_handle, filename );

  endfunction

  function void close_pa_history_file( int delete_xml_file );

    svt_mem_sa_inst_close_pa_history_file( inst_handle, delete_xml_file );

  endfunction


  //----------------------------------------------------------------------
  // CREATE PATTERN - creates an algorithmic data pattern generator
  //
  // Priority levels -  0 is highest priority
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int create_pattern(
    input  svt_mem_sa_patspec  pat_spec,   // pattern specifier
    input  logic [`SVT_MEM_MAX_DATA_WIDTH-1:0]  base_data,   // pattern base data 
    output int                 pat_id,     // pattern identifier
    input  longint unsigned    sim_time ); // simulation time

    return svt_mem_sa_inst_create_pattern( inst_handle, pat_spec, base_data, pat_id, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // REMOVE PATTERN - remove a pattern generator
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int remove_pattern( input  int pattern_id, input longint unsigned sim_time );

    return svt_mem_sa_inst_remove_pattern( inst_handle, pattern_id, sim_time );

  endfunction


  //----------------------------------------------------------------------
  // GET PATTERN DATA - remove a pattern generator
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int get_pattern_data( input  int              pattern_id,
                                 input  longint unsigned adr,
                                 output bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data );  // patterns are 2-state!

    data = `SVT_MEM_MAX_DATA_WIDTH'h0;

    return svt_mem_sa_inst_get_pattern_data( inst_handle, pattern_id, adr, data );

  endfunction


  //----------------------------------------------------------------------
  // SHOW PATTERN - print pattern parameters
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int show_pattern( input  int pattern_id );

    return svt_mem_sa_inst_show_pattern( inst_handle, pattern_id );

  endfunction




  //----------------------------------------------------------------------
  // CREATE BREAKPOINT - creates a breakpoint using the supplied 
  // breakspec struct.
  //
  // Returns 0 if successful.
  //        <0 error code.
  //----------------------------------------------------------------------
  function int create_breakpoint(
    input  svt_mem_sa_breakspec                 spec,
    input  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
    input  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data_hi,
    input  bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] data_mask,
    input  string                               text_msg,
    output int                                  break_id );  // unique breakpoint identifier

    return svt_mem_sa_inst_create_breakpoint( inst_handle, spec, data, data_hi, data_mask, text_msg, break_id );

  endfunction


  //----------------------------------------------------------------------
  // REMOVE BREAKPOINT - removes the breakpoint identified by the provided
  // breakpoint id number.
  //
  // Return 0 if OK or <0 if error occurred
  //----------------------------------------------------------------------
  function int remove_breakpoint( input  int break_id );

    return svt_mem_sa_inst_remove_breakpoint( inst_handle, break_id );

  endfunction


  //----------------------------------------------------------------------
  // BREAKPOINT ENABLE functions
  //
  //----------------------------------------------------------------------
  function int enable_breakpoint( input  int break_id );

    return svt_mem_sa_inst_enable_breakpoint( inst_handle, break_id );

  endfunction

  function int disable_breakpoint( input  int break_id );

    return svt_mem_sa_inst_disable_breakpoint( inst_handle, break_id );

  endfunction

  function int is_breakpoint_enabled( input int break_id, output int enabled );

    return svt_mem_sa_inst_is_breakpoint_enabled( inst_handle, break_id, enabled );

  endfunction


  //----------------------------------------------------------------------
  // ITERATOR NEXT functions
  //
  //----------------------------------------------------------------------

  //
  // Advance 'adr' to the address of the next memory location that has
  // been written or initialized.
  //
  // Returns 1 if another occupied address was found <= limit_adr
  //         0 if next occupied address was not found
  //
  function int next_occupied( input  longint unsigned adr,
                              input  longint unsigned limit_adr,
                              output longint unsigned next_adr );

    return svt_mem_sa_inst_next_occupied( inst_handle, adr, limit_adr, next_adr );

  endfunction

  //
  // Advance 'adr' to the address of the next memory location with matching
  // attribute bits.
  //
  // Looks for:    (mem.attrs & mask) == (attrs & mask)
  //
  // Returns 1 if another occupied address was found <= limit_adr
  //         0 if next occupied address was not found
  //
  function int next_attr( input  longint unsigned adr,
                          input  int unsigned     attrs,
                          input  int unsigned     mask,
                          input  longint unsigned limit_adr,
                          output longint unsigned next_adr );

    return svt_mem_sa_inst_next_attr( inst_handle, adr, attrs, mask, limit_adr, next_adr );

  endfunction

  //----------------------------------------------------------------------
  // Enable data width aligned address feature
  //----------------------------------------------------------------------
  function void enable_dwidth_aligned_addr();
    svt_mem_sa_enable_dwidth_aligned_addr(inst_handle);
  endfunction

endclass : svt_mem_sa_core_4state




//======================================================================
//======================================================================
//
// svt_mem_backdoor_4state class -- "backdoor" interface for
// use by models
//
//======================================================================
//======================================================================

class svt_mem_backdoor_4state extends svt_mem_sa_core_4state ;


  //----------------------------------------------------------------------
  // NEW - create a new sparse array instance
  //----------------------------------------------------------------------
  function new( input string name );

    super.new( name, 0, 0, 0, 0, 0, 0, "" );

  endfunction


  //----------------------------------------------------------------------
  // IS CONNECTED - if true, this backdoor connected successfully to 
  // a sparse array instance.
  //----------------------------------------------------------------------
  function int is_connected;

    return super.valid_instance;

  endfunction


  //----------------------------------------------------------------------
  // COPY - create a copy of a sparse array
  //----------------------------------------------------------------------
  function int copy( input svt_mem_sa_core_4state src,
                     input longint unsigned       dest_adr,
                     input longint unsigned       src_adr,
                     input longint unsigned       length,
                     input longint unsigned       sim_time );

    return svt_mem_sa_inst_copy( inst_handle, src.get_inst_handle(), dest_adr, src_adr, length, sim_time );

  endfunction

endclass : svt_mem_backdoor_4state

`endif // GUARD_SVT_MEM_SA_CORE_4state_SV
