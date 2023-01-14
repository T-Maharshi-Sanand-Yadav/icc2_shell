icc2_shell> man report_auto_floorplan_constraints

2.  Synopsys Commands                                        Command Reference
                       report_auto_floorplan_constraints

NAME
       report_auto_floorplan_constraints
              Reports  constraints  set  by the set_auto_floorplan_constraints
              command.

SYNTAX
       status report_auto_floorplan_constraints
              [-control_type]
              [-shape]
              [-side_length]
              [-side_ratio]
              [-core_utilization]
              [-boundary]
              [-orientation]
              [-coincident_boundary]
              [-core_offset]
              [-row_core_ratio]
              [-flip_first_row]
              [-honor_pad_limit]
              [-site_def]
              [-use_site_row]
              [-origin_offset]
              [-row_pattern]

ARGUMENTS
       -control_type
              Reports the control type of the core  or  die.  The  default  is
              ratio.

       -shape Reports the core boundary shape. The default is rectangular (R).

       -side_length
              Reports the length of the edges of the core shape.

       -side_ratio
              Reports the ratio of the edges of the core shape.

       -core_utilization
              Reports the core utilization. The default is 0.7.

       -boundary
              Reports the boundary of the core shape.

       -orientation
              Reports the orientation of the specified core shape.

       -coincident_boundary
              Reports whether to keep the same existing boundary.

       -core_offset
              Reports the distance between the side of the core and boundary.

       -row_core_ratio
              Reports the channel ratio between cell rows. The default is 1.0.

       -flip_first_row
              Reports whether the command flips the first row at the bottom of
              the core area for horizontally placed cell  rows  or  flips  the
              leftmost  row  for vertically placed cell rows. By default, this
              option is enabled.

       -honor_pad_limit
              Reports whether to adjust the core and die size  to  honor  pad-
              limited designs.

       -site_def
              Reports the site def name used.

       -use_site_row
              Reports whether to create the site rows.

       -origin_offset
              Reports  the  location  of lower-left corner of the die boundary
              bounding box with respect to the origin of the block.

       -row_pattern
              Reports the row pattern used for floorplan.

DESCRIPTION
       This command reports the constraints that create  a  floorplan  with  a
       boundary,  core, site arrays (or rows), and wire tracks. Before execut-
       ing this command,  you  must  open  a  physical  design  by  using  the
       open_block  command  or  create  a  design by using the read_verilog or
       read_verilog_outline command.

EXAMPLES
       The following example reports the constraint of utilization to be 0.8.

         prompt> report_auto_floorplan_constraints -core_utilization
         1

       The following example reports the preferred core shape to be  rectangle
       (R).

         prompt> report_auto_floorplan_constraints -shape
         1

       The  following  example reports the preferred core length to create the
       floorplan.

         prompt> report_auto_floorplan_constraints -side_length
         1

SEE ALSO
       report_auto_floorplan_constraints(2)
       create_io_ring(2)
       remove_io_rings(2)
       report_io_rings(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
