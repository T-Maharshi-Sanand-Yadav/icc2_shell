icc2_shell> man fix_floorplan_rules
2.  Synopsys Commands                                        Command Reference
                              fix_floorplan_rules

NAME
       fix_floorplan_rules
              Moves  macros  or  create  routing or placement blockages to fix
              violations of related floorplan  spacing,  enclosure,  location,
              length, halo, area and width rules, and optionally, output a Tcl
              file to record the changes.

SYNTAX
       collection fix_floorplan_rules
              [-include include_list]
              [-exclude exclude_list]
              [-file file_name]
              [-prefix blockage_prefix]
              [-objects macros]
              [-bbox bounding_box]
              [rule_name_list]

   Data Types
       include_list            list
       exclude_list            list
       file_name               string
       blockage_prefix         string
       macros                  list
       bounding_box            rectangle
       rule_name_list          list

ARGUMENTS
       -include include_list
              Specifies the types of  fixing  operations  to  include  in  the
              process.  This  option  cannot  be  specified  together with the
              -exclude option.  If neither this nor -exclude option is  speci-
              fied, all types are included by default.

              The supported types are:

              o hard_macro
                  fix  violations  by  moving  hard  macros; used for macro to
                  macro spacing/length  rule  violations,  block  boundary  to
                  macro enclosure/location rule violations, and shape to shape
                  length rule violations, where the shapes  are  in  different
                  macros

              o soft_macro
                  fix  violations  by  moving  soft  macros; used for macro to
                  macro spacing/length rule violations and block  boundary  to
                  macro enclosure/location rule violations

              o cover_bump
                  fix  violations by moving cover bumps; used for two kinds of
                  enclosure rules: layer shape to bump and block  boundary  to
                  bump.

              o std_cell_area
                  fix  violations by adding hard placement blockages; used for
                  macro  to  std_cell_area  spacing/length  rule   violations,
                  std_cell_area  to  std_cell_area  spacing  rule  violations,
                  block boundary to std_cell_area enclosure/location rule vio-
                  lations,  std_cell_area  width and area rule violations, and
                  std_cell_area poly rule violations

              o boundary_cell_region
                  fix violations by adding hard placement  blockages;  similar
                  use  as  std_cell_area, but considering voltage area regions
                  instead of overall standard cell area.

              o core_area
                  fix violations by adjusting core area;  used  for  core_area
                  width rule violations and block_boundary to core_area enclo-
                  sure rule violations

              o block_boundary
                  fix  violations  by  adjusting  block  boundary;  used   for
                  block_boundary  width  rule violations and block_boundary to
                  core_area enclosure rule violations

              o va_boundary
                  fix violations by adjusting voltage  area  boundaries;  used
                  for core_area to va_boundary enclosure rule violations

              o macro_keepout
                  fix  violations by deriving  hard keepout margins on macros;
                  used for macro and std_cell_area spacing and halo rule  vio-
                  lations

              o routing_blockage
                  fix  violations  by adding routing blockages; used for macro
                  and routing blockage enclosure/halo rule violations

       -exclude exclude_list
              Specifies the types of fixing operations  to  exclude  from  the
              process.  This  option  cannot  be  specified  with the -include
              option.  If this option is specified, the command  performs  all
              types   of   operations,  except  the  types  specified  in  the
              exclude_list.  The  allowed  types  are  the  same  as  for  the
              -include option.

       -file file_name
              Name  of Tcl script to record changes. If it is not provided, no
              Tcl script will be output.

       -prefix blockage_prefix
              Name of prefix that is automatically added to blockages.

       -objects macros
              List of macro instances for which violations are fixed. If  pro-
              vided,  only the violations that are related to specified macros
              are fixed. Mutually exclusive with -bbox.

       -bbox bounding_box
              Bounding box of macros to consider  for  fixing  violations.  If
              provided, only macros that are completely covered by the box are
              selected and  only  the  violations  that  are  related  to  the
              selected macros are fixed. Mutually exclusive with -objects.

       rule_name_list
              Specifies the list of floorplan rule names to fix related viola-
              tions.  By default, the tool fixes all floorplan  rules  set  by
              you.

DESCRIPTION
       After  the  floorplan rule checker is done, use this command to fix the
       following violations:

       o Adjust core area and block boundary to  mitigate  block  boundary  to
         core  area  enclosure rule violations and core area width rule viola-
         tions.

       o Adjust voltage area boundary to mitigate core area  to  voltage  area
         boundary enclosure rule violations.

       o  Derive  the  macros'  hard  keepout  margin  to satisfy the macro to
         std_cell_area spacing/halo rule.

       o Move hard and/or soft macros to satisfy all grid-type  spacing/length
         rules, and enclosure/location rules from the block boundary.

       o Create routing blockages after macro placement to satisfy all routing
         blockage to hard macro enclosure and halo rules.

       o Create placement blockages after macro placement to make the standard
         cell  area  satisfy  all  width  rules, poly rules, area rules, spac-
         ing/length rules to hard macro, enclosure rules from the block bound-
         ary and spacing rules to standard cell area.

       Note: -include/-exclude options specify the types of violations to fix.

       If  none  of them are specified, the tool behaves as though all of them
       have been specified.

EXAMPLES
       The following commands fix  violations  of  floorplan  rule_1  on  hard
       macros to the block boundary.
         prompt> set_floorplan_spacing_rule -name rule_1 \
            -from_object_types hard_macro -to_object_types block_boundary -min 10
         prompt> fix_floorplan_rules -include hard_macro  -bbox {{10 10} {100 100}}
         prompt> fix_floorplan_rules -objects [get_selection] -file fixer.tcl

       The following commands fix violations of floorplan rule_2 on core boundary.
         prompt> set_floorplan_width_rules -name rule_2 \
            -object_types core_area -offset .4 -step .8
         prompt> fix_floorplan_rules -include {core_area block_boundary}

       The following commands fix violation of floorplan rule_3 on std cell area.
         prompt> set_floorplan_width_rule -name rule_3 \
            -object_types std_cell_area -min .3
         prompt> fix_floorplan_rules -exclude {hard_macro soft_macro} -prefix "auto_blk"

       The following command fixes violations related to all rules that may be specified:
         prompt> fix_floorplan_rules

SEE ALSO
       set_floorplan_spacing_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_width_rules(2)
       set_floorplan_area_rules(2)
       set_floorplan_length_rules(2)
       set_floorplan_location_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
