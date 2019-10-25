# Evaluate change in Fourier shell correlation (FSC) during fitting simulation

Last edited: Oct 24 2019

Goal: Assess map-model agreement from density fitting. In this example, I have a series of three simulations which continue from each other. The first two are 1 ns each, and the third is 5 ns. My objective is to calculate the FSC at regular intervals during the fitting simulations and see how the FSC curves change over time.

1. Extract every 6 frames (every 600 ps).

```
vmdt -e /nethome/vlim/Desktop/Project/gitmisc/vmd/write_nth_frame.tcl -args 6 ph3_01 ../../../01_reference/ca_cpt.gro ../densfit01.xtc ../densfit02.part0001.xtc ../densfit03.xtc
```

To get a single frame .gro or .pdb file, write out only protein heavy atoms with something along the lines of:

```
gmx trjconv -s orig01.tpr -f orig01.xtc -o orig01_1000ps.gro -b 1100 -e 1100  # system at 1000 ps
gmx trjconv -s orig01.tpr -f orig01_1000ps.gro -o ph5_01_fin.pdb              # protein only
```

2. Remove virtual sites.

```
for k in {0..13}; do echo $k; grep -v "M[CN]" ph3_01_$k.pdb > ph3_02_$k.pdb; done
```

3. Use original tempy move script to invert move back to original map placement.  
[EDIT: Skip this step since translating the structure from inverse tempy script may lose fitting improvements during MD]  

    * It's easier to use `tempy_pdb.py` and update the values in there rather than to use the original `tempy.py` script due to slight syntactical diffrences. 
    * Make sure you put the angles in the inverted order of z y x instead of x y z.
    * While this script does generate a map .mrc file, I don't use them because some of the FSC curves have an artifact of -1 value at inverse spatial resolution of x=0.

```
cp /nethome/vlim/Desktop/Project/scripts/tempy_pdb.py .
vi -o tempy_pdb.py ../../adjust_map/06_blur/tempy_df02_orig.py
conda activate tempy

for k in {0..13}; do echo $k; python tempy_pdb.py GLIC_pH3_half1_unfil.mrc ph3_02_$k.pdb; mv moved.pdb ph3_03_$k.pdb; done
```

4. Generate maps for the translated structures.

```
cp /nethome/vlim/Desktop/Project/scripts/genmap.cmd .
vi genmap.cmd

module load chimera
python /nethome/vlim/Desktop/Project/scripts/density_chimera.py
```

For a single frame calculation:

```
chimera --nogui fixed.pdb genmap.cmd
```

5. Calculate FSCs using [webserver](https://www.ebi.ac.uk/pdbe/emdb/validation/fsc/) and download XML files.

6. Plot delta FSCs.

```
conda activate base
python /nethome/vlim/Desktop/Project/scripts/fsc_delta.py
```
