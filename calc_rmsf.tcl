# __________________________________________________________________________________
#
# calc_rmsf.tcl
# Purpose:          Measure RMSF along trajectory.
# Usage:            vmdt -e calc_rmsf.tcl -args inpsf indcd selection,txt
# Example:          vmdt -e calc_rmsf.tcl -args file.gro file.xtc resid,223
#
# Notes:
# - VMD can take in .gro(.xtc) files in place of .pdb(.dcd) files.
# - Script based on: https://github.com/vtlim/misc/blob/master/vmd/structural/analyzeDCD.tcl
# __________________________________________________________________________________


set inpsf [lindex $argv 0]
for {set i 1} {$i < $argc} {incr i} {
    lappend dcdlist [lindex $argv $i]
}

mol new $inpsf
foreach dcd $dcdlist {
    mol addfile $dcd first 0 last -1 step 1 waitfor all
}

# align system
source /nethome/vlim/Desktop/Project/scripts/align_tmd.tcl
align_traj

# open file for writing output
set outDataFile [open rmsf.dat w]
puts $outDataFile "# Data from files:\n#  $inpsf\n#  $dcdlist\n"
puts $outDataFile "# Res | RMSF (Angstroms)"

# borrow some lone ion to use as dummy atom
# check that this atom exists if you get syntax error below
# atomselect: cannot parse selection text: atomselect3
set dumid 0

# rmsf calculation
puts "Calculating RMSF..."

for {set i 0} {$i < 310} {incr i} {

    set whole [atomselect top "protein and residue $i"]
    set group [atomselect top "protein and residue $i and noh"]
    set dummy [atomselect top "index $dumid"]

    puts "$i ([$group num] atoms)"

    set num_steps [molinfo top get numframes]
    for {set frame 0} {$frame < $num_steps} {incr frame} {
        $whole frame $frame
        $group frame $frame
        $dummy frame $frame

        # measure crds of center of this noh-residue and set crds on dummy atom
        set xyz [measure center $group]
        $dummy set x [lindex $xyz 0]
        $dummy set y [lindex $xyz 1]
        $dummy set z [lindex $xyz 2]
    }

    # rmsf calculation over all frames
    set rmsf [measure rmsf $dummy]
    $whole set occupancy $rmsf
    puts $outDataFile "$i\t$rmsf"

}

# write out rmsf info in occupancy column of a PDB file
animate write pdb rmsf.pdb beg 0 end 0 sel [atomselect top protein]
close $outDataFile
exit


