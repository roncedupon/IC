//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_MEM_CATALOG_SV
`define GUARD_SVT_MEM_CATALOG_SV

/**
 * Default values for specifying memory part depths
 */
typedef enum {
              SVT_MEM_2Kb    = `SVT_MEM_DEPTH_2KB,
              SVT_MEM_4Kb    = `SVT_MEM_DEPTH_4KB,
              SVT_MEM_8Kb    = `SVT_MEM_DEPTH_8KB,
              SVT_MEM_16Kb   = `SVT_MEM_DEPTH_16KB,
              SVT_MEM_32Kb   = `SVT_MEM_DEPTH_32KB,
              SVT_MEM_64Kb   = `SVT_MEM_DEPTH_64KB,
              SVT_MEM_128Kb  = `SVT_MEM_DEPTH_128KB,
              SVT_MEM_256Kb  = `SVT_MEM_DEPTH_256KB,
              SVT_MEM_512Kb  = `SVT_MEM_DEPTH_512KB,
              SVT_MEM_1Mb    = `SVT_MEM_DEPTH_1MB,
              SVT_MEM_2Mb    = `SVT_MEM_DEPTH_2MB,
              SVT_MEM_4Mb    = `SVT_MEM_DEPTH_4MB,
              SVT_MEM_8Mb    = `SVT_MEM_DEPTH_8MB,
              SVT_MEM_16Mb   = `SVT_MEM_DEPTH_16MB,
              SVT_MEM_24Mb   = `SVT_MEM_DEPTH_24MB,
              SVT_MEM_32Mb   = `SVT_MEM_DEPTH_32MB,
              SVT_MEM_48Mb   = `SVT_MEM_DEPTH_48MB,
              SVT_MEM_64Mb   = `SVT_MEM_DEPTH_64MB,
              SVT_MEM_128Mb  = `SVT_MEM_DEPTH_128MB,
              SVT_MEM_192Mb  = `SVT_MEM_DEPTH_192MB,
              SVT_MEM_256Mb  = `SVT_MEM_DEPTH_256MB,
              SVT_MEM_384Mb  = `SVT_MEM_DEPTH_384MB,
              SVT_MEM_512Mb  = `SVT_MEM_DEPTH_512MB,
              SVT_MEM_768Mb  = `SVT_MEM_DEPTH_768MB,
              SVT_MEM_1536Mb = `SVT_MEM_DEPTH_1536MB,
              SVT_MEM_1Gb    = `SVT_MEM_DEPTH_1GB,
              SVT_MEM_2Gb    = `SVT_MEM_DEPTH_2GB,
              SVT_MEM_3Gb    = `SVT_MEM_DEPTH_3GB,
              SVT_MEM_4Gb    = `SVT_MEM_DEPTH_4GB,
              SVT_MEM_6Gb    = `SVT_MEM_DEPTH_6GB,
              SVT_MEM_8Gb    = `SVT_MEM_DEPTH_8GB,
              SVT_MEM_9Gb    = `SVT_MEM_DEPTH_9GB,
              SVT_MEM_12Gb   = `SVT_MEM_DEPTH_12GB,
              SVT_MEM_16Gb   = `SVT_MEM_DEPTH_16GB,
              SVT_MEM_24Gb   = `SVT_MEM_DEPTH_24GB,
              SVT_MEM_32Gb   = `SVT_MEM_DEPTH_32GB,
              SVT_MEM_48Gb   = `SVT_MEM_DEPTH_48GB,
              SVT_MEM_64Gb   = `SVT_MEM_DEPTH_64GB,
              SVT_MEM_96Gb   = `SVT_MEM_DEPTH_96GB,
              SVT_MEM_128Gb  = `SVT_MEM_DEPTH_128GB,
              SVT_MEM_192Gb  = `SVT_MEM_DEPTH_192GB,
              SVT_MEM_256Gb  = `SVT_MEM_DEPTH_256GB } svt_mem_depth_t;

/**
 * Default values for specifying memory part widths
 */
typedef enum {SVT_MEM_x1   = 1,
              SVT_MEM_x2   = 2,
              SVT_MEM_x4   = 4,
              SVT_MEM_x8   = 8,
              SVT_MEM_x16  = 16,
              SVT_MEM_x32  = 32,
              SVT_MEM_x64  = 64,
              SVT_MEM_x128 = 128,
              SVT_MEM_x256 = 256,
              SVT_MEM_x512 = 512,
              SVT_MEM_x1k  = 1024} svt_mem_width_t;

/**
 * Default values for specying a part clock rate
 */
typedef enum {
              SVT_MEM_20MHz   = 20,
              SVT_MEM_25MHz   = 25,
              SVT_MEM_30MHz   = 30,
              SVT_MEM_33MHz   = 33,
              SVT_MEM_40MHz   = 40,
              SVT_MEM_50MHz   = 50,
              SVT_MEM_66MHz   = 66,
              SVT_MEM_67MHz   = 67,
              SVT_MEM_75MHz   = 75,
              SVT_MEM_80MHz   = 80,
              SVT_MEM_84MHz   = 84,
              SVT_MEM_85MHz   = 85,
              SVT_MEM_86MHz   = 86,
              SVT_MEM_100MHz  = 100,
              SVT_MEM_104MHz  = 104,
              SVT_MEM_108MHz  = 108,
              SVT_MEM_133MHz  = 133,
              SVT_MEM_144MHz  = 144,
              SVT_MEM_150MHz  = 150,
              SVT_MEM_166MHz  = 166,
              SVT_MEM_200MHz  = 200,
              SVT_MEM_266MHz  = 266,
              SVT_MEM_267MHz  = 267,
              SVT_MEM_300MHz  = 300,
              SVT_MEM_350MHz  = 350,
              SVT_MEM_333MHz  = 333,
              SVT_MEM_344MHz  = 344,
              SVT_MEM_400MHz  = 400,
              SVT_MEM_466MHz  = 466,
              SVT_MEM_467MHz  = 467,
              SVT_MEM_500MHz  = 500,
              SVT_MEM_533MHz  = 533,
              SVT_MEM_600MHz  = 600,
              SVT_MEM_667MHz  = 667,
              SVT_MEM_688MHz  = 688,
              SVT_MEM_700MHz  = 700,
              SVT_MEM_733MHz  = 733,
              SVT_MEM_750MHz  = 750,
              SVT_MEM_800MHz  = 800,
              SVT_MEM_900MHz  = 900,
              SVT_MEM_933MHz  = 933,
              SVT_MEM_938MHz  = 938,
              SVT_MEM_1000MHz = 1000,
              SVT_MEM_1066MHz = 1066,
              SVT_MEM_1100MHz = 1100,
              SVT_MEM_1200MHz = 1200,
              SVT_MEM_1250MHz = 1250,
              SVT_MEM_1300MHz = 1300,
              SVT_MEM_1333MHz = 1333,
              SVT_MEM_1375MHz = 1375,
              SVT_MEM_1400MHz = 1400,
              SVT_MEM_1466MHz = 1466,
              SVT_MEM_1500MHz = 1500,
              SVT_MEM_1600MHz = 1600,
              SVT_MEM_1700MHz = 1700,
              SVT_MEM_1750MHz = 1750,
              SVT_MEM_1800MHz = 1800,
              SVT_MEM_1866MHz = 1866,
              SVT_MEM_2000MHz = 2000,
              SVT_MEM_2133MHz = 2133,
              SVT_MEM_2200MHz = 2200,
              SVT_MEM_2400MHz = 2400,
              SVT_MEM_2500MHz = 2500,
              SVT_MEM_2600MHz = 2600,
              SVT_MEM_2667MHz = 2667,
              SVT_MEM_2800MHz = 2800,
              SVT_MEM_2900MHz = 2900,
              SVT_MEM_3000MHz = 3000,
              SVT_MEM_3200MHz = 3200 } svt_mem_clkrate_t;

typedef class svt_mem_vendor_catalog_base;

           
/**
 * Base class for the default part catalog entry.
 */
virtual class svt_mem_vendor_part_base;

  local string            m_number;
  local string            m_descr;
  local svt_mem_depth_t   m_depth;
  local svt_mem_width_t   m_width;
  local svt_mem_clkrate_t m_clkrate;
  local string            m_cfgfile;

  local svt_mem_vendor_catalog_base m_catalog;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log used if no log is provided to class constructor. */
  protected static vmm_log log = new("svt_mem_vendor_part_base", "class");
`else
  /** Shared reporter used if no reporter is provided to class constructor. */
  protected static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_vendor_part_base:class");
