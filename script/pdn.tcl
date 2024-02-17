####################################
# global connections
####################################
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDD$} -power
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDPE$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {^VDDCE$}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {VPWR}
add_global_connection -net {VDD} -inst_pattern {.*} -pin_pattern {VPB}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VSS$} -ground
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {^VSSE$}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {VGND}
add_global_connection -net {VSS} -inst_pattern {.*} -pin_pattern {VNB}
global_connect

####################################
# voltage domains
####################################
set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}

####################################
# standard cell grid
####################################
define_pdn_grid -name {grid} -voltage_domains {CORE}

add_pdn_stripe -grid {grid} -layer {met1} -width {0.48} -pitch {5.44} -offset {0} -followpins -extend_to_core_ring

add_pdn_stripe -grid {grid} -layer {met2} -width {1} -pitch {5.44} -offset {2.5} -extend_to_core_ring -snap_to_grid

add_pdn_ring -grid {grid} -layers {met3 met4} -width 2.0 -spacings 2.0 -core_offsets 2.0

add_pdn_connect -grid {grid} -layers {met1 met4}
add_pdn_connect -grid {grid} -layers {met4 met3}
