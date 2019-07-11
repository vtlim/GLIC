# called by density_chimera.py

# open the reference map #1 for grid info
open straight_molmap_15a.mrc 

# generate map of structure #0 loaded from python 
molmap #0 15 model #2 onGrid #1

# save the new map
volume #2 save temp.mrc

stop
