

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

def shortener(array, rowlist, collist):

    # TODO: IMPROVE THIS. np.take? np.compress?

    # take relevant rows in 2d array
    print("Initial dimensions: {}".format(array.shape))
    new_rows = array[rowlist[0]]
    for i in rowlist[1:]:
        array_i = array[i]
        new_rows = np.vstack((new_rows, array_i))
    print("Extracted to dimensions: {}".format(new_rows.shape))

    # take relevant columns in matrix
    old_cols = np.copy(new_rows).T
    new_cols = old_cols[collist[0]]
    for i in collist[1:]:
        array_i = old_cols[i]
        new_cols = np.vstack((new_cols, array_i))
    fin_array = new_cols
    print("Extracted to dimensions: {}".format(fin_array.shape))

    return fin_array


def extract_matrix_residue(array, rlist):

    # sort list of residue numbers, first line should be 0
    rlist = [int(x) for x in rlist]
    rlist = np.sort(np.array(rlist))

    # extract specified residues
    fin_array = shortener(array, rlist, rlist)

    return fin_array

def extract_matrix_resid(array, rlist, parts, each, first):
    """

    Example:
    - homopentamer (parts=5)
    - 311 residues in each subunit (each=311)
    - first residue is number 5 (first=5)

    """

    # sort list of resid numbers
    rlist = [int(x) for x in rlist]
    rlist = np.sort(np.array(rlist)) - first

    # convert resid numbers (single subunit) to line numbers (all units)
    expanded = np.copy(rlist)
    for i in range(1, parts):
        subunit_i = i*each + rlist
        expanded = np.vstack((expanded, subunit_i))

    # extract specified residues
    fin_array = shortener(array, expanded, expanded)

    return fin_array

def map_diff(flist, **args):

    # parse data from txt file
    array1 = parse_txt_file(flist[0])
    array2 = parse_txt_file(flist[1])
    diff = array2 - array1

    # define heat map limits symmetrically so that value of zero is white
    absval = get_range(diff)

    # extract subplot if resid or residue is not None
    if args['residue'] is not None:
        diff = extract_matrix_residue(diff, args['residue'])
    elif args['resid'] is not None:
        diff = extract_matrix_resid(diff, args['resid'], args['parts'], args['each'], args['first'])
    elif args['row1'] is not None:
        rowlist = list(range(args['row1'], args['row2'], 1))
        collist = list(range(args['col1'], args['col2'], 1))
        diff = shortener(diff, rowlist, collist)

    # TODO: renumber ticks after extraction

    # plot data
    #plt.imshow(diff, cmap='seismic', origin='lower', vmin=-absval, vmax=absval)
    plt.imshow(diff, cmap='seismic', origin='lower', vmin=-10, vmax=10)
    plt.colorbar()
    plt.savefig('diff_DistanceMap.eps')
    plt.show()

def map_single(file1, **args):

    # parse data from txt file
    array1 = parse_txt_file(file1)

    # extract subplot if resid or residue is not None
    if args['residue'] is not None:
        array1 = extract_matrix_residue(array1, args['residue'])
    elif args['resid'] is not None:
        array1 = extract_matrix_resid(array1, args['resid'], args['parts'], args['each'], args['first'])
    elif args['row1'] is not None:
        rowlist = list(range(args['row1'], args['row2'], 1))
        collist = list(range(args['col1'], args['col2'], 1))
        diff = shortener(diff, rowlist, collist)

    # TODO: renumber ticks after extraction

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

    # options for extracting subplots for ONLY specified residues or resids
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
                            "subunit is taken for plotting. Starts at 0.")
    parser.add_argument("-p", "--parts", type=int,
                        help="How many subunits (analogous parts) comprise "
                             "the protein?")
    parser.add_argument("-e", "--each", type=int,
                        help="How many residues are in each identical subunit?")
    parser.add_argument("-f", "--first", type=int,
                        help="What resid number is the first resid?")

    # options for extracting subplots based on specified range(s) (can be asymmetric)
    parser.add_argument("--row1", type=int,
                        help="Lower range of what row (x-axis) index to use")
    parser.add_argument("--row2", type=int,
                        help="Upper range of what row (x-axis) index to use")
    parser.add_argument("--col1", type=int,
                        help="Lower range of what col (y-axis) index to use")
    parser.add_argument("--col2", type=int,
                        help="Upper range of what col (y-axis) index to use")


    args = parser.parse_args()

    # TODO: expand this checking to row1/row2 col1/col2
    if bool(args.residue and args.resid):
        sys.exit("ERROR: Only specify --resid (-d) OR --residue (-u) not both.")

    # if resid not None, make sure other requirements listed
    if args.resid:
        if not bool(args.parts and args.each and args.first):
            sys.exit("ERROR: Please specify --parts (-p), --each (-e), --first (-f).")

    # heat map useless for single data point
    if args.residue and len(args.residue) == 1:
        sys.exit("ERROR: At least 2 residues must be listed.")

    if args.single:
        map_single(args.infile[0], **vars(args))
    else:
        map_diff(args.infile, **vars(args))
