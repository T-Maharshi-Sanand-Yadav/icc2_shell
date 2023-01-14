icc2_shell> man copy_floorplan
2.  Synopsys Commands                                        Command Reference
                                copy_floorplan

NAME
       copy_floorplan
              Copies  the floorplan data from the design view of source design
              label to the design view of the target design label in the  same
              or a different library.

SYNTAX
       collection copy_floorplan
              [-to_block top_block]
              -from_block from_top_block
              [-objects objects]
              [-include include_list]
              [-exclude exclude_list]
              [-hierarchical]
              [-force]
              [-verbose]

   Data Types
       top_block                     string
       from_top_block                string
       objects                       collection
       include_list                  list
       exclude_list                  list

ARGUMENTS
       -force Forces copying of those floorplan objects of source block to the
              destination block even if they already exist. To check  existing
              floorplan  objects,  names  are  matched.  In  the default mode,
              matching objects are not copied.

       -from_block from_top_block
              Specifies the source design label name  with  optional  library,
              block and label specifications. The from_top_block specification
              is as follows:

              [libName:]blockName[/labelName]

              If the library specification is not present, the current library
              is  used.   If  label  specification  is  not  present, then the
              default label is used.  This is a required option.

       -to_block top_block
              Specifies  the  destination  design  label  name  with  optional
              library  and  label specifications.  The top_block specification
              is as follows:

              [libName:]blockName[/labelName]

              If the library, block, or label specifications are not  present,
              the  values from the source block are used. By default, the cur-
              rent_block is used as the destination.

       -include include_list
              Specifies the types of floorplan data to copied  to  the  output
              design  view.  This option cannot be specified together with the
              -exclude or -objects options. If this option is  not  specified,
              all types are included by default.

              The supported types are:

              o blockages

              o bounds

              o cells

              o corridors

              o die_area

              o edit_groups

              o io_guides

              o macros

              o module_boundaries

              o pin_guides

              o pins

              o route_guides

              o rows

              o tracks

              o vias

              o scan_chains

              o routing_directions

              o voltage_areas

              o fills

              o pg_metal_fills

              o routing_rules

              o pg_regions

              o port

              o supernet

              o bundle

              o topology_plan

              o net_estimation_rule

              Specify  -include  macros  to  output  only macro cells and skip
              standard cells. Specify -include cells to output all cells.

       -exclude exclude_list
              Specifies the types of data to exclude  from  the  output.  This
              option  cannot be specified with the -include option or -objects
              options. If this option is specified,  the  command  writes  all
              types,  except  the types specified in exclude_list. The allowed
              data types are the same as for the -include option.

       -objects objects
              Specifies the floorplan objects to be copied to the  destination
              design view. Supported object types are:

              o "block"

              o "design"

              o "routing_blockage"

              o "shaping_blockage"

              o "placement_blockage"

              o "bound"

              o "cell"

              o "routing_corridor"

              o "core_area"

              o "edit_group"

              o "fill_cell"

              o "io_guide"

              o "via"

              o "shape"

              o "net"

              o "pin_guide"

              o "pg_region"

              o "routing_guide"

              o "site_row"

              o "site_array"

              o "track"

              o "voltage_area"

              o "routing_rule"

              o "port"

              o "supernet"

              o "bundle"

              o "topology_plan"

       -verbose
              This option enables display of verbose messages.

       -hierarchical
              This  option enables copying of the floorplan objects hierarchi-
              cally.  This option is mutually exclusive with "-objects".

DESCRIPTION
       This command copies the floorplan data from the design view  of  source
       design  label  to  the  design view of the target design label with the
       same or different library and block. The command fails if the  destina-
       tion  library  is  not open or is opened in read-only mode. The command
       also fails if you specify an illegal name for the source or destination
       design  label  or  if the design view is not available for a particular
       design label. If successful, the destination block is returned.

       This command returns the block if successful, or O if not. If an  ille-
       gal  name  is  given  for  the source or destination block names, a Tcl
       error is raised.

       The operation happens only between design  views.  If  the  destination
       design  is  not specified, the current block is used as the destination
       design if the view is design view.

       The command only copies the floorplan objects which exist in the source
       but  not  in  the  destination.  To find whether a particular floorplan
       object exists, the name is matched. If the name of a particular  floor-
       plan  object  already  exists, the object is skipped and is not copied.
       This can be overriden by specifying the -force option.

EXAMPLES
       This example copies floorplan data of design view of design  label  Top
       to design view of block Top2. Only the floorplan objects not present in
       Top2 are copied.

         prompt> copy_floorplan -from_block lib:Top/place_opt -to_block lib:Top2/place_opt
         {"lib:Top2.design"}

       This example copies a block Top  into  a  new  library  MyOtherDesigns.
       Only  the  floorplan  objects not present in Top2 are copied MyOtherDe-
       signs:TOPlace_opt.

         prompt> copy_floorplan -from_block lib:Top/place_opt -to_block MyOtherDesigns:TOPlace_opt

         {"MyOtherDesigns:Top.design"}

SEE
       ALSO
       get_blocks(2)
       open_block(2)
       open_lib(2)
       remove_blocks(2)
       reopen_block(2)
       copy_block(2)
       save_block(2)

                          Version S-2021.06-SP5
            Copyright (c) 2022 Synopsys, Inc. All rights reserved.
icc2_shell>
