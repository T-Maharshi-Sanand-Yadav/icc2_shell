icc2_shell> man set_floorplan_composite_spacing_rules

2.  Synopsys Commands                                        Command Reference
                     set_floorplan_composite_spacing_rules

NAME
       set_floorplan_composite_spacing_rules
              Defines a composite spacing floorplan rule in the design.

SYNTAX
       status set_floorplan_composite_spacing_rules
              -from object_and_lib_cell_list
              -to object_and_lib_cell_list
              -extension_from_element index_direction_distance_value_list
              -extension_to_element index_direction_distance_value_list
              [-extension_from direction_distance_value_list]
              [-extension_to direction_distance_value_list]
              -directions direction_list
              [-min_parallel_run_length distance]
              [-max_parallel_run_length distance]
              -name rule_name
              [-forbidden_list distance_list]
              [-forbidden_ranges range]
              [-max distance]
              [-min distance]
              [-offset distance]
              [-step distance]
              [-valid_list distance_list]
              [-valid_ranges range]

   Data Types
       object_and_lib_cell_list                list
       index_direction_distance_value_list     list
       direction_distance_value_list           list
       direction_list                          list
       distance                                float
       rule_name                               string
       distance_list                           list
       range                                   float

ARGUMENTS
       -from object_and_lib_cell_list
              Specifies  the  list of "from" object types or lib_cells for the
              composite  spacing  floorplan  rule.  These  object   types   or
              lib_cells  can  be  merged. Spacing between these type and other
              objects or lib_cells specified with -to are checked after  merg-
              ing.  Valid  object  types values for this option are hard_macro
              and std_cell_area.  You must give 'lib_cell' keyword before men-
              tioning lib_cells name.

       -to object_and_lib_cell_list
              Specifies  the  list  of  "to" object types or lib_cells for the
              composite  spacing  floorplan  rule.  These  object   types   or
              lib_cells  can  be  merged. Spacing between these type and other
              objects / lib_cells specified with -from are checked after merg-
              ing.  Valid  object  types values for this option are hard_macro
              and std_cell_area.  You must give 'lib_cell' keyword before men-
              tioning lib_cells name.

       -extension_from_element index_direction_distance_value_list
              Specifies  the  list  of "element_extension" for example, "index
              direction distance" as one value  of  the  list.   Index  refers
              object  type or lib_cells specified in -from. Here direction and
              distance specify that in which direction and  by  what  distance
              object or lib_cells can be extended for merging.

       -extension_to_element index_direction_distance_value_list
              Specifies  the  list  of "element_extension" for example, "index
              direction distance" as one value  of  the  list.   Index  refers
              object  type  or  lib_cells specified in -to. Here direction and
              distance specify that in which direction and  by  what  distance
              object or lib_cells can be extended for merging.

       -extension_from direction_distance_value_list
              Specifies the list of "direction_extension" for example, "direc-
              tion distance" as one value of the  list.   Here  direction  and
              distance  specify  that  in which direction and by what distance
              merged object (specified in -from) can be extended.

       -extension_to direction_distance_value_list
              Specifies the list of "direction_extension" for example, "direc-
              tion  distance"  as  one  value of the list.  Here direction and
              distance specify that in which direction and  by  what  distance
              merged object (specified in -to) can be extended.

       -directions direction_list
              Specifies  the  sides  or  directions  in  which spacing between
              "from" object or from  library  cells  and  "to"  object  or  to
              library  cells  needs to be checked. Valid values are any, hori-
              zontal, vertical, left, right, bottom, top, nearest_corners  and
              corner.  The  horizontal  argument includes both left and right.
              Similarly, the vertical argument includes both bottom  and  top.
              This is a mandatory option.

       -min_parallel_run_length distance
              Specifies  the  minimum overlap length of two "to" objects or to
              library cells kept side-by-side. This  is  an  optional  option.
              This option is mutually exclusive with -directions corner.

       -max_parallel_run_length distance
              Specifies  the  maximum overlap length of two "to" objects or to
              library cells kept side-by-side. This  is  an  optional  option.
              This option is mutually exclusive with -directions corner.

       -name rule_name
              Specifies  the  name  of  the  spacing floorplan rule. This is a
              mandatory option.

       -forbidden_list distance_list
              Specifies a list of  distances  that  are  not  allowed  between
              "from"  objects  or  "from" library cell and "to" object or "to"
              library  cell.  This   option   is   mutually   exclusive   with
              -valid_list.  Values  specified  cannot  be negative. This is an
              optional option.

       -forbidden_ranges range
              Specifies a list of distance ranges that are not allowed between
              "from"  objects  or  "from"  library  cell and "to" object or to
              library  cell.   The  format  for  range  is  {{low1  high1}  {2
              high2}...}.   The distance must not lie within low and high that
              are specified in the list of ranges.  This  option  is  mutually
              exclusive  with  -valid_ranges. Values specified cannot be nega-
              tive. This is an optional option.

       -max distance
              Specifies the maximum distance between "from" object  or  "from"
              library  cell and "to" object or "to" library cell. The distance
              cannot be greater than this value. The specified value cannot be
              negative.  If  -min  is  also  specified then this value must be
              greater than the specified minimum value. This  is  an  optional
              option.

       -min distance
              Specifies  the  minimum distance between "from" object or "from"
              library cell and "to" object or "to" library cell. The  distance
              cannot  be  less  than this value. The specified value cannot be
              negative. If -max is also specified  then  this  value  must  be
              lesser  than  the  specified  maximum value. This is an optional
              option.

       -offset distance
              Specifies a parameter in distance calculation between "from" and
              "to" objects. This option must be used together with -step. This
              implies that the distance has to be an integer multiple of  dis-
              tance specified in -step option plus distance specified in -off-
              set option.  Value specified cannot  be  negative.  This  is  an
              optional option.

       -step distance
              Specifies a parameter in distance calculation between "from" and
              "to" objects. This option must be used  together  with  -offset.
              This  implies that the distance has to be an integer multiple of
              distance specified in -step option plus  distance  specified  in
              -offset option.  Value specified must be greater than zero. This
              is an optional option.

       -valid_list distance_list
              Specifies a list  of  legal  separation  distances  between  the
              "from"  object  or  "from"  library cell and "to" object or "to"
              library cell. This option is mutually  exclusive  with  -forbid-
              den_list.  Values  specified  cannot  be  negative.  This  is an
              optional option.

       -valid_ranges range
              Specifies a list of distance  ranges  between  with  the  "from"
              object  or  "from"  library cell and "to" object or "to" library
              cell must be separated. The format for range is {{low1 high1} {2
              high2}...}.   The  distance  must lie within any of low and high
              that are specified in the list of ranges. This option  is  mutu-
              ally  exclusive  with -forbidden_ranges. Values specified cannot
              be negative. This is an optional option.

