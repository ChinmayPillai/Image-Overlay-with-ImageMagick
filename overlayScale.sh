#!/usr/bin/bash


Help(){

	echo "Use this package with the following arguments"
	echo "-r: Specify the region where the watermark must be overlayed. Options: NorthWest, North, NorthEast, West, Center, East, SouthWest, South, SouthEast"
	echo "-h: Horizontal Offset of watermark"
	echo "-v: Vertica Offset of watermark"
	echo "-w: Watermark image path"
	echo "-i: Image path"
	echo "-o: Output image path"
	exit 1
}


while getopts :r:h:v:w:i:o: opt; do
	case $opt in
		r) region=$OPTARG;;
		h) hor_off=$OPTARG;;
		v) ver_off=$OPTARG;;
		w) watermark=$OPTARG;;
		i) image=$OPTARG;;
		o) output=$OPTARG;;
		?) Help;;
	esac
done


if [[ $# -ne 12 ]];then
	Help
fi


COMPOSITE=/usr/bin/composite
$COMPOSITE -gravity $region -geometry +$hor_off+$ver_off $watermark $image $output
