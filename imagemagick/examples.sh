#!/bin/bash
echo "Check which fonts are available"
convert -list font | grep Font

# Loop through the numbers from 1 to 100
for i in $(seq 1 100); do
  # Draw the number in black on transparent canvas 200 wide by 120 high
  convert  -size 200x120 \
            canvas:transparent \
            -font Helvetica \
            -pointsize 96 \
            -fill black \
            -gravity center  \
            -annotate 0 "$i" \
            $(printf "%03d" $i).gif
done

# create animated gif using ffmpeg
# not working. Maybe only works if input images are png
#ffmpeg -framerate 10  -i '%d.gif' -loop 0 ffmpeg.gif
# ffmpeg -pattern_type glob -i '*.gif' ffmpeg.gif
#ffmpeg -i './%03d.gif' ffmpeg.gif

#            -draw "text 20,0 '$i'" \
# create animated gif with a delay in hundreths of a second between each frame. Loop is number of time to loop. 0 is infinite. 
# -options must be before input files !!!
# -dispose previous removes the previous frame since we are dealing with transparent input images

#create animated gif using imagemagick convert
convert -delay 10 -loop 0 -dispose previous *.gif animated.gif

#create montage gif setting tile size to 20x12 and not resizing images smaller than 20x12. no offsets
montage {001..100}.gif -geometry 20x12\>+0+0 montage.gif

echo "Cleanup intermediate files"
for i in $(seq 1 100); do
  rm $(printf "%03d" $i).gif
done

# Display montage gif in a nonblocking way
#display montage.gif &
display montage.gif 

# Display the animated gif
animate animated.gif


