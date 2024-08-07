#!/usr/bin/tclsh
# $argc - number items of arguments passed
# $argv - list of arguments
# $argv0 - name of the script
# [lindex $argv 0] 0th index of argv

proc dflipflop {} {
    puts "creating d flip flop"
    set fp [open "dff.sv" w+]
}

proc 2mux1 {} {
    puts "creating 2:1 mux"
    close [open "2mux1.tv" w+]
}

# ----------------------------------------

if {[lindex $argv 0] == "2:1mux"} {
    2mux1
}

if {[lindex $argv 0] == "dff"} {
    dflipflop
}
