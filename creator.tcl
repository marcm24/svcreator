#!/usr/bin/tclsh
# $argc - number items of arguments passed
# $argv - list of arguments
# $argv0 - name of the script
# [lindex $argv 0] 0th index of argv

# proc for all components

#check for bits to change via cla
proc 2to1mux {} {
    puts "creating 2:1 mux"

    set 2mux1 {
    module 2mux1 #(parameter WIDTH = 8)
                  (input logic [WIDTH-1:0] d0, d1,
                   input logic s,
                   output logic [WIDTH-1:0] y);

        assign y = s ? d1 : d0;
    endmodule
    }

    set fp [open "2mux1.sv" a+]
    puts $fp $2mux1

}

#check for bits to change via cla
proc 3to1mux {} {
    puts "creating 3:1 mux"

    set 3mux1 {
    module 3mux1 #(parameter WIDTH = 8)
                  (input logic [WIDTH-1:0] d0, d1, d2,
                   input logic [1:0] s,
                   output logic [wIDTH-1:0] Y);
        
        assign y = s[1] ? d2 : (s[0] ? d1 : d0);
    endmodule
    }

    set fp [open "3mux1.sv" a+]
    puts $fp $3mux1
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
    2to1mux
}

if {[lindex $argv 0] == "3:1mux"} {
    3to1mux
}

if {[lindex $argv 0] == "dff"} {
    dflipflop [lindex $argv 1]
}
