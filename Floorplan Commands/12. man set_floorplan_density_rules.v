icc2_shell> man set_floorplan_density_rules
2.  Synopsys Commands                                        Command Reference
                          set_floorplan_density_rules

NAME
       set_floorplan_density_rules
              Defines a floorplan density rule.

SYNTAX
       set_floorplan_density_rules
              -from_object_types from_type_list
              -to_object_types to_type_list
              -to_lib_cells lib_cells
              -name rule_name
              [-from_layers layer_list]
              [-to_layers layer_list]
              -numerator count_method_type
              -cut_method cut_method_type
              -density_method density_method_type
              [-window_size {width length}]
              [-window_step {x_step y_step}]
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
       from_type_list        list
       to_type_list          list
       lib_cells             collection
       rule_name             string
       layer_list            list
       distance_list         list
       count_method_type     string
       cut_method_type       string
       density_method_type   string
       width                 float
       length                float
       x_step                float
       y_step                float
       low                   float
       high                  float
       low1                  float
       high1                 float
       distance        float

ARGUMENTS
       -from_object_types from_type_list
              Specifies the list of "from" object types for the density floor-
              plan rule. These type of objects will enclose the  object  types
              specified  with -to_object_types or library cells specified with
              -to_lib_cells. Valid values for this option are  block_boundary,
              routing_blockage,  shape,  unplaceable_area  and  std_cell_area.
              This is a mandatory option.

       -to_object_types to_type_list
              Specifies the list of "to" object types for the  density  floor-
              plan  rule.  These  type  of  objects  will be enclosed by other
              objects specified with -from_object_types. Valid values for this
              option are cover_bump, hard_macro, io_pad, shape, soft_macro and
              tsv. This option is mutually exclusive  with  -to_lib_cells  and
              you must specify one or the other.

       -to_lib_cells lib_cells
              Specifies the collection of library cells for the density floor-
              plan rule. These library  cells  are  being  enclosed  by  other
              objects specified in -from_object_types. This option is mutually
              exclusive with -to_object_types and either one of them  must  be
              specified.

       -name rule_name
              Specifies  the  name  of  the  density floorplan rule. This is a
              mandatory option.

       -from_layers layer_list
              Specifies the routing layers to be considered for  "from"  rout-
              ing_blockage  or  shape  object  type.  This option must be used
              along    with     -from_object_types     routing_blockage     or
              -from_object_types shape. This is an optional option.

       -to_layers layer_list
              Specifies  the  routing  layers  to be considered for "to" rout-
              ing_blockage or shape object type.  This  option  must  be  used
              along with -to_object_types routing_blockage or -to_object_types
              shape. This is an optional option.

       -numerator count_method_type
              Specifies counting calculation method for  density  calculation.
              It can either 'area' or 'count' of "to_object_types".  This is a
              mandatory option.

       -cut_method cut_method_type
              Specifies cut method which is  used  to  specify  how  to  treat
              "to_object_types"  when  it  is  partial  /  overlap  or  inside
              "from_object_types".  Value 'keep' indicates if "to_object_type"
              touches "from_object_type" then complete "to_object_type" should
              be   taken   into   account,   value   'drop'   indicates   that
              "to_object_type"  should  not  be  count if it is not completely
              inside "from_object_type" and window, value  'proportion'  indi-
              cates  that  only  count the portion of "to_object_type" overlap
              with "from_object_type".  This is a mandatory option.

       -density_method density_method_type
              Specifies density method which is used  to  specify  portion  on
              which density should be calculated.  This is a mandatory option.

       -window_size {width length}
              Specifies  size  of  the window for which density will be calcu-
              lated. This option must be used with -density_method  local_win-
              dow and -window_step.
               This is an optional option.

       -window_step {x_step y_step}
              Specifies step by which window can be moved. This option must be
              used with -density_method local_window and -window_size. This is
              an optional option.

       -forbidden_list distance_list
              Specifies  a list of distances by which the "from" object cannot
              enclose the "to" object. This option is mutually exclusive  with
              -valid_list.  Values  in  the  distance_list cannot be negative.
              This is an optional option.

       -forbidden_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance ranges  between  which  the  "from"
              object  cannot  enclose  the "to" object. The enclosing distance
              must not lie within any of low and high in the specified list of
              ranges.  This  option  is mutually exclusive with -valid_ranges.
              Values cannot be negative. This is an optional option.

       -max distance
              Specifies the maximum distance by which the  "from"  object  can
              enclose  the  "to"  object.  The distance cannot be greater than
              this value. The distance cannot be negative.  If  -min  is  also
              specified,  this  value must be greater than the min value. This
              is an optional option.

       -min distance
              Specifies the minimum distance by which the  "from"  object  can
              enclose  the  "to" object. The distance cannot be less than this
              value. The value specified cannot be negative. If -max  is  also
              specified  then this value must be less than the max value. This
              is an optional option.

       -offset distance
              Specifies a parameter in distance calculation between the "from"
              and  "to" objects. This option must be used together with -step.
              This implies that the distance has to be an integer multiple  of
              the -step value plus the -offset value. The value specified can-
              not be negative.  This option is mutually exclusive  with  -off-
              set_ranges. This is an optional option.

       -step distance
              Specifies a parameter in distance calculation between the "from"
              and "to" objects. This option must be used together with -offset
              or  -offset_ranges.  This implies that the distance has to be an
              integer multiple of the -step value plus the  -offset  value  or
              distance  has to be in range of an integer multiple of the -step
              value plus the -offset_ranges value. The value specified  cannot
              be negative. This is an optional option.

       -valid_list distance_list
              Specifies  a  list  of  distances by which the "from" object can
              enclose the "to" object. This option is mutually exclusive  with
              -forbidden_list. Values specified cannot be negative. This is an
              optional option.

       -valid_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance ranges  between  which  the  "from"
              object can enclose the "to" object. The distance must lie within
              any of low and high in the specified list of ranges. This option
              is  mutually  exclusive with -forbidden_ranges. Values specified
              cannot be negative. This is an optional option.

       -offset_ranges {{low high} {low1 high1} ... }
              Specifies a list of distance ranges. This implies that the  dis-
              tance  has  to be in range of an integral multiple of step value
              plus offset_ranges value.  Values specified can't  be  negative.
              This  option must be used along with -step.  This is an optional
              option.

DESCRIPTION
       The set_floorplan_density_rules command defines a named density  floor-
       plan  rule  in  the  current design. The defined rule is persistent. If
       another floorplan rule by the same name exists then the command  errors
       out.

       If  the  measured  value falls inside valid range or is a member of the
       valid list then there is no violation  given  by  check_floorplan_rules
       regardless  of  other  constraints like min, max, etc. If this measured
       value is outside valid range or list then a violation  is  reported  if
       other  constraints  are  specified  and they are not met or if no other
       constraints are specified.

       All the values specified as float are supported upto 4 decimal points.

EXAMPLES
       The following example creates an density  rule  named  ds1.  This  rule
       checks  the  density  based on amount of io_pad. If shape is completely
       inside io_pad then it will not be counted. It checkes density in a win-
       dow  of width 1 and length 2 which can be step to 3 units on x-axis and
       4 units on y-axis.

         prompt> set_floorplan_density_rules -name ds1 \
            -from_object_types shape \
            -to_object_types io_pad -numerator amount -cut_method drop \
             -density_method local_window -window_size {1 2} -window_step {3 4} \
            -offset 10 -step 2

SEE ALSO
       remove_floorplan_rules(2)
       report_floorplan_rules(2)
       set_floorplan_area_rules(2)
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
