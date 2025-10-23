//=======================================================================
// COPYRIGHT (C) 2014-2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_TYPES_SV
`define GUARD_SVT_TYPES_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_cmd_defines)
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// ****************************************************************************
//   Memory Typedefs
// ****************************************************************************

/** Generic memory address type */
typedef bit [`SVT_MEM_MAX_ADDR_WIDTH-1:0] svt_mem_addr_t;

/** Generic memory data type */
`ifdef SVT_MEM_LOGIC_DATA
typedef logic [`SVT_MEM_MAX_DATA_WIDTH-1:0] svt_mem_data_t;
`else
typedef bit [`SVT_MEM_MAX_DATA_WIDTH-1:0] svt_mem_data_t;
`endif

/** Generic memory attribute type */
typedef bit [`SVT_MEM_MAX_ATTR_WIDTH-1:0] svt_mem_attr_t;

/** Data type for the GPIO data signals */
typedef logic [63:0] svt_gpio_data_t;

// =============================================================================
/**
 * This class is a place where enumerated types commonly used by different
 * SVT Classes are collected. The usage model is that any class that wants
 * to use the svt_types provided enumerations must reference the type of interest
 * using a class-scoped type reference. Note that it is not necessary to create
 * an instance of this class. Simply including this class in the compile is
 * sufficient.
 */
class svt_types;

  /**
   * Values that specify unique methodology independent messaging levels.
   */
  typedef enum {
    FATAL       = `SVT_CMD_FATAL_SEVERITY,    /**< Severity representing a FATAL situation. */
    ERROR       = `SVT_CMD_ERROR_SEVERITY,    /**< Severity representing a ERROR situation. */
    WARNING     = `SVT_CMD_WARNING_SEVERITY,  /**< Severity representing a WARNING situation. */
    NORMAL      = `SVT_CMD_NORMAL_SEVERITY,   /**< Severity representing a NORMAL situation. */
    TRACE       = `SVT_CMD_TRACE_SEVERITY,    /**< Severity representing a TRACE situation. */
    DEBUG       = `SVT_CMD_DEBUG_SEVERITY,    /**< Severity representing a DEBUG situation. */
    VERBOSE     = `SVT_CMD_VERBOSE_SEVERITY   /**< Severity representing a VERBOSE situation. */
  } severity_enum;

  /**
   * Different timeunit values.
   */
  typedef enum {
    TU_UNKNOWN   = `SVT_TIMEUNIT_UNKNOWN, /**< Indicates that the timeunit is an unknown value. */
    TU_1_FS      = `SVT_TIMEUNIT_1_FS,    /**< Value corresponding to a timeunit of 1fs. */
    TU_10_FS     = `SVT_TIMEUNIT_10_FS,   /**< Value corresponding to a timeunit of 10fs. */
    TU_100_FS    = `SVT_TIMEUNIT_100_FS,  /**< Value corresponding to a timeunit of 100fs. */
    TU_1_PS      = `SVT_TIMEUNIT_1_PS,    /**< Value corresponding to a timeunit of 1ps. */
    TU_10_PS     = `SVT_TIMEUNIT_10_PS,   /**< Value corresponding to a timeunit of 10ps. */
    TU_100_PS    = `SVT_TIMEUNIT_100_PS,  /**< Value corresponding to a timeunit of 100ps. */
    TU_1_NS      = `SVT_TIMEUNIT_1_NS,    /**< Value corresponding to a timeunit of 1ns. */
    TU_10_NS     = `SVT_TIMEUNIT_10_NS,   /**< Value corresponding to a timeunit of 10ns. */
    TU_100_NS    = `SVT_TIMEUNIT_100_NS,  /**< Value corresponding to a timeunit of 100ns. */
    TU_1_US      = `SVT_TIMEUNIT_1_US,    /**< Value corresponding to a timeunit of 1us. */
    TU_10_US     = `SVT_TIMEUNIT_10_US,   /**< Value corresponding to a timeunit of 10us. */
    TU_100_US    = `SVT_TIMEUNIT_100_US,  /**< Value corresponding to a timeunit of 100us. */
    TU_1_MS      = `SVT_TIMEUNIT_1_MS,    /**< Value corresponding to a timeunit of 1ms. */
    TU_10_MS     = `SVT_TIMEUNIT_10_MS,   /**< Value corresponding to a timeunit of 10ms. */
    TU_100_MS    = `SVT_TIMEUNIT_100_MS,  /**< Value corresponding to a timeunit of 100ms. */
    TU_1_S       = `SVT_TIMEUNIT_1_S,     /**< Value corresponding to a timeunit of 1s. */
    TU_10_S      = `SVT_TIMEUNIT_10_S,    /**< Value corresponding to a timeunit of 10s. */
    TU_100_S     = `SVT_TIMEUNIT_100_S    /**< Value corresponding to a timeunit of 100s. */
  } timeunit_enum;

  /**
   * Static array used to simplify conversion from timeunit enum to 'short' timeunit value.
   * Implementation note: This was originally constructed as an associative array mapping
   * directly from the timeunit enum values to the short strings. But due to simulator
   * limitations (i.e., vcs_2012.09 and prior have problems, vcs_2012.09-SP1 and later
   * do not) this is setup as an associative array mapping from the timeunit constants
   * to the short strings.
   */
  static string short_timeunit_str[int] = '{
    `SVT_TIMEUNIT_UNKNOWN : "UNKNOWN",
    `SVT_TIMEUNIT_1_FS    : "1fs",
    `SVT_TIMEUNIT_10_FS   : "10fs",
    `SVT_TIMEUNIT_100_FS  : "100fs",
    `SVT_TIMEUNIT_1_PS    : "1ps",
    `SVT_TIMEUNIT_10_PS   : "10ps",
    `SVT_TIMEUNIT_100_PS  : "100ps",
    `SVT_TIMEUNIT_1_NS    : "1ns",
    `SVT_TIMEUNIT_10_NS   : "10ns",
    `SVT_TIMEUNIT_100_NS  : "100ns",
    `SVT_TIMEUNIT_1_US    : "1us",
    `SVT_TIMEUNIT_10_US   : "10us",
    `SVT_TIMEUNIT_100_US  : "100us",
    `SVT_TIMEUNIT_1_MS    : "1ms",
    `SVT_TIMEUNIT_10_MS   : "10ms",
    `SVT_TIMEUNIT_100_MS  : "100ms",
    `SVT_TIMEUNIT_1_S     : "1s",
    `SVT_TIMEUNIT_10_S    : "10s",
    `SVT_TIMEUNIT_100_S   : "100s"
  };

endclass

//=======================================================================

`protected
C]\M0>If3U1AQ<X3(HISA8S9Q39.Q8,[;VZTU)fU6NF7^P&I\7^a0)H>B-g]AX6H
./;X5\KCCLUA,$
`endprotected
 

`endif // GUARD_SVT_TYPES_SV
