#!/bin/bash

#-e	Checks if the file exists
file=myfile.txt
[ -e $file ] && echo "File exists" || echo "File does not exist"

#-d	Checks if it is a directory
folder=myfolder
[ -e $folder ] && echo "File exists" || echo "File does not exist"