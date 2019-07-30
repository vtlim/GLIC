

import sys
import numpy as np
import matplotlib.pylab as plt

def extract_txt_file(txtfile):
    """
    Extract distances from text file generated with nanoHUB contact maps tool.
    """
    array = np.genfromtxt(txtfile)
    return array

# extract data from txt file
array1 = extract_txt_file(sys.argv[1])
array2 = extract_txt_file(sys.argv[2])
diff = array2 - array1

# define heat map limits symmetrically so that value of zero is white
maxval = np.amax(diff)
minval = np.amin(diff)
absval = max(abs(maxval), abs(minval))

# plot data
plt.imshow(diff, cmap='seismic', origin='lower', vmin=-absval, vmax=absval)
plt.colorbar()
plt.savefig('diff_DistanceMap.eps')
plt.show()
