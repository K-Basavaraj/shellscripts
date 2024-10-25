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

  # Declare an associative array to hold word counts
    declare -A word_count

    # Read the file and count words
    while read -r word; do
        # Convert to lowercase and increment count
        word=$(echo "$word" | tr '[:upper:]' '[:lower:]')
        ((word_count["$word"]++))
    done < <(tr -c '[:alnum:]' '[\n*]' < "$file")

    # Display the top 5 most frequent words for this file
    echo -e "$G Top 5 words in $file:$N"
    for word in "${!word_count[@]}"; do
        echo "${word_count[$word]} $word"
    done | sort -nr | head -n 5
done