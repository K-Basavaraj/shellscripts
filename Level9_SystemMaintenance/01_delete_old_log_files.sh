#/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"

#write a script to delete only .log files which are older than 14 days
: '
#1) finding .log files and days 
find . -name "*.log"            # Find all .log files in the current directory and its subdirectories.
find . -name "*.log" -mtime +14 # Find all .log files that have been modified more than 14 days ago.
# Find all .log files that have been modified more than 14 days ago 
# and list their details using ls -lrt. [ find . -name "*.log" -mtime +14 -exec ls -lrt {} \; ]

#2) In which directory we need to delete?
#3) Check is that Directory exist?
#4) if yes, find the .log files and delete 
#5) if no exit or print message.
'
# Function to check if the directory exists
directory() {
    if [ -d "$1" ]; then
        echo -e "$G $1  Exists $N"
    else
        echo -e "$R $1 Does not Exist $N"
        exit 1
    fi
}


# for crontab purpose dinamically given this path 
SOURCE_DIR=/home/ec2-user/logs

# # Prompt for source directory input
# read -p "Please enter the source Directory: " SOURCE_DIR 

# Check if the directory exists
directory "$SOURCE_DIR"

# find the files
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo -e "Files: \n$FILES"


# delete the files which are old one by one for that we use loop
while IFS= read -r file; do ##IFS,internal field seperatpor, empty it will ignore while space.                                       -r is for not to ingore special charecters like /
    echo "Deleting file: $file"
    rm -rf $file
done <<<$FILES