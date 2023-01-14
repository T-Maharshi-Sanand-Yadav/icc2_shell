icc2_shell> man set_floorplan_area_rules
2.  Synopsys Commands                                        Command Reference
                           set_floorplan_area_rules

NAME
       set_floorplan_area_rules
              Defines an area floorplan rule.

SYNTAX
       set_floorplan_area_rules
              -object_types type_list
              -lib_cells lib_cells
              -name rule_name
              [-layers layer_list]
              [-forbidden_list area_list]
              [-forbidden_ranges {{low high} {low1 high1} ... }]
              [-max area]
              [-min area]
              [-valid_list area_list]
              [-valid_ranges {{low high} {low1 high1} ... }]

   Data Types
       type_list       list
       lib_cells       collection
       rule_name       string
       layer_list      collection
       area_list       list
       low             float
       high            float
       low1            float
       high1           float
       area            float

ARGUMENTS
       -object_types type_list
              Specifies  the list of object types for the area floorplan rule.
              The area of these type of objects will be checked. Valid  values
              for  this  option  are  block_boundary,  core_area,  hard_macro,
              placement_blockage,  routing_blockage,  shape,  soft_macro   and
              std_cell_area. This option is mutually exclusive with -lib_cells
              and you must specify one or the other.

       -lib_cells lib_cells
              Specifies the collection of library cells for the area floorplan
              rule.  The  area  of  these  library cells will be checked. This
              option is mutually exclusive with  -object_types  and  you  must
              specify one or the other.

       -name rule_name
              Specifies  the name of the area floorplan rule. This is a manda-
              tory option.

       -layers layer_list
              Specifies the routing layers to  be  considered  for  the  rout-
              ing_blockage  or  shape  object  type.  This option must be used
              together with -object_types  routing_blockage  or  -object_types
              shape. This is an optional option.

       -forbidden_list area_list
              Specifies a list of areas that are not allowed for the object or
              library  cell.  This   option   is   mutually   exclusive   with
              -valid_list.  Values  specified  cannot  be negative. This is an
              optional option.

       -forbidden_ranges {{low high} {low1 high1} ... }
              Specifies a list of area ranges that are  not  allowed  for  the
              object  or library cell. The area must not lie within any of low
              and high in the specified list of ranges. This option  is  mutu-
              ally  exclusive  with  -valid_ranges. Values specified cannot be
              negative. This is an optional option.

       -max area
              Specifies the maximum area for the object or library  cell.  The
              area cannot be greater than this value. The value specified can-
              not be negative. If -min is also specified then this value  must
              be greater than the min value. This is an optional option.

       -min area
              Specifies  the  minimum area of object or library cell. The area
              cannot be less than this value. The value  specified  cannot  be
              negative.  If  -max  is  also  specified then this value must be
              lesser than the max value. This is an optional option.

       -valid_list area_list
              Specifies a list of allowed areas for the area of the object  or
              library  cell.  This  option is mutually exclusive with -forbid-
              den_list. Values  specified  cannot  be  negative.  This  is  an
              optional option.

       -valid_ranges {{low high} {low1 high1} ... }
              Specifies  a  list  of  allowed  area  ranges  for the object or
              library cell. The area must lie within any of low  and  high  in
              the  specified list of ranges. This option is mutually exclusive
              with -forbidden_ranges. Values  specified  cannot  be  negative.
              This is an optional option.

DESCRIPTION
       The  set_floorplan_area_rules  command  defines  a named area floorplan
       rule in the current design. The defined rule is persistent. If  another
       floorplan rule by the same name exists then the command errors out.

       There   is   a   difference  between  the  object  type  core_area  and
       std_cell_area. The core_area object type  means  core  boundary  region
       without  cutting  out any blockages and is typically applicable for top
       level whereas std_cell_area object  type  means  core  boundary  region
       after  cutting  out all blockages and is typically applicable for block
       level.

       If an area rule is defined for a library cell and another area rule  is
       defined  for  a  hard  macro then the area rule defined for the library
       cell will take precedence over the area rule  defined  for  hard  macro
       when checks are done for that library cell.

       If  the  measured  value falls inside valid range or is a member of the
       valid list then there is no violation  given  by  check_floorplan_rules
       regardless  of  other  constraints like min, max, etc. If this measured
       value is outside valid range or list then a violation  is  reported  if
       other  constraints  are  specified  and they are not met or if no other
       constraints are specified.

EXAMPLES
       The following example creates an area rule named a1 to check  the  area
       of  block  boundary and hard macro. The area can't be greater than 2400
       and can't lie between 370 and 790.

         prompt> set_floorplan_area_rules -name a1 \
            -object_types {block_boundary hard_macro} -max 2400 \
            -forbidden_ranges {{370 790}}

SEE ALSO
       remove_floorplan_rules(2)
       report_floorplan_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
