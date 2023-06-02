[maharshi@s0 ICCII]$ cat run.tcl
source ./../paths.tcl
create_lib -ref_libs $PDK_PATH/lib/stdcell_rvt/ndm/saed32rvt_c.ndm rvt_ndm_1

read_verilog {./../DC/results/picorv32.mapped.v} -library rvt_ndm_1 -design picorv32 -top picorv32

initialize_floorplan -core_utilization 0.5
create_placement -floorplan

create_net -power {VDD VSS}
create_pg_ring_pattern ring_pattern -horizontal_layer M7 -vertical_layer M8 -horizontal_width {5} -vertical_width {5} -horizontal_spacing {2} -vertical_spacing {2}

set_pg_strategy core_ring -core -pattern {{name : ring_pattern}{nets : {VDD VSS}}{offset : {3 3}}}

create_pg_mesh_pattern mesh -layers { {{vertical_layer: M8}{width: 5} {spacing: interleaving}{pitch: 20} {offset: 3}} {{horizontal_layer: M7}{width: 5} {spacing: interleaving} {pitch: 20} {offset: 3}} {{vertical_layer: M6}{width: 1} {spacing: interleaving}{pitch: 20} {offset: 3}}} -via_rule {{{layers: M8}{layers: M7}{via_master: VIA78BAR1}}}

set_pg_strategy core_mesh -pattern { {pattern:mesh} {nets: VDD VSS}} -core

compile_pg -strategies {core_mesh core_ring}


set mode1 "func"

set corner1 "nom"
set scenario1 "${mode1}::${corner1}"
remove_modes -all; remove_corners -all; remove_scenarios -all



create_mode $mode1



create_corner $corner1



create_scenario -name func::nom -mode func -corner nom



current_mode func



current_scenario func::nom

source ./../constraints/picorv32a.sdc


current_corner nom



current_scenario func::nom







set parasitic1 "p1"

set tluplus_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"


set layer_map_file$parasitic1 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

set parasitic2 "p2"
set tluplus_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set layer_map_file$parasitic2 "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1



read_parasitic_tech -tlup $tluplus_filep2 -layermap $layer_map_filep2 -name p2



set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic2



set_app_options -name place.coarse.continue_on_missing_scandef -value true


place_pins -self
place_opt
clock_opt
route_opt

write_verilog ./results/picorv32.routed.v
write_sdc -output ./results/picorv32.routed.sdc
[maharshi@s0 ICCII]$
