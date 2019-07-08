
from TEMPy.StructureParser import PDBParser
from TEMPy.MapParser import MapParser
import numpy as np

# define point for rotation
# tempy examples use COM from input structure
# rotating against 0 0 0 doesn't seem to work
import TEMPy.Vector as Vector
com = Vector.Vector(90,90,90)

# read in map
target_map=MapParser.readMRC('GLIC_pH5_half1_unfil.mrc') #read target map

# rotate along x, y, z
target_map = target_map.rotate_by_axis_angle(1,0,0, np.rad2deg(-3.1396619777494124), com)
target_map = target_map.rotate_by_axis_angle(0,1,0, np.rad2deg(0.0005038746980934731), com)
target_map = target_map.rotate_by_axis_angle(0,0,1, np.rad2deg(2.125868534775962), com)

# translate along x, y, z
target_map = target_map.translate(-42, -58, 5)

# save map
target_map.write_to_MRC_file('moved.mrc') # Writing out to MRC file

