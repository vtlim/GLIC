
# __________________________________________________________________________________
#
# xyz_constrict.tcl
# Purpose:          Calculate center of mass of alpha carbon atoms for constriction at 9' residue.
# Usage:            vmdt -e xyz_constrict.tcl -args file1.pdb
#
# Notes:
# - VMD can take in .gro files in place of .pdb files.
# __________________________________________________________________________________


set inpdb [lindex $argv 0]
set seltxt "alpha and resid 233"

# =============================================================== #

mol new $inpdb
set sel [atomselect top "$seltxt"]
puts "\n\nConstriction selection has [$sel num] atoms"
puts "\nSelection geometric center (A):"
puts "[measure center $sel]\n\n"
exit
