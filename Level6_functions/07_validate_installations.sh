#!/bin/bash

USER_ID=$(id - u)

if [ $USER_ID -ne 0 ]; then
    echo "pleasse run the script with root privilages"
    exit 1
fi

validate() {
    if [ $1 -ne 0 ]; then
        echo "$2 is.. FAILED"
        exit 1
    else
        echo "$2 is.. SUCESS"
    fi
}

dnf list installed git
validate $? "Listing Git" #here passing two arguments.

: '
First Argument ($1): The exit status from the previous command (dnf list installed git).
 This will be 0 if the command succeeded or a non-zero value if it failed.
Second Argument ($2): The string "Listing Git".
'

: '
output: 
Installed Packages
git.x86_64                                          2.43.5-1.el9_4                                          @rhel-9-appstream-rhui-rpms
Listing Git is.. SUCCESS
'