#/bin/bash 

DISK_USAGE_DETAILS=$(df -hT)
echo -e "this is the Result:\n '$DISK_USAGE_DETAILS'"

read -p "Please Enter the Type/field you need: " TYPE 

#read -p "Please Enter the threshold value to check Health" DISK_THRESHOLD

DISK_USAGE=$(echo "$DISK_USAGE_DETAILS"| grep $TYPE)

# echo -e "Filtered Result:\n$DISK_USAGE"