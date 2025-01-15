#!/bin/bash

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