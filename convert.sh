#!/bin/bash
# 2022 Elise Willar
# Requires FFMPEG to be installed.

#Replace with your directory
directory=~/Desktop/files/

for d in $directory* ; do
    
    cd $directory
    
    cd $d

    for i in *.mp4; do 

        
        format=$(ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=nokey=1:noprint_wrappers=1 "$i")
        
        if [ "$format" = "h264" ]; then
                ffmpeg -y -i "$i" -c:v libx265 -vtag hvc1 -c:a copy "processing-$i"; 
                rm "$i"
                mv "processing-$i" "${i%.*}-h265.mp4"
        else
            echo "File already h265"
            continue
        fi

    done
done
