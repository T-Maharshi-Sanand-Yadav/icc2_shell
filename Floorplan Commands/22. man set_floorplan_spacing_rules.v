icc2_shell> man set_floorplan_spacing_rules
2.  Synopsys Commands                                        Command Reference
                          set_floorplan_spacing_rules

NAME
       set_floorplan_spacing_rules
              Defines a spacing floorplan rule in the design.

SYNTAX
       set_floorplan_spacing_rules
              -from_object_types from_type_list
              -to_object_types to_type_list
              -from_lib_cells lib_cells
              -to_lib_cells lib_cells
              -directions direction_list
              [-orientation_types orientation_list]
              -name rule_name
              [-shielding_object_types type_list]
              [-shielding_lib_cells lib_cells]
              [-between_lib_cells lib_cells]
              [-min_parallel_run_length distance]
              [-max_parallel_run_length distance]
              [-follow_rotations]
              [-ignore_rotate90]
              [-no_overlap]
              [-no_overlap_policy no_overlap_policy_type]
              [-identical]
              [-mirror]
              [-from_layers from_layer_list]
              [-to_layers to_layer_list]
              [-check_same_object]
              [-check_same_object_policy check_same_object_policy_type]
              [-forbidden_list distance_list]
              [-forbidden_ranges {{low high} {low1 high1} ... }]
              [-max distance]
              [-min distance]
              [-offset distance]
              [-step distance]
              [-valid_list distance_list]
              [-valid_ranges {{low high} {low1 high1} ... }]
              [-offset_ranges {{low high} {low1 high1} ... }]

   Data Types
       from_type_list                  list
       to_type_list                    list
       lib_cells                       collection
       orientation_list                list
       type_list                       list
       direction_list                  list
       no_overlap_policy_type          string
       check_same_object_policy_type   string
       rule_name                       string
       distance                        float
       from_layer_list                 list
       to_layer_list                   list
       distance_list                   list
       low                             float
       high                            float
       low1                            float
       high1                           float

