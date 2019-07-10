# set top molecule as protein prior to this script
set closerlook [atomselect top "residue 622 to 932"]
set mask_out "vmd_mask_chainC.dx"
set map_orig "sharp_03_mask.mrc"
set map_mask "sharp_03_mask_chainC.dx"

# run the commands
volmap mask $closerlook -res 1.0 -cutoff 3.0 -o $mask_out
volutil -mult $map_orig $mask_out -o $map_mask
mol new $map_mask
