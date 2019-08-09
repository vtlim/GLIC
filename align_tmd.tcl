
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


proc align_traj { {molid 0} } {
    # parameter molid x can be aligned against reference
    # molid 0 frame 0 is set as reference for alignment
    set align_txt "backbone and (resid 195 to 314) and (not resid 242 to 253)"
    set align_txt "alpha and resid 233" ;# 9' position (I232)

    set refprot [atomselect 0 "$align_txt" frame 0]
    set compprot [atomselect $molid "$align_txt"]
    set all [atomselect $molid "all"]

    set num_steps [molinfo 0 get numframes]
    for {set frame 0} {$frame < $num_steps} {incr frame} {
        $compprot frame $frame
        $all frame $frame
        $all move [measure fit $compprot $refprot]
    }
}


# proc for importing into other scripts
# extra braces are needed for default parameter
proc align_two { {move_txt "all and not water"} } {
    # aligns mols with molids 0 and 1 and one frame each

    # maybe skip terminal resid 315 if vmd is unable to read in gro
    set tmd_sel "backbone and (resid 195 to 314) and (not resid 242 to 253)"

    # create vmd atom selections
    set ref_sel [atomselect 0 "$tmd_sel"]
    set mov_sel [atomselect 1 "$tmd_sel"]
    set mov_all [atomselect 1 "$move_txt"]

    # compute and actualize the move matrix
    set matrix [measure fit $mov_sel $ref_sel]
    $mov_all move $matrix

    # handle water separately since vmd doesn't write moved crds for all (> 99998 = too many?)
    # CHECK FINAL STRUCTURE
    #set wat_sel1 [atomselect 1 "water and index <= 90000"]
    #set wat_sel2 [atomselect 1 "water and index > 90000"]
    #$wat_sel1 move $matrix
    #$wat_sel2 move $matrix
    #animate write gro wat1.gro sel $wat_sel1
    #animate write gro wat2.gro sel $wat_sel2


    puts "\n==================================="
    puts "\n\nThe move matrix is $matrix"
    puts "\n==================================="

    return [array get matrix]

}

# do the following if script is run as program and NOT imported
# TODO this doesn't work as import if other scripts also have 2 args...
# temp work around is to change argc condition to 100 or something when importing

if {$argc == 10} {

    set ref_pdb [lindex $argv 0]
    set mov_pdb [lindex $argv 1]
    mol new $ref_pdb
    mol new $mov_pdb

    set move_txt "all and not water"
    #set move_txt "protein"

    # can't pass matrix info from proc to here? (TODO)
    set matrix [align_two $move_txt]

    animate write gro system_dry.gro sel [atomselect 1 "$move_txt"]
    #animate write pdb system_dry.pdb sel $mov_all

    exit
}
