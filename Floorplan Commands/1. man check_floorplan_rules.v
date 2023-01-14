icc2_shell> man check_floorplan_rules
2.  Synopsys Commands                                        Command Reference
                             check_floorplan_rules

NAME
       check_floorplan_rules
              Reports  violations  of  related  floorplan  spacing, enclosure,
              halo, length, area, width rules and track constraints.

SYNTAX
       collection check_floorplan_rules
              [list_of_rule_names]
              [-object_types list_of_object_types]
              [-lib_cells collection_of_lib_cells]
              [-exclude_rules list_of_rule_names]
              [-exclude_lib_cells collection_of_lib_cells]
              [-objects macro_list]
              [-bbox { {llx lly} {urx ury} }]
              [-error_view view_name]
              [-enable_rule_override true | false]

   Data Types
       list_of_rule_names         list
       list_of_object_types       list
       collection_of_lib_cells    list
       macro_list                 list
       llx                        float
       lly                        float
       urx                        float
       ury                        float
       view_name                  string

ARGUMENTS
       list_of_rule_names
              Specifies the list of floorplan rule  names  to  report  related
              violations.   By  default is checking all floorplan rules set by
              user.

       -object_types list_of_object_types
              Report floorplan rule violations on the listed object types. The
              object  types  include  hard_macro,  std_cell_area,  soft_macro,
              block_boundary, core_area. This option cannot be specified  with
              the -bbox and -objects options.

       -lib_cells collection_of_lib_cells
              Report  floorplan  rule violations on the listed lib cells. This
              option  cannot  be  specified  with  the  -bbox,  -objects   and
              -exclude_lib_cells options.

       -exclude_rules list_of_rule_names
              Specifies  the list of floorplan rules that will not report vio-
              lations.

       -exclude_lib_cells collection_of_lib_cells
              Specified the lib cells that the violations will not be reported
              on them. If this option is specified with "-exclude_rules", only
              the    violations    match    the    "-exclude_lib_cells"    and
              "-exclude_rules"  will  not  be reported.  This option cannot be
              specified with the -bbox, -objects and -lib_cells options.

       -objects macro_list
              Report floorplan rule violations  on  the  listed  macros.  This
              option  cannot  be  specified  with  the  -bbox,  -object_types,
              -exclude_lib_cells and -lib_cells options.

       -bbox { {llx lly} {urx ury} }
              Report floorplan rule violations of  macros  that  fully  inside
              this  region. This option cannot be specified with the -objects,
              -object_types, -exclude_lib_cells and -lib_cells options.

       -error_view view_name
              Specifies the name of the generated error view. If this  options
              is specified, the command saves the error view data to a file in
              XML format with  the  specified  name.  If  the  view_name  file
              already  exists  under  the  current  run directory, the command
              overwrites the file. If a file extension is specified,  it  must
              be  ".err",  otherwise  it is ignored. If no extension is speci-
              fied, the ".err" extension is appended to the file name. If this
              options  is not specified, an attachment is created/modified and
              saved  in  to  the  design  database  with  the  file  name   as
              "#block_name#_floorplanRules.err" .

       -enable_rule_override true | false
              When set true, if a lib_cell has its own rule, the corresponding
              rules for hard_macro  would  not  apply  to  instances  of  this
              lib_cell;  In  other  words,  one  or  more lib_cell rules to an
              object_type/lib_cell of a certain constraint type overrides  any
              general  rule  to the same object_type/lib_cell of the same con-
              straint  type.  Besides  this,  when  it  set  true,  cmd  allow
              lib_cell-routing_blockage   enclosure   rule  to  override  both
              hard_macro-routing_blockage enclosure rules and halo rules; Sim-
              ilarly,  allow  lib_cell-routing_blockage  halo rule to override
              both hard_macro-routing_blockage enclosure rules and halo rules.
              The default value is false.

DESCRIPTION
       This  command  check  floorplan  rule  violations  set by the commands:
       set_floorplan_spacing_rules  set_floorplan_enclosure_rules   set_floor-
       plan_halo_rules    set_floorplan_width_rules   set_floorplan_area_rules
       set_track_constraint

EXAMPLES
       The following command checks floorplan rule_1 on hard and soft macros.

         prompt> check_floorplan_rules rule_1 -object_types {hard_macro soft_macro}

       Assuming DTCD_lib is the ref lib of a DTCD cell and DTCD cell  has  the
       design type of hard macro, the following command reports all macro cell
       violations except for DTCD cells.

         prompt> set_floorplan_spacing_rules -name R1 \
            -from_lib_cells DTCD_lib -to_object_types std_cell_area

         prompt> set_floorplan_spacing_rules -name R2 \
            -from_object_types hard_macro -to_object_types std_cell_area

         prompt> check_floorplan_rules R2 -enable_rule_override

SEE ALSO
       set_floorplan_area_rules(2)
       set_floorplan_enclosure_rules(2)
       set_floorplan_halo_rules(2)
       set_floorplan_spacing_rules(2)
       set_floorplan_width_rules(2)
       set_floorplan_length_rules(2)
       remove_floorplan_rules(2)
       report_floorplan_rules(2)
       set_track_constraint(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
