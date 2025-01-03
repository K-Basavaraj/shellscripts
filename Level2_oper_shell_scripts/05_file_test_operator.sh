#!/bin/bash

#-e	Checks if the file exists
file=$1
[ -e $file ] && echo "File exists" || echo "File does not exist"

#-d	Checks if it is a directory
folder=$2
[ -d $folder ] && echo "Folder exists" || echo "Folder does not exist"

#Check if a File is Readable
[ -r $file ] && echo "File is readable" || echo "File is not readable"
