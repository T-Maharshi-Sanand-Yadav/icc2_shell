set DESIGN_DIR /ve/home/maharshi/assignments/design
set PDK_PATH /data/pdk/SAED32_EDK
set WORK_DIR_DC /ve/home/maharshi/assignments/DC
set WORK_DIR_ICCII /ve/home/maharshi/assignments/ICCII
_______________________________________________________________________
#[maharshi@s0 ICCII]$ cat run.tcl
#source /ve/home/maharshi/assignments/paths.tcl
create_lib -ref_libs /data/pdk/SAED32_EDK/lib/stdcell_rvt/ndm/saed32rvt_c.ndm tmsy_lib_design_1
read_verilog {/ve/home/maharshi/assignments/design/design_1.v} -library tmsy_lib_design_1 -design design_1 -top design_1
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
write_verilog /ve/home/maharshi/results/design_1.routed.v
write_sdc -output /ve/home/maharshi/results/design_1.routed.sdc
//////////////////////////////////////////////////////////////////////////////////
icc2_shell> man create_lib
2.  Synopsys Commands                                        Command Reference
                                  create_lib

NAME
       create_lib
              Creates a design library.

SYNTAX
       collection create_lib
              [-technology tech_path | -use_technology_lib tech_lib_name]
              [-use_parasitic_tech_lib para_tech_lib_name]
              [-scale_factor scale_factor]
              [-ref_libs ref_libs]
              [-convert_sites site_name_pairs_list]
              [-base_lib base_library_path]
              [-dont_set_current]
              library_name

   Data Types
       tech_path             string
       tech_lib_name         string
       para_tech_lib_name    string
       scale_factor          int
       ref_libs              list
       site_name_pairs_list  list
       base_library_path     string
       library_name          string

ARGUMENTS
       -technology tech_path
              Specifies the technology file for this library.

       -use_technology_lib tech_lib_name
              Specifies the reference library to use as a dedicated technology
              library.

              The library must contain a technology section and must be one of
              the libraries specified with the -ref_libs option.

              This  option  is mutually exclusive with the -technology option,
              and it must be used with the -ref_libs option.

       -use_parasitic_tech_lib para_tech_lib_name
              Specifies one library on the reference library list as  a  dedi-
              cated parasitic technology library.

              You must use this option with the -ref_libs option.

       -scale_factor scale_factor
              Specifies the length precision for this library. The length pre-
              cision for the library and all of its reference  libraries  must
              be  identical.   The  value  is  specified in terms of units per
              micron. By default, a length precision of 10000 is  used,  which
              implies one internal unit is equal to one Angstrom or 0.1 nm

              Choose  a  scale_factor value that will result in a whole number
              of database units per minimum grid spacing. For example, if your
              minimum  grid spacing is 1 nm, the default scale_factor of 10000
              dbu per micron could be used. But if your minimum  grid  spacing
              is  0.25  nm,  a scale factor of, for example, 4000, must not be
              used because rounding errors might result.

       -ref_libs ref_libs
              Specifies the reference libraries for this library.

              In addition to pre-built cell  libraries,  this  option  accepts
              physical  source  data such as physical libraries (which contain
              frame views of the cells), LEF files,  and  Milkyway  libraries.
              The tool automatically builds cell libraries based on the physi-
              cal source data.

              You can specify the reference libraries and physical source data
              using  absolute or relative paths.  If you specify the libraries
              with a relative path or with no path, the tool uses  the  search
              path  defined  with  the  search_path  variable  to  locate  the
              libraries.

       -convert_sites site_name_pairs_list
              Specifies the mapping for the site names in the technology  file
              in the following format:
                {tech_file_site_name new_site_name}

              This option must be used with the -technology option.

       -base_lib base_library_path
              Creates  a  sparse  library  based on the specified library. The
              base library must be a design  lib  and  cannot  be  a  lib-cell
              library.  No  other  options can be specified when the -base_lib
              option is used. For example, the sparse  library  must  use  the
              same technology file and ref_libs as the base library.

       -dont_set_current
              An optional argument to create the lib without setting it as the
              current lib.

       library_name
              Specifies the name of the new library. This  can  be  a  simple,
              relative,  or  absolute  path.  If  it is a relative or absolute
              path, the trailing portion of the path after he last '/' becomes
              the  name  of the library. It is an error if a library, file, or
              directory with the same name already exists on disk.

              The name can be a simple path, a path relative  to  the  current
              working  directory, or an absolute path. The name cannot contain
              spaces or the colon (":") character, which is  used  to  delimit
              the library and design name.

              The  library_name  is optional when -base_lib option is used. If
              unspecified, the  name  of  the  created  local  sparse  library
              matches  the  name  of  the  base  library  specified  using the
              -base_lib.

DESCRIPTION
       The create_lib command creates a new design library.  The  library  can
       contain  technology  information specified with the -technology option.
       If there are sites defined in the technology file  (and  one  is  being
       used),  you can use the -convert_sites option to map the sites from one
       name to another. This same option is used with the read_def command  to
       ensure that the site names match among all the input data.

       You can directly specify the library's reference library path list with
       the -ref_libs option. Alternatively, if  you  specify  physical  source
       data with the -ref_libs option, the tool creates the cell libraries and
       sets them as reference libraries. The supported  physical  source  data
       includes  physical  libraries,  which  contain  the  frame views of the
       cells, LEF files, and  Milkyway  libraries.  The  logic  libraries  are
       determined  from  the link_library variable. The created cell libraries
       are put in the directory specified by the  lib.configuration.local_out-
       put_dir   application   option.   You   can   use   the  lib.configura-
       tion.default_flow_setup application option to point  to  a  Tcl  script
       with  customized  settings  for  the cell library creation. See the man
       pages of these application variables and options for detailed  informa-
       tion about how to use them.

       When  the -base_lib option is used the create_lib command creates a new
       sparse library based upon an  existing  design  library  on  disk.  The
       sparse  library  uses the same technology file and ref_libs as the base
       library. Initially, a sparse library does not have any  locally  stored
       blocks. It copies the base library's catalog and ref_lib list into mem-
       ory as its own and also remembers the full path of the base library for
       reference.

       The library is then opened and made the current library.

       If the command is successful, it returns the newly-created library as a
       single-element collection. If the command fails, it  returns  an  empty
       string. If there is a syntax error, it returns a TCL_ERROR.

EXAMPLES
       The  following  example  creates  a  library named r4000 in the current
       directory that uses the tcbn90g.tf technology file.

         prompt> create_lib -technology LIBS/TECH/tcbn90g.tf r4000
         Information: Loading technology file '/usr/LIBS/TECH/tcbn90g.tf' (FILE-007)
         {r4000}
         prompt> current_lib
         {r4000}

       The following example creates a library  named  r4000  in  the  current
       directory that uses the tcbn90g.tf technology file and has a scale fac-
       tor of 4000.

         prompt> create_lib -technology LIBS/TECH/tcbn90g.tf r4000 -scale_factor 4000
         Information: Loading technology file '/usr/LIBS/TECH/tcbn90g.tf' (FILE-007)
         {r4000}
         prompt> current_lib
         {r4000}
         prompt> get_attribute [current_lib] scale_factor
         4000

       The following example creates a library named top_lib in the  ./lib_dir
       directory that uses the tcbn90g.tf technology file.

         prompt> create_lib -technology LIBS/TECH/tcbn90g.tf lib_dir/top_lib
         Information: Loading technology file '/usr/LIBS/TECH/tcbn90g.tf' (FILE-007)
         {top_lib}

       The  following  example  creates  a  library  named  design_lib  in the
       /home/user directory that uses the my_tech.tf technology file.

         prompt> create_lib -technology my_tech.tf /home/user/design_lib
         Information: Loading technology file 'my_tech.tf' (FILE-007)
         {design_lib}

       The following example creates a  sparse  library  named  top_sparse_lib
       based on the design library top_lib in the /home/user directory.

         prompt> create_lib -base_lib /home/user/top_lib top_sparse_lib
         Information: Creating Sparse View library 'top_sparse_lib' with base
         library '/home/user/top_lib'. (NDM-103)
         {top_sparse_lib}

       The  following example creates a library named design_lib and automati-
       cally creates cell libraries for it. The  cell  libraries  are  created
       based on the logic library files specified in the link_library variable
       and the physical library specified with the -ref_libs option.

         prompt> set_app_var link_library \
            "* 1_pvt1.db 1_pvt2.db 2_pvt1.db 2_pvt2.db"
         prompt> create_lib -technology my_tech.tf /home/user/design_lib \
            -ref_libs frame_only.ndm
          ... run lm_shell to build reference libraries.
          ................................................................
         Information: Successfully built 3 reference libraries: 1.ndm 2.ndm
         EXPLORE_physical_only.ndm
         {design_lib}

SEE ALSO
       open_lib(2)
       save_lib(2)
       close_lib(2)
       copy_lib(2)
       move_lib(2)
       current_lib(2)
       get_libs(2)
       set_ref_libs(2)
       set_base_lib(2)
       search_path(3)
       link_library(3)
       lib.configuration.local_output_dir(3)
       lib.configuration.default_flow_setup(3)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////////////
icc2_shell> man read_verilog
2.  Synopsys Commands                                        Command Reference
                                 read_verilog

NAME
       read_verilog
              Reads in one or more Verilog files.

SYNTAX
       string read_verilog
              [-library library_name]
              [-design design_name]
              [-top module_name]
              file_names

   Data Types
       library_name     string
       design_name      string
       module_name      string
       file_names       string

ARGUMENTS
       -library library_name
              Specifies  the name of the library to contain the design. If the
              current library is not set, the command creates a library  using
              the  first  input  file  name. By default, the command saves the
              design into the current library. If the reference  library  list
              is not set, then issues a warning.

       -design design_name
              Specifies  the  name  of  the  design  and  label to read in, in
              designName[/labelName] format. If design name is not  specified,
              the  top module is used as the design name. If label name is not
              specified, the  default  label,  specified  with  the  file.ver-
              ilog.default_user_label  app_option,  will be used. Reading into
              an opened design is not allowed. The  design  must  not  already
              exist or be closed.

       -top module_name
              Specifies the name of the top module in the design hierarchy. By
              default, the top module is the module that is  not  instantiated
              by any other modules.

       -as_block
              Specifies  that  a new block should be created to store the read
              modules.

       file_names
              Specifies the names of one or more input Verilog netlist files.

