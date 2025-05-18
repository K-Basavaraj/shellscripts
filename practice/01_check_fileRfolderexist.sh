#!/bin/bash 

DIRECTORY=$1
FILE=$2

if [ $# -lt 2 ]; then 
 echo "Error: you must provide both a dir and a file as argument.."
 echo "Usage: $0 <directory_path> <file_path>" 
 exit 1
fi

if [ -d $DIRECTORY ]; then 
 echo "$DIRECTORY exist.." 
else 
 echo "$DIRECTORY Destnt exist.." 
fi 

if [ -f $FILE ]; then 
 echo "$FILE exist.."
else 
 eho "$FILE Doesnt exist.."
fi 
