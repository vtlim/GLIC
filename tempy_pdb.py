
from TEMPy.StructureParser import PDBParser
from TEMPy.MapParser import MapParser
from TEMPy.StructureBlurrer import StructureBlurrer
import numpy as np
import sys

# define point for rotation
# tempy examples use COM from input structure
# rotating against 0 0 0 doesn't seem to work
import TEMPy.Vector as Vector
com = Vector.Vector(90,90,90)

# read in map
target_map=MapParser.readMRC(sys.argv[1]) #read target map

# read in structure
structure_instance=PDBParser.read_PDB_file('structure_id', sys.argv[2])

# create the map
blurrer = StructureBlurrer()
sim_map = blurrer.gaussian_blur(structure_instance, 2.49, densMap=target_map)

# translate along x, y, z
sim_map = sim_map.translate(42, 58, -5)

# rotate along x, y, z
sim_map = sim_map.rotate_by_axis_angle(1,0,0, np.rad2deg(3.1396619777494124), com)
sim_map = sim_map.rotate_by_axis_angle(0,1,0, np.rad2deg(-0.0005038746980934731), com)
sim_map = sim_map.rotate_by_axis_angle(0,0,1, np.rad2deg(-2.125868534775962), com)

# save map
sim_map.write_to_MRC_file('moved.mrc') # Writing out to MRC file

