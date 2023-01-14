icc2_shell> man set_floorplan_length_rules
2.  Synopsys Commands                                        Command Reference
                          set_floorplan_length_rules

NAME
       set_floorplan_length_rules
              Defines a length floorplan rule in the design.

SYNTAX
       set_floorplan_length_rules
              -from_object_types from_type_list
              -to_object_types to_type_list
              -from_lib_cells lib_cells
              -to_lib_cells lib_cells
              -type parallel_run | projection_difference
              -direction direction_list
              -name rule_name
              [-max_spacing distance]
              [-min_parallel_run_length distance]
              [-identical]
              [-mirror]
              [-asymmetric]
              [-from_layers layer_list]
              [-to_layers layer_list]
              [-max distance]
              [-min distance]

   Data Types
       from_type_list   list
       to_type_list     list
       lib_cells        collection
       direction_list   list
       rule_name        string
       distance         float
       layer_list       list

ARGUMENTS
       -from_object_types from_type_list
              Specifies  the list of "from" object types for the length floor-
              plan rule. Length  between  these  type  of  objects  and  other
              objects  specified with -to_object_types or library cells speci-
              fied with -to_lib_cells will be checked. Valid values  for  this
              option  are  hard_macro,  routing_blockage,  shape,  soft_macro,
              std_cell_area and boundary_cell_region. This option is  mutually
              exclusive  with  -from_lib_cells and you must specify one or the
              other.

       -to_object_types to_type_list
              Specifies the list of "to" object types for the length floorplan
              rule.  Length  between  these  type of objects and other objects
              specified with -from_object_types  or  library  cells  specified
              with  -from_lib_cells  will  be  checked.  Valid values for this
              option  are  hard_macro,  routing_blockage,  shape,  soft_macro,
              std_cell_area  and boundary_cell_region. This option is mutually
              exclusive with -to_lib_cells and you must  specify  one  or  the
              other.

       -from_lib_cells lib_cells
              Specifies  the collection of library cells for the length floor-
              plan rule. Length between these library cells and other  objects
              specified  with -to_object_types or library cells specified with
              -to_lib_cells will be checked. This option is mutually exclusive
              with -from_object_types and you must specify one or the other.

       -to_lib_cells lib_cells
              Specifies  the collection of library cells for the length floor-
              plan rule. Length between these library cells and other  objects
              specified  with  -from_object_types  or  library cells specified
              with -from_lib_cells will be checked. This  option  is  mutually
              exclusive  with -to_object_types and you must specify one or the
              other.

       -type parallel_run | projection_difference
              Specifies the length type of the length check. Valid values  are
              parallel_run  and  projection_difference.  This  is  a mandatory
              option.

       -direction direction_list
              Specifies the sides or directions in which length of  object  or
              library  cells  needs to be checked. Valid values are horizontal
              and vertical. The horizontal argument  includes  both  left  and
              right. Similarly, the vertical argument includes both bottom and
              top. This is a mandatory option.

       -name rule_name
              Specifies the name of the  length  floorplan  rule.  This  is  a
              mandatory option.

       -max_spacing distance
              Specifies  the  maximum  spacing between "from" and "to" objects
              for this rule to be applied. The specified value cannot be nega-
              tive. This is an optional option.

       -min_parallel_run_length distance
              Specifies  the  minimum  overlap  length between "from" and "to"
              objects for this rule to be applied. This is an optional option.

       -identical
              Specifies whether this rule applies to hard macros of same  ref-
              erence. This is an optional option.

       -mirror
              Specifies  whether  this rule applies when hard macros face each
              other mirrored.  This is an optional option.

       -asymmetric
              Specifies whether this rule applies asymmetric or not. If speci-
              fied,  need to measure the difference only from object specified
              in -from_object_types. This option must be used along with -type
              projection_difference. This is an optional option.

       -from_layers layer_list
              Specifies the routing layers to be considered for routing_block-
              age or shape object types. This option must be used  along  with
              -from_object_types routing_blockage or -from_object_types shape.
              This is an optional option.

       -to_layers layer_list
              Specifies the routing layers to be considered for routing_block-
              age  or  shape object types. This option must be used along with
              -to_object_types  routing_blockage  or  -to_object_types  shape.
              This is an optional option.

       -max distance
              Specifies the maximum value of length type between "from" object
              or "from" library cell and "to" object or "to" library cell. The
              distance  cannot be greater than this value. The specified value
              cannot be negative. If -min is also specified  then  this  value
              must be greater than the min value. This is an optional option.

       -min distance
              Specifies the minimum value of length type between "from" object
              or "from" library cell and "to" object or "to" library cell. The
              distance  cannot  be  less  than this value. The specified value
              cannot be negative. If -max is also specified  then  this  value
              must be lesser than the max value. This is an optional option.

DESCRIPTION
       The set_floorplan_length_rules command defines a named length floorplan
       rule in the current design. The defined rule is persistent. If  another
       floorplan rule by the same name exists then the command errors out.

       There   is   a   difference  between  the  object  type  core_area  and
       std_cell_area. The core_area object type  means  core  boundary  region
       without  cutting  out any blockages and is typically applicable for top
       level whereas std_cell_area object  type  means  core  boundary  region
       after  cutting  out all blockages and is typically applicable for block
       level.

       If a length rule is defined for a library cell and another length  rule
       is  defined  for  a  hard  macro  then  the length rule defined for the
       library cell will take precedence over the length rule defined for hard
       macro when checks are done for that library cell.

EXAMPLES
       The  following  example creates a length rule named le1 to check length
       between the standard cell area and  the  hard  macro  in  the  vertical
       direction, both top and bottom. The length must be at least 5.

         prompt> set_floorplan_length_rules -name le1 \
            -from_object_types std_cell_area -to_object_types hard_macro \
            -direction vertical -min 5

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
