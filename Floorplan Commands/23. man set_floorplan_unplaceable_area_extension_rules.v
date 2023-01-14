icc2_shell> man set_floorplan_unplaceable_area_extension_rules
2.  Synopsys Commands                                        Command Reference
                set_floorplan_unplaceable_area_extension_rules

NAME
       set_floorplan_unplaceable_area_extension_rules
              Defines an unplaceable area extension floorplan rule.

SYNTAX
       set_floorplan_unplaceable_area_extension_rules
              -object_types type_list
              -lib_cells lib_cells
              -sides side_list
              -value distance
              -name rule_name
              [-follow_rotations]

   Data Types
       type_list       list
       lib_cells       collection
       side_list       list
       distance        float
       rule_name       string

ARGUMENTS
       -object_types type_list
              Specifies  the  list  of  object  types for the unplaceable area
              extension floorplan rule. The area of these type of objects will
              be  checked.  Valid values for this option are std_cell_area and
              hard_macro. This option is mutually  exclusive  with  -lib_cells
              and you must specify one or the other.

       -lib_cells lib_cells
              Specifies  the  collection  of library cells for the unplaceable
              area extension floorplan rule. This option is mutually exclusive
              with -object_types and you must specify one or the other.

       -sides side_list
              Specifies  the sides or directions in which the target object in
              specified floorplan rules is to be extended.  Valid  values  are
              all, bottom, horizontal, left, right, top and vertical. The hor-
              izontal argument includes both left and  right.  Similarly,  the
              vertical argument includes both bottom and top. This is a manda-
              tory option.

       -value distance
              Specifies the extent by which the target  objects  of  specified
              floorplan rules will be extended for that particular rule check-
              ing. This is a mandatory option.

       -name rule_name
              Specifies the name of the unplaceable area  extension  floorplan
              rule. This is a mandatory option.

       -follow_rotations
              Specifies whether mentioned sides should follow the rotations of
              macro, that is, if meaning  of  horizontal  or  vertical  should
              change when macro has a 90-degree rotations. This option must be
              used together with -lib_cells or -object_types hard_macro.  This
              is an optional option.

DESCRIPTION
       The  set_floorplan_unplaceable_area_extension_rules  command  defines a
       named unplaceable area extension floorplan rule in the current  design.
       The  defined  rule is persistent. If another floorplan rule by the same
       name exists then the command errors out.

       If an unplaceable area extension rule is defined for a library cell and
       another  unplaceable  area  extension  rule is defined for a hard macro
       then the rule defined for the library cell will  take  precedence  over
       the  rule  defined for hard macro when checks are done for that library
       cell.

EXAMPLES
       The following example creates an unplaceable area extension rule  named
       a1  to  check the area of block boundary and hard macro. The area can't
       be greater than 2400 and can't lie between 370 and 790.

         prompt> set_floorplan_area_rules -name a1 \
            -object_types hard_macro -sides {top left} \
            -value 2000

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
