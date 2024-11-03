#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

: '
Display top 5 frequntly repeated words
Write a script that reads a text file and counts the occurrences of each word, display the top 5 most frequent 
words along with their counts.
'

# which directory
SOURCE_DIR=/home/ec2-user/applog

# is that directory exists?
if [ -d $SOURCE_DIR ]; then
    echo -e "$SOURCE_DIR $G Exist $N"
else
    echo -e "$SOURCE_DIR $R Does not Exist $N"
    exit 1
fi

# find the files
FILES=$(find "$SOURCE_DIR" -name "*.txt")
echo "Files: $FILES"

# Loop through each file found
for file in $FILES; do

tr -c '[:alnum:]' '[\n*]' < "$file" | tr '[:upper:]' '[:lower:]' |  # Replace non-alphanumeric characters with newlines and convert to lowercase.
sort | uniq -c |                                                     #Sort words and # Count occurrences
sort -nr | head -n 5                                                 # Sort numerically in reverse Display top 5

done


# # grep -v '^$' |                               # Remove empty lines
# # sort |                                       # Sort words
# uniq -c |                                    # Count occurrences
# sort -nr |                                   # Sort numerically in reverse
# head -n 5                                    # Display top 5
# done

: '
sort: Sorts the words alphabetically.

uniq -c: Counts occurrences of each unique word and prefixes the count.

sort -nr: Sorts the output numerically in reverse order (highest count first).

head -n 5: Displays the top 5 lines from the sorted output.
'