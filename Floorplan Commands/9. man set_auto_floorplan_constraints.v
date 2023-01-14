icc2_shell> man set_auto_floorplan_constraints

2.  Synopsys Commands                                        Command Reference
                        set_auto_floorplan_constraints

NAME
       set_auto_floorplan_constraints
              Sets  constraints  for  implicit floorplan initialization.  This
              command is used to set the auto floorplan settings,  which  sup-
              port  the  same  parameters as the initialize_floorplan command.
              During auto floorplanning, the compile_fusion  command  performs
              the following tasks:

              o Creates the die, rows, and tracks

              o Shapes and places voltage areas

              o Places macros

              o Places pins and I/Os

              The  values preset on the set_auto_floorplan_constraints parame-
              ters are passed onto the parameters of the  initialize_floorplan
              command  to  perform  auto  floorplan.   set_auto_floorplan_con-
              straints is called during compile_fusion  -logic_opto  and  com-
              pile_fusion  -initial_place.  If  you  run  initialize_floorplan
              explicitly, auto floorplan is not triggered. Auto floorplan cre-
              ates  missing  floorplan  information; if there is DEF provided,
              auto floorplan preserves user inputs, and incrementally  updates
              the missing information.

SYNTAX
       status set_auto_floorplan_constraints

              [-control_type core | die]
              [-shape R | L | T | U]
              [-side_length side_length]
              [-side_ratio side_ratio]
              [-core_utilization utilization]
              [-boundary coordinates ]
              [-orientation N | W | S | E]
              [-coincident_boundary true | false]
              [-core_offset core_offset_spec]
              [-row_core_ratio row_core_ratio]
              [-flip_first_row true | false]
              [-honor_pad_limit]
              [-site_def site_def_name]
              [-use_site_row]
              [-origin_offset origin_offset_spec]
              [-row_pattern {row_pattern_name}]
              [-reset]

   Data Types
       side_length           list
       side_ratio            list
       utilization           float
       coordinates           list
       core_offset_spec      float
       row_core_ratio        float
       site_def_name         string
       origin_offset_spec    float
       row_pattern_name      string

