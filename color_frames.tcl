##
## Usage:
##  1) Edit frame numbers in the for loop sections
##  2) Increment the number after "set user" consecutively
##  3) Edit the last number of "scaleminmax" to highest "user" value
##  4) In an open VMD session where traj is mol ID 0, call "source color_frames.tcl"
##
## Adapted from: https://www.ks.uiuc.edu/Research/vmd/mailing_list/vmd-l/att-2493/usercolor.vmd
##
set sel [atomselect top "all"]

##
## Color each trajectory section by setting the user value on $sel.
##

#set numframes [molinfo top get numframes]
# COLOR CHUNK 1
for {set i 0} {$i<12} {incr i} {
  animate goto $i
  $sel frame $i
  puts "Setting User data for frame [$sel frame] ..."
  $sel set user 0
}

# COLOR CHUNK 2
for {set i 12} {$i<63} {incr i} {
  animate goto $i
  $sel frame $i
  puts "Setting User data for frame [$sel frame] ..."
  $sel set user 1
}

# COLOR CHUNK 3
for {set i 63} {$i<85} {incr i} {
  animate goto $i
  $sel frame $i
  puts "Setting User data for frame [$sel frame] ..."
  $sel set user 2
}
$sel delete

##
## change the "color by" and "trajectory" tab settings so that
## the new color values, and start it animating...
##
mol modcolor 0 0 User
mol colupdate 0 0 1
#mol scaleminmax 0 0 0.0 $numframes
mol scaleminmax 0 0 0.0 2.0
animate forward

