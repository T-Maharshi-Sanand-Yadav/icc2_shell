icc2_shell> man compare_floorplans
2.  Synopsys Commands                                        Command Reference
                              compare_floorplans

NAME
       compare_floorplans
              Writes  a report that lists any differences in objects and their
              locations between the current design and  floorplan  information
              for another design written by the write_floorplan command.

SYNTAX
       int compare_floorplans
              [-input dir_name]
              [-verbosity minimum | low | high]
              [-top_level_only]

   Data Types
       dir_name string

ARGUMENTS
       -input dir_name
              Specifies  the name of the directory under which the file floor-
              plan_compare_data.txt is located. The  default  is  ./floorplan.
              The  command  writes an error message and exits if the directory
              does not exist, or if the file is missing.

       -verbosity minimum | low | high
              Determines the level of comparison detail to report. The minimum
              argument  prints the number of differences for each object type.
              The low argument prints up to  five  examples  for  each  object
              type.  The  high  argument prints up to 1000 differences of each
              type. By default, the level is minimum.

       -top_level_only
              Compares only top-level objects and skip comparison  for  lower-
              level objects.

DESCRIPTION
       The  compare_floorplans  command  creates a report containing a list of
       objects that are either in floorplan_compare_data.txt file but  not  in
       the  design  database,  or  in  the  design  database but not in floor-
       plan_compare_data.txt. The object types that are considered are  macros
       and  pins.  Feedthrough  pins are not considered. The command creates a
       file named compare_output, in the current directory, that creates lists
       of  new  objects  that  are  in the existing in database but not in the
       file. For example:

       set _new_macros [get_cells { macro1_name macro2_name ...}]
       set _new_ports {...}

       For objects in the floorplan_compare_data.txt file but not in the data-
       base, the command outputs names and locations or boundaries in the same
       file. The command outputs two levels, for example, pins and  macros  at
       the  top  level and inside blocks. The command skips the output for the
       third level and beyond.

       Note that the  floorplan_compare_data.txt  file  is  generated  by  the
       write_floorplan command. The compare_floorplans command is typical used
       to compare different versions of the same design. For example, begin by
       running the write_floorplan command on one version of the design. Then,
       load the new version and use the compare_floorplans command  to  deter-
       mine if any differences exist between the two versions.

       This command returns 1 on success, 0 otherwise.

EXAMPLES
       The  following  example  writes a report based on comparing the current
       design with the floorplan_compare_data.txt file in  the  script  direc-
       tory.

         prompt> compare_floorplans -input script

       The  following  example  prints  more detailed information, but outputs
       data related to the top-level only.

         prompt> compare_floorplans -verbosity high -top_level_only

SEE ALSO
       write_floorplan(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
