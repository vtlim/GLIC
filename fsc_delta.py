
import natsort
import glob
import xmltodict
import matplotlib.pyplot as plt
import numpy as np

def plot_format(plt):
    plt.legend()

    # set plot limits
#    plt.ylim(-0.1, 1.1)

    # add grid
    ax = plt.gca()
    ax.grid(axis='y', linewidth=0.5)
    return plt, ax

# get list of structures
files = glob.glob('*.xml')
files.sort(key=natsort.natural_keys)

# assume x-locations are the same across all files (!!)
yarray = []

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
    yarray.append(ylist)

# plot all fsc curves
colors = plt.cm.plasma(np.linspace(0, 1, len(yarray)))
for i, y in enumerate(yarray):
    plt.plot(xlist, y, label=i, c=colors[i])

plt, ax = plot_format(plt)
plt.show()


# plot delta fsc curves (ex. y4-y3)

for i, y in enumerate(yarray):
    if i==0:
        dy = [0]*len(xlist)
    else:
        dy = np.array(y)-np.array(yarray[i-1])
    plt.plot(xlist, dy, label=i, c=colors[i])

plt, ax = plot_format(plt)
plt.show()
