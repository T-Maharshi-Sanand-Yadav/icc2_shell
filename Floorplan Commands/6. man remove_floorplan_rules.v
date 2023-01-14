icc2_shell> man remove_floorplan_rules
2.  Synopsys Commands                                        Command Reference
                            remove_floorplan_rules

NAME
       remove_floorplan_rules
              Removes the floorplan rules in the design.

SYNTAX
       status remove_floorplan_rules
              [-object_types type_list]
              [-lib_cells lib_cells]
              [-all]
              [rule_list]

   Data Types
       type_list  list
       lib_cells  collection
       rule_list  list

ARGUMENTS
       -object_types type_list
              Specifies  the  list  of  object  types for which some floorplan
              rules are defined. Floorplan rules that  have  specified  object
              types   in   their  -from_object_types  or  -to_object_types  or
              -object_types will be removed. Valid values for this option  are
              block_boundary, core_area, hard_macro, placement_blockage, rout-
              ing_blockage, shape, soft_macro and std_cell_area.  This  option
              is mutually exclusive with the -all and rule_list options.

       -lib_cells lib_cells
              Specifies  the collection of library cells for which some floor-
              plan rules are defined.  Floorplan  rules  that  have  specified
              library  cells  in  their  -from_lib_cells  or  -to_lib_cells or
              -lib_cells will be removed. This option  is  mutually  exclusive
              with the -all and rule_list options.

       -all   Removes  all  floorplan rules defined in the design. This option
              is mutually exclusive with  the  -object_types,  -lib_cells  and
              rule_list options.

       rule_list
              Specifies  the  list  of  floorplan  rule  names to remove. This
              option is mutually exclusive with the -object_types,  -lib_cells
              and -all options.

DESCRIPTION
       The  remove_floorplan_rules command removes existing floorplan rules in
       a design based on specified input parameters.  On  successful  removal,
       the command returns a status of 1.

       The  rule_list  option  is  mutually  exclusive with the -object_types,
       -lib_cells and -all options. If any named rule in  rule_list  does  not
       exist  or no rule exists for the given object types or library cells, a
       warning is issued.

EXAMPLES
       The following example tries to remove two floorplan rules named e2  and
       ab. The floorplan rule ab does not exist.

         prompt> remove_floorplan_rules {e2 ab}

         Warning: Floorplan rule 'ab' does not exist.
         0
         prompt> report_floorplan_rules e2
         Warning: Floorplan rule 'e2' does not exist.
         0

       The  following  example tries to remove floorplan rules for object type
       std_cell_area and library cell lc4. Since no floorplan rule exists  for
       library  cell  lc4,  the  command  issues a warning message and removes
       floorplan rule e2 for object type std_cell_area.

         prompt> remove_floorplan_rules -object_types std_cell_area -lib_cells \
            [get_lib_cells */lc4]

         Warning: No floorplan rules exists for given lib cells.
         1
         prompt> report_floorplan_rules e2
         Warning: Floorplan rule 'e2' does not exist.
         0

SEE ALSO
       report_floorplan_rules(2)
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
