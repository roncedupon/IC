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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KtUX2FTrddNQmVNYwcUBfptx8Z87pQ6O85m2PNEuT3dCUv43bu12jrUixo3HbXH5
f1bM1EEPnukdwnsY6bYIOXBHQBqphwD98FP3q9IKcUOWWVfzHsrFK2hW7OherhbX
o4HDku8HkyN2m1DEG7l7lMF1x5JAxiYQPI/tOXOhFfZc5NyzIi386Q==
//pragma protect end_key_block
//pragma protect digest_block
+tDG/hguHVhVFT+TR8Ys9Gfz/oI=
//pragma protect end_digest_block
//pragma protect data_block
RwwF2a8O1oLu6JygTZoJOf7csBr7yRf37qGan3Gl444hFhyj9xJxXZSmNtgOU4Nf
o2FrSv+55qcca2QF+Pv2px47HdseHC19cIKOu62Q0nTyqwWzVCGHG1o1UH4wpWI7
ZPZo/dLx7YVAVJAmvDWzLFjjEWUVaZYOXbVaMcZDUI05f2DWQYUbNbfE6B0xgmb4
MvmnO1HDUx+u48ERIDuz+ZriNaVwHj0fboovjgHf+3hZvuKqi2IncoaTD+uInKOM
KPeg8qYoY9E9dhbgBWsam61OacLxF/eYmvnwYD1gRz+zsraGMJWmCwlwgIVgEL/U
vlW8YnFK1aj4yVFZdrwzCISgg9NpxvubsXSohT+8IPI5KbnGSSsYhAOtnbOXHmPy
z1hVGUrH2hdDLscGruG2w6K1Pw8POidLPeRp+qw0SM2v2pitR8vx2hXsyrCxr01K
D9QErpxGTrZP85EvGPjqE1fOTLlgrtyOaUs8b8R/X+l8TK54VBEaY4s/e/XSrDXH
VlNNqKBebSLiq0lWtwdVQ33J13C+Ivf3jv5QOHmcDmn+mkXy6uzZpv3SaCkw+ehM
z02ito+JSztEMaJhOw+6hqo7lhhrqE7XGebz6fELiJMdBt2tcFs34ybsp86nEFND
3QpQWI6LSuzE3zSczC00dV7h0uoj9+bos7FuyeJLMRo=
//pragma protect end_data_block
//pragma protect digest_block
shQDJvtyw5vK9TiwzahYPYZ+XAE=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MbwrUXYkbXHKW92kyUd3KrrwNNN+XE+shH6I1gA73jNP2Tg9iGABG54Gh1q0lamd
wjFXETRT/3ehG7m2viL5Tufll66YYPr/oK54cRr03dyvi+aM48Z4AHGUjda0MQUb
9c0CpQrQ8g0i09Jxd7UyXd0/3UNFkUMgXUzU4O6PVLgiz2gdQjKjuA==
//pragma protect end_key_block
//pragma protect digest_block
jk5WPBbwjbQKBFh2Vu7S0BsWzmY=
//pragma protect end_digest_block
//pragma protect data_block
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
v/fgO7g2kKycAWJzDHtHmg==
//pragma protect end_data_block
//pragma protect digest_block
oS874zRlx7C6Hkzsn3otBza67Jk=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6YUY4m8TgOcbS9UKn+2KY8J/zIX6AUD/8PAV1FRy19OxB1/aj+xGgERSz1pZHtVt
1dLGsUNVQ5H+YUlSc09eN86ui1HvxwA3e1EgNDX6u01FvV9B8lFggAUw7d4xqo9W
RXMLn96nDwklnTi8q/pjn1neANjXSxYqYnXXyK0IHXRpi40RBDHBZQ==
//pragma protect end_key_block
//pragma protect digest_block
XqdS2JWXvsWyfheTecQZk8LnYlY=
//pragma protect end_digest_block
//pragma protect data_block
lqBPby36kVA0gFgkBkG7174XKEKjtfk5j7R04GUzdO9q7sQZfu0xnW9ybNPk9JMu
sk59mH/X4PK7eKHqH1TPLvDAnvF9uKXrkHmstXKKr9vaqDf2EUX6vXL1sUW/v80t
hu1r0m38gixxrFs4TcdTi+8eB3DvBJok1CSVIOevGVn/j03PCpF1TdPlX6Hs8RzO
8KygyVwMXzs6vOvxcTPMAD/KIphetn80vNw7X551Xg16YUUtm7q2wfF1pWZZxN+W
AbzYES54Ha5w1rGCx0H4gvwR+KXOi5ea/rAm8bfT2NgVX1A2EF78ufgIKU/MH/HC
GQ+405/JtM8k4w1ziGbb3l5khpHLAtGRyz9f/sB1PuypYx/C8A5YRubRLdUevond
fm94A0BCUIOVnH9++oUhjradT2u3tEE2OZllBLlA8mjRHzskDF9BsfrxtXhsDc/n
hgQDkf5YrUsiHxxt1BYNkjmZIg0siZNhUAWDwIJ8rnmfbpgBRqMivyascbXb2oAZ
6EOy8MvFf3j+dkWgja/y8FvKqEK/bgZIrKump6SOtrIlkikesGLVQc2gicMEu3mM
86GmpnNfkhXKVMXIzqx52VbcMOuWlzjGStcWpRw8qCJ2T2O7llmzT7P9qaYAzRe1
c+Brso+ymG+ZbYgo3hymw58hp+WI0X8ZbKfkeUF0Q9737mAxqu5w5VSDPjQE4vSw
r+DQ63ysQEYmqYjfZ33Kudzja46aKabA+s5rgg3WXWiKAbXeKVsVQE3W4X5jSacC
kPHIUz1Q/gZoy+skiCcQZq2PYIlobQUuOwHPLjSyvV0hYyvSvB8zQ/vUWto0CUN2
1pc1JX7J2q8fyST/pBnKUGaAEsBDcWkIs8KUmHUzGGHEo77HOZm6AnuntPJH9Zhk
b+496q/BMS9zcIUIC7DSwmkcABYLeYnF8wXIy4EMNxV/73JTBIR9qdG45p3/+qbS
6Nsr2i+ZewVW/cnnSmp9MNPQWKt3WNAt94ZeszBHgFftGHFe3//zLWE2Lq/vBuev
S3/BdygARNPJ76at4RMnVj9PaQ+gkmv4IRH3EunrCEkp07jzGmiXppG/KS6BfSAj
YalUmKQiriYQx1Val+fLShDVrHrc/UzwgLnfDYUzsGmK9AXfkYd+sxbFBPK6xo3U
Tp0otYEVKNstIEqU9lU5zPt9nZUF8uiHAlUoCXnjI2vZX2lgl/fjkGpgSA1xnpQ/
IP8Jc+XfjyOgfQCWs6SpJiRbHf0EGMMpvyEz36rtukc0CP5L8Hpm8ThgqEy+gTI+
aFiD7xKEfC7tTiGwdae/J/SthuKVj3hpa71/9TYa4przBa/LIKzNH0BTQ84G3zXB

//pragma protect end_data_block
//pragma protect digest_block
BBN8/TToCU6UyiB2vCgwCyrZdrI=
//pragma protect end_digest_block
//pragma protect end_protected
  endfunction

endclass

`endif
