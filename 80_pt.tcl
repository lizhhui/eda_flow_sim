##############################################################
set s40_lib "/file/library/smic40ll"

set sram_list ""
set sram_list [concat $sram_list sram16384x32]
set sram_list [concat $sram_list sram2048x128]
set sram_list [concat $sram_list sram2048x16]
set sram_list [concat $sram_list sram2048x18]
set sram_list [concat $sram_list sram2048x20]
set sram_list [concat $sram_list sram2048x24]
set sram_list [concat $sram_list sram2048x25]
set sram_list [concat $sram_list sram2048x32]
set sram_list [concat $sram_list sram2048x34]
set sram_list [concat $sram_list sram2048x64]
set sram_list [concat $sram_list sram2048x65]
set sram_list [concat $sram_list sram2080x128]
set sram_list [concat $sram_list sram2080x32]
set sram_list [concat $sram_list sram2080x64]
set sram_list [concat $sram_list sram3072x64]
set sram_list [concat $sram_list sram3200x22]
set sram_list [concat $sram_list sram3328x32]
set sram_list [concat $sram_list sram4096x128]
set sram_list [concat $sram_list sram4096x25]
set sram_list [concat $sram_list sram4096x32]
set sram_list [concat $sram_list sram4096x64]
set sram_list [concat $sram_list sram7168x16]
set sram_list [concat $sram_list sram8192x16]
set sram_list [concat $sram_list sram8192x32]
set sram_list [concat $sram_list sram8192x64]

set S40NLLUHSSPRURK ""
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X256Y8D36B4]
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X128Y4D31B4]
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X256Y4D32B4]
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X32Y4D30B4]
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X48Y4D43B4]
set S40NLLUHSSPRURK [concat $S40NLLUHSSPRURK S40NLLUHSSPRURK_X32Y4D20B4]


##############################################################
set power_enable_analysis TRUE
#set power_analysis_mode time_based

set search_path        "/file/pub/aw1680/digital/netlist/"


set link_path           [list * ]
# standard cell
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_ULVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC50_ULVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_LVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC50_LVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_RVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC50_RVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_PEK_ULVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_PEK_LVT_V0p1/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC4050_PMK_C2_V0p0/synopsys/1.1v]
set search_path         [concat $search_path $s40_lib/SCC40NLL_VHSC40_PMK_RVT_V0p0a/synopsys/LH_1.1v_1.1v]
set search_path         [concat $search_path /home/digital4/lizh/project/library]
set link_path           [concat $link_path scc40nll_vhsc40_ulvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc50_ulvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc40_lvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc50_lvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc40_rvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc50_rvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc40_pek_ulvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc40_pek_lvt_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc4050_pmk_c2_tt_v1p1_25c_basic.db]
set link_path           [concat $link_path scc40nll_vhsc40_pmk1_rvt_tt_v1p1_v1p1_25c_ccs.db]
set link_path           [concat $link_path AW_BUF_HEAD_tc.db]
# SRAM
foreach sram $sram_list {
    set search_path         [concat $search_path /file/pub/memory/smic40_arm/sram/$sram]
    set link_path           [concat $link_path /file/pub/memory/smic40_arm/sram/$sram/${sram}_tt_1p10v_1p10v_25c.db]
}
# S40NLLUHSSPRURK_A53
foreach sp $S40NLLUHSSPRURK {
    set search_path         [concat $search_path /file/library/smic40ll/S40NLLUHSSPRURK/V0P2PB/PEK/lib_nov]
    set link_path           [concat $link_path   /file/library/smic40ll/S40NLLUHSSPRURK/V0P2PB/PEK/lib_nov/${sp}_TT_1.1_25.db]
}

# memory_for_cpu]
# custom_sc_for_cpu macro_for_cpu

read_verilog            {cortexa7core.v cortexa7core_pg.v ac327_subsystem.v cpu_hcell_s40.v}
current_design        ac327_subsystem
#read_verilog            {cortexa7core.v}
#current_design          cortexa7core
link


#####################################################################
#       set transition time / annotate parasitics
#####################################################################
#read_sdc ../../netlist/ac327.sdc
#source ../../netlist/ac327_subsystem_fun_wc.sdc
#set_disable_timing [get_lib_pins ssc_core_typ/*/G]
read_parasitics ./80_saif/ac327_subsystem_typical_25.spef.gz


#####################################################################
#       check/update/report timing
#####################################################################
#check_timing
#update_timing
#report_timing

#####################################################################
#       read switching activity file
#####################################################################
#read_saif ./80_saif/80_maxpower_5_quad.saif -strip_path sim/aw1680/u_core/u_cpu
read_saif ./80_saif/80_dhrystone_8_quad.saif -strip_path sim/aw1680/u_core/u_cpu

#####################################################################
#       check/update/report power
#####################################################################
report_switching_activity
report_power
current_instance x_ac327_subsystem_core/x_CORTEXA7INTEGRATION/u_cortexa7_u_cortexa7core_0
#check_power
#set_power_analysis_options -waveform_format fsdb -waveform_output power
#update_power
report_power

quit