ARGUMENTS
       -control_type core | die
              Specifies  whether  the side_length and side_ratio options apply
              to the core or the die boundary. If set to die, then the  dimen-
              sions (side_length and side_ratio) are applied to the die bound-
              ary and the core_offset values are subtracted  from  the  dimen-
              sions  to determine the core boundary. If set to core (default),
              the  dimensions  are  applied  to  the  core  boundary  and  the
              core_offset  values are added to the dimensions to determine the
              final die boundary. By default, the control_type is core.

       -shape R | L | T | U
              Specifies the shape used by the command. If the control_type  is
              die,  then the shape applies to the die boundary shape settings.
              Specifies a template shape used to determine the  cell  boundary
              and  core  shape of the rectilinear block. The following diagram
              shows the definition of the edges and the orientation of the R-,
              L-,  T-,  and U- rectilinear blocks.  By default, the core shape
              is R (rectangular).

                        _a_         ___________      _b_     _f_
              __a___   |   |       |           |    |   |   |   |
              |    |   |   b       |           a    a   c   e   |
              |    |   |   |       |_f_     _b_|    |   |_d_|   |
              b    |   |   |_c_        |   |        |           |
              |    |   |       |       e   c        |___________|
              |____|   |       d       |   |
                       |_______|       |_d_|

       -side_length side_length
              Specifies the side length used  by  the  command.  If  the  con-
              trol_type  is die, then it applies to the die boundary side set-
              tings.  Each dimension in the side_length  list  represents  the
              length  of the edge. If you provide more values than required to
              describe the specified shape, the extra values are  ignored.  If
              you  do  not  provide all of the values required to describe the
              specified shape, the tool issues an  error  message.  There  are
              only  two-dimensions  for  -shape  Rect: width and height.  This
              option is mutually exclusive with the -side_ratio option.

       -side_ratio side_ratio
              Specifies the side ratio  used  by  the  command.  If  the  con-
              trol_type  is  die,  then  it  applies the side_ratio to the die
              boundary side settings.  Each dimension in the  list  represents
              the  relative proportion of the dimension of the edge to the sum
              of all the dimensions listed. For example, if the list of dimen-
              sions of an L-shaped block is {1 2 1 1}, the tool calculates the
              dimension of side a, c, or d (where the value is 1) as  20  per-
              cent  (1/(1+2+1+1)) of the sum of the dimensions listed, and the
              dimension of side b is 40 percent of the summation.

       -core_utilization utilization
              Specifies the utilization of the core area. The  utilization  is
              the  total  area  of the core occupied by all standard cells and
              macro cells divided by the total core area.  You can  specify  a
              value  between  0 and 1. The cell area includes all standard and
              macro cells.  For example, a core utilization of  0.8  specifies
              that  80  percent of the core area is used for cell placement at
              this stage. Later, the tool might add more cell area,  with  the
              remaining  area available for routing. By default, the core uti-
              lization is 0.7.

       -boundary coordinates
              Specifies the shape to be used  by  the  command.  If  the  con-
              trol_type  is  core, then the boundary defines the core area and
              the core_offsets should be added to  create  the  die.  If  con-
              trol_type is die, then the core_offset should be subtracted from
              the die boundary to create the core area. The format  is  {  {x1
              y1} {x2 y2} {x3 y3} {x4 y4} }.

       -orientation N | W | S | E
              Specifies  one  of the four possible orientations for the speci-
              fied rectilinear shape. The orientations  are  North  (N),  West
              (W),  South (S), and East (E). The tool repositions the block to
              the specified orientation by rotating it in a  clockwise  direc-
              tion. For -shape R, the orientation is always N.

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

       -core_offset core_offset_spec}
              Specifies the distance between the side of the core and the side
              of  the die boundary.  If only one value is specified, the value
              is used for all sides. If two values are  specified,  the  first
              value  is  applied to all vertical edges and the second value is
              applied to all horizontal edges. Side numbers are based  on  the
              standard  rectilinear numbering and do not correlate to the num-
              bering scheme used to define the  size  of  each  edge  (side_a,
              side_b,  etc). By default, the core offset is equal to the mini-
              mum I/O cell height. If there are no I/O cells, the core  offset
              is 0.

       -row_core_ratio row_core_ratio
              Specifies  the  amount  of channel area between cell rows in the
              core area to reserve for routing.  The ratio is a number between
              0  and  1.0.  A smaller row-to-core ratio creates more space for
              routing channels. A value of  1.0  creates  no  routing  channel
              space. By default, the ratio is 1.0. Note that this ratio should
              be greater than or equal to the core utilization value.

       -flip_first_row true | false
              Specifies whether the command flips the first row at the  bottom
              of the core area for horizontally-placed cell rows, or flips the
              leftmost row for vertically-placed cell rows. By  default,  this
              option is true.

       -honor_pad_limit
              Adjusts  the  core and die size to honor pad-limited designs. If
              this option is not specified, the core area is created based  on
              the default core utilization ratio 0.7.

       -site_def site_def_name
              Specifies  the  site  def to be used in floorplanning when there
              are multiple site defs in the technology file. The default is to
              use default site def.  If there is no default site def, the com-
              mand uses the site def with the smallest site width.

       -use_site_row
              Specifies that the tool creates site rows.

       -origin_offset origin_offset_spec]
              Specifies the location of  the  lower-left  corner  of  the  die
              boundary bounding box with respect to the origin of the block.

       -row_pattern {row_pattern_name}
              Specifies the name of row_pattern to be used for floorplan, when
              there are row patterns specification in the physical  rule  sec-
              tion of technology file.

       -reset Resets all the constraints to their defaults.

DESCRIPTION
       This  command specifies the constraints used to create a floorplan with
       a boundary, core, site array (or rows), and wire tracks. Before execut-
       ing  this  command,  you  must  open  a  physical  design  by using the
       open_block command,  or  create  a  design  with  the  read_verilog  or
       read_verilog_outline commands.

EXAMPLES
       The following example sets the constraint of utilization to be 0.8.

         prompt> set_auto_floorplan_constraints -core_utilization 0.8
         1

       The  following  example sets the preferred core shape to be a rectangle
       (R).

         prompt> set_auto_floorplan_constraints -shape R
         1

       The following example sets the preferred  core  length  to  create  the
       floorplan.

         prompt> set_auto_floorplan_constraints -side_length {200 200}
         1

SEE ALSO
       report_auto_floorplan_constraints(2)
       create_io_ring(2)
       remove_io_rings(2)
       report_io_rings(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
