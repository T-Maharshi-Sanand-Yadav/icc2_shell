icc2_shell> man set_floorplan_width_rules
2.  Synopsys Commands                                        Command Reference
                           set_floorplan_width_rules

NAME
       set_floorplan_width_rules
              Defines a width floorplan rule.

SYNTAX
       set_floorplan_width_rules
              -object_types type_list
              -lib_cells lib_cells
              -type concave | continuous | incorner | jog | simple
              -direction direction_list
              -name rule_name
              [-except_project_lib_cells lib_cells]
              [-project_extension distance]
              [-max_project_spacing distance]
              [-layers layer_list]
              [-gap_size distance]
              [-forbidden_list width_list]
              [-forbidden_ranges {{low high} {low1 high1} ... }]
              [-max distance]
              [-min distance]
              [-offset distance]
              [-step distance]
              [-valid_list distance_list]
              [-valid_ranges {{low high} {low1 high1} ... }]
              [-offset_ranges {{low high} {low1 high1} ... }]

   Data Types
       type_list       list
       lib_cells       collection
       direction_list  list
       rule_name       string
       layer_list      list
       width_list      list
       low             float
       high            float
       low1            float
       high1           float
       distance        float
       distance_list   float

ARGUMENTS
       -object_types type_list
              Specifies the list of object types for the width floorplan rule.
              The width of these type of objects is checked. Valid values  for
              this  option  are  block_boundary, core_area, hard_macro, place-
              ment_blockage,  routing_blockage,  shape,  soft_macro,  unplace-
              able_area,    boundary_cell_region,   io_pad,   cover_bump   and
              std_cell_area. This option is mutually exclusive with -lib_cells
              and you must specify one or the other.

       -lib_cells lib_cells
              Specifies  the  collection of library cells for the width floor-
              plan rule. The width of these library  cells  is  checked.  This
              option  is  mutually  exclusive  with -object_types and you must
              specify one or the other.

       -type concave | continuous | incorner | jog | simple
              Specifies the width type of the width check.  Valid  values  are
              concave,  continuous,  incorner,  jog,  and  simple.   This is a
              mandatory option.

              concave indicates the distance in horizontal or vertical  direc-
              tion  between  two  horizontal  or  vertical  edges whose paral-
              lel_run_length is 0.

              continuous indicates the  distance  in  horizontal  or  vertical
              direction  between  merged objects. The tool considers an object
              to be merged If the spacing of two objects is not large than the
              gap_size  and  the parallel_run_length value of these two object
              is larger than 0.

              incorner indicates the distance in horizontal or vertical direc-
              tion between two 270-degree corners.

              jog  indicates  the distance in horizontal or vertical direction
              between one 90-degree corner and one 270-degree corner.

              simple indicates the distance in horizontal or  vertical  direc-
              tion. For example, if the placeable sites are sliced into multi-
              ple rectangle shapes and let the shapes be as large as possible,
              the  height or width of these shapes represent the "simple" dis-
              tance.

       -direction direction_list
              Specifies the sides or directions in which width  of  object  or
              library  cells  needs to be checked. Valid values are any, hori-
              zontal and vertical. The horizontal argument includes both  left
              and right. Similarly, the vertical argument includes both bottom
              and top. This is a mandatory option.

       -name rule_name
              Specifies the name of the width floorplan rule. This is a manda-
              tory option.

       -except_project_lib_cells lib_cells
              Specifies  the  collection of library cells for the width floor-
              plan rule where the rule is not applied on the object if  speci-
              fied  lib  cells  project  on that object for a given projection
              distance. This is an optional option. This  option  is  mutually
              exclusive  with  -project_lib_cells  and you must specify one or
              the other.

       -project_extension distance
              Specifies the projection distance of lib  cells  specified  with
              -except_project_lib_cells on the object so that this rule is not
              applied for that object. The value specified cannot be negative.
              This      option      must     be     used     together     with
              -except_project_lib_cells. This is an optional option.

       -max_project_spacing distance
              Specifies the  maximum  spacing  of  lib  cells  specified  with
              -except_project_lib_cells  to  the object within which this rule
              is not applied for that object. The value  specified  cannot  be
              negative.    This    option   must   be   used   together   with
              -except_project_lib_cells. This is an optional option.

       -layers layer_list
              Specifies the routing layers to  be  considered  for  the  rout-
              ing_blockage  or  shape  object  type.  This option must be used
              together with -object_types  routing_blockage  or  -object_types
              shape. This is an optional option.

       -project_lib_cells lib_cells
              Specifies  the  collection of library cells for the width floor-
              plan rule where the rule is applied on the object  if  specified
              lib  cells  project  on  that object for a given projection dis-
              tance. This option must  be  used  together  with  -object_types
              std_cell_area  and -type simple.  This option is mutually exclu-
              sive with -except_project_lib_cells and you must specify one  or
              the other.

       -gap_size distance
              Specifies  the  gap between objects to be considered continuous.
              This option can be given only with -type continuous.

       -forbidden_list width_list
              Specifies a list of widths that are not allowed for  the  object
              or   library  cell.  This  option  is  mutually  exclusive  with
              -valid_list. Values specified cannot be  negative.  This  is  an
              optional option.

       -forbidden_ranges {{low high} {low1 high1} ... }
              Specifies  a  list  of width ranges that are not allowed for the
              object or library cell. The width must not lie within any of low
              and  high  in the specified list of ranges. This option is mutu-
              ally exclusive with -valid_ranges. Values  specified  cannot  be
              negative. This is an optional option.

       -max distance
              Specifies  the maximum width for the object or library cell. The
              width cannot be greater than this  value.  The  value  specified
              cannot  be  negative.  If -min is also specified then this value
              must be greater than the min value. This is an optional option.

       -min distance
              Specifies the minimum width of object or library cell. The width
              cannot  be  less  than this value. The value specified cannot be
              negative. If -max is also specified  then  this  value  must  be
              lesser than the max value. This is an optional option.

       -offset distance
              Specifies  a parameter in width calculation of object or library
              cell.  This option  must  be  used  together  with  -step.  This
              implies  that  the  width  has to be an integer multiple of step
              value plus offset value. This option is mutually exclusive  with
              -offset_ranges.  Value specified cannot be negative.  This is an
              optional option.

       -step distance
              Specifies a parameter in width calculation of object or  library
              cell.   This  option  must  be  used together with -offset. This
              implies that the width has to be an integral  multiple  of  step
              value  plus offset value or width has to be in range of an inte-
              gral multiple of step  value  plus  offset_ranges  value.  Value
              specified  must  be  greater  than  zero.   This  is an optional
              option.

       -valid_list distance_list
              Specifies a list of allowed widths for the width of  the  object
              or library cell. This option is mutually exclusive with -forbid-
              den_list. Values  specified  cannot  be  negative.  This  is  an
              optional option.

       -valid_ranges {{low high} {low1 high1} ... }
              Specifies  a  list  of  allowed  width  ranges for the object or
              library cell. The distance must lie within any of low  and  high
              in  the specified list of ranges. This option is mutually exclu-
              sive with -forbidden_ranges. Values specified  cannot  be  nega-
              tive. This is an optional option.

       -offset_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance ranges. This implies that the width
              has to be in range of an integral multiple of  step  value  plus
              offset_ranges  value.   Values specified can't be negative. This
              option must be used along  with  -step.   This  is  an  optional
              option.