`endif

  function new(svt_mem_vendor_catalog_base catalog,
               string                      number,
               string                      descr,
               svt_mem_depth_t             depth,
               svt_mem_width_t             width,
               svt_mem_clkrate_t           clkrate,
               string                      cfgfile);
    m_number  = number;
    m_descr   = descr;
    m_depth   = depth;
    m_width   = width;
    m_clkrate = clkrate;
    m_cfgfile = cfgfile;
  endfunction

  
  pure virtual function string get_dwhome();

  virtual function void write();
    $write("%s %s (%s) : %sx%0d, %0dMHz (%s)", get_vendor_name(), m_number,
           m_descr, get_depth_desc(), m_width, m_clkrate, m_cfgfile);
  endfunction

  /** Set the vendor catalog this part is in */
  function void set_catalog(svt_mem_vendor_catalog_base catalog);
    if (m_catalog != null) m_catalog.remove_part(this);
    m_catalog = catalog;
    if (catalog != null) void'(catalog.add_part(this));
  endfunction

  /** Return the vendor catalog this part is in */
  function svt_mem_vendor_catalog_base get_catalog();
    return m_catalog;
  endfunction

  /** Return the name of the vendor for the part */
  virtual function string get_vendor_name();
    if (m_catalog == null) return "<Unknown>";
    return m_catalog.get_vendor_name();
  endfunction


  /** Return the name/number for the part */
  function string get_part_number();
    return m_number;
  endfunction

  /** Return the description of the part */
  function string get_descr();
    return m_descr;
  endfunction

  /** Return the depth of the part */
  function svt_mem_depth_t get_depth();
    return m_depth;
  endfunction

  /** Return the depth in string format */
  function string get_depth_desc();
    string depth;
    depth = m_depth.name;
    get_depth_desc = depth.substr(8, depth.len()-1);
  endfunction

  /** Return the width of the part */
  function svt_mem_width_t get_width();
    return m_width;
  endfunction

  /** Return the clock rate of the part */
  function svt_mem_clkrate_t get_clkrate();
    return m_clkrate;
  endfunction

  /** Return the cfgfile value provided for this part at construction */
  function string get_cfgfile_path();
    return m_cfgfile;
  endfunction

  /** Return '1' if substring found in cfgfile_path, else 0 */
  function bit match_cfgfile_path(string regex);
     
`ifdef SVT_UVM_TECHNOLOGY
    match_cfgfile_path = !uvm_re_match(regex, m_cfgfile);
