export SHELL = /bin/csh -f

ifdef VC_HOME
  ifdef VC_VIP_OVERRIDE
    export DESIGNWARE_HOME = $(VC_VIP_OVERRIDE)
  else
    export DESIGNWARE_HOME = $(VC_HOME)/vl
  endif
endif

ifndef USE_SIMULATOR
  ifeq ($(filter help clean,$(MAKECMDGOALS)),)
    $(error 'USE_SIMULATOR=<simulator>' argument must be provided)
  endif
endif

mode                 = svlog
control              = svlog

simulator            = $(USE_SIMULATOR)-$(mode)

ifndef DESIGNWARE_HOME
  $(error DESIGNWARE_HOME is not defined)
endif

dw_home_dir          = /mnt/disk_0/softwares/vips/designware
design_dir           = /mnt/disk_0/IC/basic/vip/i2c

include_dir          = ${design_dir}/include
src_dir              = ${design_dir}/src
tbench_name          = tb_i2c_svt_uvm_basic_sys
tbench_dir           = ${design_dir}/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys
scenario_list        = base_test corrupt_10b_rd_test directed_long_reset_test directed_min_dat_su_time_fm_test directed_min_dat_su_time_fs_test directed_min_dat_su_time_hs_test directed_min_dat_su_time_ss_test directed_reset_in_ten_bit_rd_test directed_test directed_test_for_10_bit_addressing_test directed_test_for_nack_for_data_test directed_test_for_retry_if_nack_test directed_test_for_slv_nack_for_data_byte_more_than_255_test directed_test_to_send_nack_after_1st_byte_of_deviceid_test directed_test_to_send_nack_after_2nd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_5th_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_6th_byte_of_deviceid_with_rollback_iteration_enable_test eeprom_2_bit_paging_wr_rd_test enable_exact_timing_checks_test general_call_test general_call_uvm_event_test i2c_cbus_10bit_addressing_coverage_test i2c_master_insert_repeated_start_after_8b_read_data_test i2c_master_insert_repeated_start_before_1b_read_data_test i2c_master_insert_stop_after_8b_read_data_test i2c_master_insert_stop_after_master_code_in_hs_mode_test i2c_master_insert_stop_before_1b_read_data_test i2c_master_insert_stop_in_10bit_addr_in_cmd_byte_test i2c_master_miss_rep_start_after_master_code_test i2c_master_miss_rep_start_after_start_byte_test i2c_master_miss_rep_start_after_start_byte_with_hs_mode_test i2c_master_send_cbus_addr_and_found_ack_test i2c_master_send_rsvd_10bit_addr_and_slv_ack_test i2c_master_send_rsvd_1111xxx_to_slv_test i2c_master_send_rsvd_addr_and_slv_ack_test i2c_master_send_wr_rd_to_10bit_addr_and_slv_nack_test i2c_master_send_wr_rd_to_7bit_addr_and_slv_nack_test i2c_master_start_txn_wo_start_test i2c_mst_10_bit_000_read_test i2c_mst_10_bit_001_read_test i2c_mst_10_bit_002_read_test i2c_mst_10_bit_005_read_test i2c_mst_10_bit_006_read_test i2c_mst_10_bit_009_read_test i2c_mst_10_bit_0f7_read_test i2c_mst_10_bit_0f9_read_test i2c_mst_10_bit_100_read_test i2c_mst_generate_stop_insted_of_repeatedstart_after_10bit_slave_address_deviceid_test i2c_mst_generate_stop_insted_of_repeatedstart_after_slave_address_deviceid_test i2c_mst_send_wr_rd_device_id_with_unknown_addr_test i2c_random_all_cmd_scenario_with_ack_nack_test random_test set_tolerance_limit_test set_tolerance_scl_high_fm_test set_tolerance_scl_high_fs_test set_tolerance_scl_high_hs_test set_tolerance_scl_high_ss_test set_tolerance_scl_low_fm_test set_tolerance_scl_low_fs_test set_tolerance_scl_low_hs_test set_tolerance_scl_low_ss_test start_byte_in_hs_mode_10_bit_test start_byte_in_hs_mode_test start_byte_with_repeated_start_10bit_test start_byte_with_repeated_start_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_enabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_enabled_test

sim_build_options    =
vcs_build_options    =
ncv_build_options    =
mti_build_options    =

sim_elab_options     =
vcs_elab_options     =
ncv_elab_options     =
mti_elab_options     =

sim_run_options      =
vcs_run_options      =
ncv_run_options      =
mti_run_options      =

pss_map_options      =
pss_dsl_options      =

uvm_home_dir         =
ifdef UVM_HOME
  uvm_home_dir = $(UVM_HOME)
else
ifeq ($(findstring vcs,${simulator}),vcs)
  ifdef VCS_HOME
    uvm_home_dir = $(VCS_HOME)/etc/uvm
  endif
endif
ifeq ($(findstring mti,${simulator}),mti)
  ifdef MTI_HOME
    mti_latest_uvm_ver = $(shell /bin/egrep 'mtiUvm +=' $(MTI_HOME)/modelsim.ini | /bin/sed -e 's,^.*/,,g')
    uvm_home_dir = $(MTI_HOME)/verilog_src/${mti_latest_uvm_ver}
  endif
endif
ifeq ($(findstring ncv,${simulator}),ncv)
  ifdef CDS_INST_DIR
    uvm_home_dir = $(CDS_INST_DIR)/tools/methodology/UVM/CDNS-1.1d/sv
  endif
endif
endif

ifneq ($(strip ${uvm_home_dir}),)
  ifeq ($(findstring /src,$(shell /bin/sh -c '/bin/ls -d ${uvm_home_dir}/src 2> /dev/null')),/src)
    uvm_major_ver = $(shell /usr/bin/find ${uvm_home_dir}/src -follow -type f -exec /bin/egrep '^.define +UVM_MAJOR_REV +[0-9]' {} \; |& /bin/grep -v ' loop ' | /usr/bin/awk '{print $$3}')
    uvm_minor_ver = $(shell /usr/bin/find ${uvm_home_dir}/src -follow -type f -exec /bin/egrep '^.define +UVM_MINOR_REV +[0-9]' {} \; |& /bin/grep -v ' loop ' | /usr/bin/awk '{print $$3}')
  else
    uvm_major_ver = 1
    uvm_minor_ver = 1
  endif
else
  uvm_major_ver = 1
  uvm_minor_ver = 1
endif

vcs_lca_option       =
ifdef VCS_HOME
  vcs_version = $(shell $(VCS_HOME)/bin/vcs -id | /bin/grep 'Compiler version =' | /usr/bin/awk '{print $5}')
  ifeq ($(findstring I-2014.03,${vcs_version}),I-2014.03)
    ifneq ($(findstring -SP,${vcs_version}),-SP)
      vcs_lca_option = +warn=noFCDCI
    endif
  endif
endif

nobuild = 0
ifdef NOBUILD
  ifeq ($(findstring output/csrc,$(shell /bin/sh -c '/bin/ls -d output/csrc 2> /dev/null')),output/csrc)
    nobuild = 1
  endif
endif

buildonly = 0
ifdef BUILDONLY
  buildonly = 1
endif

norun = 0
ifdef NORUN
  norun = 1
endif

incdir = 0
ifdef INCDIR
  incdir = 1
endif

cencrypt = 0
ifdef CENCRYPT
  cencrypt = 1
endif

noclean = 0
ifdef NOCLEAN
  noclean = 1
endif

ifndef VERBOSE
  vcs_quiet = -q
else
  cds_quiet = -parseinfo include
endif

ifdef DEBUG_OPTS
  sim_run_debug = +svt_debug_opts
  export SLI_DEBUG_SERVER = file
endif

ifdef SEED
  vcs_run_seed = +ntb_random_seed=$(SEED)
  ncv_run_seed = -svseed $(SEED)
  mti_run_seed = -sv_seed $(SEED)
endif

ifdef AUX_VCSFLAGS
  aux_vcsflags       = $(AUX_VCSFLAGS)
else
  aux_vcsflags       =
endif

ifdef AUX_MTIFLAGS
  aux_mtiflags       = $(AUX_MTIFLAGS)
else
  aux_mtiflags       =
endif

ifdef AUX_NCVFLAGS
  aux_ncvflags       = $(AUX_NCVFLAGS)
