# called by density_chimera.py

# open the reference map #1 for grid info
open straight_molmap_15a.mrc 

# generate map of structure #0 loaded from python 
# grid spacing will be set to 1/3 of specified resolution

# [not working] molmap #0 2.49 model #2 onGrid #1

molmap #0 2.49 model #2
vop resample #2 onGrid #1

# save the new map
volume #3 save temp.mrc

stop
