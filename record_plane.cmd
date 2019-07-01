# this is a script to open in chimera after structure is loaded

set projection orthographic

volume #0 planes z,55
movie record
volume #0 planes z,0,205
wait 220
movie stop
movie encode output planes.mov bitrate 10000
