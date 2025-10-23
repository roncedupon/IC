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
`protected
6e]Y7a=LN19gJ8f;PTb=aA+S-^R=a].PWKW0TWS&G\f9#70)#;()&(&LAeVFQ:0H
QXL(B<XER7/gW6JdNd&;+W#=Z]6L-0ZMg[;I(8D>Oe3EcbG8UZa(94LK?3MXg_H0
)/N^aT4W?<-Pa&0TQ(?A3Ge^AU@4YO>-80d^/2BA<<=2-B.fMI\J0:^?\-=MB.Wb
O0D>SM83GM(T&9aV8F>gZ[>82RUZfcgP:5>6>.bJ[^dRVD-&UKMgV0g+LMNE:DJF
0\+,e/6G8(#VAOLP5UKV.cC9NAaY0UN(M=I)b-=IPOEDG]5>P(@T9CdKeg5RNBP^
]J?W-:(J4#Kf8)L&E),:Qc(>6.f:EG?.U3TS>RC.JP_0^O/X=;ZF\0Tbd>5DgIIN
Y7532Ma>9/AbB[DLHM[8SGVEY,9[79CO>$
`endprotected

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
`protected
,I^d,MN<(LNfR).P4&aU9LLZ_97L3#aNZC_<N#0D-A>6aDC#Q.Q9-(5OO?6Hb+Y+
#4F\^F:^,WK-M6ScF/OHfaG80(>VAU-[RS4YRL:(JH>:cELDf5d22X#ZY@]&L:Rf
)=VBCP,#.\?#MBJ.+29^e)CP?FUf#_Sf,.d7&/BXC4?f(L^8fHR;,VfYC8Ue^-\\
;YQ?V&9A,;,H4\MQRE/)[GVRJ4Gd@]f+g7bW?1I3VG+EWBJ(X2eG^^eeGcEZ+V\<
]X4/CNVNV10e2EM:<[-5-=93#(\/\8_^aDS(]^N&.0AJ.Hba0@L;2KSMHN0LZY=A
b#Z04&De5I1]A0:[79;GC_E&Kc7<b/6@6S5(@a;0#UYdC3F9XR>GZV4M.I08[d6b
=(O:-d=+:ec&OdH#KcS5H+ZM=ac(8c;[U]O(g+Ld2Y43HI,a&1FD3^=(=-V,+b?9
5T5;DJ\4.ZWI>(BW_]^B;Mb)U6_aDfePDVQ]b(>#;b5DNJZEaRZ,O--FK96,McXe
OIU>:VaeI1NBA2EIK;W77=NZ9XT9OF6XY#VTeDO5YeT[K<d#)TD,^O(aTI(FASJP
8=@(6XK[[]@MPd_DM201-H[YO9XP0<cPI0G-4b\+dNTXURF^g.O/4<HV<fVMgS:X
D-#_]5L;33B=WRN0/R7MM+?bGLL@)<,M,W0&TZUfdKe):EYNCbMXM1(J#Ee_7)WO
SG6]7;5YSBN6b8HH\cSI1-5J9R^4b\LPad;AU6&_08fHDA.B?3<<@1?]Sc<DUC4U
@4bNa^8a?4EOfG=S0&)BD2gBV>GKC=S\PS&?N@&,&&[I>bE88bP.@f>O[[OP]T;>
36:P</9E#:I\\EId(WE52-H#O_7L4eZB3=KLLeIB1ZJQS\=_DI3^g<-#,\[>TG(L
d\Q@dLS3M.#(07@J4&O]/0A[;Of_\+9B)\RaHO=B_-5BL)@V2UBJNO;>H(_5I&<6
B>W-\L)KVW#K;U]eKdB[Y(,-3EW6]BP:f<Db-f\R/##?((7ga99cgDYJ]GOMMR>;
+BK/1]dK^cV4,<S3@#/<Z^_+QC6La.>VTY,g+e&OF;4WVS&g_9WXH:0LHA0I9CRN
UZL(,[(J21RHLBYZXga/GY&c-F@fe<N+CAcYaYNH@>+gcdHfPgZP@Q9(52U=ZfS1
,<_6C23cH:)Q6GZa1e#U,&\+P^M_Bg2^VU;B#b1_ag;M&bI10@DRfE><PC#P_LSb
N_.>[2-1ga.>f9QDTO-60.@X6W3bNC3dC_W0D3LUL@JW,1Y7FI\#9[T^f?Ig_7A=
)),[?O=XVcFQ-A5fY;:5Z?fD^J4?N_eEg#&TCH<4&F7-_KB,,R.EB2A3d<^=O/]=
Q8XABM=8>7S1-4-TAO.=0[Ye[d@+?2^,M-39Fg+W05^)<TL+MaMA([.CRKD]dPE0
;1BJd@UY:-6N#?N89\\]]b(3+U=LEW>(M0W5Z(=E8:dAEFd?/ST7c@+c\Yf<KcDH
eWFE/6dR?egd2\C6N5:+=W4M6@:R;b-IDTd)0D;@:3Cd.KHY.P-LfW=SSUbPB_Yf
M/0[HITQ+aT8Q,_621Y,R>3)ML9SK&O_gE@<ESdR\5KSGU[.CPbG<SebX\]cUS7M
gYD2c=NAEN6\ERJTEFWV^])-]0/eI(A>^Ff_gaW-I+>FSa]gB(&N;e6.7DaV2+P,
E\-.E^[QNg88#WG)6aC^/).]]OJMNWC8c:VW97X5,AVA34\-CbeR]0DWJTf=P(T/
Z<?^=>R1B()[S[NNU(]WO2:P@T8/M<-,I7>[37d2]F17+K6bG.c.fgB-;+.QQV);
)R>Y;RSL_Z<:RaZKUIe\D3e#FM6L7SB02g:-W.[)YaRe6,?aF4]LV^8LV]3N]c;7
/6/ASc8NOHK#AeXQ?91M]Z21,]3;^2;HJdL?DSaXU5EG+Lg^UbLC9K[14EFLW?9K
[JVAN8T[1BS/050SLNSQ(R-4SG.1&8fO3W/[Bd_7=NKV:3=6G^<SUf;EB3XQ<5HO
Be+HT)^4DOIUNbf\]#V_7K3E0PKW/+QDJe^\cXb_6S8=&3SgHg;Xd.OW;b5;6GEg
:@MZ2UBQ1#:IXBGD6OEfB^cAS)3311SFE[Q@e/[(0@@,b8FB)1QW3BX0LKQfVKI1
DM@Pc>b;DE417=+T>VdYEY^P=--P\\24Q(ddVWML-RDeRR(O@d(1;?J[H8bdG\OA
6X56U.Fg:2#<dIQ(LM4YaAS-e#-(+0IK1e1cYgJ2:/.PTH3[G71eL.Ab-1Fe<?3L
C6<>V=gP+/g\@>TWc6K/HbYF/9aJXO1A0=52#W]BAe^M3gHOQYTfg&3d4<Q>##A3
/#N#]X]]-a-<X6@)Y1g9<:K)</9C<Y/FPP1P>eB3XZJRE?H@>bH><9.;<ZR0K?Ib
(.CV)>^JNZWX.g46=7)K[_08I/Z[1<TXSD-PbDgB,gYE+IA337]dVUb:,;G<SD?=
;2c:W.I9c<=Y\&\C4O4A0VS;#@1WS8N8YLU>E2LYR3;.&T?3ad4HXf2SFR>VRC(5
[WeQPXQQP:(FTdX(CW_fc\Lf4dd:N[@GW[F1/=.RQ]3\GEX2f5N@&7+GN;6PcCBL
7OeN^+#WWTcNA5;+@OcYV_@TfFB5HVS(:)-J?XM=0Jc.GVIUUFY[ZZ><+13U(.#2
F8<g=<>:,PTMD/<H&>#)Z_Ud#(c>SMFQ90CX-7(1:fC>&L86#bY&YQXQLdb_W]GE
M&G2VF;4.X.N-S0DUc^/\894FD,g\@OD_Ze[@S&_e237B5.Y,BJ#5.:G#&UeID=H
S.&g^=GH0OTLLRU&0Hg)_G[-f>5:b_+:8f>(OGf#B=KPF&#^Xg5cc1QI[4b=1.UO
I@&=20I,C0T1CYNWLFX>:fMM5P\E6E^6AeVe;)A;b2/(MLZ?Ee)ORI>40:RI.U9I
X?X6g^]#C^H6S/b:PTXBROLH0CR#d4=K5g^+7Va..CLBL8)OAOGDaUdG2G>1g<?C
-UZKUX5CN2#3D0--dZ&>#dI:]fPUdf\<3(35]G)R>O5P/fI#<8P8[I1Q_6.,/4I8
/0DIJSSX;eG-=YdaRQa7NM1=.]_?f[3c3C(&S6fYY)_fT)2W.9(/XG=P905I41c5
aFa:I4QJ#V-6MTVY^/0MBP8a<4RU1Dc0#239>T82L8HATC8_4=&)T9cWcdG:O)fW
ZX>]G,H7AU5?JgR<(H[.0@Q[(>:W&GF=G1_JNJ5+YdFLBd\Z]gaAWBbW4HQe9XJ[
3,F8)C\MgT(@I=,DRFdUJ?>HdB9b6+]H/Eb)\-ab.D.C+_a0LL5K<JKU<aTJ_@H.
/@,fH:)D_#.F-9Z(g-_[#dABZMGaNaB=,F]^;)^??=JgG@.MFcfCC(/]eU\^URfH
9&5BMc:9eZT<0.RJ^>RZXT;E=AFU(+c,HYLK-1)c^6&dO1.E;_:#GK[E51MG_Ye7
W,[KT0[@/7,B^-_D],6@(T_T^XGAL:-:D_3B/Ue+cAUB_HHINYURTa&=4E)MJ/cL
>\]CW6.^Red/QI&LTXB#-S^2;IW?:F^RRb8K(9S]KRLP)d5W?AEZJ1cH5&Q7Q0[(
d7)=LaH@0Q.O0JOR_N\)fY/HB]UI&@^@=[DcE^Db[7^Q4_A_HPLPKF^#=E4gHAOV
S?A4L+]OY8=.)Dg9^84_?3@Z\R#/JINAU434;WIP/T8[Y?=CB:ON;L+_Z2@WgdW+
A)<DV]I^UFa](:LDg#cE,S;fSbBA:361I_62>G#B(9gfZd+a<>ULBOfg[R_-4ERG
P;5[)6.5@Se14W3dNaS.>?4e&3cf,a^Y-DaR/1Q1^)?M2MX[4@_+PI=&\7OD/7\d
CPAG_C_[WKeP@.Y,9^>F=,Qa(W9J?0J->[H^:FVg0)T4P6,Yd877<f_BI/^T?;,Z
GfSQEg_aF2P60:G=/_<b0MMCa54I2;cd&T=AM)>W1(P9SK+(2.VSZH09@>M.P)H;
3M?]b9;ZR@ZcPSWF5IA^F?Ne(aO56MW3_OPccGR1KPX:C6aV\YNE_A]gbe)M+/L5
L#F@,D?K2\:MgU_@__3TPS^[VSEOaE\ca.T<&a0P0ZXD25)-C]Y:UP\YZA=WFAIf
U(2&Q<9^.FSU?^[8<JGUYG3]MNcU49<d^Ob:BPeGfdMX9&Eb6;)5C\#A9L38Q&8e
BdNUTM6@T2CfNN?F>8Q4+LKJLVS[XL;OR?UMeDU,#=<76CgQN:#:<C1R[YMUg\D/
O0ZTF7?Weab>UDAD;Q:5A2\S#1I9>N)PFRe5@\ISGBZL+B>0YgC+#8PIdLS7Sdc4
K1PW;[5?Jbb=OMR0/ec;/^Z_K@5F\<=:+N<^JgF]<<B#e<S?SAFc_.:42E8a]5<.
[VVRBNB:S@0K^-AJ868(]bT@SONVc^L)N-;1\W1^3c,Ke;@M)AEP/eH<HL[=2]aB
L@]&bI8[UXISZ:@;e_)>OL\d@D(LHI_E>Z:VGe2/^9?J,(?0+1FQ1G1Qgd.0d<5;
HYHG-7bBaKR(&BU3P@Bc1ZSLZ.&0SNPT/SMLcH(_.f9=DB?XS),DB;?I:N/,M272
:WScF+;YS;U4)&9/N:(67]P14DecgH+.(#VaH0MJ;1:Rg:N7XgTTCH&+Uc(<:;V&
>AOK9TQIa)=A;9g/F\Va,\1Y@B_+R(0W+5<0R+S,\QX1P4^2WX2W7a=IRW=FS#4?R$
`endprotected

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
`protected
aff[LS-PcNN(L<505XM3M10FT;#R?]N]ECe,-c)]-fIJ#<04a3e(((K9GI:^NTCe
4)Q/)Z:[9ccbIMUOY)/;P07UcHR8M1V7?TH^(ZZQ/&?=G9_BM@LAeXc,E.5NCA3_
2B9C0V@RdOL&6]S_AD]2<d5A^EJ?@3e_5AEaB@:;1,7X?VNLL.E7HKMB#I(&5d/>
8MQ[X/?Z/b1B&Zf8H@deB2X;]f#Pg\?5RS,ZC]U#X)?cAPN5+BRWC(0b,PYNa?G[
_K.0Z5g^cfSY&=fU86]U?g^3?,MK6gKBK4L8J@C)PbQ5gK-DHNVE4[0D\9N8FLV#
UO:M-_6f6BfK^A>JfF?<GUQe@L8#DIgQPU;RNaII:SL_,]\PD[N\E#P7I,D_bcWM
c<(I#:&K=O)R-G5T8cXFb)#]:;^;)4OedW:.HE\J0]fRG0cH]W3M_4?UF+LEWIFZ
bC,N\FgX)1a.9;;CS>Z?C[d]=Gd77[I^8]8;7XbL1S3e[-<T(GIe,:SY=?U?SRWb
DYKYa^E)<5+RELRRCce?G4Q[dU75W_BSU+(fe\]J&.WN>;P8VN.NK(WGJ<G3/?R7
\GL:b3P?54#KYPQ9fe9+56NHSb2+++([B.YG,4V)\@+#.eH6;OEH,.-1@83&G6\&
\-,>.WeGE5)+3HC_P4,T#7/H71K0HPLFHdJZ2-;Ge0B_J<OQ)3UfHNYHW6;d9Kb5
>H>/\51[,:6?R4&d87I9CSe2H=<1<#KNH5/F0VNIF.C7@=,Nb3CfFW\DU9g<:E>Q
71DAJ/^YOPCTDaaZXOJg7VM=DgO9V2_M@;NU(Q]=+1>df[IQKYL+^Sb?L_7VcRMC
HB4Q4++.fY++;FGO:1EH1+UF>QFeRF)[g-,TQT\)3E,K?3,(]QHOb]H?4H]@ZI:L
ZA?8_P?XH>].)K+=JI0>._IaX#@F[GT/@<_QE8CZYS205/TT#X2e:/La)dHR:b;.
bBgX-;)3?>L8C-]USVFbR]-FBDC+@Z;@6@084/A/P3[,63c)OT0;;83ZU>AD(>RM
#NZegDOH?R>6dI4P?X]gH?d3#BHHS(S4Cb1-KYJD6Q+BOH75Rc)+;V3ZI$
`endprotected

  endfunction

endclass

`endif
