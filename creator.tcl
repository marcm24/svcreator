#!/usr/bin/tclsh
# $argc - number items of arguments passed
# $argv - list of arguments
# $argv0 - name of the script
# [lindex $argv 0] 0th index of argv

# proc for all components

proc 2mux1 {} {
    puts "creating 2:1 mux"
    close [open "2mux1.tv" a+]
}

proc dflipflop {bits} {
    puts "creating d flip flop"
    
    set bitio [expr $bits - 1]

    set dff {
    module dff(input logic clk,
               input logic reset,
               input logic \[$bitio:0]\ d, # need to subtract 1 from bits
               output logic \[$bitio:0]\ q); 
    
    always_ff @(posedge clk)
        if (reset) q <= $bits'b0;
        else       q <= d;
    
    endmodule
    }
    
    set fp [open "dff.sv" a+]
    puts $fp [subst $dff]

}


# ----------------------------------------

# logic for proc calls
if {[lindex $argv 0] == "2:1mux"} {
    2mux1
}

if {[lindex $argv 0] == "dff"} {
    dflipflop [lindex $argv 1]
}
