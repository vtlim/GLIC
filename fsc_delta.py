
import natsort
import glob
import xmltodict
import matplotlib.pyplot as plt
import numpy as np

def plot_format(plt):
    plt.legend(fontsize=16, loc=1)         # discrete
#    plt.legend(fontsize=16, loc=1, ncol=2)  # diverging

    # set plot limits
#    plt.ylim(-0.1, 1.1)

    # set figure size
    plt.gcf().set_size_inches(18,6)

    # add grid
    ax = plt.gca()
    ax.grid(axis='y', linewidth=0.5)

    # add x-axis label
    plt.xlabel("spatial frequency ($\AA^{-1}$)", fontsize=18)

    # increase tick font size
    ax.tick_params(axis='both', which='major', labelsize=16)

    return plt, ax

# get list of structures
files = glob.glob('*.xml')
files.sort(key=natsort.natural_keys)

# assume x-locations are the same across all files (!!)
yarray = []
labels = []

# iterate over each
for f in files:

    # parse xml file
    print(f)
    with open(f) as fopen:
        fdict = xmltodict.parse(fopen.read())

    #import pprint
    #pprint.pprint(dict(fdict))

    # organize coordinates
    xlist = [float(c['x']) for c in fdict['fsc']['coordinate']]
    ylist = [float(c['y']) for c in fdict['fsc']['coordinate']]

    # store data
    yarray.append(ylist)
    labels.append(f.split("_")[-1].split(".")[0]) # prefix_label.xml

# define plot colors
colors = plt.cm.tab10(np.linspace(0, 1, 10))               # discrete
#colors = plt.cm.coolwarm_r(np.linspace(0, 1, len(yarray))) # diverging

# plot fsc curves
for i, (y, l) in enumerate(zip(yarray, labels)):
    plt.plot(xlist, y, label=l, c=colors[i])

plt, ax = plot_format(plt)
plt.ylabel('correlation', rotation=0, ha='right', fontsize=18)
plt.savefig('fsc.png', bbox_inches='tight')
plt.show()


# plot delta fsc curves (ex. y4-y3)
# todo: probably can combine with for loop above
for i, (y, l) in enumerate(zip(yarray, labels)):
    if i==0:
        dy = [0]*len(xlist)
    else:
        dy = np.array(y)-np.array(yarray[i-1])
    plt.plot(xlist, dy, label=l, c=colors[i])

plt, ax = plot_format(plt)
plt.ylabel('change in\ncorrelation', rotation=0, ha='right', fontsize=18)
plt.savefig('fsc_delta.png', bbox_inches='tight')
plt.show()
