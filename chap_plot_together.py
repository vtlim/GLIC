
import os
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import json

"""
Adapted code from Yuxuan Zhuang
"""

def plot_together(infiles):

    sns.set_style("ticks")
    sns.set_context(font_scale=3,context='paper')
    sns.set_context({"figure.figsize": (20, 20)})

    # load files
    dict_list = []
    lab_list = []
    colors = ['black', 'red', 'blue', 'green']

    for f in infiles:
        with open(f) as json_file:
            fdict = json.load(json_file)
            dict_list.append(fdict)
        homedir = os.path.basename(os.path.dirname(f))
        lab_list.append(homedir)


    fig, ax = plt.subplots(figsize = (8,14))

    for d, l, c in zip(dict_list, lab_list, colors):

        ax.plot(np.array(d["pathwayProfile"]["radiusMean"])*10,
                -np.array(d["pathwayProfile"]["s"]),
                color=c, linewidth=4, label=l)

        radius_sd = np.array(d["pathwayProfile"]["radiusSd"])*10

        ax.fill_betweenx(-np.array(d["pathwayProfile"]["s"]),
                np.array(d["pathwayProfile"]["radiusMean"])*10 - radius_sd,
                np.array(d["pathwayProfile"]["radiusMean"])*10 + radius_sd,
                facecolor = "#000000",
                alpha = 0.2)


    ax.set_xlim(0,15)
    ax.set_ylim(-6,11)
    ax.set_xlabel('Radius ($\AA$)')
    ax.set_ylabel('Distance along pore (nm)')

    # configure legend
    l = plt.legend()
    l.draw_frame(False)

    # configure spines
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_linewidth(4)
    ax.spines['bottom'].set_linewidth(4)

    # configure ticks
    ax.xaxis.set_tick_params(width=4)
    ax.yaxis.set_tick_params(width=4)

    plt.savefig('output.png', bbox_inches='tight')
    plt.show()


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()

    parser.add_argument("-i", "--infile", nargs='+',
                        help="Name of the input file(s).")

    args = parser.parse_args()
    plot_together(args.infile)

