set DESIGN_DIR /ve/home/maharshi/assignments/design
set PDK_PATH /data/pdk/SAED32_EDK
set WORK_DIR_DC /ve/home/maharshi/assignments/DC
set WORK_DIR_ICCII /ve/home/maharshi/assignments/ICCII
_______________________________________________________________________
#[maharshi@s0 ICCII]$ cat run.tcl
#source /ve/home/maharshi/assignments/paths.tcl
create_lib -ref_libs /data/pdk/SAED32_EDK/lib/stdcell_rvt/ndm/saed32rvt_c.ndm tmsy_lib_mealy1001
read_verilog {/ve/home/maharshi/assignments/design/mealy1001.v} -library tmsy_lib_mealy1001 -design mealy1001 -top mealy1001
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
source /ve/home/maharshi/assignments/constraints/picorv32a.sdc
current_corner nom
current_scenario func::nom
set parasitic1 "p1"
set tluplus_file$parasitic1 "/data/pdk/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_file$parasitic1 "/data/pdk/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"
set parasitic2 "p2"
set tluplus_file$parasitic2 "/data/pdk/SAED32_EDK/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set layer_map_file$parasitic2 "/data/pdk/SAED32_EDK/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"
read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
read_parasitic_tech -tlup $tluplus_filep2 -layermap $layer_map_filep2 -name p2
set_parasitic_parameters -late_spec $parasitic1 -early_spec $parasitic2
set_app_options -name place.coarse.continue_on_missing_scandef -value true
place_pins -self
place_opt
clock_opt
route_opt
write_verilog /ve/home/maharshi/results/picorv32.routed.v
write_sdc -output /ve/home/maharshi/results/picorv32.routed.sdc
//////////////////////////////////////////////////////////////////////////////////
[maharshi@s0 design]$ cat mealy1001.v
module mealy1001(reg [1:0] present_state,reg [1:0] next_state,x,reg z,clock,reset);
input x;
input clock;
input reset;
parameter[1:0] a=2'b00,b=2'b01,c=2'b10,d=2'b11;
always@(posedge clock)
begin
        if (reset)
                present_state <= a;
        else
                present_state <= next_state;
end

always@(present_state,x)
begin
        case(present_state)
        2'b00: if (x)
                next_state <= b;
        else
                next_state <= a;
        2'b01: if (~x)
                next_state <= c;
        else
                next_state <= b;
        2'b10: if (~x)
                next_state <= d;
        else
                next_state <= b;

        2'b11: if (x)
                next_state <= b;
        else
                next_state <= a;
        endcase
end

always @(present_state,next_state,x)
begin
        if(present_state==d & next_state==b)
                z=1'b1;
        else
                z=1'b0;
end
endmodule

