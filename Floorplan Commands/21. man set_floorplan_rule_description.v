icc2_shell> man set_floorplan_rule_description
2.  Synopsys Commands                                        Command Reference
                        set_floorplan_rule_description

NAME
       set_floorplan_rule_description
              Sets a description on a floorplan rule in the design.

SYNTAX
       status set_floorplan_rule_description
              -name rule_name
              -description rule_description

   Data Types
       rule_name  string
       rule_description  string

ARGUMENTS
       -name rule_name
              Specifies  the  name of the floorplan rule for which description
              has to be defined. Required option.

       -description rule_description
              Specifies the description to be set for the specified  floorplan
              rule.  Required option.

DESCRIPTION
       The  set_floorplan_rule_description  command  sets  a description on an
       existing floorplan rule in a design.

EXAMPLES
       The following example tries to set description on floorplan rule  named
       e2.

         prompt> set_floorplan_rule_description -name e2 -description {user defined description}
         1

         The following example reports the description set on floorplan rule e2 above.
           prompt> report_floorplan_rules e2

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
           Description:        "user defined description"

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
