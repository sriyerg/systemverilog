# TCL file invoked from VCS's simv at run-time using this: -ucli -do <this file>


# Syntax: fsdbDumpvars [depth] [instance] [option]*
##############################################################################
# Option                     Description
##############################################################################
# +mda                       Dumps memory and MDA signals in all scopes.
# +packedmda                 Dumps packed signals
# +struct                    Dumps structs
# +skip_cell_instance=mode  Enables or disables cell dumping
# +strength                  Enables strength dumping
# +parameter                 Dumps parameters
# +power                     Dumps power-related signals
# +trace_process             Dumps VHDL processes
# +no_functions              Disables dumping of functions
# +sva                       Dumps assertions
# +Reg_Only                  Dumps only reg type signals
# +IO_Only                   Dumps only IO port signals
# +by_file=<filename>        File to specify objects to add
# +all                       Dumps memories, MDA signals, structs, unions,power, and packed structs

set waves "0"
if {[info exists ::env(WAVES)]} {
  set waves "$::env(WAVES)"
}

set tb "tb"
if {[info exists ::env(TB)]} {
  set tb "$::env(TB)"
} else {
  puts "WARNING: TB environment variable not set - using \"tb\" as the
        top level testbench hierarchy."
}

if {$waves eq "1"} {
  fsdbDumpfile  "waves.fsdb"
  fsdbDumpvars  0 $tb +all
  fsdbDumpSVA   0 $tb
}

run
quit