ARGUMENTS
       -from_object_types from_type_list
              Specifies the list of "from" object types for the spacing floor-
              plan rule. Spacing between  these  type  of  objects  and  other
              objects  specified with -to_object_types or library cells speci-
              fied with -to_lib_cells is checked. Valid values for this option
              are   block_boundary,   hard_macro,   placement_blockage,  rout-
              ing_blockage,  shape,   soft_macro,   unplaceable_area,   bound-
              ary_cell_region,  std_cell_area,  io_pad  and  cover_bump.  This
              option is mutually exclusive with -from_lib_cells and  you  must
              specify one or the other.

       -to_object_types to_type_list
              Specifies  the  list of "to" object types for the spacing floor-
              plan rule. Spacing between  these  type  of  objects  and  other
              objects specified with -from_object_types or library cells spec-
              ified with -from_lib_cells is checked.  Valid  values  for  this
              option are block_boundary, hard_macro, placement_blockage, rout-
              ing_blockage,  shape,   soft_macro,   unplaceable_area,   bound-
              ary_cell_region,  std_cell_area,  io_pad  and  cover_bump.  This
              option is mutually exclusive with  -to_lib_cells  and  you  must
              specify one or the other.

       -from_lib_cells lib_cells
              Specifies the collection of library cells for the spacing floor-
              plan rule. Spacing between these library cells and other objects
              specified  with -to_object_types or library cells specified with
              -to_lib_cells is checked. This option is mutually exclusive with
              -from_object_types and you must specify one or the other.

       -to_lib_cells lib_cells
              Specifies the collection of library cells for the spacing floor-
              plan rule. Spacing between these library cells and other objects
              specified  with  -from_object_types  or  library cells specified
              with -from_lib_cells is checked. This option is mutually  exclu-
              sive  with  -to_object_types  and  you  must  specify one or the
              other.

       -shielding_object_types type_list
              Specifies the collection of object types for the halo  floorplan
              rule  as  shielding objects so that the rule is not applied when
              these object  types  form  a  shield  between  "from"  and  "to"
              objects.  Valid  values  for  this  option  are  hard_macro  and
              std_cell_area. This is an optional option.

       -shielding_lib_cells lib_cells
              Specifies the collection of library cells for the spacing floor-
              plan  rule  as shielding objects so that the rule is not applied
              when these lib cells form  a  shield  between  "from"  and  "to"
              objects.

       -between_lib_cells lib_cells
              Specifies the collection of library cells for the spacing floor-
              plan rule to check when this collection of cells is between  the
              specified  "from" and "to" objects.

       -directions direction_list
              Specifies  the  sides  or  directions  in  which spacing between
              "from" object or from  library  cells  and  "to"  object  or  to
              library  cells  needs to be checked. Valid values are any, hori-
              zontal, vertical, left, right, bottom, top and  nearest_corners.
              The horizontal argument includes both left and right. Similarly,
              the vertical argument includes both bottom and top.  This  is  a
              mandatory option.

       -orientation_types orientation_list
              Specifies the orientation of the two objects for the check to be
              enabled. Valid values are align, mirror and partial. align means
              both  the  objects should be of same orientation like R0, MX, MY
              or R180. partial means the orientation pair should be R0-R180 or
              MX-MY.  mirror  means the objects are mirrored in checked direc-
              tion.

       -name rule_name
              Specifies the name of the spacing  floorplan  rule.  This  is  a
              mandatory option.

       -min_parallel_run_length distance
              Specifies  the  minimum overlap length of two "to" objects or to
              library cells kept side-by-side. This is an optional option.

       -max_parallel_run_length distance
              Specifies the maximum overlap length of two "to" objects  or  to
              library cells kept side-by-side. This is an optional option.

       -follow_rotations
              Specifies whether mentioned sides should follow the rotations of
              library cells, that is, if meaning  of  horizontal  or  vertical
              should  change when library cell has a 90-degree rotations. This
              option   must   be   used   together   with   -to_lib_cells   or
              -from_lib_cells     or     -to_object_types     hard_macro    or
              -to_object_types soft_macro or -from_object_types hard_macro  or
              -from_object_types soft_macro. This is an optional option.

       -ignore_rotate90
              Specifies  whether  this  rule  can be ignored for library cells
              with a 90-degree rotation. This option  must  be  used  together
              with   -to_lib_cells   or  -from_lib_cells  or  -to_object_types
              hard_macro or -to_object_types soft_macro or  -from_object_types
              hard_macro or -from_object_types soft_macro. This is an optional
              option.

       -no_overlap
              Specifies whether the shapes can overlap. By default the  shapes
              can  overlap.  This is an optional option and mutually exclusive
              with -no_overlap_policy.

       -no_overlap_policy no_overlap_policy_type
              Specifies whether the shapes can  overlap  or  not  or  internal
              shapes  need to be excluded. By default, the shapes can overlap.
              This is an optional option and mutually exclusive with -no_over-
              lap.

       -identical
              Specifies  whether this rule applies to hard macros of same ref-
              erence. This is an optional option.

       -mirror
              Specifies whether this rule applies when hard macros  face  each
              other mirrored.  This is an optional option.

       -from_layers from_layer_list
              Specifies    the   routing   layers   to   be   considered   for
              -from_object_types routing_blockage or -from_object_types shape.
              This  option  must  be  used along with -from_object_types rout-
              ing_blockage or -from_object_types shape. This  is  an  optional
              option.

       -to_layers to_layer_list
              Specifies    the   routing   layers   to   be   considered   for
              -to_object_types  routing_blockage   or  -to_object_types  shape
              object   types.   This   option   must   be   used   along  with
              -to_object_types  routing_blockage  or  -to_object_types  shape.
              This is an optional option.

       -check_same_object
              Specifies  whether this rule checks the spacing between edges of
              same  objects.   This   option   must   be   used   along   with
              -from_object_types  std_cell_area  or  boundary_cell_region  and
              -to_object_types std_cell_area or boundary_cell_region.  This is
              an    optional    option    and    mutually    exclusive    with
              -check_same_object_policy.

       -check_same_object_policy check_same_object_policy_type
              Specifies whether this rule will check  the  inside  or  outside
              spacing between edges of same objects.  This option must be used
              along   with   -from_object_types   std_cell_area   or    bound-
              ary_cell_region  and  -to_object_types  std_cell_area  or bound-
              ary_cell_region.  This is an optional option and mutually exclu-
              sive with -check_same_object.

       -forbidden_list distance_list
              Specifies  a  list  of  distances  that  are not allowed between
              "from" objects or "from" library cell and "to"  object  or  "to"
              library   cell.   This   option   is   mutually  exclusive  with
              -valid_list. Values specified cannot be  negative.  This  is  an
              optional option.

       -forbidden_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance ranges that are not allowed between
              "from" objects or "from" library cell  and  "to"  object  or  to
              library  cell.  The  distance must not lie within any of low and
              high in the specified list of ranges. This  option  is  mutually
              exclusive  with  -valid_ranges. Values specified cannot be nega-
              tive. This is an optional option.

       -max distance
              Specifies the maximum distance between "from" object  or  "from"
              library  cell and "to" object or "to" library cell. The distance
              cannot be greater than this value. The specified value cannot be
              negative.  If  -min  is  also  specified then this value must be
              greater than the min value. This is an optional option.

       -min distance
              Specifies the minimum distance between "from" object  or  "from"
              library  cell and "to" object or "to" library cell. The distance
              cannot be less than this value. The specified  value  cannot  be
              negative.  If  -max  is  also  specified then this value must be
              lesser than the max value. This is an optional option.

       -offset distance
              Specifies a parameter in distance calculation between "from" and
              "to" objects. This option must be used together with -step. This
              implies that the distance has to be an integer multiple of  step
              value  plus offset value. This option is mutually exclusive with
              -offset_ranges. Value specified cannot be negative.

       -step distance
              Specifies a parameter in distance calculation between "from" and
              "to"  objects.  This  option must be used together with -offset.
              This implies that the distance has to be an integral multiple of
              step  value  plus offset value or distance has to be in range of
              an integral multiple of step  value  plus  offset_ranges  value.
              Value  specified must be greater than zero.  This is an optional
              option.

       -valid_list distance_list
              Specifies a list  of  legal  separation  distances  between  the
              "from"  object  or  "from"  library cell and "to" object or "to"
              library cell. This option is mutually  exclusive  with  -forbid-
              den_list.  Values  specified  cannot  be  negative.  This  is an
              optional option.

       -valid_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance  ranges  between  with  the  "from"
              object  or  "from"  library cell and "to" object or "to" library
              cell must be separated. The distance must lie within any of  low
              and  high  in the specified list of ranges. This option is mutu-
              ally exclusive with -forbidden_ranges. Values  specified  cannot
              be negative. This is an optional option.

       -offset_ranges {{low high} {low1 high1} ... }
              Specifies  a list of distance ranges. This implies that the dis-
              tance has to be in range of an integral multiple of  step  value
              plus  offset_ranges  value.  Values specified can't be negative.
              This option must be used along with -step.  This is an  optional
              option.

