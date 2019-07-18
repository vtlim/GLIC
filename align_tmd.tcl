
# __________________________________________________________________________________
#
# align_tmd.tcl
# Purpose:          Align GLIC structure by transmembrane domain to reference coordinates.
# Usage:            vmdt -e align_tmd.tcl -args reference.pdb to_be_moved.pdb
#
# Notes:
# - VMD can take in .gro files in place of .pdb files.
# - If you do not have a reference structure, try using Chimera to optimize fit of coords to map, or map to map.
#   https://www.cgl.ucsf.edu/chimera/docs/ContributedSoftware/fitmaps/fitmaps.html
# - Script based on: https://github.com/vtlim/misc/blob/master/vmd/structural/analyzeDCD.tcl
# __________________________________________________________________________________


# maybe skip terminal resid 315 if vmd is unable to read in gro
set tmd_sel "alpha and (resid 195 to 314) and (not resid 242 to 253)"

set ref_pdb [lindex $argv 0]
set mov_pdb [lindex $argv 1]

# =============================================================== #

mol new $ref_pdb
mol new $mov_pdb

set ref_sel [atomselect 0 "$tmd_sel"]
set mov_sel [atomselect 1 "$tmd_sel"]
set mov_all [atomselect 1 "all and not water"]
#set mov_all [atomselect 1 "protein"]

set matrix [measure fit $mov_sel $ref_sel]

$mov_all move $matrix
animate write gro system_dry.gro sel $mov_all
#animate write pdb system_dry.pdb sel $mov_all


# handle water separately since vmd doesn't write moved crds for all (> 99998 = too many?)
# CHECK FINAL STRUCTURE
set wat_sel1 [atomselect 1 "water and index <= 90000"]
set wat_sel2 [atomselect 1 "water and index > 90000"]
$wat_sel1 move $matrix
$wat_sel2 move $matrix
animate write gro wat1.gro sel $wat_sel1
animate write gro wat2.gro sel $wat_sel2

puts "\n==================================="
puts "\n\nThe move matrix is $matrix"
puts "\n==================================="

exit
