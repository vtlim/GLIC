
# Process for fitting structure to density map in Bayesian fitting MD simulations

## Route 1: With non-equilibrated structure

1. Prepare and organize [1] structure coordinates, [2] map files, [3] GROMACS configuration files.
Edit config files as appropriate.

```
ln -s ../adjust_map/07_newmap/03_mask.mrc GLIC_pH3_half1.mrc
ln -s ../adjust_map/07_newmap/blur_03_mask.mrc GLIC_pH3_half1_blur.mrc
ln -s ../adjust_map/07_newmap/shrp_03_mask.mrc GLIC_pH3_half1_sharp.mrc
```

## Route 2: With pre-equilibrated structure

1. Same as step 1 above.

2. Call the GROMACS preprocessor for stage 1 of fitting `MainChain` to blurred map.

```
~/local/gromacs-df2/bin/gmx grompp -f blur01_.mdp -c ../../01_reference/yz/ca.gro -p ../../01_reference/yz/GLIC_pH70_POPC_SOL_ION.top -o blur01.tpr -t ../../01_reference/yz/ca.cpt
```

3. Continue simulation stages with edited mdp file.
    1. Continuation of same stage with higher force constant

```
~/local/gromacs-df2/bin/gmx grompp -f blur02_.mdp -c blur01.gro -p ../../01_reference/yz/GLIC_pH70_POPC_SOL_ION.top -o blur02.tpr -t blur01.cpt
```

    2. Continuation onto next stage of blur --> orig

```
~/local/gromacs-df2/bin/gmx grompp -f orig01_.mdp -c blur02.part0001.gro -p ../../01_reference/yz/GLIC_pH70_POPC_SOL_ION.top -o orig01.tpr -t blur02.cpt

~/local/gromacs-df2/bin/gmx grompp -f sharp01_nvt.mdp -c orig01.part0001.gro -p ../../01_reference/yz/GLIC_pH70_POPC_SOL_ION.top -o sharp01.tpr -t orig01.cpt
```

4. To extend a simulation with no change to mdp file, input time in ps to extend flag:

```
~/local/gromacs-df2/bin/gmx convert-tpr -s blur01.tpr -extend 80000 -o densfit02.tpr
```

5. Take a look at the trajectory. To wrap:

```
gmx trjconv -s densfit03.tpr -f densfit03.part0002.xtc -o densfit03_nopbc.xtc -pbc mol -center
```