DESCRIPTION
       The  set_floorplan_spacing_rules command defines a named spacing floor-
       plan rule in the current design. The defined  rule  is  persistent.  If
       another  floorplan rule by the same name exists then the command errors
       out.

       There  is  a  difference  between  the  object   type   core_area   and
       std_cell_area.  The  core_area  object  type means core boundary region
       without cutting out any blockages and is typically applicable  for  top
       level  whereas  std_cell_area  object  type  means core boundary region
       after cutting out all blockages and is typically applicable  for  block
       level.

       If  a  spacing  rule  is defined for a library cell and another spacing
       rule is defined for a hard macro then the spacing rule defined for  the
       library  cell  takes  precedence over the spacing rule defined for hard
       macro when checks are done for that library cell.

       If the measured value falls inside valid range or is a  member  of  the
       valid  list  then  there is no violation given by check_floorplan_rules
       regardless of other constraints like min, max, and so on. If this  mea-
       sured value is outside valid range or list then a violation is reported
       if other constraints are specified and they are not met or if no  other
       constraints are specified.

EXAMPLES
       The  following example creates a spacing rule named s1 to check spacing
       between the standard cell area and the block boundary in  the  vertical
       direction, both top and bottom. The spacing must be at least 5.

         prompt> set_floorplan_spacing_rules -name s1 \
            -from_object_types std_cell_area -to_object_types block_boundary \
            -directions vertical -min 5

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_width_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
