###############################################################################
# File Name         : formality.tcl
# Purpose 	    : for equivalence checking a gate level netlist to the RTL
###############################################################################
sh hostname
sh date

#### set option
#set_host_options -max_cores 4
set op_con wcl

set synopsys_auto_setup true
set_svf ./data/${TOP_DESIGN}.svf
# Identfy the version of DesignWare used in building the netlist
set hdlin_dwroot  $SYN_DIR
set hdlin_unresolved_modules black_box
set hdlin_ignore_full_case false
set hdlin_ignore_parallel_case false
set hdlin_warn_on_mismatch_message "FMR_VLOG-091 FMR_ELAB-118 FMR_ELAB-115 FMR_ELAB-116 FMR_ELAB-147 FMR_VLOG-079"
set verification_set_undriven_signals x
set verification_assume_reg_init none
set verification_failing_point_limit 100
set verification_blackbox_match_mode identity
set verification_timeout_limit "8:0:0"

# Identify the mode of clock gating if used in the design
set verification_clock_gate_hold_mode low	

# Read in the technology library.
source -echo -verbose $COMMON/${SYN_TECH}.tcl

### Read in the Reference Design ( -> r )
source -echo -verbose $COMMON/read_design.tcl
read_verilog -container r -libname WORK ../data/syn_define.v
#read_verilog -libname WORK -netlist -c r ./data/${TOP_DESIGN}.v
set_reference_design  r:/WORK/${TOP_DESIGN}
set_top r:/WORK/${TOP_DESIGN}
#### Read in the Implementation Design ( -> i )
#read_verilog -libname WORK -netlist -c i ./layout/${TOP_DESIGN}_post_route.v
#read_verilog -libname WORK -netlist -c i ./data/${TOP_DESIGN}_dft.v
read_verilog -libname WORK -netlist -c i /file/pub/aw1680/icc/netlist/netlist_imp/ss_top.v
set_implementation_design  i:/WORK/${TOP_DESIGN}
set_top i:/WORK/${TOP_DESIGN}

# Disable  test & scan mode. 
 set_constant  i:/WORK/${TOP_DESIGN}/scan_mode 0 -type port  ;## test mode
 set_constant  r:/WORK/${TOP_DESIGN}/scan_mode 0 -type port  ;## test mode
 set_constant  i:/WORK/${TOP_DESIGN}/scan_en 0 -type port  ;## SCANENBALE
# set_constant  r:/WORK/${TOP_DESIGN}/scan_en 0 -type port  ;## SCANENBALE

# Verify the Design
match
report_unmatched_points
echo " start report datapath"
report_unmatched_points -datapath
if [ verify r:/WORK/${TOP_DESIGN} i:/WORK/${TOP_DESIGN} ] {
  echo "RTL2Gate Verification PASSED "
} else {
  echo "RTL2Gate Verification FAILED "
report_failing_points > point_failing.rpt
#save_session -replace ./data/${TOP_DESIGN}.fss
}

sh date
#quit
