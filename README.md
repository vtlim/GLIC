# Scripts for project on GLIC fitting to cryo-EM densities
Last updated: Aug 05 2019

## Contents

| file                  | use with          | description                                                           |
|-----------------------|-------------------|-----------------------------------------------------------------------|
| `align_tmd.tcl`       | vmd               | align GLIC structure against its transmembrane domain                 |
| `calc_rmsf.tcl`       | vmd               | calculate RMSF of specified residues                                  |
| `decompose_matrix.py` | python            | decompose matrix extracted from `align_tmd.tcl` into rot, transl, etc.|
| `density_chimera.py`  | python, chimera   | generate synthetic density in chimera for each structure              |
| `distance_map_diff.py`| python            | plot heat map for one distance map minus another from nanoHUB output  |
| `fsc_delta.py`        | python            | plot change in Fourier Shell Correlation curve from input xml files   | 
| `genmap.cmd`          | chimera           | called by `density_chimera.py` to generate synthetic density          |
| `genmask.cmd`         | chimera           | generate mask for map from around a reference protein structure       |
| `natsort.py`          | python            | import from other scripts for natural sort of file names              |
| `record_plane.cmd`    | chimera           | open in chimera to generate movie of plane snapshot over varying z    |
| `rmsd_residue.tcl`    | vmd               | compute RMSD for each residue backbone between two structures         |
| `tempy.py`            | python            | example application of moving density with input rotation/translation | 
| `tempy_pdb.py`        | python            | related to `tempy.py`; now take *structure* and move to orig map      | 
| `transformations.py`  | python            | called by `decompose_matrix.py` to decompose 4x4 move matrix          | 
| `vmd_color_subunit.tcl` | vmd             | color each of five subunits in VMD for when chains not recognized     |
| `vmd_mask.tcl`          | vmd             | quickly generate/view masked map in vmd; vmd can only write .dx map   |
| `write_nth_frame.tcl`\* | vmd             | write every nth frame from trajectory as separate pdb file            |
| `xyz_constrict.tcl`     | vmd             | get coords of constriction site (center of E223 alphaC of 5 subunits) |

\*Note: Located in [misc repo](https://github.com/vtlim/misc)


## Contents of archive folder

For files that are not actively used in the project but may come into handy.

| file                  | use with          | description                                                           |
|-----------------------|-------------------|-----------------------------------------------------------------------|
| `contact_map.py`      | python            | generate contact map (not distance map) on two PDBs to compare        |
| `density_gromaps.sh`  | bash, gromaps     | create run file for gromaps to write densities from gromacs trajectory|
| `rmsd_pairwise.tcl`   | vmd               | compute all by all pairwise rmsd of protein residues

