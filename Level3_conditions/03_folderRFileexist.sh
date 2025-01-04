# Note: In this code, it works fine if you give two arguments. 
# But if you provide only one argument, it will not work properly. 
# To handle this, we need to always add a condition for argument validation, 
# which you can see implemented in this script.


#!/bin/bash

DIRECTORY=$1   # Assigning the first command-line argument to DIRECTORY (directory path)
FILE=$2        # Assigning the second command-line argument to FILE (file path)

# Check directory
if [ -d $DIRECTORY ]; then
    echo "$DIRECTORY Exist.."
else
    echo "$DIRECTORY does not exist...Please check"
fi

# Check file
if [ -f $FILE ]; then
    echo "$FILE Exist..."
else
    echo "$FILE does not exist...Please check"
fi

: '
output: 
sh 02_filefolderexitornot.sh /home/ec2-user/myfolder/ /home/ec2-user/myfolder/myfile.txt
/home/ec2-user/myfolder/ Exist..
/home/ec2-user/myfolder/myfile.txt Exist...

sh 02_filefolderexitornot.sh /home/ec2-user/myfolder1/ /home/ec2-user/myfolder/myfile1.txt
/home/ec2-user/myfolder1/ does not exist...Please check
/home/ec2-user/myfolder/myfile1.txt does not exist...Please check
'