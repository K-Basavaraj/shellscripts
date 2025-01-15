#!/bin/bash

# Define color codes
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Reset

: '
Display top 5 frequently repeated words
Write a script that reads a text file and counts the occurrences of each word, 
display the top 5 most frequent words.
'

DIR="/home/ec2-user/user_folder/"
mkdir -p $DIR 

FILE="$DIR/message.txt"
touch "$FILE"

# Check if the file exists, if not, exit the script
if [[ ! -f "$FILE" ]]; then
  echo -e "$R File does not exist, exiting script.$N"
  exit 1
fi

# Prompt the user for input and overwrite the file
echo -n "Enter your message: "
read -r MESSAGE

echo "$MESSAGE" > "$FILE" # Overwrite the file with the new input

# Read the file and process its content
echo -e "$Y Top 5 most frequent words:$N"

# Process the content of the message.txt file
tr -s '[:space:][:punct:]' '\n' < "$FILE" | tr '[:upper:]' '[:lower:]' |  # Convert words to lines and convert to lowercase.
sort | uniq -c |                                                           # Sort words and count occurrences
sort -nr | head -n 5                                                      # Sort numerically in reverse and display top 5

# End message
echo -e "$G Script executed succes $N"

: '
Enter your message: The quick brown fox jumps over the lazy dog. The fox is quick and the dog is sleepy.
 Top 5 most frequent words:
      4 the
      2 quick
      2 is
      2 fox
      2 dog
 Script executed succes
'