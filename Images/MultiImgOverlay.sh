#!/usr/bin/env bash


helpFunction()
{
   echo ""
   echo "Usage:"
   echo ""
   echo "$0 -l <overlay_image> -p <position_of_overlay> -h <horizontal_ofset>"
   echo "\t-v <vertical_ofset> <bottom_image_1> <bottom_image_2 ..."
   echo -e "Can have multiple input(bottom images)."
   echo -e "\t-p The possible positions are:  NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast"
   echo -e "\t-h Put 0 if no offset needed"
   echo -e "\t-v Put 0 if no offset needed"
   echo ""
   echo "Run with any arguments for help"
   exit 1 # Exit script after printing help
}


while getopts l:p:h:v: flag
do
    case "${flag}" in
        l) ov_im=${OPTARG};;
        p) position=${OPTARG};;
        h) hor_of=${OPTARG};;
        v) ver_of=${OPTARG};;
        ?) helpFunction ;;
    esac

done


if [ -z "$position" ] || [ -z "$hor_of" ] || [ -z "$ver_of" ] || [ -z "$ov_im" ]
then
   echo "Some or all of the parameters are empty"
   helpFunction
fi


i=1 #after 8, so $9 onwards are the input
for img in "$@" 
do
    if [ $i -gt 8 ]
    then
        if [ -z $img ]
            then 
            echo "No input images given"
            helpFunction
        fi
    out_im=$i"_out.jpg"
    new_name="${img%.*}"
    extension="${img##*.}"
    new_out=$new_name"_scale."$extension
    COMPOSITE=/usr/bin/composite
    $COMPOSITE -gravity $position -geometry +$hor_of+$ver_of $ov_im $img $new_out
    fi
    i=$((i + 1));
done
