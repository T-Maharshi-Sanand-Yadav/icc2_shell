icc2_shell> man set_floorplan_forbidden_rules
2.  Synopsys Commands                                        Command Reference
                         set_floorplan_forbidden_rules

NAME
       set_floorplan_forbidden_rules
              Defines a forbidden floorplan rule in the design.

SYNTAX
       set_floorplan_forbidden_rules
              -lib_cells lib_cells
              -name rule_name

   Data Types
       lib_cells        collection
       rule_name        string

ARGUMENTS
       -lib_cells lib_cells
              Specifies  the  collection  of  library  cells for the forbidden
              floorplan rule. Specified lib cells are not allowed to be placed
              in the design.  This is a mandatory option.

       -name rule_name
              Specifies  the  name  of the forbidden floorplan rule. This is a
              mandatory option.

DESCRIPTION
       The set_floorplan_forbidden_rules command  defines  a  named  forbidden
       floorplan  rule  in the current design. The defined rule is persistent.
       If another floorplan rule by the same  name  exists  then  the  command
       errors out.

       The  set_floorplan_forbidden_rules  command  is used to specify list of
       lib cells that are not allowed to be placed in the design.

EXAMPLES
       The following example creates a forbidden rule named f1 to  check  that
       specified lib cells are not placed in the design.

         prompt> set_floorplan_forbidden_rules -name f1 \
            -lib_cells {*/an2* */aoi*}

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_extension_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