DESCRIPTION
       Reads one or more structural,  gate-level  Verilog  netlists  into  the
       tool. To locate Verilog files that have relative pathnames, the command
       uses the search_path variable and searches for each file in each direc-
       tory  listed  in  the  search_path.  Files  with absolute pathnames are
       loaded independent of the search_path variable. Use the  which  command
       to  determine  the file that read_verilog loads. After reading the Ver-
       ilog files with the read_verilog command, use the  list_blocks  command
       to  view  the  design  objects. To remove designs, use the remove_block
       command.

       The command saves the read modules into the current block if  there  is
       an  open  current block defined, and the block is not yet linked.  This
       behavior can be disabled so a new block is created with  the  -as_block
       argument, or if -design is used.

       When  targeting an existing block a redefinition of a module will over-
       write an existing definition.

       The Verilog netlists must contain fully-mapped, structural designs. The
       tool  cannot link or perform timing analysis with netlists that are not
       fully mapped at the gate level. There must  be  no  high-level  Verilog
       constructs in the netlist.

       The  Verilog file can be a simple ASCII file or a compressed gzip file.
       Each gzip file is uncompressed to a temporary  file  in  the  directory
       defined by the icc2_tmp_dir variable.

       Generally, the Verilog reader does not create unconnected nets and dis-
       cards unconnected instances. To keep unconnected nets in  your  design,
       set the file.verilog.keep_unconnected_nets app option to true. Also, if
       a module has one or  more  references  to  a  reference  name,  but  no
       instances   have  connections,  those  instances  are  omitted  if  the
       file.verilog.keep_unconnected_cells app option is set to  "false"  (the
       default).  Discarding  unconnected instances saves memory for instances
       of filler cells and other cells with no pins.

       Additionally, read_verilog command prints summary at the  end  of  run.
       The following describes each field:

     o Number of modules read: <no. of modules read from verilog file>
     o Top level ports: <no. of ports in top module including PG ports>
     o  Total  ports  in  all  modules: <total no. of ports in all the modules
       including PG ports>
     o Total nets in all modules: <total  no.  of  nets  in  all  the  modules
       including PG nets>
     o  Total  instances  in  all modules : <total no. of instances in all the
       modules>
     o Elapsed = <clock time>, CPU = <cpu time>

Limitations of the Verilog Reader
       The Verilog reader has the following limitations:

     o No non-structural constructs are supported. For details, see the  "Sup-
       ported Language Subset for the Verilog Reader".

     o  Parameters  are  not  supported. Parameter and defparam statements are
       read and ignored.

     o Gate instantiations are not supported.

