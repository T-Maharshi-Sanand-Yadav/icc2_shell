icc2_shell> man set_floorplan_extension_rules
2.  Synopsys Commands                                        Command Reference
                         set_floorplan_extension_rules

NAME
       set_floorplan_extension_rules
              Defines an extension floorplan rule in the design.

SYNTAX
       set_floorplan_extension_rules
              -rules rule_list
              -name rule_name
              -sides side_list
              -target target_type
              -value distance

   Data Types
       rule_list    list
       rule_name    string
       side_list    list
       target_type  string
       distance     float

ARGUMENTS
       -rules rule_list
              Specifies  the  list of floorplan rules for which this extension
              rule needs to be applied. It is not required that  rules  speci-
              fied  in  this  list  has  to pre-exist in the design. This is a
              mandatory option.

       -name rule_name
              Specifies the name of the extension floorplan rule.  This  is  a
              mandatory option.

       -sides side_list
              Specifies  the sides or directions in which the target object in
              specified floorplan rules is to be extended.  Valid  values  are
              all, bottom, horizontal, left, right, top and vertical. The hor-
              izontal argument includes both left and  right.  Similarly,  the
              vertical argument includes both bottom and top. This is a manda-
              tory option.

       -target target_type
              Specifies the target object  in  specified  floorplan  rules  on
              which  this extension rule needs to be applied. It can be "from"
              or "to" or both objects in that specified floorplan rule.  Those
              objects  will  be extended by the value specified in this exten-
              sion rule. This is a mandatory option.

       -value distance
              Specifies the extent by which the target  objects  of  specified
              floorplan rules will be extended for that particular rule check-
              ing. This is a mandatory option.

DESCRIPTION
       The set_floorplan_extension_rules command  defines  a  named  extension
       floorplan  rule  in the current design. The defined rule is persistent.
       If another floorplan rule by the same  name  exists  then  the  command
       errors out.

       The  command  specifies how the target objects either in "from" or "to"
       or both in specified floorplan rules need to be  extended  during  that
       particular rule check.

EXAMPLES
       The following example creates an extension rule named ex1 to extend the
       "from" objects in length floorplan rules le1 and le2 in directions  top
       and left by a value of 17 during the check for le1 and le2.

         prompt> set_floorplan_extension_rules -name ex1 \
            -rules {le1 le2} -target from \
            -sides {top left} -value 17

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_exception_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_forbidden_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
