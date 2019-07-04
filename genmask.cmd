# Masking map against protein structure, from Joe Jordan

# load protein as #0 and map as #1
open ca_cpt_protein.pdb
open moved.mrc

# generate a 10 A map from protein
molmap protein 10

# generate a map that has ones on voxels where there is density from the previous step
mask ones #0.1

# multiply the input map with the mask
vop multiply #2,1

# save the resulting map
volume #3 save output.mrc

stop
