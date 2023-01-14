icc2_shell> man set_floorplan_reshape_rules

2.  Synopsys Commands                                        Command Reference
                          set_floorplan_reshape_rules

NAME
       set_floorplan_reshape_rules
              Defines a reshape floorplan rule in the design.

SYNTAX
       status set_floorplan_reshape_rules
              -object_types type_list
              -ignore_lib_cells lib_cells
              -name rule_name

   Data Types
       type_list       list
       lib_cells       collection
       rule_name       string

ARGUMENTS
       -object_types type_list
              Specifies  the  list  of  object types for the reshape floorplan
              rule.  Valid values for this option are boundary_cell_region and
              std_cell_area.

       -ignore_lib_cells lib_cells
              Specifies the collection of library cells for the reshape floor-
              plan rule.

       -name rule_name
              Specifies the name of the reshape floorplan rule. This is manda-
              tory.

DESCRIPTION
       This  command  defines  a  named  reshape floorplan rule in the current
       design.  The defined rule is persistent.  If another floorplan rule  by
       the  same  name  exists then the command errors out.  Reshape rule con-
       nects objects underneath macro to make sure macros  are  enclosed  with
       reshape object.

EXAMPLES
       The following example creates a reshape rule named reshape1.

         prompt> set_floorplan_reshape_rules -name reshape1 \
            -object_types std_cell_area \
            -ignore_lib_cells [get_lib_cells */adio*]

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