`elsif SVT_OVM_TECHNOLOGY
    match_cfgfile_path = ovm_is_match(regex, m_cfgfile);
`else
    match_cfgfile_path = `vmm_str_match(m_cfgfile, regex);
`endif

  endfunction

  /** Find the CFG file for this part
   *  First look into VIP installation directory
   *  then in the colon-separated search path list specified
   *  using the +SVT_MEM_USER_CFG_PATH= command-line argument.
   */
  function string get_cfgfile();
    string paths;
    string cfgfile_full_name = "";

    `svt_debug("get_cfgfile", $sformatf("Entered, m_cfgfile = '%0s'.", m_cfgfile));

    if (m_catalog == null) return "";
    
    // Look in the VIP installation first
    paths = {get_dwhome(), "/catalog"};
    begin
      string arg;
      if ($value$plusargs("SVT_MEM_USER_CFG_PATH=%s", arg)) begin
        // The user catalog should take precedence
        paths = {arg, ":", paths};
      end
    end

    `svt_debug("get_cfgfile", $sformatf("Searching for cfgfile using m_cfgfile = '%0s', paths = '%0s'.", m_cfgfile, paths));
    cfgfile_full_name = svt_mem_find_file(m_cfgfile, paths);

    if (cfgfile_full_name.len() == 0) begin
      `svt_fatal("get_cfgfile", $sformatf("Failed attempting to find 'cfgfile_full_name' in catalog based on m_cfgfile = '%0s', paths = '%s'.", m_cfgfile, paths));
    end

    return cfgfile_full_name;
  endfunction
endclass


/**
 * Default part catalog entry.
 * If additional or different part selection criteria are required
 * for a specific suite, they should be added in a derived class.
 * It must be specialized with a policy class the contains
 * a static "\#get()" method returning the
 * full path to the installation directory of the suite.
 */
class svt_mem_vendor_part#(type DWHOME=int) extends svt_mem_vendor_part_base;

  typedef svt_mem_vendor_part#(DWHOME) this_type;
  
  function new(svt_mem_vendor_catalog_base catalog,
               string                      number,
               string                      descr,
               svt_mem_depth_t             depth,
               svt_mem_width_t             width,
               svt_mem_clkrate_t           clkrate,
               string                      cfgfile);
    super.new(catalog, number, descr, depth, width, clkrate, cfgfile);
    set_catalog(catalog);
  endfunction

  virtual function string get_dwhome();
    return DWHOME::get();
  endfunction

  /**
   * Parse a line to see if it is a metadata line
   *  and, if so, return the contained tag and value.
   */
  static local function bit is_metadata_line(input  string line,
                                             output string tag,
                                             output string value);
    int i, j, k;

    // Skip leading blanks
    i = 0;
    while (i < line.len() && (line[i] == " " || line[i] == "\t")) i++;
    if (i >= line.len()) return 0;
    
    // Must be a "//" or "#" comment line
    if (line[i] == "/" && line[i+1] == "/") i = i + 2;
    else if (line[i] == "#" ) i = i + 1;
    else return 0;

    // Skip blanks again
    while (i < line.len() && (line[i] == " " || line[i] == "\t")) i++;
    if (i >= line.len()) return 0;

    // Tag ends with a ':'
    j = i+1;
    while (j < line.len() && line[j] != ":") j++;
    if (j >= line.len()) return 0;
    k = j+1;

    // Strip trailing blanks from tag
    j--;
    while (j >= i && (line[j] == " " || line[j] == "\t")) j--;
    if (j < i) return 0;

    tag = line.substr(i, j);
    
    // Skip blanks again
    while (k < line.len() && (line[k] == " " || line[k] == "\t")) k++;
    if (k >= line.len()) return 0;

    // Strip trailing blanks from value
    j = line.len() - 1;
    while (j >= k && (line[j] == " " || line[j] == "\t" || line[j] == "\n")) j--;
    if (j < k) return 0;

    value = line.substr(k, j);

    return 1;
  endfunction

  /** Parse the specified file and add the part it describes in the
   *  specified catalog.
   *  Returns TRUE if the operation was succesful.
   *  Returns FALSE if the format was invalid or incomplete.
   */
  static function this_type create_from_file(string                      fname,
                                             string                      partnum,
                                             svt_mem_vendor_catalog_base catalog);
    this_type part;
    int fp;
    string line, tag, value, descr;
    svt_mem_depth_t depth;
    svt_mem_width_t width;
    svt_mem_clkrate_t speed;
    bit has_descr, has_density, has_speed;

    fp = $fopen(fname, "r");
    if (fp == 0) begin
      void'($ferror(fp, line));
      `svt_error("create_from_file", $sformatf("Cannot open \"%s\" for reading: %s\n", fname, line));
      return null;
    end

    while ($fgets(line, fp)) begin
      if (!is_metadata_line(line, tag, value)) continue;

      case (tag)
       "Description":
         begin
           if (has_descr) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Description\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_descr = 1;

           descr = value;
         end

       "Speed":
         begin
           // Speed is encoded as nnnMHz
           int i;
           
           if (has_speed) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Speed\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_speed = 1;

           i = value.len()-1;
           if (i < 3 || value.substr(i-2, i) != "MHz") begin
             `svt_error("create_from_file", $sformatf("Invalid speed metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           value = value.substr(0, i-3);
           if (!$cast(speed, value.atoi())) begin
             `svt_error("create_from_file", $sformatf("Invalid speed metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
         end

       "Density": // Density is encoded as nnnMbxWWW or nnnGbxWWW
         begin
           int i, x = 0;
           string w;
           
           if (has_density) begin
             `svt_error("create_from_file", $sformatf("Multiple \"Density\" metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end
           has_density = 1;

           while (x < value.len() && value[x] != "x") x++;
           if (value[x] != "x") begin
             `svt_error("create_from_file", $sformatf("Invalid density metadata value \"%s\" in \"%s\".", value, fname));
             return null;
           end

           w = value.substr(x+1, value.len()-1);
           i = w.atoi();
           if (w.substr(w.len()-1, w.len()-1) == "k") i = i*1024;
           if (!$cast(width, i)) begin
             `svt_error("create_from_file", $sformatf("Invalid width (%0d) in density metadata value \"%s\" in \"%s\".",
                                                      i, value, fname));
             return null;
           end

           w = value.substr(0, x-1);
           w = {"SVT_MEM_", w};
           depth = set_depth_via_string(w);
         end
      endcase
    end

    if (!has_density) begin
      `svt_error("create_from_file", $sformatf("No \"Density\" metadata value in \"%s\".", fname));
      return null;
    end
    if (!has_speed) begin
      `svt_error("create_from_file", $sformatf("No \"Speed\" metadata value in \"%s\".", fname));
      return null;
    end
    if (!has_descr) begin
      `svt_error("create_from_file", $sformatf("No \"Description\" metadata value in \"%s\".", fname));
      return null;
    end
    
    part = new(catalog, partnum, descr, depth, width, speed, fname);

    $fclose(fp);
    
    return part;
  endfunction
  
  static function svt_mem_depth_t set_depth_via_string( string depth_str );
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jO87EvD6RZ/QsHMs0BXqh3DBKlkCoydh971WBZhn93gWiV9Ytlz3P4p+ooC/KDde
Sa/bW6aBC5CkB8PCUzXRKaBVwEsFNGpJvlrtx1sx1yPKfZ0EHnYx0hnBkhkDGHlG
6cfK2299uHO1gMxQPj1rbqy7TtBtPqPvHhaH+F8BaWk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 344       )
FycyIwx3DnBOhDqoGAPbQntJLTu0kZKCgWgCfFrrPMjT7Ugj03F7/xMciD/nop2X
O3C9w5/XQxPZhlz5xGonEEpr59Rc3JgjOTRIX80yCHq4jHTGZvcz5VtFz6l5B4XY
sPOIr3fYo1c6VljTRZ1wu+16PSb5fRZoKfLDPRMNja6lu5Ha7oA8+QvbTkMAOmUB
ASvWwWqGWnmy79Svevy5l2aVZu87+B+HIQsqV1I2delKsZhZdNc40PR8Ek9rnXSa
xDNrUXcCg7syaAs+0hDheTacQO4d6jyIbsTsUhLGtYNoiKWd+lvv1CNVl00xyGf8
AkaCCW8gRYFOp01oEsD983dBA+YOly3W3ZIYm85Vxxu2vhbIwfEja8e5GJDKsq/r
ITLXMUy+lZfwD9Cl3iRjCzqrMsVJK7UlnCF1wh1CbFnk+H/jy65+wA2xR7zxtICY
2I4SacQedvuquPp/kVcHlw==
`pragma protect end_protected
  endfunction

endclass

/**
 * Part-independent base class for the vendor part catalog.
 */
virtual class svt_mem_vendor_catalog_base;

/** @cond PRIVATE */
  local string m_name;
/** @endcond */

  function new(string name);
    m_name = name;
  endfunction

  /** Return the name of the vendor for this catalog */
  virtual function string get_vendor_name();
    return m_name;
  endfunction

/** @cond PRIVATE */

  /** Add a vendor part to this catalog.
   *  If a part with the same number already exists in the catalog,
   *  it is repaced with the new one.
   *  Returns TRUE if the part is compatible with the catalog.
   */
  virtual function bit add_part(svt_mem_vendor_part_base part);
    return 0;
  endfunction

  /** Remove the specified part from the catalog */
  virtual function void remove_part(svt_mem_vendor_part_base part);
  endfunction

  /** Get the base class for the ith vendor catalog in the suite-specific shelf
   *  and increment i. The first catalog is at index 0.
   *  returns NULL if there is not such catalog.
   */
  virtual function svt_mem_vendor_catalog_base get_ith_base_vendor(inout int unsigned i);
    return null;
  endfunction

  /** Return the base class for the ith part in this catalog and increment i.
   *  The first part is at index 0.
   *  Returns NULL if there is no such part.
   * */
  virtual function svt_mem_vendor_part_base get_ith_base_part(inout int unsigned i);
    return null;
  endfunction

/** @endcond */

endclass

/**
 * Base class for the vendor part catalog.
 * Must first be specialized with the suite-specific vendor part catalog entry type
 * (itself extended/specialized from svt_mem_vendor_part class).
 */
class svt_mem_vendor_catalog#(type PART=int) extends svt_mem_vendor_catalog_base;

/** @cond PRIVATE */

  typedef svt_mem_vendor_catalog#(PART) this_type;
  
  local static this_type m_vendors[string];
  local static string    m_names[$];
  local        PART      m_parts[string];
  local        string    m_numbers[$];

`ifndef SVT_VMM_TECHNOLOGY
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_vendor_catalog:class");
`else
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log log = new("svt_mem_vendor_catalog", "class");
`endif

/** @endcond */

  function new(string name);
    super.new(name);
  endfunction

  /** Write all vendor catalogs for the corresponding suite */
  static function void write_shelf();
    foreach (m_vendors[i]) begin
      m_vendors[i].write();
    end
  endfunction

  /** Write the content of the vendor catalog */
  function void write();
    $write("%s Catalog:\n", get_vendor_name());
    foreach (m_parts[i]) begin
      $write("   ");
      m_parts[i].write();
      $write("\n");
    end
  endfunction

  /** Get a catalog from the shelf for the corresponding suite for the named vendor.
   *  If it does not exists, it is created.
   */
  static function this_type get_vendor(string name);
    if (!m_vendors.exists(name)) begin
      m_vendors[name] = new(name);
      m_names.push_back(name);
    end
    return m_vendors[name];
  endfunction

/** @cond PRIVATE */
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AvhA2zEKohFd9AGdDhj+3ct71oJ0tZQbiXzoWoqWZZsDLh/2BCAdksn7v1TcLEk4
RAT1fPUbFdRcHOuJUPkPwPYTMLJ39Wv+0AyvvABPrL/b35cNglq4J5moLmQY2c+Z
W/3/UzcQ1oJqdtj96WkgdG9CjbOuKGYoHvQ5iME/zSA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3828      )
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
`pragma protect end_protected
/** @endcond */

endclass

/**
 * Default policy class to select all parts in all catalogs on a shelf
 * with an equal distribution value of 1.
 */
class svt_mem_all_parts#(type PART=int);
  /** Simply returns 1 */
  static function int weight(PART part);
    return 1;
  endfunction
endclass


/**
 * Class to pick a suitable vendor part at random amongst all
 * vendor parts in all catalogs on a shelf.
 * 
 * The PART parameter defines the suite-specific shelf.
 * 
 * Suitability is determined by the static POLICY:: weight(PART) function.
 * This method is called by this class
 * for each part in each catalg on the shelf.
 * If it returns a zero or negative value, the specified part is not suitable.
 * If it returns a positive value, the part is suitable and the value
 * is the random-distribution weight assigned to that part.
 * 
 * By default, all parts are suitable and have an equal distribution weight value of 1.
 * 
 * User may specify different part selection policies by implementing
 * different static weight(PART) functions. For example:
 * <pre>
 * class only_x16_parts#(type PART=int);
 *   static function int weight(PART part);
 *     if (part.\#get_width() != SVT_MEM_x16) return 0;
 *     return 1;
 *   endfunction
 * endclass
 * </pre>
 */
class svt_mem_part_mgr#(type PART=int, type POLICY=svt_mem_all_parts#(PART));

`ifndef SVT_VMM_TECHNOLOGY
  /** Shared reporter used if no reporter is provided to class constructor. */
  local static `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_mem_part_mgr:class");
`else
  /** Shared log used if no log is provided to class constructor. */
  local static vmm_log log = new("svt_mem_part_mgr", "class");
