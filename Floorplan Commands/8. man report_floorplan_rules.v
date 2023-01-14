icc2_shell> man report_floorplan_rules
2.  Synopsys Commands                                        Command Reference
                            report_floorplan_rules

NAME
       report_floorplan_rules
              Reports the floorplan rules in the design.

SYNTAX
       status report_floorplan_rules
              [-object_types type_list]
              [-lib_cells lib_cells]
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
              -object_types will be reported. Valid values for this option are
              block_boundary, core_area, hard_macro, placement_blockage, rout-
              ing_blockage, shape, soft_macro and std_cell_area.  This  option
              is mutually exclusive with rule_list.

       -lib_cells lib_cells
              Specifies  the collection of library cells for which some floor-
              plan rules are defined.  Floorplan  rules  that  have  specified
              library  cells  in  their  -from_lib_cells  or  -to_lib_cells or
              -lib_cells options are reported. This option is mutually  exclu-
              sive with the rule_list option.

       rule_list
              Specifies  the  list  of  floorplan  rule  names to report. This
              option  is  mutually  exclusive  with  the   -object_types   and
              -lib_cells options.

DESCRIPTION
       The  report_floorplan_rules  command  generates  a  report  of existing
       floorplan rules in a design based on specified input parameters. For  a
       matching  floorplan rule, the command reports all applicable parameters
       of that rule in a tabular format. It will not report  those  parameters
       that are not applicable for that rule. On successful reporting the com-
       mand returns a status of 1.

       The  rule_list  option  is  mutually  exclusive  with   other   options
       -object_types  and  -lib_cells.  If  a named rule in rule_list does not
       exist or no rule exists for  the  specified  object  types  or  library
       cells, the tool issues a warning message.

EXAMPLES
       The  following example tries to report two floorplan rules named e2 and
       ab out of which ab does not exist.

         prompt> report_floorplan_rules {e2 ab}

         Warning: Floorplan rule 'ab' does not exist.
         ****************************************
         Report : report_floorplan_rules
         Design : ABCD
         Version: M-2016.12-SP2-BETA
         Date   : Thu Jan 12 12:29:56 2017
         ****************************************

         ---------------------------------------------------------------
         Name                Type      Parameters          Value
         ---------------------------------------------------------------
         e2                  enclosure Max Value           214748
                                       Min Value           0
                                       Offset              0
                                       Step                0
                                       Valid Range         3 - 20
                                       Forbidden List      4, 6, 8
                                       From Object Types   std_cell_area
                                       To Lib Cells        lc1, lc2, lc3
                                       Must Enclose        true
                                       Sides               vertical

         1

       The  following  example  tries  to  report  floorplan  rules  for   the
       std_cell_area object type and library cell lc4. Since no floorplan rule
       exists for library cell lc4, the tool  issues  a  warning  message  and
       prints floorplan rule for object type std_cell_area.

         prompt> report_floorplan_rules -object_types std_cell_area -lib_cells \
            [get_lib_cells */lc4]

         Warning: No floorplan rules exists for given lib cells.
         ****************************************
         Report : report_floorplan_rules
         Design : ABCD
         Version: M-2016.12-SP2-BETA
         Date   : Thu Jan 12 12:29:56 2017
         ****************************************

         ---------------------------------------------------------------
         Name                Type      Parameters          Value
         ---------------------------------------------------------------
         e2                  enclosure Max Value           214748
                                       Min Value           0
                                       Offset              0
                                       Step                0
                                       Valid Range         3 - 20
                                       Forbidden List      4, 6, 8
                                       From Object Types   std_cell_area
                                       To Lib Cells        lc1, lc2, lc3
                                       Must Enclose        true
                                       Sides               vertical

         1

SEE ALSO
       remove_floorplan_rules(2)
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
