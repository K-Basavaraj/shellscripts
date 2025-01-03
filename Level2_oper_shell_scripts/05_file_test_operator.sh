#!/bin/bash

#-e	Checks if the file exists
file=$1
[ -e $file ] && echo "File exists" || echo "File does not exist"

#-d	Checks if it is a directory
folder=$2
[ -d $folder ] && echo "Folder exists" || echo "Folder does not exist"

#Check if a File is Readable
[ -r $file ] && echo "File is readable" || echo "File is not readable"

: '
 sh 05_file_test_operator.sh /home/ec2-user/myfile.txt /home/ec2-user/myfolder
File exists
Folder exists
File is readable

Note: 
-x, -w This operator check whether the given file has execute access, write access or not. 
If it has execute access, write access then it returns true otherwise false.
-s operator: This operator checks the size of the given file. 
If the size of given file is greater than 0 then it returns true otherwise it is false.
'