
import transformations
import numpy as np

m = [[-0.527004599571228, 0.8498613238334656, -0.0013752640224993229, 88.9829330444336], [0.849862277507782, 0.5270028710365295, -0.0014456979697570205, 32.7724609375], [-0.0005038746749050915, -0.0019306744216009974, -0.9999980330467224, 186.9623260498047], [0.0, 0.0, 0.0, 1.0]]

print('\nThe input transformation matrix is:\n{}\n'.format(np.matrix(m)))

scale, shear, angles, translate, perspective = transformations.decompose_matrix(m)

print('scale:\n{}\n'.format(scale))
print('shear:\n{}\n'.format(shear))
print('angles:\n{}\n'.format(angles))
print('translate:\n{}\n'.format(translate))
print('perspective:\n{}\n'.format(perspective))
