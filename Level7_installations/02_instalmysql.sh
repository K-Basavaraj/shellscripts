#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "please run the script with root privilages.."
    exit 1
fi

#check wethere the mysql is installed or not
dnf list installed mysql

if [ $? -ne 0 ]; then
    echo "mysql is not installed going to install.."
    dnf install mysql -y
    if [ $? -ne 0 ]; then
        echo "mysql installation is not success.. Check it."
        exit 1
    else
        echo "mysql is installed sucessfully.."
    fi
else
    echo "mysql is already installed nothing to do.."
fi