else
  aux_ncvflags       =
endif

ifeq ($(findstring methodology,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/methodology 2> /dev/null')),methodology)
  methodology_mode = $(shell cat ${tbench_dir}/methodology)
  ifeq ($(findstring uvm,$(methodology_mode)),uvm)
    vcsovmflags =
    mtiovmflags =
    ncvovmflags =
    ifdef UVM_HOME
      irun_method     = -uvmhome ${UVM_HOME}
      vcsuvmflags     = -CFLAGS -DVCS +incdir+${UVM_HOME}/src ${UVM_HOME}/src/dpi/uvm_dpi.cc
      vcselabuvmflags = -CFLAGS -DVCS ${UVM_HOME}/src/dpi/uvm_dpi.cc
      mtiuvmflags     =
      ncvuvmflags     =
    else
      irun_method     = -uvm
      vcsuvmflags     = -ntb_opts uvm
      vcselabuvmflags = -ntb_opts uvm
      mtiuvmflags     =
      ncvuvmflags     =
    endif
  else
  ifeq ($(findstring ovm,$(methodology_mode)),ovm)
    vcsuvmflags     =
    vcselabuvmflags =
    mtiuvmflags     =
    ncvuvmflags     =
    ifdef OVM_HOME
      irun_method     = -ovmhome ${OVM_HOME}
      vcsovmflags     = +incdir+${OVM_HOME}/src
      mtiovmflags     = +incdir+${OVM_HOME}/src
      ncvovmflags     = -incdir ${OVM_HOME}/src
    else
      irun_method     = -ovm
      vcsovmflags     =
      mtiovmflags     =
      ncvovmflags     =
    endif
  else
    irun_method =
    vcsuvmflags =
    vcselabuvmflags =
    mtiuvmflags =
    ncvuvmflags =
    vcsovmflags =
    mtiovmflags =
    ncvovmflags =
    nobuild = 0
  endif
  endif
else
  methodology_mode =
  irun_method =
  vcsuvmflags =
  vcselabuvmflags =
  mtiuvmflags =
  ncvuvmflags =
  vcsovmflags =
  mtiovmflags =
  ncvovmflags =
  nobuild = 0
endif

ifeq ($(findstring uvm,$(methodology_mode)),uvm)
ifeq ($(findstring sim_uvm_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/sim_uvm_options 2> /dev/null')),sim_uvm_options)
  ifeq ($(findstring disable_uvm_item_recording,$(shell /bin/grep 'disable_uvm_item_recording' ${tbench_dir}/sim_uvm_options)), disable_uvm_item_recording)
    ifeq ($(shell /bin/echo "${uvm_major_ver}==1 && ${uvm_minor_ver}<2" | /usr/bin/bc),1)
      ifeq ($(findstring M3586,${uvm_home_dir}),M3586)
        vcsuvmflags += +define+SVT_ENABLE_MANTIS_3586_FIX
        mtiuvmflags += +define+SVT_ENABLE_MANTIS_3586_FIX
        ncvuvmflags += -define SVT_ENABLE_MANTIS_3586_FIX
      else
        vcsuvmflags += +define+UVM_DISABLE_AUTO_ITEM_RECORDING
        mtiuvmflags += +define+UVM_DISABLE_AUTO_ITEM_RECORDING
        ncvuvmflags += -define UVM_DISABLE_AUTO_ITEM_RECORDING
      endif
    endif
  endif
endif
endif

ifeq ($(findstring zebu_ip_libs,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/zebu_ip_libs 2> /dev/null')),zebu_ip_libs)
  zebu_ip_libs = $(shell cat ${tbench_dir}/zebu_ip_libs)
else
  zebu_ip_libs =
endif

os_uname = $(strip $(shell /bin/uname -s))
mach_uname = $(strip $(shell /bin/uname -m))
ifeq ($(os_uname),SunOS)
ifeq ($(mach_uname),i86pc)

  bitarch            = $(shell /bin/isainfo -b)
  ld                 = ld
  elf                = -lelf
  ccflags            =
  mtivlog_flags      =
  ifdef FORCE_32BIT
    bitarch = 32
  endif
  ifeq ($(bitarch),64)
    platform         = x86sol64
    vmm_platform     = sunos5x86_64
    uvm_platform     = 64bit
    novas_platform   =
    vcsflags         =
    vcs_bitmode      = -full64
    ncverilog_flags  = +nc64bit
    ncvlog_flags     = -64BIT
    ncvhdl_flags     = -64BIT
    ccflags_dyn      = -Kpic -m32
    ldflags_dyn      = -G
    mti_tool_path    = sunos5x86_64
    export MTI_VCO_MODE = 64
  else
    platform         = x86sol32
    vmm_platform     = sunos5x86
    uvm_platform     =
    novas_platform   =
    vcsflags         =
    vcs_bitmode      =
    ncverilog_flags  =
    ncvlog_flags     =
    ncvhdl_flags     =
    ccflags_dyn      = -Kpic -m32
    ldflags_dyn      = -G
    mti_tool_path    = bin
    export MTI_VCO_MODE = 32
  endif
  vcslibs            =
  mtilibs            =
  vuser_entry        =
  cpplibs            = -lsocket
  dyn_ext            = so
  dyn_path_var       = LD_LIBRARY_PATH
else

  bitarch            = $(shell /bin/isainfo -b)
  ld                 = ld
  elf                = -lelf
  ccflags            =
  mtivlog_flags      =
  ifdef FORCE_32BIT
    bitarch = 32
  endif
  ifeq ($(bitarch),64)
    platform         = sparc64
    vmm_platform     = sunos5_64
    uvm_platform     = 64bit
    novas_platform   =
    vcsflags         =
    vcs_bitmode      = -full64
    ncverilog_flags  = +nc64bit
    ncvlog_flags     = -64BIT
    ncvhdl_flags     = -64BIT
    ccflags_dyn      = -Kpic -m64
    ldflags_dyn      = -G
    mti_tool_path    = sunos5v9
    export MTI_VCO_MODE = 64
  else
    platform         = sparcOS5
    vmm_platform     = sunos5
    uvm_platform     =
    novas_platform   =
    vcsflags         =
    vcs_bitmode      =
    ncverilog_flags  =
    ncvlog_flags     =
    ncvhdl_flags     =
    ccflags_dyn      = -Kpic -m32
    ldflags_dyn      = -G
    mti_tool_path    = bin
    export MTI_VCO_MODE = 32
  endif
  vcslibs            =
  mtilibs            =
  vuser_entry        =
  cpplibs            = -lsocket
  dyn_ext            = so
  dyn_path_var       = LD_LIBRARY_PATH
endif
else
ifeq ($(os_uname),Linux)

  bitarch            = $(shell /bin/uname -i)
  ld                 = cc
  elf                =
  ncverilog_flags    =
  ncvlog_flags       =
  ncvhdl_flags       =
  ifdef FORCE_32BIT
    bitarch = _32
  endif
  ifeq ($(findstring _64,$(bitarch)),_64)
    ifeq ($(findstring SuSE-release,$(shell /bin/sh -c '/bin/ls /etc/SuSE-release 2> /dev/null')),SuSE-release)
      platform       = suse64
    else
      platform       = amd64
    endif
    vmm_platform     = linux_x86_64
    uvm_platform     = 64bit
    novas_platform   = LINUX64
    vcsflags         =
    vcs_bitmode      = -full64
    ncverilog_flags  = +nc64bit
    ncvlog_flags     = -64BIT
    ncvhdl_flags     = -64BIT
    ccflags          = 
    ccflags_dyn      = -fPIC
    ldflags_dyn      = -shared
    mti_tool_path    = linux_x86_64
    export MTI_VCO_MODE = 64
  else
    ifeq ($(findstring SuSE-release,$(shell /bin/sh -c '/bin/ls /etc/SuSE-release 2> /dev/null')),SuSE-release)
      platform       = suse32
    else
      platform       = linux
    endif
    vmm_platform     = linux
    uvm_platform     =
    novas_platform   = LINUX
    vcsflags         =
    vcs_bitmode      =
    ccflags          = -m32
    ccflags_dyn      = -m32 -fPIC
    ldflags_dyn      = -m32 -shared
    mti_tool_path    = "bin"
    export MTI_VCO_MODE = 32
  endif
  vcslibs            =
  mtilibs            = -lc
  vuser_entry        =
  cpplibs            = -lm
  dyn_ext            = so
  dyn_path_var       = LD_LIBRARY_PATH
else
  $(error Unsupported platform)
endif
endif

lib_dir          = ${design_dir}/lib/${platform}

dw_vip_path         = vip/svt/i2c_svt/R-2020.12

ifdef INCDIR
vcs_incdir_options = +define+DESIGNWARE_INCDIR=/mnt/disk_0/softwares/vips/designware +define+SVT_LOADER_UTIL_ENABLE_DWHOME_INCDIRS +incdir+/mnt/disk_0/softwares/vips/designware/vip/svt/i2c_svt/R-2020.12/sverilog/include 
mti_incdir_options = +define+DESIGNWARE_INCDIR=/mnt/disk_0/softwares/vips/designware +define+SVT_LOADER_UTIL_ENABLE_DWHOME_INCDIRS +incdir+/mnt/disk_0/softwares/vips/designware/vip/svt/i2c_svt/R-2020.12/sverilog/include 
else
vcs_incdir_options = +incdir+${src_dir}/sverilog/vcs +incdir+${include_dir}/sverilog +incdir+${src_dir}/verilog/vcs +incdir+${include_dir}/verilog  
mti_incdir_options = +incdir+${src_dir}/sverilog/mti +incdir+${include_dir}/sverilog +incdir+${src_dir}/verilog/mti +incdir+${include_dir}/verilog  
endif

ifdef CENCRYPT
vcs_cencrypt_options = +define+SVT_ENABLE_COMMON_ENCRYPT
mti_cencrypt_options = +define+SVT_ENABLE_COMMON_ENCRYPT
endif
pa = 0
ifdef PA
  override PA = fsdb
  ifeq ($(PA),fsdb)
    pa = fsdb
    ifdef NOVAS_HOME
      ifndef VERDI_HOME
        VERDI_HOME = $(NOVAS_HOME)
      endif
    endif
    ifndef VERDI_HOME
      $(error The PA FSDB option requires the VERDI_HOME environment variable to be properly set)
    endif
    sim_run_debug += +svt_enable_pa=fsdb
    vcs_pa_options = +plusarg_save -debug_access+pp+dmptf+thread -debug_region=cell+encrypt -notice
    vcs_pa_options += -P ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/novas.tab ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/pli.a
    vcs_pa_defines = '+define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=\"fsdb\"'
  else
    pa = 1
    sim_run_debug += +svt_enable_pa
    vcs_pa_options =
    vcs_pa_defines =
  endif
else
  vcs_pa_options =
  vcs_pa_defines =
endif
ifdef WAVES
  ifeq ($(WAVES),1)
    override WAVES = dve
  endif
  vcs_waves_options  = +plusarg_save -debug_access+pp+dmptf+thread -debug_region=cell+encrypt -notice
  ncv_waves_defines  =
  ncv_waves_options  =
  mti_waves_defines  =
  mti_waves_options  =
  ifeq ($(WAVES),fsdb)
    ifdef NOVAS_HOME
      ifndef VERDI_HOME
        VERDI_HOME = $(NOVAS_HOME)
      endif
    endif
    ifndef VERDI_HOME
      $(error The WAVES FSDB option requires the VERDI_HOME environment variable to be properly set)
    endif
    vcs_waves_defines = '+define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=\"fsdb\"'
    vcs_waves_options += -P ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/novas.tab ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/pli.a
    ncv_waves_defines = +define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=fsdb
    ncv_waves_options += -L${VERDI_HOME}/share/PLI/IUS/${novas_platform}/boot -loadpli debpli:novas_pli_boot
    mti_waves_defines = +define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=fsdb
    mti_waves_options += -pli ${VERDI_HOME}/share/PLI/MODELSIM/${novas_platform}/novas_fli.so
    vcs_waves_cmd =
  else
  ifeq ($(WAVES),verdi)
    ifdef NOVAS_HOME
      ifndef VERDI_HOME
        VERDI_HOME = $(NOVAS_HOME)
      endif
    endif
    ifndef VERDI_HOME
      $(error The FSDB option requires the VERDI_HOME environment variable to be properly set)
    endif
    vcs_waves_defines = '+define+WAVES_FSDB +define+WAVES=\"fsdb\"'
    vcs_waves_options += -P ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/novas.tab ${VERDI_HOME}/share/PLI/VCS/${novas_platform}/pli.a
    vcs_waves_cmd = ; nWave -ssf test_top.fsdb
  else
  ifeq ($(WAVES),dve)
    vcs_waves_defines  = '+define+WAVES_DVE +define+WAVES=\"dve\"'
    vcs_waves_cmd = -assert dumpoff +vpdfile+vcdplus.vcd -vcd vcdplus.vcd; touch vpdplus.vpd vcdplus.vcd; cp vpdplus.vpd wavesdump; if ( -z wavesdump ) cp vcdplus.vcd wavesdump; rm -f verilog.dump; ln -s wavesdump verilog.dump; dve ${vcs_bitmode}
    ifeq ($(findstring waves.tcl,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/waves.tcl 2> /dev/null')),waves.tcl)
      ifeq ($(findstring verilog.dump,$(shell /bin/grep '\-file verilog.dump' ${tbench_dir}/waves.tcl)),verilog.dump)
        vcs_waves_cmd += -session ${tbench_dir}/waves.tcl
      else
        vcs_waves_cmd += -session ${tbench_dir}/waves.tcl -vpd verilog.dump
      endif
    else
      vcs_waves_cmd += -vpd verilog.dump
    endif
  else
    vcs_waves_defines  = '+define+WAVES_VCD +define+WAVES=\"dve\"'
    vcs_waves_cmd = -assert dumpoff +vpdfile+vpdplus.vpd -vcd vcdplus.vcd
  endif
  endif
  endif
else
  vcs_waves_defines  =
  vcs_waves_options  =
  ncv_waves_defines  =
  ncv_waves_options  =
  mti_waves_defines  =
  mti_waves_options  =
  vcs_waves_cmd      =
endif
sim_build_options =
ifeq ($(findstring sim_build_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/sim_build_options 2> /dev/null')),sim_build_options)
    sim_build_options := $(shell /usr/bin/head -1 ${tbench_dir}/sim_build_options)
    sim_build_options := $(shell echo '${sim_build_options}' | /bin/sed -e 's,-ntb_opts uvm,,' -e 's,-CFLAGS -DVCS,,' -e 's,+incdir+$${UVM_HOME}/src,,' -e 's,$${UVM_HOME}/src/dpi/uvm_dpi.cc,,')
    sim_build_options := $(shell echo '${sim_build_options}' | /bin/sed -e 's,\\\",\\\\\\\",g')
endif

vcs_build_options  =
ifeq ($(findstring vcs_build_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/vcs_build_options 2> /dev/null')),vcs_build_options)
    vcs_build_options  = $(shell /usr/bin/head -1 ${tbench_dir}/vcs_build_options)
endif

ncv_build_options  =
ifeq ($(findstring ncv_build_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/ncv_build_options 2> /dev/null')),ncv_build_options)
    ncv_build_options  = $(shell /usr/bin/head -1 ${tbench_dir}/ncv_build_options)
endif

mti_build_options  =
ifeq ($(findstring mti_build_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/mti_build_options 2> /dev/null')),mti_build_options)
    mti_build_options  = $(shell /usr/bin/head -1 ${tbench_dir}/mti_build_options)
endif

sim_elab_options  =
ifeq ($(findstring sim_elab_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/sim_elab_options 2> /dev/null')),sim_elab_options)
    sim_elab_options  = $(shell /usr/bin/head -1 ${tbench_dir}/sim_elab_options)
endif

vcs_elab_options  =
ifeq ($(findstring vcs_elab_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/vcs_elab_options 2> /dev/null')),vcs_elab_options)
    vcs_elab_options  = $(shell /usr/bin/head -1 ${tbench_dir}/vcs_elab_options)
endif

ncv_elab_options  =
ifeq ($(findstring ncv_elab_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/ncv_elab_options 2> /dev/null')),ncv_elab_options)
    ncv_elab_options  = $(shell /usr/bin/head -1 ${tbench_dir}/ncv_elab_options)
endif

mti_elab_options  =
ifeq ($(findstring mti_elab_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/mti_elab_options 2> /dev/null')),mti_elab_options)
    mti_elab_options  = $(shell /usr/bin/head -1 ${tbench_dir}/mti_elab_options)
endif

sim_run_options  =
ifeq ($(findstring sim_run_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/sim_run_options 2> /dev/null')),sim_run_options)
    sim_run_options  = $(shell /usr/bin/head -1 ${tbench_dir}/sim_run_options)
endif

vcs_run_options  =
ifeq ($(findstring vcs_run_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/vcs_run_options 2> /dev/null')),vcs_run_options)
    vcs_run_options  = $(shell /usr/bin/head -1 ${tbench_dir}/vcs_run_options)
endif

ncv_run_options  =
ifeq ($(findstring ncv_run_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/ncv_run_options 2> /dev/null')),ncv_run_options)
    ncv_run_options  = $(shell /usr/bin/head -1 ${tbench_dir}/ncv_run_options)
endif

mti_run_options  =
ifeq ($(findstring mti_run_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/mti_run_options 2> /dev/null')),mti_run_options)
    mti_run_options  = $(shell /usr/bin/head -1 ${tbench_dir}/mti_run_options)
endif

pss_map_options  =
ifeq ($(findstring pss_map_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/pss_map_options 2> /dev/null')),pss_map_options)
    pss_map_options_from_file  = $(shell /usr/bin/head -1 ${tbench_dir}/pss_map_options)
    pss_map_options  = $(addprefix ${DESIGNWARE_HOME}/${dw_vip_path}/pss/sv_uvm/map/,${pss_map_options_from_file})
endif

pss_dsl_options  =
ifeq ($(findstring pss_dsl_options,$(shell /bin/sh -c '/bin/ls ${tbench_dir}/pss_dsl_options 2> /dev/null')),pss_dsl_options)
    pss_dsl_options_from_file  = $(shell /usr/bin/head -1 ${tbench_dir}/pss_dsl_options)
    pss_dsl_action_libs = $(addprefix ${DESIGNWARE_HOME}/${dw_vip_path}/pss/sv_uvm/dsl/,${pss_dsl_options_from_file})
    vcsflags += ${VCS_HOME}/${platform}/lib/libscheduler.so
    vcselabuvmflags += ${VCS_HOME}/${platform}/lib/libscheduler.so
endif

ifneq ($(vcselabuvmflags),)
  vcselabuvmflags += ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb.so
endif

export LD_LIBRARY_PATH =

all : base_test corrupt_10b_rd_test directed_long_reset_test directed_min_dat_su_time_fm_test directed_min_dat_su_time_fs_test directed_min_dat_su_time_hs_test directed_min_dat_su_time_ss_test directed_reset_in_ten_bit_rd_test directed_test directed_test_for_10_bit_addressing_test directed_test_for_nack_for_data_test directed_test_for_retry_if_nack_test directed_test_for_slv_nack_for_data_byte_more_than_255_test directed_test_to_send_nack_after_1st_byte_of_deviceid_test directed_test_to_send_nack_after_2nd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_5th_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_6th_byte_of_deviceid_with_rollback_iteration_enable_test eeprom_2_bit_paging_wr_rd_test enable_exact_timing_checks_test general_call_test general_call_uvm_event_test i2c_cbus_10bit_addressing_coverage_test i2c_master_insert_repeated_start_after_8b_read_data_test i2c_master_insert_repeated_start_before_1b_read_data_test i2c_master_insert_stop_after_8b_read_data_test i2c_master_insert_stop_after_master_code_in_hs_mode_test i2c_master_insert_stop_before_1b_read_data_test i2c_master_insert_stop_in_10bit_addr_in_cmd_byte_test i2c_master_miss_rep_start_after_master_code_test i2c_master_miss_rep_start_after_start_byte_test i2c_master_miss_rep_start_after_start_byte_with_hs_mode_test i2c_master_send_cbus_addr_and_found_ack_test i2c_master_send_rsvd_10bit_addr_and_slv_ack_test i2c_master_send_rsvd_1111xxx_to_slv_test i2c_master_send_rsvd_addr_and_slv_ack_test i2c_master_send_wr_rd_to_10bit_addr_and_slv_nack_test i2c_master_send_wr_rd_to_7bit_addr_and_slv_nack_test i2c_master_start_txn_wo_start_test i2c_mst_10_bit_000_read_test i2c_mst_10_bit_001_read_test i2c_mst_10_bit_002_read_test i2c_mst_10_bit_005_read_test i2c_mst_10_bit_006_read_test i2c_mst_10_bit_009_read_test i2c_mst_10_bit_0f7_read_test i2c_mst_10_bit_0f9_read_test i2c_mst_10_bit_100_read_test i2c_mst_generate_stop_insted_of_repeatedstart_after_10bit_slave_address_deviceid_test i2c_mst_generate_stop_insted_of_repeatedstart_after_slave_address_deviceid_test i2c_mst_send_wr_rd_device_id_with_unknown_addr_test i2c_random_all_cmd_scenario_with_ack_nack_test random_test set_tolerance_limit_test set_tolerance_scl_high_fm_test set_tolerance_scl_high_fs_test set_tolerance_scl_high_hs_test set_tolerance_scl_high_ss_test set_tolerance_scl_low_fm_test set_tolerance_scl_low_fs_test set_tolerance_scl_low_hs_test set_tolerance_scl_low_ss_test start_byte_in_hs_mode_10_bit_test start_byte_in_hs_mode_test start_byte_with_repeated_start_10bit_test start_byte_with_repeated_start_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_enabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_enabled_test

base_test corrupt_10b_rd_test directed_long_reset_test directed_min_dat_su_time_fm_test directed_min_dat_su_time_fs_test directed_min_dat_su_time_hs_test directed_min_dat_su_time_ss_test directed_reset_in_ten_bit_rd_test directed_test directed_test_for_10_bit_addressing_test directed_test_for_nack_for_data_test directed_test_for_retry_if_nack_test directed_test_for_slv_nack_for_data_byte_more_than_255_test directed_test_to_send_nack_after_1st_byte_of_deviceid_test directed_test_to_send_nack_after_2nd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_test directed_test_to_send_nack_after_3rd_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_5th_byte_of_deviceid_with_rollback_iteration_enable_test directed_test_to_send_nack_after_6th_byte_of_deviceid_with_rollback_iteration_enable_test eeprom_2_bit_paging_wr_rd_test enable_exact_timing_checks_test general_call_test general_call_uvm_event_test i2c_cbus_10bit_addressing_coverage_test i2c_master_insert_repeated_start_after_8b_read_data_test i2c_master_insert_repeated_start_before_1b_read_data_test i2c_master_insert_stop_after_8b_read_data_test i2c_master_insert_stop_after_master_code_in_hs_mode_test i2c_master_insert_stop_before_1b_read_data_test i2c_master_insert_stop_in_10bit_addr_in_cmd_byte_test i2c_master_miss_rep_start_after_master_code_test i2c_master_miss_rep_start_after_start_byte_test i2c_master_miss_rep_start_after_start_byte_with_hs_mode_test i2c_master_send_cbus_addr_and_found_ack_test i2c_master_send_rsvd_10bit_addr_and_slv_ack_test i2c_master_send_rsvd_1111xxx_to_slv_test i2c_master_send_rsvd_addr_and_slv_ack_test i2c_master_send_wr_rd_to_10bit_addr_and_slv_nack_test i2c_master_send_wr_rd_to_7bit_addr_and_slv_nack_test i2c_master_start_txn_wo_start_test i2c_mst_10_bit_000_read_test i2c_mst_10_bit_001_read_test i2c_mst_10_bit_002_read_test i2c_mst_10_bit_005_read_test i2c_mst_10_bit_006_read_test i2c_mst_10_bit_009_read_test i2c_mst_10_bit_0f7_read_test i2c_mst_10_bit_0f9_read_test i2c_mst_10_bit_100_read_test i2c_mst_generate_stop_insted_of_repeatedstart_after_10bit_slave_address_deviceid_test i2c_mst_generate_stop_insted_of_repeatedstart_after_slave_address_deviceid_test i2c_mst_send_wr_rd_device_id_with_unknown_addr_test i2c_random_all_cmd_scenario_with_ack_nack_test random_test set_tolerance_limit_test set_tolerance_scl_high_fm_test set_tolerance_scl_high_fs_test set_tolerance_scl_high_hs_test set_tolerance_scl_high_ss_test set_tolerance_scl_low_fm_test set_tolerance_scl_low_fs_test set_tolerance_scl_low_hs_test set_tolerance_scl_low_ss_test start_byte_in_hs_mode_10_bit_test start_byte_in_hs_mode_test start_byte_with_repeated_start_10bit_test start_byte_with_repeated_start_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_p_3_bytes_10_bit_enabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_disabled_test ten_bit_addr_rd_wr_sr_3_bytes_10_bit_enabled_test : 
ifeq ($(simulator),vcsmxpcvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcsmxpcvlog-svtb is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcsmxpcsvtb test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcsmxpcsvtb test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxpcsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxpcsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),ncvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${CDS_INST_DIR}/tools/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work INCA_libs' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work INCA_libs ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# irun -access rw -messages -sv -licqueue -zlib 5 -l ./logs/simulate__$${scenario}.log ${cds_quiet} ${irun_method} ${ncvlog_flags} ${aux_ncvflags} ${sim_build_options} ${ncv_build_options} ${ncv_waves_options} ${ncv_waves_defines} ${ncvuvmflags} ${ncvovmflags} -uvmnoautocompile  -define SVT_UVM_TECHNOLOGY  -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR -nowarn IGNFMT -nowarn CUVIHR -nowarn FUNTSK  -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests ${sim_elab_options} ${ncv_elab_options} ${sim_run_debug} ${ncv_run_seed} $${sim_run_options} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb   -f top_files -f hdl_files" ; \
        if ( ! $${buildonly} ) eval irun -access rw -messages -sv -licqueue -zlib 5 -l ./logs/simulate__$${scenario}.log ${cds_quiet} ${irun_method} ${ncvlog_flags} ${aux_ncvflags} ${sim_build_options} ${ncv_build_options} ${ncv_waves_options} ${ncv_waves_defines} ${ncvuvmflags} ${ncvovmflags} -uvmnoautocompile  -define SVT_UVM_TECHNOLOGY  -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR -nowarn IGNFMT -nowarn CUVIHR -nowarn FUNTSK  -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests ${sim_elab_options} ${ncv_elab_options} ${sim_run_debug} ${ncv_run_seed} $${sim_run_options} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb   -f top_files -f hdl_files ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcszebuvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin ${ZEBU_ROOT}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage zcui.work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage zcui.work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv LD_LIBRARY_PATH ${ZEBU_ROOT}/lib:${ZEBU_IP_ROOT}/lib:${VERDI_HOME}/share/FsdbWriter/${novas_platform}' ; \
        eval setenv LD_LIBRARY_PATH ${ZEBU_ROOT}/lib:${ZEBU_IP_ROOT}/lib:${VERDI_HOME}/share/FsdbWriter/${novas_platform} ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv SNPS_ZEBU_INTERNAL_DEV_VCS 1; source ${ZEBU_ROOT}/zebu_env.csh' ; \
        eval setenv SNPS_ZEBU_INTERNAL_DEV_VCS 1; source ${ZEBU_ROOT}/zebu_env.csh ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv ZEBU_SYSTEM_DIR ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}' ; \
        eval setenv ZEBU_SYSTEM_DIR ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE} ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv FILE_CONF ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}/config/zse_configuration.tcl' ; \
        eval setenv FILE_CONF ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}/config/zse_configuration.tcl ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# zCui -c -n -u project.utf' ; \
        if ( ! $${nobuild} ) eval zCui -c -n -u project.utf ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog +define+COEMU +define+ZEBUMODE -L${ZEBU_IP_ROOT}/lib -lZebuXtor -lZebuXtorUVM ${zebu_ip_libs} ${ZEBU_IP_ROOT}/vlog/svt_dpi.sv -CFLAGS -I${ZEBU_IP_ROOT}/include -CFLAGS -I${ZEBU_ROOT}/include ${tbench_dir}/hw_platform.cpp -CFLAGS -DZEBUWORK=zcui.work/zebu.work -L${ZEBU_ROOT}/lib -lZebu -lHWAccessCommon -lZebuDB -lzRtl -lzRtlRt -lZebuRDB_ro -ntb_opts check=all -ntb_opts sv_dwfork ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY +incdir+${ZEBU_IP_ROOT}/vlog   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog +define+COEMU +define+ZEBUMODE -L${ZEBU_IP_ROOT}/lib -lZebuXtor -lZebuXtorUVM ${zebu_ip_libs} ${ZEBU_IP_ROOT}/vlog/svt_dpi.sv -CFLAGS -I${ZEBU_IP_ROOT}/include -CFLAGS -I${ZEBU_ROOT}/include ${tbench_dir}/hw_platform.cpp -CFLAGS -DZEBUWORK=zcui.work/zebu.work -L${ZEBU_ROOT}/lib -lZebu -lHWAccessCommon -lZebuDB -lzRtl -lzRtlRt -lZebuRDB_ro -ntb_opts check=all -ntb_opts sv_dwfork ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY +incdir+${ZEBU_IP_ROOT}/vlog   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcspcvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcspcvlog-svtb is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcspcsvtb  -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcspcsvtb  -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcspcsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcspcsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),vcsmxvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -o ./output/simvcsmxsvlog test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -o ./output/simvcsmxsvlog test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),ncmvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${CDS_INST_DIR}/tools/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work INCA_libs' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work INCA_libs ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -I ${CDS_INST_DIR}/tools/inca/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc' ; \
        if ( ! $${nobuild} ) eval c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -I ${CDS_INST_DIR}/tools/inca/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# ncvlog -sv -messages ${ncvlog_flags} ${sim_build_options} ${ncv_build_options} ${ncvuvmflags} ${ncvovmflags} ${aux_ncvflags} -define SVT_UVM_TECHNOLOGY   -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR  -incdir ${UVM_HOME}/src -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests  -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval ncvlog -sv -messages ${ncvlog_flags} ${sim_build_options} ${ncv_build_options} ${ncvuvmflags} ${ncvovmflags} ${aux_ncvflags} -define SVT_UVM_TECHNOLOGY   -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR  -incdir ${UVM_HOME}/src -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests  -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# ncelab ${ncvlog_flags} ${sim_elab_options} ${ncv_elab_options} -loadpli ${CDS_INST_DIR}/tools/methodology/UVM/CDNS-1.1d/sv/lib/${uvm_platform}/libuvmpli:uvm_pli_boot -nowarn WARIPR -nowarn CUVIHR -access rw test_top' ; \
        if ( ! $${nobuild} ) eval ncelab ${ncvlog_flags} ${sim_elab_options} ${ncv_elab_options} -loadpli ${CDS_INST_DIR}/tools/methodology/UVM/CDNS-1.1d/sv/lib/${uvm_platform}/libuvmpli:uvm_pli_boot -nowarn WARIPR -nowarn CUVIHR -access rw test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ncsim -messages ${ncvlog_flags} $${sim_run_options} ${ncv_run_seed} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb  -sv_lib uvm_dpi test_top" ; \
        if ( ! $${buildonly} ) eval ncsim -messages ${ncvlog_flags} $${sim_run_options} ${ncv_run_seed} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb  -sv_lib uvm_dpi test_top ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcsvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs} -o ./output/simvcssvtb  -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs} -o ./output/simvcssvtb  -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcssvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcssvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),vcsvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcsmxpcvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcsmxpcvlog-svlog is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# mkdir -p output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir -p output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcsmxpcsvlog test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcsmxpcsvlog test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxpcsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxpcsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),mtivlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${MTI_HOME}/${mti_tool_path} $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DQUESTA -I ${MTI_HOME}/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc' ; \
        if ( ! $${nobuild} ) eval c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DQUESTA -I ${MTI_HOME}/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlib work' ; \
        if ( ! $${nobuild} ) eval vlib work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlog -sv -mfcu ${mti_incdir_options} ${mti_cencrypt_options} ${mtivlog_flags} ${aux_mtiflags} ${sim_build_options} ${mti_build_options} ${mtiuvmflags} ${mtiovmflags} ${mti_waves_defines} -l ./logs/compile.log +define+SVT_UVM_TECHNOLOGY    +define+QUESTA +define+MODELTECH -suppress 2181,2217,2240,2227,2283  +incdir+${UVM_HOME}/src +incdir+${tbench_dir} +incdir+${tbench_dir}/../../env +incdir+${tbench_dir}/../env +incdir+${tbench_dir}/env +incdir+${tbench_dir}/dut +incdir+${tbench_dir}/hdl_interconnect +incdir+${tbench_dir}/tests  -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlog -sv -mfcu ${mti_incdir_options} ${mti_cencrypt_options} ${mtivlog_flags} ${aux_mtiflags} ${sim_build_options} ${mti_build_options} ${mtiuvmflags} ${mtiovmflags} ${mti_waves_defines} -l ./logs/compile.log +define+SVT_UVM_TECHNOLOGY    +define+QUESTA +define+MODELTECH -suppress 2181,2217,2240,2227,2283  +incdir+${UVM_HOME}/src +incdir+${tbench_dir} +incdir+${tbench_dir}/../../env +incdir+${tbench_dir}/../env +incdir+${tbench_dir}/env +incdir+${tbench_dir}/dut +incdir+${tbench_dir}/hdl_interconnect +incdir+${tbench_dir}/tests  -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'set SolveArrayResizeMax 0\nonbreak resume\nrun -all\nquit\n'" > sim.cmd' ; \
        if ( ! $${nobuild} ) eval "printf 'set SolveArrayResizeMax 0\nonbreak resume\nrun -all\nquit\n'" > sim.cmd ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# vsim ${sim_run_debug} ${mti_run_seed} $${sim_run_options} ${mti_run_options} ${mti_waves_options} -l ./logs/simulate__$${scenario}.log -permit_unmatched_virtual_intf -suppress 3534 -c -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb  -sv_lib uvm_dpi -do sim.cmd work.test_top" ; \
        if ( ! $${buildonly} ) eval vsim ${sim_run_debug} ${mti_run_seed} $${sim_run_options} ${mti_run_options} ${mti_waves_options} -l ./logs/simulate__$${scenario}.log -permit_unmatched_virtual_intf -suppress 3534 -c -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb  -sv_lib uvm_dpi -do sim.cmd work.test_top ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcsscvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage lib' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage lib ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage lib' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage lib ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > DEFAULT\nDEFAULT : ./lib\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > DEFAULT\nDEFAULT : ./lib\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog -timescale=$${timescale} ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} +define+SYNOPSYS_SV +define+SEP_CMP -lca -sep_cmp -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/verilog+${include_dir}/svtb+${tbench_dir}/../env+${tbench_dir}/env+${tbench_dir}/dut+${tbench_dir}/hdl_interconnect ${vcslibs}  -f modif_files -f pkg_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog -timescale=$${timescale} ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} +define+SYNOPSYS_SV +define+SEP_CMP -lca -sep_cmp -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/verilog+${include_dir}/svtb+${tbench_dir}/../env+${tbench_dir}/env+${tbench_dir}/dut+${tbench_dir}/hdl_interconnect ${vcslibs}  -f modif_files -f pkg_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs ${vcs_bitmode} ${vcsflags} -l ./logs/compile.log -lca -sep_cmp  -ntb_opts use_sigprop  SYNOPSYS_VIP_PACKAGE' ; \
        if ( ! $${nobuild} ) eval vcs ${vcs_bitmode} ${vcsflags} -l ./logs/compile.log -lca -sep_cmp  -ntb_opts use_sigprop  SYNOPSYS_VIP_PACKAGE ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog -timescale=$${timescale} ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} +define+SYNOPSYS_SV +define+SEP_CMP -lca -sep_cmp -partition CORE -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/verilog+${include_dir}/svtb+${tbench_dir}/../env+${tbench_dir}/env+${tbench_dir}/dut+${tbench_dir}/hdl_interconnect ${vcslibs}  -f envif_files -f test_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog -timescale=$${timescale} ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} +define+SYNOPSYS_SV +define+SEP_CMP -lca -sep_cmp -partition CORE -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/verilog+${include_dir}/svtb+${tbench_dir}/../env+${tbench_dir}/env+${tbench_dir}/dut+${tbench_dir}/hdl_interconnect ${vcslibs}  -f envif_files -f test_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs ${vcs_bitmode} ${vcsflags} -l ./logs/compile.log -lca -sep_cmp -sverilog  -ntb_opts use_sigprop  CORE' ; \
        if ( ! $${nobuild} ) eval vcs ${vcs_bitmode} ${vcsflags} -l ./logs/compile.log -lca -sep_cmp -sverilog  -ntb_opts use_sigprop  CORE ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs ${vcs_bitmode} ${vcsflags} -lca -sep_cmp -sverilog  -ntb_opts use_sigprop  -ntb_opts genShellOnly CORE' ; \
        if ( ! $${nobuild} ) eval vcs ${vcs_bitmode} ${vcsflags} -lca -sep_cmp -sverilog  -ntb_opts use_sigprop  -ntb_opts genShellOnly CORE ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs ${vcs_bitmode} ${vcsflags} -lca -sep_cmp -sverilog -Mdir=./output/csrc +define+SVTB_SEP_COMP -ntb_vl  -ntb_opts use_sigprop  +incdir+${tbench_dir}/env+${tbench_dir}/dut $${program_name}.svshell -f top_files -o ./output/simvcsscsvtb' ; \
        if ( ! $${nobuild} ) eval vcs ${vcs_bitmode} ${vcsflags} -lca -sep_cmp -sverilog -Mdir=./output/csrc +define+SVTB_SEP_COMP -ntb_vl  -ntb_opts use_sigprop  +incdir+${tbench_dir}/env+${tbench_dir}/dut $${program_name}.svshell -f top_files -o ./output/simvcsscsvtb ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsscsvtb $${sim_run_options} ${vcs_run_options} -sep_cmp=CORE -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsscsvtb $${sim_run_options} ${vcs_run_options} -sep_cmp=CORE -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),vcsmxpipvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcsmxpipvlog-svtb is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_enum_pkg -lca; ' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_enum_pkg -lca;  ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} -fastpartcomp=j4 -integ -lca -o ./output/simvcsmxpipsvtb test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} -fastpartcomp=j4 -integ -lca -o ./output/simvcsmxpipsvtb test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxpipsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxpipsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),mtivlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${MTI_HOME}/${mti_tool_path} $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DQUESTA -I ${MTI_HOME}/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc' ; \
        if ( ! $${nobuild} ) eval c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DQUESTA -I ${MTI_HOME}/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlib work' ; \
        if ( ! $${nobuild} ) eval vlib work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlog -sv -mfcu ${aux_mtiflags} ${sim_build_options} ${mti_build_options} -l ./logs/compile.log +define+QUESTA +define+MODELTECH -suppress 2181,2217,2240,2227,2283 +incdir+${UVM_HOME}/src +incdir+${include_dir}/svtb +incdir+${include_dir}/verilog +incdir+${include_dir}/sverilog +incdir+${src_dir}/sverilog/mti +incdir+${tbench_dir} +incdir+${tbench_dir}/../../env +incdir+${tbench_dir}/../env +incdir+${tbench_dir}/env +incdir+${tbench_dir}/dut +incdir+${tbench_dir}/hdl_interconnect +incdir+${tbench_dir}/tests -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlog -sv -mfcu ${aux_mtiflags} ${sim_build_options} ${mti_build_options} -l ./logs/compile.log +define+QUESTA +define+MODELTECH -suppress 2181,2217,2240,2227,2283 +incdir+${UVM_HOME}/src +incdir+${include_dir}/svtb +incdir+${include_dir}/verilog +incdir+${include_dir}/sverilog +incdir+${src_dir}/sverilog/mti +incdir+${tbench_dir} +incdir+${tbench_dir}/../../env +incdir+${tbench_dir}/../env +incdir+${tbench_dir}/env +incdir+${tbench_dir}/dut +incdir+${tbench_dir}/hdl_interconnect +incdir+${tbench_dir}/tests -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'set SolveArrayResizeMax 0\nonbreak resume\nrun -all\nquit\n'" > sim.cmd' ; \
        if ( ! $${nobuild} ) eval "printf 'set SolveArrayResizeMax 0\nonbreak resume\nrun -all\nquit\n'" > sim.cmd ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# vsim $${sim_run_options} ${mti_run_options} -l ./logs/simulate__$${scenario}.log -permit_unmatched_virtual_intf -suppress 3534 -c -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb -sv_lib uvm_dpi -do sim.cmd work.test_top" ; \
        if ( ! $${buildonly} ) eval vsim $${sim_run_options} ${mti_run_options} -l ./logs/simulate__$${scenario}.log -permit_unmatched_virtual_intf -suppress 3534 -c -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb -sv_lib uvm_dpi -do sim.cmd work.test_top ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),ncvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${CDS_INST_DIR}/tools/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work INCA_libs' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work INCA_libs ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DNC_VERILOG -DCADENCE -I ${CDS_INST_DIR}/tools/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc' ; \
        if ( ! $${nobuild} ) eval c++ -Wno-deprecated ${ccflags_dyn} ${ldflags_dyn} -DNC_VERILOG -DCADENCE -I ${CDS_INST_DIR}/tools/include -o uvm_dpi.so ${UVM_HOME}/src/dpi/uvm_dpi.cc ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# irun -access rw -messages -sv -licqueue -zlib 5 -l ./logs/simulate__$${scenario}.log ${cds_quiet} ${irun_method} ${ncvlog_flags} ${aux_ncvflags} ${sim_build_options} ${ncv_build_options} -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR -nowarn IGNFMT -nowarn CUVIHR -nowarn FUNTSK -incdir ${UVM_HOME}/src -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests ${sim_elab_options} ${ncv_elab_options} $${sim_run_options} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb -sv_lib uvm_dpi -f hdl_files" ; \
        if ( ! $${buildonly} ) eval irun -access rw -messages -sv -licqueue -zlib 5 -l ./logs/simulate__$${scenario}.log ${cds_quiet} ${irun_method} ${ncvlog_flags} ${aux_ncvflags} ${sim_build_options} ${ncv_build_options} -define CADENCE -errormax 5 -nowarn NOTIND -nowarn PMBDVX -nowarn ECBICP -nowarn AAMNSD -nowarn LVLFNC -nowarn PMBMDV -nowarn WARIPR -nowarn IGNFMT -nowarn CUVIHR -nowarn FUNTSK -incdir ${UVM_HOME}/src -incdir ${src_dir}/sverilog/ncv -incdir ${include_dir}/sverilog -incdir ${src_dir}/verilog/ncv -incdir ${include_dir}/verilog -incdir ${tbench_dir} -incdir ${tbench_dir}/../../env -incdir ${tbench_dir}/../env -incdir ${tbench_dir}/env -incdir ${tbench_dir}/dut -incdir ${tbench_dir}/hdl_interconnect -incdir ${tbench_dir}/tests ${sim_elab_options} ${ncv_elab_options} $${sim_run_options} ${ncv_run_options} -nowarn SYSFMW -sv_lib ${DESIGNWARE_HOME}/vip/common/latest/C/lib/${platform}/VipCommonNtb -sv_lib uvm_dpi -f hdl_files ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),vcsvhdl-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.vhd >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.vhd >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.vhd | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/vloganalyze.log ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} +define+DW_VIP_USE_SVTB_WRAPPER +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/{verilog,svtb} +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect} ${vcslibs}  -f vlog_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/vloganalyze.log ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} +define+DW_VIP_USE_SVTB_WRAPPER +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera +incdir+${include_dir}/{verilog,svtb} +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect} ${vcslibs}  -f vlog_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vhdlan -l ./logs/vhdlanalyze.log ${vcs_bitmode} ${vcsflags} -f vhdl_files' ; \
        if ( ! $${nobuild} ) eval vhdlan -l ./logs/vhdlanalyze.log ${vcs_bitmode} ${vcsflags} -f vhdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log cfgtest -Mdir=./output/csrc -ntb_opts use_sigprop -t NS ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} -o ./output/simvhdlsvtb' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log cfgtest -Mdir=./output/csrc -ntb_opts use_sigprop -t NS ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} -o ./output/simvhdlsvtb ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvhdlsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run" ; \
        if ( ! $${buildonly} ) eval ./output/simvhdlsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif
ifeq ($(simulator),vcsmxpipvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcsmxpipvlog-svlog is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# mkdir -p output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir -p output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} ${vcs_quiet} ${vcs_bitmode} ${vcsflags} ${sim_build_options} ${vcs_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_enum_pkg -lca; ' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_uvm_pkg -lca; vcs -l ./logs/compile_package.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -fastpartcomp=j4 -genip svt_i2c_enum_pkg -lca;  ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -fastpartcomp=j4 -integ -lca -o ./output/simvcsmxpipsvlog test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} $${program_name} -fastpartcomp=j4 -integ -lca -o ./output/simvcsmxpipsvlog test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxpipsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxpipsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcszsimvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin ${ZEBU_ROOT}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage zcui.work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage zcui.work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv LD_LIBRARY_PATH ${ZEBU_ROOT}/lib:${ZEBU_IP_ROOT}/lib' ; \
        eval setenv LD_LIBRARY_PATH ${ZEBU_ROOT}/lib:${ZEBU_IP_ROOT}/lib ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv ZEBU_SYSTEM_DIR ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}' ; \
        eval setenv ZEBU_SYSTEM_DIR ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE} ; \
        if ( $${status} ) exit( 9 ) ; \
        echo '# setenv FILE_CONF ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}/config/zse_configuration.tcl' ; \
        eval setenv FILE_CONF ${ZEBU_SYSTEM_ROOT}/${ZEBU_DEVICE}/config/zse_configuration.tcl ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# zCui -n --sem -u project.utf' ; \
        if ( ! $${nobuild} ) eval zCui -n --sem -u project.utf ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog +define+COEMU +define+ZEBUMODE -L${ZEBU_IP_ROOT}/lib -lZebuXtor -lZebuXtorUVM ${zebu_ip_libs} ${ZEBU_IP_ROOT}/vlog/svt_dpi.sv -CFLAGS -I${ZEBU_IP_ROOT}/include -CFLAGS -I${ZEBU_ROOT}/include ${tbench_dir}/hw_platform.cpp -CFLAGS -DZEBUWORK=zcui.work/zebu.work -L${ZEBU_ROOT}/lib -lZebu -lHWAccessCommon -lZebuDB -lzRtl -lzRtlRt -lZebuRDB_ro -ntb_opts check=all -ntb_opts sv_dwfork ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY +incdir+${ZEBU_IP_ROOT}/vlog   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog +define+COEMU +define+ZEBUMODE -L${ZEBU_IP_ROOT}/lib -lZebuXtor -lZebuXtorUVM ${zebu_ip_libs} ${ZEBU_IP_ROOT}/vlog/svt_dpi.sv -CFLAGS -I${ZEBU_IP_ROOT}/include -CFLAGS -I${ZEBU_ROOT}/include ${tbench_dir}/hw_platform.cpp -CFLAGS -DZEBUWORK=zcui.work/zebu.work -L${ZEBU_ROOT}/lib -lZebu -lHWAccessCommon -lZebuDB -lzRtl -lzRtlRt -lZebuRDB_ro -ntb_opts check=all -ntb_opts sv_dwfork ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY +incdir+${ZEBU_IP_ROOT}/vlog   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests}  -o ./output/simvcssvlog -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcssvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcspcvlog-svlog)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set pa = ${pa}; \
        set design_dir = ${design_dir}; \
        set tbench_name = ${tbench_name}; \
        set tbench_dir = ${tbench_dir}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( ! -f "${tbench_dir}/pc.optcfg" ) \
            eval 'echo "Simulator vcspcvlog-svlog is not supported by this example" ; exit 0'; \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        if ( -f pss_dsl_options ) eval gmake generate_dsl_solution ; \
        if ( -f pss_map_options ) eval gmake pss_tr_map ; \
        if ( ! $${nobuild} ) echo '# mkdir -p output logs coverage' ; \
        if ( ! $${nobuild} ) eval mkdir -p output logs coverage ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcspcsvlog -f top_files -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log ${vcs_quiet} -Mdir=./output/csrc ${vcs_incdir_options} ${vcs_cencrypt_options} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options} ${vcs_pa_options} ${vcs_lca_option} +define+SVT_UVM_TECHNOLOGY   +define+SYNOPSYS_SV  ${vcslibs} +incdir+${tbench_dir}/{.,../../env,../env,env,dut,hdl_interconnect,lib,tests} -partcomp -fastpartcomp=j4 +optconfigfile+${tbench_dir}/pc.optcfg -lca -o ./output/simvcspcsvlog -f top_files -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcspcsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcspcsvlog ${sim_run_debug} ${vcs_run_seed} $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ) ; \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1 ; \
        if ( $${pa} == "fsdb" ) \
            ${VERDI_HOME}/bin/verdi -workMode protocolDebug -ssf test_top.fsdb ; \
        if ( $${pa} == "1" ) \
            ${DESIGNWARE_HOME}/bin/pa -dir . -ts
endif
ifeq ($(simulator),vcsmxvlog-svtb)
	@set scenario = $@; \
        set norun = ${norun}; \
        set nobuild = ${nobuild}; \
        set buildonly = ${buildonly}; \
        set noclean = ${noclean}; \
        set design_dir = ${design_dir}; \
        set tbench_dir = ${tbench_dir}; \
        set tbench_name = ${tbench_name}; \
        set include_dir = ${include_dir}; \
        set platform = ${platform}; \
        set simulator = ${simulator}; \
        set ccflags = ${ccflags}; \
        set ccflags_dyn = "${ccflags_dyn}"; \
        set ldflags_dyn = "${ldflags_dyn}"; \
        set sim_build_options = "${sim_build_options}"; \
        set sim_elab_options = "${sim_elab_options}"; \
        set sim_run_options = "${sim_run_options}"; \
        set path = ( ${VCS_HOME}/bin $$path ); \
        if ( -f "${tbench_dir}/prescript" ) \
            source ${tbench_dir}/prescript || eval exit 1; \
        /bin/rm -f hdl_files; \
        /bin/touch hdl_files; \
        /bin/rm -f modif_files; \
        /bin/touch modif_files; \
        /bin/rm -f envif_files; \
        /bin/touch envif_files; \
        /bin/rm -f pkg_files; \
        /bin/touch pkg_files; \
        /bin/rm -f top_files; \
        /bin/touch top_files; \
        /bin/rm -f test_files; \
        /bin/touch test_files; \
        /bin/rm -f tb_i2c_svt_uvm_basic_sys.config; \
        /bin/touch tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cSlaveAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterMonitorSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cMasterAgentSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo program I2cEnvSvtProgram.vrp >> tb_i2c_svt_uvm_basic_sys.config; \
        /bin/echo ${tbench_dir}/top.sv >> hdl_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cMasterMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveMonitorSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cSlaveAgentSvtInterface.svi >> modif_files; \
        /bin/echo ${include_dir}/svtb/I2cEnvSvtInterface.svi >> modif_files; \
        /bin/echo /mnt/disk_0/IC/basic/vip/i2c/examples/sverilog/i2c_svt/tb_i2c_svt_uvm_basic_sys/env/i2c_reset_if.svi >> envif_files; \
        /bin/echo ${tbench_dir}/top.sv >> top_files; \
        /bin/echo ${tbench_dir}/tests/ts.$@.sv >> test_files; \
        set program_name = `/bin/egrep '^\s*program\s*\w*\s*' ${tbench_dir}/tests/ts.$@.sv | /bin/sed -e 's/program//' -e 's/automatic//' -e 's/\w*//' | /usr/bin/cut -d "(" -f1`; \
        set timescale = `/bin/egrep '^\s*.timescale\s*\w*\s*' ${tbench_dir}/top.sv | /bin/sed -e 's/ *//g' | /bin/sed -e 's/.timescale//'`; \
        if ( ! $${nobuild} ) echo '# rm -rf output logs coverage work' ; \
        if ( ! $${nobuild} ) eval rm -rf output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# mkdir output logs coverage work' ; \
        if ( ! $${nobuild} ) eval mkdir output logs coverage work ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup' ; \
        if ( ! $${nobuild} ) eval "printf 'WORK > work\nwork : ./work\n'" > synopsys_sim.setup ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options}' ; \
        if ( ! $${nobuild} ) eval vlogan -ntb_opts uvm-1.${uvm_minor_ver} -ntb_opts vera_compat ${vcs_quiet} ${vcs_bitmode} +define+UVM_DISABLE_AUTO_ITEM_RECORDING ${vcsflags} ${sim_build_options} ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files' ; \
        if ( ! $${nobuild} ) eval vlogan -l ./logs/analyze.log ${vcs_quiet} ${vcsuvmflags} ${vcsovmflags} ${vcs_bitmode} ${vcsflags} ${aux_vcsflags} -sverilog ${sim_build_options} ${vcs_build_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_lca_option} +define+SYNOPSYS_SV -ntb_define NTB  -ntb_opts use_sigprop  -ntb_vipext .ov +define+NTB -ntb_incdir ${include_dir}/vera+${src_dir}/vera+${tbench_dir}/env+${tbench_dir}/hdl_interconnect +incdir+${include_dir}/{verilog,svtb,sverilog} +incdir+${src_dir}/sverilog/vcs +incdir+${tbench_dir}/{.,../env,env,dut,hdl_interconnect,lib,tests} ${vcslibs}  -f hdl_files ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${nobuild} ) echo '# vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -o ./output/simvcsmxsvtb test_top' ; \
        if ( ! $${nobuild} ) eval vcs -l ./logs/compile.log -Mdir=./output/csrc -ntb_opts use_sigprop ${vcselabuvmflags} ${vcs_bitmode} ${vcsflags} ${sim_elab_options} ${vcs_elab_options} ${vcs_waves_options} ${vcs_pa_options} -o ./output/simvcsmxsvtb test_top ; \
        if ( $${status} ) exit( 9 ) ; \
        if ( ! $${buildonly} ) echo "# ./output/simvcsmxsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd}" ; \
        if ( ! $${buildonly} ) eval ./output/simvcsmxsvtb $${sim_run_options} ${vcs_run_options} -l ./logs/simulate__$${scenario}.log run ${vcs_waves_cmd} ; \
        if ( $${status} ) \
            exit( 10 ); \
        sleep 2 ; \
        if ( -f "${tbench_dir}/postscript" ) \
            source ${tbench_dir}/postscript || eval exit 1
endif

generate_dsl_solution : ${pss_dsl_action_libs}
	@echo 'Generating the DSL solution...'
	cd dsl ; \
  vcs -dsl -dsl_root=root ${pss_dsl_action_libs} test.dsl ; \
  ./simv +protobuf ; 

pss_tr_map :
	@echo 'Executing the PSS Test Realization phase...'
	cd vcus_map ; \
  pss_map -debug -config instance_map.xml ${pss_map_options} ; 

clean : 
	@/bin/rm -rf hdl_files top_files synopsys_sim.setup work vcdplus.vcd vpdplus.vpd vc_hdrs.h wavesdump DVEfiles simv.cm simv.daidir simv.vdb verilog.dump test_top.fsdb INCA_libs vsim.wlf sim.cmd ncelab.log ncvlog.log ncsim.log workspace ucli.key pli.tab msglog.o >& /dev/null; /bin/rm -rf logs/* >& /dev/null; /bin/rm -rf output/* >& /dev/null; /bin/rm -rf coverage/* >& /dev/null; /bin/rm -rf *.xml >& /dev/null; /bin/rm -rf *.vcd >& /dev/null; /bin/rm -rf *.vpd >& /dev/null; /bin/rm -rf *.svd >& /dev/null; /bin/rm -rf *.data_trace >& /dev/null; /bin/rm -rf *.physical_service_trace >& /dev/null; /bin/rm -rf svt_debug.out svt_debut.transcript >& /dev/null; /bin/rm -rf partitionlib >& /dev/null; /bin/rm -rf *.mempa >& /dev/null; /bin/rm -rf *.link_service_trace >& /dev/null; true


help : 
	@echo "Usage: gmake USE_SIMULATOR=<simulator> [VERBOSE=1] [DEBUG_OPTS=1] [SEED=<value>] [FORCE_32BIT=1] [WAVES=fsdb|verdi|dve|vcd] [NOBUILD=1] [BUILDONLY=1] [PA=1] [<scenario> ...]"
	@echo "       Valid simulators are: vcsmxpcvlog ncvlog vcszebuvlog vcspcvlog vcsmxvlog ncmvlog vcsvlog mtivlog vcsscvlog vcsmxpipvlog vcsvhdl vcszsimvlog"
	@echo "       Valid scenarios are:  test entry under tests directory, sans the ts. prefix and file extension"

