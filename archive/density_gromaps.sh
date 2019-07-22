#!/bin/bash

# Script:   density_snapshots.sh
# Purpose:  Extract single frames in gromacs trajectory file as synthetic cryo-EM densities
# Usage:    sh density_snapshots.sh start end skip > output.log
# 
# $gmx maptide -f ../densfit01_nopbc.xtc -s ../densfit01.tpr -b 20 -e 39 -dt 20 -spacing X -mo k2s_20.mrc
#


gmx=/nethome/vlim/Downloads/gromaps/build/bin/gmx


if [ $# -ne 3 ]
then
    echo "Please supply three parameters for start, end, skip (ps)"
    exit
fi


start=$1
end=$2
skip=$3


printf "# chmod +x ./runsh\n# ./run.sh 2>> output.log\n" > run.sh

for (( i=$start; i<=$end; i+=$skip ))
do
    echo $i
    ((j=i + skip - 1))
    printf "$gmx maptide -f ../densfit01_nopbc.xtc -s ../densfit01.tpr -b $i -e $j -dt $skip -mo k2s_$i << EOF" >> run.sh

    # check that 2 represents "Protein-H" option
    printf "\n2\nEOF\n\n" >> run.sh

done
