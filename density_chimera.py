
import natsort
import glob
import subprocess
import os

# get list of structures
files = glob.glob('*_02_*pdb')
files.sort(key=natsort.natural_keys)

# iterate over each
for f in files:

    # print filename, and define name for mrc
    print(f)
    g = os.path.splitext(f)[0] + '.mrc'

    # call chimera
    chim_out = subprocess.check_output(["chimera", "--nogui", f, "genmap.cmd"],
        stderr=subprocess.STDOUT)
    print(chim_out)

    # rename the output based on the input
    mv_out = subprocess.check_output(["mv", "temp.mrc", g])
    print(mv_out)

