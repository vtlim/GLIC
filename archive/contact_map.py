
# https://contact-map.readthedocs.io/en/latest/examples/nb/contact_map.html

import os
import sys
import matplotlib.pyplot as plt
import mdtraj as md
from contact_map import ContactMap, ContactFrequency, ContactDifference

def map_contacts(fname):

    traj = md.load(fname)
    contacts = ContactMap(traj[0])
    (fig, ax) = contacts.residue_contacts.plot(cmap='seismic', vmin=-1, vmax=1)
    plt.xlabel("Residue")
    plt.ylabel("Residue")

    figname = os.path.splitext(fname)[0] + '.png'
    plt.savefig(figname, bbox_inches='tight')
    plt.show()

    return contacts

contacts1 = map_contacts(sys.argv[1])
contacts2 = map_contacts(sys.argv[2])

diff = contacts1 - contacts2
diff.residue_contacts.plot(cmap='seismic', vmin=-1, vmax=1)

plt.savefig('diff.png', bbox_inches='tight')
plt.show()

diff_residues = diff.residue_contacts.most_common()

print('\nMOST POSITIVE VALUES FOR {} - {}'.format(sys.argv[1], sys.argv[2]))
print(diff_residues[:10])

print('\nMOST NEGATIVE VALUES FOR {} - {}'.format(sys.argv[1], sys.argv[2]))
print(diff_residues[:-10:-1])
