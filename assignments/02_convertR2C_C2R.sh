#!/bin/bash

: '
Convert Rows to Columns, Columns to Rows
Given a text file file.txt, transpose its content.

You may assume that each row has the same number of columns, and each field is separated by the space.

Convert Rows into Columns and Columns into Rows
input: 
1 2 
3 4
5 6 
output: 
1 2 3 
4 5 6
'

# Directory setup
DIR="/home/ec2-user/user_folder/"
mkdir -p $DIR

# File path setup
FILE="$DIR/message.txt"
touch "$FILE"

# Check if the file exists, if not, exit the script
if [[ ! -f "$FILE" ]]; then
  echo -e "$R File does not exist, exiting script.$N"
  exit 1
fi

# Prompt the user for input and capture multiple lines
echo "Enter the data (multiple lines, press Ctrl+D when done):"
cat > "$FILE"

# Transpose the contents of the file (rows to columns, columns to rows)
echo "Transposed content: "
awk '{ for (i=1; i<=NF; i++) a[i]= (a[i]? a[i] FS $i: $i) } END{ for (i in a) print a[i] }' $FILE