Supported Language Subset for the Verilog Reader
       The Verilog reader supports a small structural subset  of  the  Verilog
       language.  Additional  constructs are recognized and ignored. Supported
       constructs are as follows:

     o  module/endmodule

     o  input, inout, and output

     o  wire

     o tri, wor, and wand: These constructs are supported and are treated  the
       same  as  the wire construct. That is, there is no special significance
       to these constructs.

     o supply0 and supply1: These constructs create wires that are logic 0 and
       1, respectively.

     o  assign

     o  tran:  An  exception  from the gate instantiation subset, tran is sup-
       ported to the extent that it relates  one  wire  to  another,  as  with
       assign. Beyond that, tran has no special significance.

     o  The  preprocessor directives `define, `undef, `include, `ifdef, `else,
       and `endif are not supported by default. The read_verilog command  tar-
       gets structural, machine-generated Verilog, which rarely contains these
       constructs. Set the  file.verilog.enable_vpp  app  option  to  true  to
       enable a preprocessor phase that expands these constructs and outputs a
       temporary file to the directory defined by the icc2_tmp_dir variable.

     o All simulation directives (for example, `timescale) are recognized  and
       ignored.

     o  The  specify/endspecify  construct and its contents are recognized and
       ignored.

     o Like HDL Compiler, the  comment  directives  translate_off  and  trans-
       late_on  are  used  to  bypass  Verilog  features  not supported by the
       reader. The following example shows how to bypass an  unsupported  fea-
       ture:

         // synopsys translate_off
         nand (n2, a1, s2);
         /* synopsys translate_on */

EXAMPLES
       The following example defines a search path and reads the newcpu.v Ver-
       ilog file.

         prompt> set search_path "/designs/newcpu/v1.6 /libs/cmos"
         /designs/newcpu/v1.6 /libs/cmos

         prompt> read_verilog newcpu.v
         Loading verilog file '/designs/newcpu/v1.6/newcpu.v'
         Number of modules read: 6
         Top level ports: 124
         Total ports in all modules: 514
         Total nets in all modules: 598
         Total instances in all modules: 18
         Elapsed = 00:00:00.00, CPU = 00:00:00.00
         1

SEE ALSO
       remove_blocks(2)
       which(2)
       bus_naming_style(3)
       search_path(3)
       shell.tmp_dir_path(3)
       verilog_options(3)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////////
icc2_shell> man initialize_floorplan
2.  Synopsys Commands                                        Command Reference
                             initialize_floorplan

NAME
       initialize_floorplan
              Creates  an  initial  floorplan  with a die boundary, core, site
              array (or rows), and wire tracks. Support is provided for a  die
              boundary that is coincident with the core, or a rectilinear core
              with rectangular die boundary.

SYNTAX
       int initialize_floorplan
              [-control_type core | die]
              [-shape R | L | T | U]
              [-side_length {side_a side_b [side_c side_d side_e side_f]}]
              [-side_ratio {side_a side_b [side_c side_d side_e side_f]}]
              [-core_utilization ratio]
              [-keep_boundary]
              [-boundary { {x y} {x y} {x y} {x y} ... } ]
              [-orientation N | W | S | E]
              [-coincident_boundary true | false]
              [-core_offset  { value | X_Offset Y_Offset | side_1 ... side_N}]
              [-row_core_ratio ratio]
              [-flip_first_row true | false]
              [-keep_pg_route]
              [-keep_detail_route]
              [-keep_placement {io macro block std_cell physical_only all} ]
              [-keep_objects object_name_or_collection]
              [-keep_object_types {placement_blockage routing_blockage move_bound}]
              [-keep_all]
              [-honor_pad_limit]
              [-site_def site_def_name]
              [-use_site_row]
              [-origin_offset {x, y}]
              [-row_pattern {row_pattern_name}]
              [-macro_utilization ratio]

   Data Types
       ratio                      float
       x                          float
       y                          float
       value                      float
       X_Offset                   float
       Y_Offset                   float
       side_*                     float
       object_name_or_collection  string or collection
       site_def_name              string
       row_pattern_name           string

ARGUMENTS
       -control_type core | die
              Specifies whether the side_length and side_ratio  options  apply
              to  the core or the die boundary. If set to die, then the dimen-
              sions are applied to the die boundary and the core_offset values
              are  subtracted from the dimensions to determine the core bound-
              ary. If set to core (default), the dimensions are applied to the
              core boundary and the core_offset values are added to the dimen-
              sions to determine the final die boundary.  By default, the con-
              trol type is core.

       -shape R | L | T | U
              Specifies  the  shape  to  be  used  by the command. If the con-
              trol_type is die, this option applies to the die boundary shape.
              The  argument  to this option specifies a template shape used to
              determine the cell boundary and core shape  of  the  rectilinear
              block.  The  following diagram shows the definition of the edges
              and the orientation of  the  R-,  L-,  T-,  and  U-  rectilinear
              blocks. By default, the core shape is R (rectangular).
                        _a_         ___________      _b_     _f_
              __a___   |   |       |           |    |   |   |   |
              |    |   |   b       |           a    a   c   e   |
              |    |   |   |       |_f_     _b_|    |   |_d_|   |
              b    |   |   |_c_        |   |        |           |
              |    |   |       |       e   c        |___________|
              |____|   |       d       |   |
                       |_______|       |_d_|

       -side_length { side_a side_b [side_c side_d side_e side_f]}
              Specifies  the  side  lengths for the edges of the floorplan. If
              the control_type is die, the  side  lengths  apply  to  the  die
              boundary.  Each  dimension  in the list represents the length of
              the edge. If you provide more values than required  to  describe
              the specified shape, the extra values are ignored. If you do not
              provide all of the values required  to  describe  the  specified
              shape,  the  tool  issues  an  error message. There are only two
              dimensions for -shape R: width and height. This option is  mutu-
              ally exclusive with the -side_ratio option.

       -side_ratio { side_a side_b [side_c side_d side_e side_f]}
              Specifies  the  relative  proportion  of  the floorplan edges in
              relation to each other. If the control_type  is  die,  the  side
              rations  apply  to the boundary side settings. Each dimension in
              the list represents the relative proportion of the dimension  of
              the  edge  to the sum of all the dimensions listed. For example,
              if the list of dimensions of an L-shaped block is {1 2 1 1}, the
              tool  calculates  the  dimension  of  side a, c, or d (where the
              value is 1) as 20 percent (1/1+2+1+1) of the sum of  the  dimen-
              sions  listed. The dimension of side b is 40 percent of the sum-
              mation, and so on.

       -core_utilization ratio
              Specifies the utilization of the core area. The  utilization  is
              the  total  area  of the core occupied by all standard cells and
              macro cells divided by the total core area. You  can  specify  a
              value  between 0 and 1.  The cell area includes all standard and
              macro cells. For example, a core utilization  of  0.8  specifies
              that  80  percent of the core area is used for cell placement at
              this stage. The tool might later add more cell area, the remain-
              ing area is available for routing. By default, the core utiliza-
              tion is 0.7.

       -macro_utilization ratio
              Specifies the utilization of the macro  cells.  The  default  is
              same as core_utilization value: range 0 to 1.

       -keep_boundary
              Uses  the existing die boundary. If this option is specified and
              the core-based constraints result in a core that is too large to
              fit  in  the  existing die boundary, the command issues an error
              message. Default is not specified.

       -boundary { {x y} {x y} {x y} {x y} ... }
              Specifies the shape to be used  by  the  command.  If  the  con-
              trol_type  is  core, then the boundary defines the core area and
              the core_offsets should be added to create the die boundary.  If
              control_type is die, then the core_offset is subtracted from the
              die boundary to create the core boundary.

       -orientation N | W | S | E
              Specifies one of four possible orientations  for  the  specified
              rectilinear  shape. The tool repositions the block to the speci-
              fied orientation by rotating it in a  clockwise  direction.  For
              -shape R, the orientation is always N.

       -coincident_boundary true | false
              Specifies  whether  the  die  boundary  follows the shape of the
              core. If true, the die boundary assumes the same  shape  as  the
              core and requires a -core_offset setting with the same number of
              sides as the core. If false, the die boundary is rectangular and
              the  -core_offset option requires only four values. When the die
              boundary is rectangular it is created with  -core_offset  values
              such  that  the offset value is honored to the closest core edge
              on a per side basis. In this case, the bounding box of  the  die
              boundary  is  the  minimum size that meets all four -core_offset
              values. By default, this option is true.

       -core_offset { value | X_Offset Y_Offset | side_1 ... side_N}
              Specifies the distance between the side of the core and the side
              of  the die boundary.  If only one value is specified, the value
              is used for all sides.  If two values are specified,  the  first
              value  is  the distance in the horizontal direction from the die
              boundary vertical edges and the second value is the distance  in
              the  vertical  direction from the die boundary horizontal edges.
              Side numbers are based on the standard rectilinear numbering and
              do  not  correlate  to  the side_a, side_b, and so on, numbering
              scheme used to define the size of each  edge.  By  default,  the
              core  offset equals to the minimum I/O cell height. If there are
              no I/O cells, the core offset is 0.

       -row_core_ratio ratio
              Specifies the amount of channel area between cell  rows  in  the
              core  area to reserve for routing. The ratio is a number between
              0 and 1.0. A smaller row-to-core ratio creates  more  space  for
              routing  channels.  A  value  of  1.0 creates no routing channel
              space. By default, the ratio is 1.0. Note that this ratio should
              be equal to or greater than the core utilization value.

       -flip_first_row true | false
              Specifies  whether the command flips the first row at the bottom
              of the core area for horizontally placed cell rows, or flips the
              leftmost  row  for vertically placed cell rows. By default, this
              option is true.

       -keep_pg_route
              Specifies that the command keeps the  PG  routes  and  does  not
              delete them. By default, the command delete all existing routes.

       -keep_detail_route
              Specifies that the command keeps all the routes except PG routes
              and does not delete them. By default,  the  command  delete  all
              existing routes.

       -keep_placement {io macro block std_cell physical_only all}
              Specifies  that  the  command  keeps  the placement of specified
              object types. The valid value for this options are:  io,  macro,
              block, std_cell, physical_only, all.

              io   means   objects   with   design   type   "flip_chip_driver,
              flip_chip_pad, corner, pad, pad_spacer";

              macro means objects with design type "macro, analog, abstract";

              block means objects with design type "module, black_box";

              physical_only means objects  with  design  type  "physical_only,
              fill";

              std_cell means objects with design type "lib_cell, cover, diode,
              end_cap, well_tap, filler";

              all means all objects with design type list above.

       -keep_objects object_name_or_collection
              Specifies the objects to be kept.  Currently  supported  objects
              are  cells  and  nets.  Specify  the  objects either by using an
              object access command, such as  get_cells  or  get_nets,  or  by
              specifying object name patterns in a Tcl list.

       -keep_object_types {placement_blockage routing_blockage move_bound}
              Specifies the object type to be kept. Currently supported object
              types are placement_blockage, routing_blockage and move_bound.

       -keep_all
              Specifies this option  to  keep  macro,  std_cell,  I/O,  physi-
              cal_only, block, blockage, detail_route and pg_route.

       -honor_pad_limit
              Adjusts  the  core and die size to honor pad-limited designs. If
              this option is not specified, the core area is created based  on
              the default core utilization ratio 0.7.

              The  option can be used only for rectangular floorplans, not for
              L, T, or U shapes.

              The assumption for the command option is that the pad-type cells
              ()I/O  pads  or  flip chip drivers) are placed around the design
              boundary.

       -site_def site_def_name
              Specifies the site def to be used in floorplan  when  there  are
              multiple site defs in the technology file. The default is to use
              default site def.  If there is no default site def, the  command
              uses the site def with the smallest site width.

       -use_site_row
              By  default,  the initialize_floorplan command creates siteArray
              objects. This option forces the command to create siteRow rather
              than siteArray.

       -origin_offset {x y}
              Specifies  the  location  of  the  lower-left  corner of the die
              boundary bounding box with respect to the origin of the block.

       -row_pattern {row_pattern_name}
              Specifies the name of row_pattern to be used for floorplan  when
              there  are  row patterns specification in the physical rule sec-
              tion of technology file.

DESCRIPTION
       Creates a floorplan with a boundary, core, site array  (or  rows),  and
       wire  tracks.  Before  executing this command, you must open a physical
       design by using the open_block command, or create  a  design  with  the
       read_verilog or read_verilog_outline commands.

EXAMPLES
       The  following example creates a rectangular core and die boundary with
       a core utilization of 80 percent and a core offset of 1000 um for  each
       side.

         prompt> initialize_floorplan -core_utilization 0.8 \
                 -core_offset {1000 1000 1000 1000}

       The following example creates a rectangular die boundary and a T-shaped
       rectilinear core with the specified side dimensions for the core and  a
       core_offset of 100 um for each side.

         prompt> initialize_floorplan -control_type core -shape T \
                 -side_length {1000 750 1500 750 1750 750} \
                 -coincident_boundary false \
                 -core_offset {100}

       The  following  example  creates  a  T-shaped  rectilinear core and die
       boundary with the specified side dimensions for the  core  and  a  core
       offset of 100 um for each side.

         prompt> initialize_floorplan -shape T \
                 -side_length {1000 750 2500 500 3000 500} \
                 -core_offset {100 100 100 100 100 100 100 100}

       The  following  example  creates  a  T-shaped  rectilinear core and die
       boundary with the specified side ratios for the core and a core  offset
       of 10 um for each side and a core utilization of 80 percent.

         prompt> initialize_floorplan -core_utilization 0.8 \
                 -shape T \
                 -side_ratio {2 1 3 1 3 1} \
                 -core_offset {100 100 100 100 100 100 100 100}

SEE ALSO
       create_io_ring(2)
       remove_io_rings(2)
       report_io_rings(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell> man create_placement

2.  Synopsys Commands                                        Command Reference
                               create_placement

NAME
       create_placement
              Performs coarse placement on the current design.

SYNTAX
       status create_placement
              [-floorplan]
              [-host_options host_option_name]
              [-use_seed_locs]
              [-effort very_low | low | medium | high]
              [-timing_driven]
              [-buffering_aware_timing_driven]
              [-congestion]
              [-congestion_effort low | medium | high]
              [-incremental]
              [-from combined_placement | macro_legalization | channel_sizing]

   Data Types
       host_option_name string

ARGUMENTS
       -floorplan
              Specifies  that  floorplanning  placement  should  be used. This
              includes macro placement and special  effort  levels  which  are
              tuned  for  speed.  There  are  a  number of special application
              option controls for floorplanning. To get a  list  of  them  use
              report_app_options     plan.place.*    and    report_app_options
              plan.macro.*.
              One  application  option  which  you  must  be   aware   of   is
              plan.place.auto_create_blockages.   This  controls whether soft,
              hard, or partial blockages are  automatically  created  in  thin
              channels  between hard macros and block boundary. This is useful
              for congestion reduction.  See  man  page  of  this  application
              option for more details.
              The  macro  placement  style is controlled using the application
              option plan.macro.style.  See the man page of  this  application
              option for more information.

       -host_options host_option_name
              Specifies that the given host option should be used for distrib-
              uted processing. Host options are set with the  set_host_options
              command.  Note  that  not  all  operations performed by the cre-
              ate_placement command support distributed processing. The effect
              of  this  option depends on the design and the other option set-
              tings.

       -use_seed_locs
              Specifies that the current placement should be used  as  a  seed
              for placement.

       -effort very_low | low | medium | high
              Specifies the CPU effort level for coarse placement. The default
              effort level is high.
              The exception is that for on-edge and island style floorplanning
              placement, the default effort level is medium.

       -timing_driven
              Enables  timing-driven  placement. When used with the -floorplan
              option, you can adjust the behavior  of  the  command  with  the
              plan.place.timing_driven_mode application option.

       -buffering_aware_timing_driven
              Enables  timing-driven  placement  using  an  approximate timing
              model that estimates the effects  of  buffering  long  nets  and
              high-fanout nets later in the flow.  The netlist is not changed.
              Intended for use as an initial placement step that gives a  bet-
              ter starting point for later timing optimizations.

       -congestion
              Enables congestion-driven placement mode.
              When  used with the -floorplan option, you can adjust the behav-
              ior of the command  with  the  plan.place.congestion_driven_mode
              application option.

       -congestion_effort low | medium | high
              Specifies  the  effort  level  for congestion mode.  The default
              effort level is medium.  Expect a significant increase  in  run-
              time  for  high  effort.   This option can only be used with the
              -congestion option.

       -incremental
              Performs incremental placement on the design. Incremental place-
              ment  tries  to  keep cells close to their current location. The
              -incremental option  automatically  enables  the  -use_seed_locs
              option.  By  default,  the command can move cells far from their
              current location to improve placement QoR.

              When -incremental is used in combination  with  -floorplan,  the
              macro  placement  is legalized while trying minimizing the macro
              movements. Also, the  standard  cell  placement  is  updated  in
              incremental  fashion.  When  also  combined with the -congestion
              option, the command expects that the current placement is  legal
              and  that  an  up-to-date congestion map exists. This congestion
              map is used to increase the channel sizes between the macros  in
              congested  areas.  Again, the standard cell placement is updated
              in an incremental  fashion.  See  also  the  man  page  for  the
              plan.place.congestion_driven_mode application option. For incre-
              mental freeform or hybrid macro placement, see  also  the  -from
              option below.

       -from combined_placement | macro_legalization | channel_sizing
              Specifies  the  incremental  level  for  incremental freeform or
              hybrid macro placement.
              This option can only be  used  in  combination  with  -floorplan
              -incremental  and  if the plan.macro.style application option is
              set to freeform or hybrid.
              The value passed with this option indicates the stage  to  start
              the macro placement flow.
              The hybrid macro placement normally starts with the placement of
              the on-edge macros.  This step is skipped for incremental place-
              ment.  The on-edge macro placement is preserved and only changes
              due to congestion driven channel sizing.
              The freeform macro placement consists of multiple stages:
              combined_placement
                   The macros and standard cells are placed together using the
                   coarse placement engine.  When -congestion is used, this is
                   congestion driven.
              macro_legalization
                   The macros are legalized, which makes sure that  all  macro
                   placement  constraints  are  satisfied.  Also, the standard
                   cells are placed incrementally, to adjust to the  legalized
                   macro locations.
              channel_sizing
                   Congestion  driven  macro  channel  sizing, which increases
                   channel sizes between macros where congestion is  detected.
                   This  is followed by congestion driven standard cell place-
                   ment.  This stage is only run when the  -congestion  option
                   is used.
              The  -from options indicates at which of these stages the incre-
              mental freeform placement starts.
              So, the value combined_placement is the most aggressive and runs
              the  full  freeform flow while the channel_sizing entry point is
              the most subtle and only runs the last stage.
              The default entry point is macro_legalization.

DESCRIPTION
       The create_placement command performs coarse placement on  the  current
       design. With the -floorplan option, this includes the placement of hard
       macros as well as standard cells. To avoid placing  hard  macros,  mark
       the  hard  macros  as fixed with the set_attribute or set_fixed_objects
       command.

EXAMPLES
       The following example runs  the  create_placement  command  in  timing-
       driven mode:

         prompt> create_placement -effort high -timing_driven

SEE ALSO
       check_host_options(2)
       legalize_placement(2)
       read_def(2)
       report_app_options(2)
       set_attribute(2)
       set_host_options(2)
       write_def(2)
       place.coarse.*(3)
       plan.place.congestion_driven_mode(3)
       plan.place.auto_create_blockages(3)
       plan.place.*(3)
       plan.macro.*(3)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
//////////////////////////////////////////////////////////////////////
icc2_shell> man create_net
2.  Synopsys Commands                                        Command Reference
                                  create_net

NAME
       create_net
              Creates one or more power, ground, tie, or signal nets.

SYNTAX
       collection create_net
              [-design design]
              [-power | -ground | -tie_high | -tie_low]
              [-cell cell]
              net_names

   Data Types
       design          collection
       cell            collection
       net_names       list

ARGUMENTS
       -design design
              Specifies  the  design in which to create the nets. If no design
              is specified, the nets are created in the current design.

       -power Specifies that power nets should be created.

       -ground
              Specifies that ground nets should be created.

       -tie_high
              Specifies that tie-high nets should be created.

       -tie_low
              Specifies that tie-low nets show be created.

       net_names
              Specifies the names of the nets to be  created  in  the  design.
              Each net name must be unique.

       -cell cell
              Specifies the cell where the net is to be added. The net is cre-
              ated in the cell's reference module. The cell must not reference
              a  library  cell, unless this command is executed in the library
              manager. In the library manager, nets may be created in  library
              cells.  When  not  specified,  the net is created in the current
              module.

DESCRIPTION
       This command creates new nets in the current design  (unless  otherwise
       specified  by  -design).  It creates only scalar (single-bit) nets. One
       net is created for each of the names listed.

       This command can create PG, tie, or signal nets.  If  no  net  type  is
       specified, the command creates signal nets.

       Nets connect ports and pins in a design. The create_net command creates
       nets, but does not connect the nets. To establish this connection,  use
       the connect_net or connect_pg_net commands.

EXAMPLES
       The following example creates signal nets named N1, N2, N3, and N4.

         prompt> create_net {N1, N2, N3, N4}

       The following example creates a power net named VDD.

         prompt> create_net -power VDD

SEE ALSO
       connect_net(2)
       disconnect_net(2)
       get_nets(2)
       remove_nets(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
////////////////////////////////////////////////////////////////////////
icc2_shell> man create_pg_ring_pattern
2.  Synopsys Commands                                        Command Reference
                            create_pg_ring_pattern

NAME
       create_pg_ring_pattern
              Creates a power ground (PG) ring pattern. The pattern created by
              this command is associated with a region or area of  the  design
              by  using  the  set_pg_strategy  command.  The  actual  ring  is
              inserted into the design by the compile_pg command.

SYNTAX
       status create_pg_ring_pattern
              pattern_name
              [-nets net_list]
              [-horizontal_width width_list]
              [-vertical_width width_list]
              [-horizontal_spacing spacing_list]
              [-vertical_spacing spacing_list]
              [-horizontal_layer layer]
              [-vertical_layer layer]
              [-side_width width_spec]
              [-side_spacing spacing_spec]
              [-side_layer layer_spec]
              [-corner_bridge true | false | @param}]
              [-track_alignment track | half_track | none |@var]
              [-parameters var_list]
              [-via_rule via_rule_spec]

   Data Types
       pattern_name       string
       net_list           list
       width_list         list
       spacing_list       list
       layer              string
       width_spec         specification
       spacing_spec       specification
       layer_spec         specification
       param              string
       var_list           list
       via_rule_spec      specification

ARGUMENTS
       pattern_name
              Specifies the name of the ring pattern.

       -nets net_list
              Specifies power and ground net names used in this ring  pattern.
              The  net  names  are symbolic names and are mapped to actual net
              names by the set_pg_strategy command.

              The net name mapping is by position, where the first net name in
              the net_list list corresponds to the first net name specified by
              the set_pg_strategy command, and so on. This option is  required
              when  you  specify  a net-based via rule, as each net can have a
              different  via  requirement.  Otherwise,  this  option  is   not
              required.

       -horizontal_width width_list
              Specifies  the  horizontal  ring width. width_list specifies the
              list of horizontal widths, where the first width in the list  is
              the  width  of  the  first  net, and so on. The unit is um. Each
              value can also be specified by evaluating the  variable  in  the
              -parameters  option.  The  at  character (@) is used as a prefix
              symbol to specify a parameter and directs the command to replace
              the  value  with the value specified by the set_pg_strategy com-
              mand. If this option is not specified, the minimum width defined
              in the technology file is used for the horizontal width.

       -vertical_width width_list
              Specifies the vertical ring width. width_list specifies the list
              of vertical widths, where the first width in  the  list  is  the
              width  of  the  first net, and so on. The unit is um. Each value
              can also be specified by evaluating the variable in  -parameters
              option. The at character (@) is used as a prefix symbol to spec-
              ify a parameter. If this option is not  specified,  the  minimum
              width  defined  in  the technology file is used for the vertical
              width.

       -horizontal_spacing spacing_list
              Specifies the spacing between horizontal  ring  segments.  spac-
              ing_list  specifies the list of horizontal spacing values, where
              the first value in the list is the spacing of the first net, and
              so on. The unit is um. Each value can also be specified by eval-
              uating the variable in -parameters option. The at character  (@)
              is  used  as  a  prefix  symbol  to specify a parameter. If this
              option is not specified, the  minimum  spacing  defined  in  the
              technology file is used for horizontal spacing.

       -vertical_spacing spacing_list
              Specifies  the  spacing  between  vertical ring segments.  spac-
              ing_list specifies the list  of  vertical  spacing  values.  The
              first  value in the list is the spacing of the first net, and so
              on.  The unit is um. Each value can also be specified by  evalu-
              ating  the  variable in -parameters option. The at character (@)
              is used as a prefix symbol  to  specify  a  parameter.  If  this
              option  is  not  specified,  the  minimum spacing defined in the
              technology file is used for vertical spacing.

       -horizontal_layer layer
              Specifies the horizontal layer name. The layer name can also  be
              specified  by evaluating the variable in -parameters option. The
              at character (@) is used as a prefix symbol to specify a parame-
              ter.  If  this option is not specified, the topmost metal layers
              in the preferred routing direction  defined  in  the  technology
              file is used.

       -vertical_layer layer
              Specifies  the horizontal layer name. The layer name can also be
              specified by evaluating the variable in -parameters option.  The
              at character (@) is used as a prefix symbol to specify a parame-
              ter.  If this option is not specified, the topmost metal  layers
              in  the  preferred  routing  direction defined in the technology
              file is used.

       -side_width width_spec
              Specifies the ring segment width per  side.  The  width_spec  is
              defined as follows:

              {{side : id_list}
               {width : width_list}}

              where  side is the keyword to create a side specification.  Side
              contains a list of edge IDs.  Each ring edge  is  indexed  by  a
              unique  number.   Edge  numbering  starts from 1 at the leftmost
              vertical edge.  If there is more than  one  leftmost  edge,  the
              bottommost  edge is the starting edge. The edge number increases
              by 1 as you proceed around the shape in the clockwise direction.

              width is the keyword to create a ring  width  specification  for
              that  side.   width_list  specifies the width list for each net.
              The unit is um.  Each value can also be specified by  evaluating
              the variable in -parameters option. The at character (@) is used
              as a prefix symbol to specify a parameter.

              You can create multiple specifications, where each spec is  con-
              tained within a brace pair.

              The  side  width  specified in this option has a higher priority
              than the horizontal or vertical width.

       -side_spacing spacing_spec
              Specifies the ring segment spacing per side. The spacing_spec is
              defined as follows:

              {{side : id_list}
               {spacing: spacing_list}}

              where  side  is  the  keyword for side.  Side contains a list of
              edge IDs.  Each ring edge is indexed by a unique  number.   Edge
              numbering starts from 1 at the leftmost vertical edge.  If there
              are more than one leftmost edges, the  bottommost  edge  is  the
              starting  edge.  The  edge  number increases by 1 as you proceed
              around the shape in the clockwise direction.

              spacing is the keyword for ring spacing  of  that  side.   spac-
              ing_list  specifies  the spacing list between nets.  The unit is
              defined in the technology file.  Each value can also  be  speci-
              fied  by  evaluating  the variable in -parameters option. The at
              character (@) is used as a prefix symbol to specify a parameter.

              You can create multiple specifications, where each spec is  con-
              tained within a brace pair.

              The  side spacing specified in this option has a higher priority
              than the horizontal or vertical spacing.

       -side_layer layer_spec
              Specifies the ring segment layer per side.   The  layer_spec  is
              defined as follows:

              {{side : id_list}
               {layer: layer_name}}

              where  side  is  the  keyword for side.  Side contains a list of
              edge IDs.  Each ring edge is indexed by a unique  number.   Edge
              numbering starts from 1 at the leftmost vertical edge.  If there
              are more than one leftmost edges, the  bottommost  edge  is  the
              starting  edge.  The  edge  number increases by 1 as you proceed
              around the shape in the clockwise direction.

              layer is the keyword for ring layer of  that  side.   layer_name
              specifies  the  layer  name for each net. Each value can also be
              specified by evaluating the variable in -parameters option.  The
              at character (@) is used as a prefix symbol to specify a parame-
              ter.

              You can create multiple specifications, where each spec is  con-
              tained within a brace pair.

              The  side  layer  specified in this option has a higher priority
              than the horizontal or vertical layer.

       -corner_bridge true | false | @param
              Specifies whether the pattern creates a corner bridge.  You  can
              specify  the  setting  by  evaluating  the variable param in the
              -parameters option. The at character (@) is  used  as  a  prefix
              symbol to specify a parameter. The "true" setting creates bridge
              connection at all ring corners  and  connects  inner  and  outer
              rings  of  the  same  net.  If  this option is not specified, no
              bridge connection is created for the ring pattern.

       -track_alignment track | half_track | none |@var
              Specifies the track alignment option of this wire  pattern.   It
              can  be  specified by track, half_track or none.  It can also be
              specified by evaluating the  var  variable  in  the  -parameters
              option.  The  at  character (@) character is used as a prefix to
              evaluate the variable. The default value is none.

       -parameters var_list
              Specifies the list of parameters for this pattern. Each  parame-
              ter  can be evaluated and used as the argument for other options
              in this command. This allows the pattern to be programmable  and
              reused  by passing different parameters in different situations.
              Each parameter var in the list var_list is a  string.  Parameter
              strings  in  var_list  for the -parameters option do not contain
              the at character (@), but the at character is used as  a  prefix
              symbol  for parameters when used with the other command options.
              Parameter values are specified by the  set_pg_strategy  command.
              See the example section for more details.

       -via_rule via_rule_spec
              Specifies  the via rule for creating vias between horizontal and
              vertical ring segments. The via rule  defines  the  intersection
              locations and the via at the locations.

              There  are  several ways to define the intersection locations in
              the via_rule_spec specification. The syntax is defined  as  fol-
              lows:

              {intersection : all}      {via_def} |
              {intersection : adjacent} {via_def} |
              list_of_filter_rules |

              The  first  way is "{intersection : all}", where intersection is
              the keyword and all refers to all intersections between any ring
              segments in different directions and different layers.

              The  second  way is "{intersection : adjacent}", where intersec-
              tion is the keyword, and adjacent refers  to  all  intersections
              between  any  two  ring segments in different directions only in
              adjacent layers.

              The third way is to define the intersections based on  two  sets
              of  shapes  using list_of_filter_rules, which contains a list of
              filtering rules. Each filtering rule is specified inside a brace
              pair. The syntax of each filtering rule is as follows:

              {{set_1} {filter_1}} {{set_2} {filter_2}} {via_def} |
               {intersection : undefined} {via_def}

              where  the  two sets are the set of ring segments.  Each set can
              be further filtered to  obtain  a  subset  of  selected  shapes.
              set_1 and set_2 are defined as follows:

              {side : id_list}

              where  side  is the keyword for ring side, which contains a list
              of edge IDs id_list.

              The filtering operations for ring segments are defined  as  fol-
              lows:

              {nets : net_list}
              {layers : layer_list}
              {width : {lower_w upper_w}}

              nets, layers, width keywords can be used to specify the wire net
              names by net_list, wire layer names by layer_list or width range
              by  {lower_w  upper_w}.   Ring  segments which satisfy the above
              criteria form a subset of shapes.

              For those intersections which do not  belong  to  any  filtering
              rule, the via definition can be specified by

              {intersection : undefined}{via_def}

              where  intersection  is  the  keyword,  undefined  refers to the
              remaining intersections which do not  belong  to  any  filtering
              rules.  By default, vias are not created at the intersections if
              they do not belong to a filtering rule, unless otherwise  speci-
              fied.  Multiple  via filtering rules, such as intersection loca-
              tion and via definition, can be defined and separated by braces,
              where each filter rule is in one brace pair.

              With   the   intersection   definition,  the  via  specification
              {via_def} is in the following format:

              {via_master : via_master_list | via_rule_list}

              where via_master is the keyword for both  via  masters  and  via
              master  rules.   via_master_list  specifies the list of via mas-
              ters.  Via masters include via contact code defined in the tech-
              nology  file or user-defined via cells.  via_rule_list is a list
              of  PG  via  rules.   Via  master  rules  are  defined  by   the
              set_pg_via_master_rule command.  NIL can be used as a keyword to
              indicate that no via is created.  default can be used  to  apply
              the  default vias in the specified location.  For each specified
              intersection, vias are created based on the specified  via  mas-
              ters  or via master rules.  If NIL is not specified in the list,
              the default contact code is used to complete a stacked via or to
              replace a via when a DRC error occurs.

              By  default,  the  default via defined in the technology file is
              created at each intersection of orthogonal ring segments,  where
              the ring segments are on different layers.

DESCRIPTION
       Creates  a  power ground (PG) ring pattern. The pattern created by this
       command is associated with a region or area of the design by using  the
       set_pg_strategy  command,  and  is inserted into the design by the com-
       pile_pg command.

       The ring pattern specifies the horizontal and vertical ring width  val-
       ues, layer names, spacing values and corner bridge options.  The values
       can be either fixed values  or  set  by  using  parameters.  Via  rules
       between horizontal and vertical ring segments can also be specified.

       The  ring  contour  shape,  offset to the ring contour and vias between
       this  ring  pattern  and  any  other  shapes  can   be   specified   by
       set_pg_strategy command when associating this pattern to a routing area
       in the design.

EXAMPLES
       The following example creates a ring pattern ring1 for  layers  M3  and
       M4.  The  spacing values are 1 and 2, the width is 5 for horizontal and
       vertical segments except for side 1 with width  6,  the  corner  bridge
       option  is  defined  by  parameter  @flag,  and  the  via  master  rule
       via34_2x2, i.e. between layer M3 and M4 with array size 2 by 2.

         prompt> create_pg_ring_pattern ring1 \
            -parameters {flag} \
            -horizontal_layer M3 -vertical_layer M4 \
            -horizontal_width 5 -vertical_width 5 \
            -horizontal_spacing 1 -vertical_spacing 2 \
            -side_width {{side: 1} {width: 6}} \
            -corner_bridge @flag \
            -via_rule {{intersection: all} {via_master: VIA34}}

       The following example creates a ring pattern  ring2,  where  the  width
       list  {1  2  3}  is  applied  to  sides {1 3} and width list {3 4 5} is
       applied to sides {2 4}. For sides 1 and 3, the innermost ring width  is
       1,  middle  ring  width is 2 and outermost ring width is 3. For sides 2
       and 4, the innermost ring width is 3, middle ring width is 4 and outer-
       most ring width is 5.

         prompt> create_pg_ring_pattern ring2 \
            -side_width { \
               {{side: 1 3} {width: 1 2 3}} \
               {{side: 2 4} {width: 3 4 5}} \
            }

       The  following  example  creates  a ring pattern ring3, where the width
       list {1 2 3} is applied to sides {1 2 3 4}. For sides 1, 2,  3  and  4,
       the  innermost ring width is 1, the middle ring width is 2 and the out-
       ermost ring width is 3.

         prompt> create_pg_ring_pattern ring3 \
            -side_width { \
               {side: 1 2 3 4} {width: 1 2 3} \
            }

MORE EXAMPLES
       For more example, please start GUI and invoke  the  following  command.
       gui_show_task_assistant   -task   "Design  Planning:PG  Planning->Exam-
       ples->Overview".

SEE ALSO
       compile_pg(2)
       create_pg_composite_pattern(2)
       create_pg_macro_conn_pattern(2)
       create_pg_std_cell_conn_pattern(2)
       create_pg_wire_pattern(2)
       remove_pg_patterns(2)
       report_pg_patterns(2)
       report_pg_strategies(2)
       set_pg_strategy(2)
       set_pg_via_master_rule(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////////
icc2_shell> man set_pg_strategy
2.  Synopsys Commands                                        Command Reference
                                set_pg_strategy

NAME
       set_pg_strategy
              Specifies the power ground network creation strategy.

SYNTAX
       status set_pg_strategy
              strategy_name
              [-core | -design_boundary | -voltage_areas voltage_areas |
               -polygon {polygon_area} | -macros macro_names |
               -blocks block_names | -pg_regions pg_region_names]
              -pattern pattern_expr
              [-extension {extension_spec}]
              [-blockage {blockage_spec}]

   Data Types
       strategy_name           string
       voltage_areas           collection
       polygon_area            list
       macro_names             collection
       block_names             collection
       pg_region_names         list
       pattern_expr            specification
       extension_spec          specification
       blockage_spec           specification

ARGUMENTS
       The options -core, -design_boundary, -voltage_areas, -polygon, -macros,
       -blocks and -pg_regions are mutually exclusive. One  and  only  one  of
       these options needs to be specified.

       strategy_name
              Specifies the name of the strategy.

       -core  Uses the core area as the power ground region.

       -design_boundary
              Uses the design boundary as the power ground region.

       -voltage_areas voltage_area
              Uses the specified voltage area as the power ground region.

       -polygon {polygon_area}
              Uses  the specified polygon area as the power ground region. The
              polygon area is specified by a list of coordinate points.

       -macros {macro_names}
              Uses the specified macros as the power ground region.

       -blocks {block_names}
              Uses the specified blocks as the power ground region.

       -pg_regions pg_region_names
              Uses the power ground regions created  by  the  create_pg_region
              command  as  the  power ground regions.  Multiple regions can be
              specified in the list pg_region_names.

       -pattern pattern_expr
              Specifies the power ground pattern to be  instantiated  in  this
              strategy.  The pattern can be wire, composite, mesh, ring, macro
              connection, standard cell rail connection, or  special  pattern.
              Only one pattern can be specified and this is a required option.

              For  wire,  composite,  mesh, connection or special pattern, the
              strategy instantiates the pattern inside  the  routing  area  by
              repeating the pattern.  For macro connection pattern, the strat-
              egy instantiates the pattern by applying the pattern  to  macros
              inside  the  routing  area.  For a standard cell rail connection
              pattern, the strategy instantiates the pattern by creating stan-
              dard cell rails inside the routing area.  The pattern expression
              pattern_expr is specified as follows:

              {name: pattern_name}
              {nets: real_net_list}
              {parameters: var_list}
              {offset: {x_offset y_offset}}
              {offset_start: boundary | {x y}}

              The name keyword followed by pattern_name specifies the name  of
              the pattern.  For standard cell connection pattern, if the spec-
              ified pattern name is std_cell_rail and this  pattern  does  not
              exist,  a  default  standard  cell rail pattern std_cell_rail is
              created.

              The nets keyword followed by real_net_list specifies the list of
              net  names  to  be mapped into the symbolic list of nets in pat-
              tern_name.

              The parameters keyword followed by var_list specifies the param-
              eter  list.  The  parameter list is passed as arguments into the
              pattern pattern_name.

              The offset keyword followed by {x_offset y_offset} specifies the
              horizontal and vertical offsets when creating the first pattern.
              By default, the offset is 0 for  both  horizontal  and  vertical
              offsets.   Offset does not apply to the scattered pin macro con-
              nection pattern or the standard cell rail pattern.

              The offset_start keyword specifies the offset reference point in
              routing area for pattern offsets. The boundary keyword refers to
              the lower-left point of the routing area bounding box. Any other
              point can also be specified as the reference point by coordinate
              {x y}. By default, boundary is used. Offset start does not apply
              to  scattered pin macro connection pattern or standard cell rail
              pattern.

              For a ring pattern, the strategy instantiates the pattern around
              the  routing area. The pattern expression pattern_expr is speci-
              fied as follows:

              {name: pattern_name}
              {nets: real_net_list}
              {parameters: var_list}
              {offset: {x_offset y_offset}}
              {skip_sides: id_list}
              {side_offset: side_offset_spec}

              The pattern keyword followed by pattern_name specifies the  pat-
              tern name.

              The  nets  keyword  followed  by real_net_list specifies the net
              name list. The nets are mapped into the symbolic list of nets in
              pattern_name.

              The parameters keyword followed by var_list specifies the param-
              eter list which will be passed as  arguments  into  the  pattern
              pattern_name.

              The offset keyword followed by {x_offset y_offset} specifies the
              horizontal and vertical  offsets  when  creating  ring  segments
              around  the  routing  area.  The  offset is the distance between
              innermost ring to the routing area boundary.   By  default,  the
              offset is 0 for both horizontal and vertical offsets.

              The skip_sides keyword specifies the edge ID list to be skipped.
              id_list specifies the edge ID list to be skipped for  ring  cre-
              ation.  Each edge is indexed by a unique number.  Edge numbering
              starts from 1 at the leftmost vertical edge.  If there  is  more
              than  one  leftmost  edge,  the  bottommost edge is the starting
              edge. The edge number increases by 1 as you proceed  around  the
              shape  in  the  clockwise  direction.   By  default,  no edge is
              skipped for ring creation.

              The side_offset keyword specifies  the  offset  for  each  edge.
              Each  edge is indexed by a unique number.  Edge numbering starts
              from 1 at the leftmost vertical edge.  If there is more than one
              leftmost  edge,  the  bottommost  edge is the starting edge. The
              edge number increases by 1 as you proceed around  the  shape  in
              the  clockwise direction.  side_offset_spec specifies the offset
              for each edge as a pair of edge_id and offset keywords. An exam-
              ple is as follows:

              {{side: edge_id}{offset: edge_offset}}

              where  side  and  offset  specify  the  edge  ID and edge offset
              respectively.  The offset unit  is  defined  in  the  technology
              file.   You  can  specify negative offsets to shrink the region.
              If you do not specify offsets for all edges, the offset for  the
              remaining  edges is either 0 or the uniform offset for all edges
              set by -offset option.

       -extension {extension_spec}
              Specifies how a group of power and  ground  nets  should  extend
              beyond the power grid.  You can specify multiple extension spec-
              ifications separated by braces. Each specification contains  the
              keywords nets, side, layers, direction and stop as follows:

              {{nets: nets}
               {side : id_list}
               {layers : layer_list}
               {direction: directions}
               {stop: stop_target}}

              The  net  names  following  the nets keyword are a subset of the
              nets specified by -nets in pattern_expr from -pattern option. If
              you  do  not  specify the nets keyword, the extension applies to
              all the nets in the strategy.

              The side keyword specifies the ring segment IDs  or  macro  side
              IDs  by id_list.  Each ring edge or macro boundary is indexed by
              a unique number.  Edge numbering starts from 1 at  the  leftmost
              vertical  edge.   If  there  is more than one leftmost edge, the
              bottommost edge is the starting edge. The edge number  increases
              by 1 as you proceed around the shape in the clockwise direction.
              If not specified, the extension applies to all ring edges or all
              macro  boundary  sides. This keyword can be only applied to ring
              or macro connection type pattern.

              The direction keyword specifies the extension direction.  direc-
              tions  contains one or more of the letters "L", "R", "T" or "B";
              "L" refers to left, "R" refers to right, "T" refers to top,  and
              "B" refers to bottom. If this entry is not specified, the exten-
              sion applies to all directions.

              The layers keyword specifies the extension  specifications  only
              applied  to  the particular layer list by layer_list, which con-
              tains a list of routing layer names.  If  this  keyword  is  not
              specified, the extension applies to all layers.

              The  specification  following the stop keyword can be a distance
              specified in microns, a collection or a list of PG pins, or  one
              of  the  following keywords: core_boundary, first_target, inner-
              most_ring, outermost_ring, pad_ring,  half_space,  design_bound-
              ary, and design_boundary_and_generate_pin.  core_boundary speci-
              fies the core area boundary.  first_target specifies  the  first
              wire  segment of the same net.  collection_of_pins specifies the
              collection of pins to be extended to.  innermost_ring  specifies
              the innermost ring of the same net, outermost_ring specifies the
              outermost ring of the same net, pad_ring specifies the pad  ring
              segment  or  pad ring pins of the same net, half_space specifies
              half spacing rule to the specified region of the strategy.   and
              design_boundary  specifies  the  boundary of the current design.
              design_boundary_and_generate_pin  specifies  extension  to   the
              design boundary and generating pins.  If you specify a distance,
              the shape extends by the distance from the boundary of the rout-
              ing  region  if  the pattern is wire pattern, composite pattern,
              mesh pattern, or standard cell connection pattern, or  from  the
              corner of ring segments for ring pattern, or from macro pins for
              macro connection pattern.  You  can  also  make  the  shapes  to
              extend to a pre-specified set of macro pins.  There are two ways
              to specify the set of pins, use a list of pin names or a collec-
              tion of pins. For this stop option to work, both nets and layers
              options need to be specified as well.

              Collection  of  pins  example  set   gnd_pins   [get_pins   -all
              -of_objects   [get_cell   $powerSwitches]  -filter  "name==GND"]
              set_pg_strategy  -extension  {{{nets:  GND}  {stop:   $gnd_pins}
              ...}...}...

              List  of pin names example set gnd_pinNames "GND0 GND1 GND2 ..."
              set_pg_strategy -extension {{{nets: GND}  {stop:  $gnd_pinNames}
              ...}...}...

       -blockage {blockage_spec}
              Specifies  the routing blockage in the power ground network. You
              can specify multiple blockages within the braces,  one  blockage
              per  group.  Blockages  are  separated by braces and contain the
              keywords nets:, layers:, and a target specification as follows:

              {{nets: nets} {layers: layers} {target}

              where target is a voltage area, block, macro,  macro  with  hard
              keep-out-margin  (KOM),  PG  region, hard placement blockage, or
              polygon that is specified as follows:

              {voltage_areas : voltage_areas | macros : macro_names |
              macros_with_keepout : macro_names | placement_blockages : all |
              polygon : {polygon_area} | blocks : blocks |
              pg_regions : region_list }

              The net names following the nets keyword are  a  subset  of  the
              nets specified by -nets in pattern_expr from -pattern option. If
              you do not specify the nets keyword, the blockage applies to all
              the  nets  in the strategy. The layer names following the layers
              keyword are the routing layers on which power or  ground  straps
              are  blocked.  If  you  do  not  specify the layers keyword, the
              blockage applies to all routing layers. Use  one  of  the  volt-
              age_areas,  macros,  polygon,  blocks  or pg_regions keywords to
              represent the blockage area.  polygon_area  is  specified  as  a
              list of coordinate points.

DESCRIPTION
       This  command  specifies the strategy for creating power ground network
       elements. The command specifies the power ground pattern, power  ground
       nets,  power  ground  routing  area, the net extension strategy and the
       blockage area.

       For wire, composite, mesh and special patterns, the strategy  instanti-
       ates  the pattern inside the routing area by repeating the pattern. For
       a ring pattern, the strategy instantiates the pattern around the  rout-
       ing  area.  For macro connection pattern, the strategy instantiates the
       pattern by applying the pattern to macros inside the routing area.  For
       standard  cell  rail  connection pattern, the strategy instantiates the
       pattern by creating standard cell rails inside the routing area. Block-
       age and extension can be further specified.

EXAMPLES
       The  following example defines a power ground strategy s1 for a compos-
       ite pattern comp_pattern. Parameters 5 and 3 are passed into  the  pat-
       tern  for  wire  width  and  spacing  respectively. The routing area is
       inside the voltage area VA1. The real net names are VDD and  VSS.  Both
       nets  extend  to the outermost VDD and VSS rings. Macro hm1 inside this
       voltage area is treated as blockage for VDD but not for VSS.

         prompt> set_pg_strategy \
           s1 \
           -voltage_areas {VA1} \
           -pattern {{name: comp_pattern}{nets:{VDD VSS}}{parameters:{5 3}}}\
           -blockage {{nets: VDD}{macros: rf0/x0/t_al}}\
           -extension {stop: outermost_ring}

       The following example defines a power ground strategy  s2  for  a  ring
       pattern ring_pattern. Parameters 4, 1, 5, 2 are passed into the pattern
       for horizontal width, spacing,  and  vertical  width,  spacing  respec-
       tively.  The  ring  is  around the routing area defined by power ground
       region r1. The net names are Vdd and Vss.  Horizontal and vertical off-
       sets  are  10  and 20 respectively.  The ring segment with edge ID 1 is
       extended in the top direction to the pad ring.

         prompt> set_pg_strategy \
           s2 \
           -pg_regions {r1} \
           -pattern {{name: ring_pattern}{nets:{Vdd Vss}} \
                     {parameters:{4 1 5 2}}{offset:{10 20}}} \
           -extension {{side: 1}{direction: T}{stop: pad_ring}}

       The following example defines a power ground strategy  s3  for  a  ring
       pattern  ring_pattern.  The  ring is around the routing area defined by
       power ground region r1. The net names are Vdd and Vss.  Horizontal  and
       vertical  offsets  are  10  and 20 respectively.  The ring segment with
       edge IDs 1 and 2 is extended in the both bottom and right directions to
       the  design  boundary with pin created, and edge ID 3 in the top direc-
       tion to design boundary with pin created.

         prompt> set_pg_strategy \
           s3 \
           -pg_regions {r1} \
           -pattern {{name: ring_pattern}{nets:{Vdd Vss}} \
                     {offset:{10 20}}} \
           -extension {{{side: 1 2}{direction: B R }{stop: design_boundary_and_generate_pin}} \
                      {{side: 3}{direction: T}{stop: design_boundary_and_generate_pin}}}

       The following example defines a power ground strategy s4  for  a  macro
       connection  pattern macro_pattern. The nets are Vdd and Vss. The macros
       to be connected are hm1 and hm2. For the pins at boundary sides indexed
       by 1, 2 and 3, the extension stops at the first target. For the pins at
       the side indexed by 4, the extension stops at the innermost ring.

         prompt> set_pg_strategy \
           s4 \
           -macros "$macro1 $macro2" \
           -pattern {{name: macro_pattern}{nets:{Vdd Vss}}} \
           -extension {{{side: 1 2 3}{stop: first_target}} \
                        {{side: 4}{stop: innermost_ring}}}

       The following example defines a power ground strategy s5 for a standard
       cell  rail  connection  pattern std_pattern.  The nets are Vdd and Vss.
       The routing area is the core area.  The routing layers are M1 and M2 as
       parameters  passed into the pattern. The rails at layer M2 are extended
       out of the core area by 10 um.

         prompt> set_pg_strategy \
           s5 \
           -core \
           -pattern {{name: std_pattern}{nets: {Vdd Vss}}{parameters: {M1 M2}}}\
           -extension {{stop: 10}{layers: M2}}

MORE EXAMPLES
       For more example, please start GUI and invoke  the  following  command.
       gui_show_task -task "Design Planning:PG Planning->Examples->Overview"

SEE ALSO
       compile_pg(2)
       create_pg_composite_pattern(2)
       create_pg_macro_conn_pattern(2)
       create_pg_mesh_pattern(2)
       create_pg_region(2)
       create_pg_ring_pattern(2)
       create_pg_special_pattern(2)
       create_pg_std_cell_conn_pattern(2)
       create_pg_wire_pattern(2)
       remove_pg_strategies(2)
       report_pg_strategies(2)
       set_pg_strategy_via_rule(2)
       set_pg_via_master_rule(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
//////////////////////////////////////////////////////////////////////////
icc2_shell> man compile_pg
2.  Synopsys Commands                                        Command Reference
                                  compile_pg

NAME
       compile_pg
              Creates  a  power  and  ground  network including straps, rings,
              macro connections, standard cell connections and via connections
              based on the specified power ground strategies.

SYNTAX
       status compile_pg
              [-strategies strategy_list]
              [-via_rule rule_list]
              [-ignore_drc]
              [-ignore_via_drc]
              [-show_phantom]
              [-undo]
              [-tag tag_name]
              [-create_ml_data]
              [-use_ml_model]

   Data Types
       strategy_list   list
       rule_list       list
       tag_name        string

ARGUMENTS
       -strategies strategy_list
              Creates  a  power  network  based  only on the specified list of
              strategies. By default, the tool creates a power ground  network
              using all strategies which have been defined.

       -via_rule rule_list
              Specifies  the  via  rule  list  between strategies and existing
              shapes. The via rule list rule_list contains strategy-level  via
              rules  defined  by  the set_pg_strategy_via_rule command.  If no
              strategy via rule is specified, the default via defined  in  the
              technology  file is created at all intersections between any two
              orthogonal shapes on different layers.

       -ignore_drc
              Creates the power network while ignoring DRCs for both wires and
              vias.   By  default,  all  DRCs are considered when creating the
              power network.  This  option  is  mutually  exclusive  with  the
              -ignore_via_drc option.

       -ignore_via_drc
              Creates  the power network while ignoring via DRCs.  By default,
              all DRCs are considered when creating the power  network.   When
              this  option  is set, DRCs for wires are checked and fixed, DRCs
              within each stacked via are checked and fixed. Only DRCs between
              stacked  vias  and neighboring objects are ignored.  This option
              is mutually exclusive with -ignore_drc option.

       -show_phantom
              Generates report for  wires/vias  that  should  be  created  but
              failed due to fixing DRC violation. Detailed information will be
              displayed in error browser.   The  report  includes  two  parts,
              phantom  wire  and phantom via.  Wire information and DRC viola-
              tion are included in one phantom wire. Only DRC violations  that
              cut  part of wire shape while fixing will be included in phantom
              wire.   Abutted  phantom  wires  will  be  merged  and  reported
              together.  Via information and DRC violation are included in one
              phantom via.  Via information includes top/bottom wire  informa-
              tion,  via def, net name.  DRC violation shows initial violation
              before fixing. If -ignore_drc or -ignore_via_drc  is  specified,
              phantom via will not be generated.

       -undo  Removes  the power and ground network created by the most recent
              compile_pg command.

       -tag tag_name
              Specifies a tag name to assign to all new vias and  shapes  cre-
              ated   by   this  command.  This tag name is used as contents of
              an user attribute tag for filtering collections at later  stages
              (see   the  example   in  the  EXAMPLES  section).  By  default,
              no tags are assigned.

       -create_ml_data
              This option enables this command to  create  training  data  for
              training  ML  model for fixability prediction.  When this option
              is set, the command only creates ML training data, not  creating
              PG wires/vias.

       -use_ml_model
              This  option  enables  this command to load pre-trained ML model
              for fixability prediction.

DESCRIPTION
       This command creates the power network based  on  the  specified  power
       ground strategies.

       Signal  routes  by  default are ignored for DRC checking and correction
       during PG creation. Use the following app option to honor signal  route
       DRC during PG creation.
         prompt> set_app_options -list {plan.pgroute.honor_signal_route_drc true}

EXAMPLES
       The  following  example  creates  a power ground network using only the
       example1 and example2 strategies. The rule1 via rule is defined by  the
       set_pg_strategy_via_rule command.

         prompt> compile_pg -strategies {example1 example2}\
                               -via_rule rule1

       The  following  example  compiles  strategy  example1  using  4 threads
       defined in the global host_options mt for via creation.

         prompt> set_host_options -max_cores 4
         prompt> compile_pg -strategies {example1}

       The following example creates collections of vias and  wires  that  are
       tagged with the name pg1.

         prompt> compile_pg -tag pg1
         prompt> set vias [get_vias -filter tag==pg1]
         prompt> set wires [get_shapes -filter tag==pg1]

       The following example creates ML training data in memory, output train-
       ing data to files in the directory ./pg_model, and train ML model based
       on  the  training data. The trained ML model is stored in the directory
       ./pg_model.

         prompt> compile_pg -create_ml_data
         prompt> train_pg_ml_model

       The following example creates ML training data in memory, output train-
       ing  data  to files in directory pg_data_1, and train ML model based on
       the training data. The trained ML model  is  stored  in  the  directory
       ./pg_model.

         prompt> compile_pg -create_ml_data
         prompt> create_pg_ml_data -output_directory pg_data_1
         prompt> train_pg_ml_model -input_directory {pg_data_1}

       The  following  example  loads  pre-trained  ML  model in the directory
       ./pg_model for fixability prediction to reduce runtime of PG  via  cre-
       ation.

         prompt> compile_pg -use_ml_model

       In  addition  to  the  above  examples, see the Examples page in the PG
       Planning section of the Task Assistant for more  information.  To  view
       the  Examples  page,  start  the  GUI and invoke the following command:
       gui_show_task_assistant  -task  "Design   Planning:PG   Planning->Exam-
       ples->Overview".

SEE ALSO
       remove_pg_strategies(2)
       report_pg_strategies(2)
       report_pg_strategy_via_rules(2)
       set_host_options(2)
       set_pg_strategy(2)
       set_pg_strategy_via_rule(2)
       get_vias(2)
       get_shapes(2)
       create_pg_ml_data(2)
       train_pg_ml_model(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
////////////////////////////////////////////////////////////////////
icc2_shell> man remove_modes
2.  Synopsys Commands                                        Command Reference
                                 remove_modes

NAME
       remove_modes
              Removes modes in multi mode analysis.

SYNTAX
       remove_modes -all | mode_list

ARGUMENTS
       -all   Specifies to remove all modes in the current design.

       mode_list
              A list of unique strings used to identify each mode.

DESCRIPTION
       This command removes the specified modes from memory. To list the modes
       in the design, use the all_modes command.

       The command returns the number of modes that were removed.

EXAMPLES
       In the following example, two modes named mode1 and mode2 are removed.

          prompt> remove_modes {mode1 mode2}
          1

SEE ALSO
       create_mode(2)
       all_modes(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
/////////////////////////////////////////////////////////////////////////
icc2_shell> man create_mode
2.  Synopsys Commands                                        Command Reference
                                  create_mode

NAME
       create_mode
              Creates a mode in the current design.

SYNTAX
       string create_mode
              mode_name

   Data Types
       mode_name      string

ARGUMENTS
       mode_name
              Specifies the name of the mode being created.

DESCRIPTION
       Creates  a mode in the current design.  Modes are used to contain a set
       of constraints environment for the design.  Unique modes are often used
       for different combinations of operating modes and power schemes.  Modes
       are used together with corners, which contain operating  condition  and
       parasitics  parameters.   Timing  analysis is actually done for various
       mode/corner combinations, as configured by the set_scenario_status com-
       mand.

       Constraints  are  contained  in  the  current mode.  When the design is
       linked, a single mode named "default" is automatically created and  set
       to  be  the current mode.  If the create_mode command is used, the cur-
       rent_mode is set to the newly-created mode.  You can  set  the  current
       mode to a different mode with the current_mode command.

       To  create  a  collection  of  modes  matching a pattern and optionally
       matching filter criteria, use the get_modes command.  To get a  collec-
       tion of all modes in the design, use the all_modes command.

       To undo create_mode, use the remove_modes command.

EXAMPLES
       The following example creates a mode named "Mission5" and sets it to be
       the current mode.

         prompt> create_mode Mission5

SEE ALSO
       all_modes(2)
       current_mode(2)
       get_modes(2)
       remove_modes(2)
       create_corner(2)
       set_scenario_status(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
////////////////////////////////////////////////////////////////////
icc2_shell> man create_corner
2.  Synopsys Commands                                        Command Reference
                                 create_corner

NAME
       create_corner
              Creates a corner in the current design.

SYNTAX
       string create_corner
              [-copy corner_name]
              corner_name

   Data Types
       corner_name string

ARGUMENTS
       corner_name
              Specifies the name of the new corner.

       -copy corner_name
              Specifies the name of the corner to copy from.

DESCRIPTION
       This  command  creates a corner in the current design. Corners are used
       to contain a set of constraints for the design. Unique corners are used
       to specify different combinations of operating conditions and parasitic
       parameters. Corners are used together with modes, which  are  used  for
       different  operating  modes and power schemes. Timing analysis done for
       various mode and corner combinations  as  configured  by  the  set_sce-
       nario_status command.

       Operating condition and parasitics parameters are contained in the cur-
       rent corner. When the design is linked, a single corner named "default"
       is  automatically  created  and assigned as the current corner.  If the
       create_corner command is used, the current_corner is set to the  newly-
       created  corner.  You  can set the current corner to a different corner
       with the current_corner command.

       To create a collection of corners matching  a  pattern  and  optionally
       matching  filter  criteria, use the get_corners command.  To get a col-
       lection of all corners in the design, use the all_corners command.

       To undo  the  create_corner  command,  or  remove  a  corner,  use  the
       remove_corners command.

EXAMPLES
       The  following example creates a corner named "LowVoltage5" and assigns
       it as the current corner.

         prompt> create_corner LowVoltage5

SEE ALSO
       all_corners(2)
       current_corner(2)
       get_corners(2)
       remove_corners(2)
       create_corner(2)
       create_mode(2)
       set_scenario_status(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////
icc2_shell> man create_scenario
2.  Synopsys Commands                                        Command Reference
                                create_scenario

NAME
       create_scenario
              Creates a scenario in the current design.

SYNTAX
       collection create_scenario
              -mode mode
              -corner corner
              [-name name]
              [-init_from corner_or_scenario]

   Data Types
       mode                collection
       corner              collection
       name                string
       corner_or_scenario  collection

ARGUMENTS
       -mode mode
              Specifies  the  mode  of  the  new  scenario.   This  option  is
              required.  The mode must already exist.

       -corner corner
              Specifies the corner  of  the  new  scenario.   This  option  is
              required.  The corner must already exist.

       -name name
              Specifies  the  name of the new scenario.  If this option is not
              given, a unique name will be synthesized from the mode and  cor-
              ner names.

       -init_from corner_or_scenario
              Specifies an existing scenario or corner object.  If given, this
              object will be used to initialize the new scenario's constraints
              and  analysis  flags.   If a scenario is given, it must have the
              same mode as the scenario being created.  If a corner is  given,
              there must be an existing scenario with that corner and the mode
              of the scenario being created.

DESCRIPTION
       Creates a scenario in the current design, and sets it  active  for  all
       analysis  types  except  cell  and signal EM.  If any of these analysis
       types are not needed, this command should be followed by  the  set_sce-
       nario_status  command.  If a scenario already exists for the given mode
       and corner, the command will fail.  If a scenario with the  given  name
       already  exists,  the command will fail.  If a scenario is successfully
       created, its mode will become the current mode,  and  its  corner  will
       become  the  current  corner.  This means that the new scenario will be
       the current scenario.

       The -init_from option allows you to duplicate all the  constraints  and
       settings  of  an existing scenario onto a new scenario.  If an existing
       scenario is given with -init_from, it will be used as the source.  If a
       corner  is  given,  it  will  be used (along with the mode given by the
       -mode option) to search for  an  existing  scenario  to  serve  as  the
       source.  In either case, the source scenario must have the same mode as
       the new scenario.

       If successful, the command returns a collection containing the new sce-
       nario.

   Multicorner-Multimode Support
       By  default, this command uses the current mode and current corner.  To
       specify a different mode, use the -mode option.  To specify a different
       corner, use the -corner option.

EXAMPLES
       The  following  command  creates a scenario named m1@c1 using corner c1
       and mode m2.

         prompt> create_scenario -name m1@c1 -mode m1 -corner c1

SEE ALSO
       create_corner(2)
       create_mode(2)
       remove_scenarios(2)
       report_scenarios(2)
       set_scenario_status(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////////
icc2_shell> man current_mode
2.  Synopsys Commands                                        Command Reference
                                 current_mode

NAME
       current_mode
              Sets  a  mode  in  the current session to be current. Constraint
              creation and modification commands apply to the current mode.

SYNTAX
       integer current_mode
              [mode_name ]

   Data Types
       mode_name        string

ARGUMENTS
       mode_name
              Name of a defined mode in the current design.

DESCRIPTION
       This command sets one mode in the current session to be  current.  Con-
       straint creation and modification commands apply to the current mode.

       Modes are used together with corners, which contain operating condition
       and parasitics parameters. Timing analysis is actually done for various
       mode/corner combinations, as configured by the set_scenario_status com-
       mand.

   Multicorner-Multimode Support
       This command works on the current mode.

EXAMPLES
       In the following example, two non-default modes are created,  then  the
       current_mode is set to "Mission1".

         1
         prompt> create_mode Mission1
         1
         prompt> create_mode Test1
         1
         prompt> current_mode Mission1
         {"Mission1"}
         prompt> source Mission1_constraints.tcl
         1

SEE ALSO
       create_corner(2)
       create_mode(2)
       remove_modes(2)
       set_scenario_status(2)
       source(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
///////////////////////////////////////////////////////////////////////
icc2_shell> man current_scenario
2.  Synopsys Commands                                        Command Reference
                               current_scenario

NAME
       current_scenario
              Sets the specified scenario as the current scenario or returns a
              collection that contains the current scenario.

SYNTAX
       collection current_scenario
              [scenario_name]

   Data Types
       scenario_name        string

ARGUMENTS
       scenario_name
              Specifies the scenario to set as the current scenario. The named
              scenario must already be defined in the current design.

              If  you do not specify this argument, the command returns a col-
              lection that contains the current scenario.

DESCRIPTION
       The behavior of the current_scenario command  depends  on  whether  you
       specify an argument.
       o If you specify a scenario, the command sets this scenario as the cur-
         rent scenario.

         The scenario's mode becomes the current mode, and its corner  becomes
         the  current corner. By default, constraint creation and modification
         commands apply to the current scenario, mode, or corner.

       o If you do not specify a scenario, the command  returns  a  collection
         that contains the current scenario.

       If  you change the current mode or corner with the current_mode or cur-
       rent_corner commands, the tool sets the current  scenario  to  whatever
       scenario  has  that  mode and corner. If there is no such scenario, the
       current scenario becomes unset.

   Multicorner-Multimode Support
       This command works on the current scenario.

EXAMPLES
       The following command returns the current scenario.

         prompt> current_scenario
         {m1@c1}

       The following command sets the current scenario to m2@c2.

         prompt> current_scenario m2@c2
         {m2@c2}

SEE ALSO
       create_corner(2)
       create_mode(2)
       create_scenario(2)
       current_corner(2)
       current_mode(2)
       remove_corners(2)
       remove_modes(2)
       remove_scenarios(2)
       report_scenarios(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
////////////////////////////////////////////////////////////////////
icc2_shell> man current_corner
2.  Synopsys Commands                                        Command Reference
                                current_corner

NAME
       current_corner
              Sets  a  corner in the current session to be current.  Operating
              condition and parasitics configuration  commands  apply  to  the
              current corner.

SYNTAX
       int current_corner
              [corner_name]

   Data Types
       corner_name   string

ARGUMENTS
       corner_name
              Name of a defined corner in the current design.

DESCRIPTION
       This  command  sets  one  corner  in the current session to be current.
       Operating condition and parasitics configuration commands apply to  the
       current corner.

       Corners  are  used  together  with  modes, which are used for different
       operating modes and power schemes.  Timing analysis  is  actually  done
       for  various  mode/corner  combinations,  as configured by the set_sce-
       nario_status command.

   Multicorner-Multimode Support
       This command works on the current corner.

EXAMPLES
       In the following example, two non-default corners are created, then the
       current_corner is set to "LowPower1".

         prompt> create_corner LowPower1
         1
         prompt> create_corner HighTemperature1
         1
         prompt> current_corner LowPower1
         {"LowPower1"}
         prompt> source LowPower1_opconds.tcl
         1

SEE ALSO
       create_corner(2)
       create_corner(2)
       create_mode(2)
       remove_corners(2)
       set_scenario_status(2)
       source(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>


