set power_enable_analysis TRUE
set power_analysis_mode time_based


#####################################################################
#       link design
#####################################################################
set search_path         "/file/pub/aw1689/icc/netlist/netlist_imp"

#set op_con ss_typical_max_0p99v_m40c
#set sclib_name sc12mc_cln40lp_base_ulvt_c40_ss_typical_max_0p99v_m40c
set sclib_name tcbn55lpbwp12ttc
set lvt_sclib_name tcbn55lpbwp12tlvttc
set hvt_sclib_name tcbn55lpbwp12thvttc
set 1d2_sclib_name tcbn55lpbwp12ttc1d21d2
set 1d2_lvt_sclib_name tcbn55lpbwp12tlvttc1d21d2
set 1d2_hvt_sclib_name tcbn55lpbwp12thvttc1d21d2




set LPlib ""
#set target_library      [list ${sclib_name}.db]
#set target_library [concat $target_library $LPlib]
#set synthetic_library [list standard.sldb dw_foundation.sldb ]
set link_path           [list * ]
#set link_path           [concat $link_path $target_library]
#set link_path           [concat $link_path $synthetic_library]
set search_path         [concat  $search_path {.} ]
#set search_path  [concat  $search_path /file/library/tsmc40lp/sc9mc_base_rvt_c40/r1p0/db]
set search_path  [concat  $search_path /file/library/tsmc55lp/tcbn55lpbwp12t_200a/Front_End/timing_power_noise/NLDM/tcbn55lpbwp12t_200a /file/library/tsmc55lp/tcbn55lpbwp12thvt_200a/Front_End/timing_power_noise/NLDM/tcbn55lpbwp12thvt_200a /file/library/tsmc55lp/tcbn55lpbwp12tlvt_200a/Front_End/timing_power_noise/NLDM/tcbn55lpbwp12tlvt_200a ]
set search_path  [concat  $search_path /home/digital1/ksg/project/aw1651/netlist]
set link_path           [concat $link_path  ${sclib_name}.db ${hvt_sclib_name}.db ${lvt_sclib_name}.db ${1d2_sclib_name}.db ${1d2_hvt_sclib_name}.db ${1d2_lvt_sclib_name}.db]

# Define hardblock search path
set arm_ram [list rf1p128x30lvt rf1p192x86lvt rf1p512x72lvt rf1p128x20lvt rf1p192x86lvt rf1p512x31lvt rf1p512x72lvt rf1p128x30lvt rf1p128x30lvt rf1p1024x32lvt rf1p128x22lvt rf1p128x8lvt rf1p256x22lvt rf1p32x24lvt rf1p32x26lvt rf1p32x30lvt rf1p512x32lvt rf1p256x72lvt rf1p256x64lvt rf1p256x32lvt rf1p256x24lvt rf1p256x16lvt rf1p256x4lvt rf1p16x32lvt rf1p16x92lvt rf1p512x65 rf1p256x46 rf1p256x16 rf1p1024x16 ]
foreach c_block $arm_ram {
    set search_path [concat  $search_path /home/digital1/ksg/share/tsmc55/hprf1p/${c_block}/NLDM ]
    set link_path [concat $link_path ${c_block}_ss1p08v125c.db ]
}
set sys_sram [list  sram120x88 sram128x72 sram128x84 sram128x64 sram256x8 sram256x32 sram560x32 sram576x48 sram960x32 sram928x32 sram1024x24 sram1024x32 sram1024x64 sram1024x128 sram3072x64 sram4096x32 sram768x32 sram3328x32 sram6144x8 sram480x32 sram480x16 sram512x32 sram2048x16 sram2048x65 sram1024x48]
foreach a_block $sys_sram {
    set search_path [concat  $search_path /home/digital1/ksg/share/tsmc55/sram/${a_block}/NLDM ]
    set link_path [concat $link_path ${a_block}_ss1p08v125c.db ]
}
set sys_rf1p [list rf1p28x82 rf1p32x64 rf1p48x64 rf1p48x80 rf1p64x16 rf1p64x32 rf1p64x64 rf1p68x80 rf1p32x128 rf1p560x32 rf1p128x64 rf1p32x32]
foreach b_block $sys_rf1p {
    set search_path [concat  $search_path /home/digital1/ksg/share/tsmc55/hprf1p/${b_block}/NLDM ]
    set link_path [concat $link_path ${b_block}_ss1p08v125c.db ]
}
set sys_rf2p [list rf2p96x32 rf2p64x48 rf2p16x56 rf2p16x64 rf2p32x11 rf2p32x24 rf2p32x32 rf2p32x48 rf2p32x64 rf2p64x16 rf2p64x18 rf2p64x24 rf2p64x32 rf2p64x64 rf2p64x72 rf2p128x8 rf2p128x16 rf2p128x64 rf2p224x16 rf2p512x8 rf2p32x44 rf2p64x44 rf2p40x45 rf2p32x72 rf2p128x33 rf2p64x33 rf2p16x35 rf2p32x36 rf2p32x37 rf2p256x32 rf2p64x46 rf2p32x50 rf2p512x32 rf2p32x54 rf2p128x36 rf2p64x38 rf2p32x40 rf2p16x42 rf2p16x72] 
foreach c_block $sys_rf2p {
    set search_path [concat  $search_path /home/digital1/ksg/share/tsmc55/rf2p/${c_block}/NLDM ]
    set link_path [concat $link_path ${c_block}_ss1p08v125c.db ]
}
set sys_rom [list BROM huff_29440x10 huff_22272x11 huff_832x27 ]
foreach d_block $sys_rom {
    set search_path [concat  $search_path /home/digital1/ksg/share/tsmc55/rom/${d_block}/NLDM ]
    set link_path [concat $link_path ${d_block}_ss1p08v125c.db ]
}

read_verilog		{ ac327_subsystem.v cortexa7core.v /home/digital2/zq/project/aw1651/netlist/cpu_hcell.v }
current_design		ac327_subsystem
link


#####################################################################
#       set transition time / annotate parasitics
#####################################################################
#read_sdc ../../netlist/ac327.sdc
#source ../../netlist/ac327_subsystem_fun_wc.sdc
#set_disable_timing [get_lib_pins ssc_core_typ/*/G]
read_parasitics	../../netlist/ac327_subsystem_typical_25.spef


#####################################################################
#       check/update/report timing 
#####################################################################
check_timing
update_timing
report_timing

#####################################################################
#       read switching activity file
#####################################################################
read_vcd "aw1651.vcd" -strip_path "sim/aw1651/u_core/u_cpu" -pipe "simv -l simv.log"

#####################################################################
#       check/update/report power 
#####################################################################
check_power
set_power_analysis_options -waveform_format fsdb -waveform_output power 
update_power
report_power

quit

