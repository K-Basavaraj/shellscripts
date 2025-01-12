#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"


: '
crontab is used to schedule the scripts periodically every minute or every week or everyday etc; 
crontab -e 
tail -f /var/log/cron #display the running scripts log
'
# which directory
SOURCE_DIR=/home/ec2-user/logs

# is that directory exists?
if [ -d $SOURCE_DIR ]; then
    echo -e "$SOURCE_DIR $G Exist $N"
else
    echo -e "$SOURCE_DIR $R Does not Exist $N"
    exit 1
fi

# find the files
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)
echo "Files: $FILES"

# delete the files which are old one by one for that we use loop
while IFS= read -r file; do ##IFS,internal field seperatpor, empty it will ignore while space.-r is for not to ingore special charecters like /
    echo "Deleting file: $file"
    rm -rf $file
done <<<$FILES
