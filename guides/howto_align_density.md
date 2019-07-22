# Move cryo-EM density to align with model

Last edited: Jul 22 2018

Goal: align density to model before fitting. The opposite approach of aligning the model to the density may not work as well if the periodic box is not aligned with the prinicipal axes (doesn't simulate well) or if the box is off-center (because GROMACS will output it at center and then adjustment may have to be repeated).

Note: Any transformations to the map should ideally be done before moving the density. For example:
 * Blurring map
```
phenix.auto_sharpen ../GLIC_pH3_half1_unfil.mrc sharpened_map_file=blur_01_orig.mrc resolution=4.1 b_sharpen=-50
```
 * Auto-sharpening map
```
phenix.auto_sharpen ../GLIC_pH3_half1_unfil.mrc sharpened_map_file=shrp_01_orig.mrc resolution=4.1
```


1. Start with a model that is well-aligned to the electron density. 
    * If it isn't, [manually adjust in VMD](https://www.ks.uiuc.edu/Research/vmd/current/ug/node33.html).
    * Relevant hot keys include `8` and `c`.
    * Save the protein with only heavy atoms.

2. Compute the transformation matrix between the (model that is aligned to the density) and the (model where you want the density to go).

```
vmdt -e /nethome/vlim/Desktop/Project/scripts/align_tmd.tcl -args model_density.pdb model_box.pdb > matrix
```

 * Adjust the `align_tmd.tcl` as needed.
 * The protein and membrane here is printed out separately from the water molecules because with too many waters than VMD can handle, the resulting structure has some waters that are not moved. Though this shouldn't matter since working with the protein only.

3. Extract rotation angles from the 4D transformation matrix. 

```
cp /nethome/vlim/Desktop/Project/scripts/decompose_matrix.py .
vi decompose_matrix.py -o matrix 
ln -s /nethome/vlim/Desktop/Project/scripts/transformations.py .
python decompose_matrix.py >> matrix
```

4. Use the values of the rotation vectors in the move script.

```
cp /nethome/vlim/Desktop/Project/scripts/tempy.py .
vi tempy.py
conda activate tempy
python tempy.py
```

5. Iteratively adjust the translation of the map in the x, y, z directions (Angstroms) with `tempy.py`.

6. The map should now be aligned to the model. Since the box sides are aberrantly noisy in the new location, mask the map around the protein.

```
cp /nethome/vlim/Desktop/Project/scripts/genmask.cmd
vi genmask.cmd
chimera genmask.cmd
```