DESCRIPTION
       The set_floorplan_composite_spacing_rules command defines a named  com-
       posite  spacing  floorplan rule in the current design. The defined rule
       is persistent. If another floorplan rule by the same name  exists  then
       the command errors out.

       If  the  measured  value falls inside valid range or is a member of the
       valid list then there is no violation  given  by  check_floorplan_rules
       regardless  of other constraints like min, max, and so on. If this mea-
       sured value is  outside  valid  range  or  list  then  a  violation  is
       reported, if other constraints are specified and they are not met or if
       no other constraints are specified.

EXAMPLES
       The following example creates a composite spacing  rule  named  cs1  to
       check  spacing  between  the  merged  cell  from standard cell area and
       lib_cells M1, M2 with merged cell from standard cell area,  hard  macro
       and  lib_cell  xyz.   standard  cell  area  specified  in  -from can be
       extended in bottom by  value  1.1  and  in  horizontal  by  0.23  while
       lib_cell abc can be extended to left by 0.43 for merging.

       standard cell area specified in -to can be extended to top direction by
       2.1, hard macro can be extended to right by 0.9 and lib_cell xyz can be
       extended to top by 0.88 for merging.

         prompt> set_floorplan_composite_spacing_rules -name cs1 \
         -from {std_cell_area {lib_cell M1 M2}} \
             -to {std_cell_area hard_macro {lib_cell xyz}} \
             -extension_from_element {{0 bottom 1.1} {0 horizontal 0.23} {1 left 0.43}} \
             -extension_to_element {{0 top 2.1} {1 right 0.9} {2 top 0.88}} \
             -max_parallel_run_length -6 -directions vertical

SEE ALSO
       set_floorplan_spacing_rules(2)
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
