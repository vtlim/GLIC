# Scripts for project on GLIC fitting to cryo-EM densities
Last updated: Jul 01 2019

## Contents

| file                  | use with          | description                                                           |
|-----------------------|-------------------|-----------------------------------------------------------------------|
| `density_chimera.py`  | python, chimera   | generate synthetic density in chimera for each structure              |
| `density_gromaps.sh`  | bash, gromaps     | create run file for gromaps to write densities from gromacs trajectory|
| `fsc_delta.py`        | python            | plot change in Fourier Shell Correlation curve from input xml files   | 
| `genmap.cmd`          | chimera           | called by `density_chimera.py` to generate synthetic density          |
| `natsort.py`          | python            | import from other scripts for natural sort of file names              |
| `record_plane.cmd`    | chimera           | open in chimera to generate movie of plane snapshot over varying z    | 