`endif

  /** Pick and return a suitable part from the catalogs on a shelf */
  static function PART pick();
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dzOtZnnNOQwJkLe0pCKtIprwdgxx9wgvUkimUloBSGsfjSbLADQpXslp1XduTuAE
7qq5ci6IE8H4O2yCZnDhsXfx4cosnZ983QJ61j9mL4Gqi/3ePJL7QrkdHmKnxo92
LPJQqT3sF0EUvJSN9MD7Rb8gqKC6uCVbILzNmnOw9S0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4663      )
JByksm++jIaIDSiSMLzKJ/iAB6Hoem3+uTqyMJq1QzUkC9hoisR7WmpLu1t8Uknj
eWQ0HvPY7oGE+4Hnkc485zn171wMerAM2ADShWxuDFLrZ15jSfFWhvlYbxFBO/iq
/JG003JC9m9xE/JRW8knBQ+ZaatCqloPqLBnjC87e1Y9BBSKREo3gypD2MhjlWcd
y8j1UY2VBQtWzgYWB8P6fYB/aVunZTR3jx7DTRjPidrSFQ5s8KHfoAlFjQVtCB44
gRKamNuAHaaqllDOUqIUeWA/aa0Iap2PwRMvZPuZgLJisgphXWz3jIGe5WrpAKr3
NeMcA7bpmzc025IDmm5+WSD4gYLm4oo0TAXmJQJMvqrMPi/9y2yKov409MK2l6BD
/RDMXBtMiHZDs9sVB1Qx4qiySdRIVMVXFT0wyX3d1l3JEhC6SH3QyVjlqtli+1ju
iAgKlc+dCG0l/hG7BlOoB2qxAQ0eathu2chna9DO9FlOL3gTeLhFYGUASyNCZmnK
n7qJl8PcsxImg9nK26H2SFRbGeLLHV6QibOkzk/H9LJt0DD0rlUvbxtbcOuUt5J+
YhPBjPmDWMOi1AznhFHtsQwoxihQpbVMY3J4UFyxlo0qNG0X3x0PEJXn5f3cUrlD
znrMHUhL2iHIlS/DX6iqFysWiiDtIthOXao+w+qTgpKO7o+wiz8/UtyXMtWfMOJU
eSNQ+99nLxb3FinxlUoAu8QwB6tZlmekZETV1A6AFnQ4pFzQfu21OIZujXw7BknN
mnBnDPZzAAOAltZEKbq3m11kvRg/4WXVFSnMzPD1KOTZvs4jvp2ODhW33m+5Hc6R
YVr8mmSd3PYEGFf0MJrOCD4a5EUdCGpMiJltKwO9xBqszhQ3C3fZvd1PdyEU9W8d
BNhhnBQcQLueynptJ6J5Lqzu145g/t+7NZTqmOH1qb5EQk1QKrUAoI7I0NujiVqB
jSVDb/pU02B6w7MnHFUb0MxwCnJg1qKhNeQ6TfA61cNlStomB4VRD6qBW5GXTgi0
SYHuUTxRO4y9Og+K9O5Qvw0PSHim/pcGvjiAuUGtwMCghPzE5p1zB3jyWWoTNP4f
cCRCa0ySi9TtRLaA71DjiBmgY6YTDKc9FBmbQR98aek=
`pragma protect end_protected
  endfunction

endclass

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mJVSoeby4OtlYvyG2L0ZRrF9N3VIIFGPMMPnMTLerL4xwfi/T381RNf5P9IVvC+Z
uVCoYhx/DKw2G56D/eNiWr1KJ1LRL5NYZWLfUL1ucbIJBomhO0gLWZFpH5VZlU7X
bPdByDjuBORKhi2FQ/778nUKgDqJMyRgpN4dPpulmjY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 4746      )
5JETKC3s9+oJRzEkOnYbjQLiuwG5hCZoukrA8KPuBmE7AqlSgSmtWi66YFUShNPd
7NO3UO4GPWuZ9rV2hCQv1s/uSSRqq3TBE3dXI/RxxaavZoPiouRVGoEejkFHCdSD
`pragma protect end_protected
