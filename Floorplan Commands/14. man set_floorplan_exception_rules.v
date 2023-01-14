icc2_shell> man set_floorplan_exception_rules
2.  Synopsys Commands                                        Command Reference
                         set_floorplan_exception_rules

NAME
       set_floorplan_exception_rules
              Defines an exception floorplan rule in the design.

SYNTAX
       set_floorplan_exception_rules
              -rules rule_list
              -name rule_name
              [-from_object_types type_list]
              [-to_object_types type_list]
              [-object_types type_list]
              [-from_lib_cells lib_cells]
              [-to_lib_cells lib_cells]
              [-lib_cells lib_cells]
              [-identical]
              [-orientation_types orientation_list]
              [-reason reason]

   Data Types
       rule_list        list
       rule_name        string
       type_list        list
       lib_cells        collection
       orientation_list list
       reason           string

ARGUMENTS
       -rules rule_list
              Specifies  the  list of floorplan rules for which this exception
              rule needs to be applied. It is not required that  rules  speci-
              fied  in  this  list  has  to pre-exist in the design. This is a
              mandatory option.

       -name rule_name
              Specifies the name of the exception floorplan rule.  This  is  a
              mandatory option.

       -from_object_types type_list
              Specifies  the  list  of  "from"  object types for the exception
              floorplan rule. These type of objects in the "from"  objects  of
              specified  list  of  rules  will  be  exempted from those rule's
              checking. Valid  values  for  this  option  are  block_boundary,
              placement_blockage, routing_blockage, hard_macro, soft_macro and
              std_cell_area.  This   option   is   mutually   exclusive   with
              -object_types, -from_lib_cells and -lib_cells.

       -from_lib_cells lib_cells
              Specifies  the  collection of "from" lib cells for the exception
              floorplan rule. These lib cells in the "from" lib cells of spec-
              ified list of rules will be exempted from those rule's checking.
              This  option  is  mutually  exclusive  with  -from_object_types,
              -object_types, and -lib_cells.

       -to_object_types type_list
              Specifies the list of "to" object types for the exception floor-
              plan rule. These type of objects in the "to" objects  of  speci-
              fied  list of rules will be exempted from those rule's checking.
              Valid  values  for  this  option  are   block_boundary,   place-
              ment_blockage,   routing_blockage,  hard_macro,  soft_macro  and
              std_cell_area.  This   option   is   mutually   exclusive   with
              -object_types, -to_lib_cells and -lib_cells.

       -to_lib_cells lib_cells
              Specifies  the  collection  of  "to" lib cells for the exception
              floorplan rule. These lib cells in the "to" lib cells of  speci-
              fied  list of rules will be exempted from those rule's checking.
              This  option  is  mutually  exclusive   with   -to_object_types,
              -object_types, and -lib_cells.

       -object_types type_list
              Specifies the list of both object types for the exception floor-
              plan rule. These type of objects in  any  objects  of  specified
              list of rules will be exempted from those rule's checking. Valid
              values for this option are  block_boundary,  placement_blockage,
              routing_blockage, hard_macro, soft_macro and std_cell_area. This
              option   is   mutually   exclusive   with    -from_object_types,
              -to_object_types, -from_lib_cells, -to_lib_cells and -lib_cells.

       -lib_cells lib_cells
              Specifies  the  collection  of  both lib cells for the exception
              floorplan rule. These lib cells in any lib  cells  of  specified
              list  of rules will be exempted from those rule's checking. This
              option   is   mutually   exclusive   with    -from_object_types,
              -to_object_types,     -object_types,     -from_lib_cells     and
              -to_lib_cells.

       -identical
              Specifies whether this rule applies to hard macros of same  ref-
              erence.

       -orientation_types orientation_list
              Specifies the orientation of the two objects for the check to be
              enabled. Valid values are align, mirror and partial. align means
              both  the  objects should be of same orientation like R0, MX, MY
              or R180. partial means the orientation pair should be R0-R180 or
              MX-MY.  mirror  means the objects are mirrored in checked direc-
              tion.

       -reason reason
              Specifies the reason for this exception rule to be specified.

DESCRIPTION
       The set_floorplan_exception_rules command  defines  a  named  exception
       floorplan  rule  in the current design. The defined rule is persistent.
       If another floorplan rule by the same  name  exists  then  the  command
       errors out.

       The exception rule is to apply existing rules on a subset of objects or
       lib cells specified for those rules. If a spacing  rule  has  all  hard
       macro  and  soft  macro  and  if user would like to exclude certain lib
       cells from that list then an exception rule can be created.

EXAMPLES
       The following example creates an exception rule named  exc1  to  exempt
       checking  of "from" std_cell_area and "to" an21* lib cells in the spac-
       ing floorplan rule s1 and enclosure floorplan rule e2.

         prompt> set_floorplan_exception_rules -name exc1 -rules {s1 e2} \
            -from_object_types std_cell_area -to_lib_cells */an21* \
            -reason myReason

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
