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
`ifndef GUARD_SVT_MEM_CORE_ITER_SV
`define GUARD_SVT_MEM_CORE_ITER_SV 1

//----------------------------------------------------------------------
// 
// S P A R S E   A R R A Y   I T E R A T O R
//
//----------------------------------------------------------------------

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_mem_sa_dpi)

//======================================================================
//======================================================================
//
// svt_mem_core_iter class -- "iterator" interface for use by models
// or the backdoor
//
//======================================================================
//======================================================================

class svt_mem_core_iter;

  longint unsigned   iter_adr;
  longint unsigned   iter_adr_lo;
  longint unsigned   iter_adr_hi;
  int                iter_adr_width;
  longint unsigned   iter_adr_mask;

  chandle inst_handle;    // pointer to C++ sparse array class instance


  //----------------------------------------------------------------------
  // ITERATOR - NEW
  // the iteration address range.
  //----------------------------------------------------------------------
  function new( input chandle instp, longint unsigned lo, longint unsigned hi );
    inst_handle = instp;

    iter_adr_width = svt_mem_sa_inst_get_addr_width( inst_handle ); 
    iter_adr_mask = ~(-1 << iter_adr_width);

//  $display("NEW: adr_width=%0d adr_mask=%0h", iter_adr_width, iter_adr_mask );
    set_range( lo & iter_adr_mask, hi & iter_adr_mask );
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - RESET - set the current address to the beginning of the
  // the iteration address range.
  //----------------------------------------------------------------------
  function void reset;
    iter_adr = iter_adr_lo;
//  $display( "RESET: iter_adr=%0h", iter_adr );
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - SET RANGE - set the iteration adr range
  //----------------------------------------------------------------------
  function void set_range( longint unsigned adr_lo, longint unsigned adr_hi );
    iter_adr_lo = adr_lo;
    iter_adr_hi = adr_hi;
    iter_adr = iter_adr_lo;
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - BEGIN ADDR - return the starting iteration address.
  //----------------------------------------------------------------------
  function longint unsigned begin_addr;
    return iter_adr_lo;
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - END ADDR - return the ending iteration address.
  //----------------------------------------------------------------------
  function longint unsigned end_addr;
    return iter_adr_hi;
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - ADDR - get the current iteration address
  //----------------------------------------------------------------------
  function longint unsigned addr;
//  $display( "ADDR: iter_adr=%0h", iter_adr );
    return iter_adr;
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - GET DATA - get data from the current iteration address
  //----------------------------------------------------------------------
  function int get_data( 
      output logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
      output int                                    status );
    return svt_mem_sa_inst_peek4( inst_handle, iter_adr, data, status );
  endfunction
    

  //----------------------------------------------------------------------
  // ITERATOR - GET ATTRS - get attributes for the current iteration address
  //----------------------------------------------------------------------
  function int get_attrs( output int unsigned attrs );
    return svt_mem_sa_inst_get_attr( inst_handle, iter_adr, attrs );
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - PUT DATA - write data to the current iteration address
  //----------------------------------------------------------------------
//function int put_data( 
//    input  @VECTOR@ [`SVT_MEM_MAX_DATA_WIDTH-1:0] data,
//    output int status );
//  return svt_mem_sa_inst_pokeead@FOURSTATESUFFIX@( inst_handle, iter_adr, data, attrs, status );
//endfunction


  //----------------------------------------------------------------------
  // ITERATOR - NEXT - advance the iteration address to the next address
  // Returns 1 if the next address is within the iteration range
  //      or 0 if the next address is outside the iteration range
  //----------------------------------------------------------------------
  function longint unsigned next;
//  $display( "NEXT: iter_adr=%0h  in  %0h to %0h", iter_adr, iter_adr_lo, iter_adr_hi );
    if (iter_adr >= iter_adr_hi)
      return 0;
    iter_adr += 1;
    return 1;           // next address within iter adr range
  endfunction


  //----------------------------------------------------------------------
  // ITERATOR - NEXT WRITTEN - advance the iteration address to the next
  // written memory location.
  // Returns 1 if another written location is found and within the
  //           iteration range
  //      or 0 if another written location is not found or outside the
  //           iteration range
  //----------------------------------------------------------------------
  function int next_written;

    longint unsigned adr;
    
    if (iter_adr < iter_adr_hi)
      begin
      //if (svt_mem_sa_inst_next_occupied( inst_handle, iter_adr, iter_adr_lo, iter_adr_hi, adr ))
      if (svt_mem_sa_inst_next_occupied( inst_handle, iter_adr, iter_adr_hi, adr ))
        begin
        iter_adr = adr;
        return 1;         // found another written location within the memory range
        end
      end
    return 0;             // no more written locations within the memory range

  endfunction
    

  //----------------------------------------------------------------------
  // ITERATOR - NEXT ATTR - advance the iteration address to the next
  // memory location with the specified attribute bit(s).
  //
  // Returns 1 if another written location is found and within the
  //           iteration range
  //      or 0 if another written location is not found or outside the
  //           iteration range
  //----------------------------------------------------------------------
  function int next_attrs(
      input  int unsigned                           attrs,
      input  int unsigned                           attrs_mask );

    longint unsigned adr;
    
    if (iter_adr < iter_adr_hi)
      begin
      if (svt_mem_sa_inst_next_attr( inst_handle, iter_adr, attrs, attrs_mask, iter_adr_hi, adr ))
        begin
        iter_adr = adr;
        return 1;         // found another location with matching attrs in the address range
        end
      end

    return 0;             // no more written locations within the memory range

  endfunction
    
endclass : svt_mem_core_iter

`endif

