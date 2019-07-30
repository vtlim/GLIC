
# __________________________________________________________________________________
#
# rmsd_pairwise.tcl
# Purpose:          Compute RMSD between each pair of residues in two GLIC structures.
# Usage:            vmdt -e rmsd_pairwise.tcl -args file1.pdb file2.pdb
#
# TODO:
# - Redundant code from align_tmd.tcl
#
# Notes:
# - VMD can take in .gro files in place of .pdb files.
# __________________________________________________________________________________


# maybe skip terminal resid 315 if vmd is unable to read in gro
set tmd_sel "alpha and (resid 195 to 314) and (not resid 242 to 253)"

set ref_pdb [lindex $argv 0]
set mov_pdb [lindex $argv 1]

# =============================================================== #
# load in structures and align

mol new $ref_pdb
mol new $mov_pdb

set ref_sel [atomselect 0 "$tmd_sel"]
set mov_sel [atomselect 1 "$tmd_sel"]
set mov_all [atomselect 1 "all and not water"]
#set mov_all [atomselect 1 "protein"]

set matrix [measure fit $mov_sel $ref_sel]

$mov_all move $matrix

# =============================================================== #

# check that number of residues match in both structures
set nres0 [llength [lsort -unique -integer [[atomselect 0 all] get residue]]]
set nres1 [llength [lsort -unique -integer [[atomselect 1 all] get residue]]]

if {![$nres0 == $nres1]} {
    puts "\n\nERROR: number of residues do not match. $nres0 $nres1\n"
    exit
}

# loop over each residue to do an NxN comparison of RMSD
puts "\nCalculating pairwise RMSD by each residue's backbone..."
set outDataFile [open rmsd_matrix.txt w]
for {set i 0} {$i < $nres0} {incr i} {

    set curr_line ""
    set sel0 [atomselect 0 "backbone and residue $i"]

    for {set j 0} {$j < $nres0} {incr j} {

        set sel1 [atomselect 1 "backbone and residue $j"]

        set rmsdsel [format "%.4f" [measure rmsd $sel1 $sel0]]
        set curr_line "$curr_line\t$rmsdsel"

        # free memory to prevent VMD from getting killed
        $sel1 delete
    }
    $sel0 delete

    puts $outDataFile $curr_line
}

close $outDataFile
