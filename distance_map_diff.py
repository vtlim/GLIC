

import sys
import numpy as np
import matplotlib.pylab as plt

def parse_txt_file(txtfile):
    """
    Extract distances from text file generated with nanoHUB contact maps tool.
    """
    array = np.genfromtxt(txtfile)
    return array

def get_range(array):

    # ignore nan in min or max
    maxval = np.nanmax(array)
    minval = np.nanmin(array)
    absval = max(abs(maxval), abs(minval))

    return absval

def map_diff(file1, file2):
    # parse data from txt file
    array1 = parse_txt_file(file1)
    array2 = parse_txt_file(file2)
    diff = array2 - array1

    # define heat map limits symmetrically so that value of zero is white
    absval = get_range(diff)

    # plot data
    plt.imshow(diff, cmap='seismic', origin='lower', vmin=-absval, vmax=absval)
    plt.colorbar()
    plt.savefig('diff_DistanceMap.eps')
    plt.show()

def map_single(file1):

    # parse data from txt file
    array1 = parse_txt_file(file1)

    # plot data
    plt.imshow(array1, cmap='Oranges', origin='lower')
    plt.colorbar()
    plt.savefig('heatmap.eps')
    plt.show()


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()

    # basic options
    parser.add_argument("-i", "--infile", nargs='+',
                        help="Name of the input file(s).")
    parser.add_argument("-s", "--single", action='store_true',
                        help="Only plot a single map and not difference map")

    # options for extracting subplots
    parser.add_argument("-u", "--residue", nargs='+',
                        help="Analgous to VMD 'residue' selection. Residue "
                            "number(s) should match file's line number(s)."
                            "This option extracts the specified lines for"
                            "plotting.")
    parser.add_argument("-d", "--resid", nargs='+',
                        help="Analgous to VMD 'resid' selection. If using "
                            "this option, you must also specify number of "
                            "residues in a single subunit with -n flag AND "
                            "the number of subunits with -- flag."
                            "For each input i, the ith residue of each "
                            "subunit is extracted for plotting.")
    parser.add_argument("-p", "--parts", type=int,
                        help="How many subunits (analogous parts) comprise "
                             "the protein?")
    parser.add_argument("-e", "--each", type=int,
                        help="How many residues are in each identical subunit?")

    args = parser.parse_args()

    if args.single:
        map_single(args.infile[0])
    else:
        map_diff(args.infile[0], args.infile[1])
