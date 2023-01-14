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
icc2_shell>
