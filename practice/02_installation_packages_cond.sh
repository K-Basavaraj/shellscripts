#!/bin/bash

USER_ID=$(id -u)

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo "please execute the script with root privilages.."
        exit 1
    fi
}

#calling function
CHECK_ROOT

#Validate wethere package is exist or not
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo "$2 is not listed in this server..."
        exit 1 
    else
        echo "$2 is SUCESSFULLy Installed.."
    fi
}

dnf list installed nginx
if [ $? -ne 0 ]; then
    echo "Nginx is not installed, going to install it.."
    dnf install nginx -y
    validate $? "Nginx"  ##here i am calling the function 
else
    echo "Nginx is already installed nothing to do.."
fi