DESCRIPTION
       The  set_floorplan_width_rules  command defines a named width floorplan
       rule in the current design. The defined rule is persistent. If  another
       floorplan rule by the same name exists then the command errors out.

       There   is   a   difference  between  the  object  type  core_area  and
       std_cell_area. The core_area object type  means  core  boundary  region
       without  cutting  out any blockages and is typically applicable for top
       level whereas std_cell_area object  type  means  core  boundary  region
       after  cutting  out all blockages and is typically applicable for block
       level.

       If a width rule is defined for a library cell and another width rule is
       defined  for  a  hard macro then the width rule defined for the library
       cell takes precedence over the width rule defined for hard  macro  when
       checks are done for that library cell.

       If  the  measured  value falls inside valid range or is a member of the
       valid list then there is no violation  given  by  check_floorplan_rules
       regardless  of  other  constraints like min, max, and so forth. If this
       measured value is outside valid range  or  list  then  a  violation  is
       reported  if other constraints are specified and they are not met or if
       no other constraints are specified.

EXAMPLES
       The following example creates a width rule named w1 to check  the  con-
       cave  width  of  block boundary and hard macro in horizontal direction,
       both left and right. The width must be at least 31 and can be  at  most
       153. Also the distance needs to follow integral multiples of 2 plus 34.

         prompt> set_floorplan_width_rules -name w1 \
            -object_types {block_boundary hard_macro} -type concave \
            -direction horizontal -max 153 -min 31 -offset 34 -step 2

SEE ALSO
       remove_floorplan_rules(2)
       report_floorplan_rules(2)
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
