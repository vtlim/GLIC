
import transformations
import numpy as np

m = [\
[0.6367010474205017, 0.7711036205291748, -0.0033135463017970324, 36.229270935058594],\
[0.7709313631057739, -0.6366397142410278, -0.018834583461284637, 104.86688995361328], \
[-0.01663294993340969, 0.009437481872737408, -0.9998171329498291, 191.3174285888672],\
[0.0, 0.0, 0.0, 1.0]]

print('\nThe input transformation matrix is:\n{}\n'.format(np.matrix(m)))

scale, shear, angles, translate, perspective = transformations.decompose_matrix(m)

print('scale:\n{}\n'.format(scale))
print('shear:\n{}\n'.format(shear))
print('angles:\n{}\n'.format(angles))
print('translate:\n{}\n'.format(translate))
print('perspective:\n{}\n'.format(perspective))
