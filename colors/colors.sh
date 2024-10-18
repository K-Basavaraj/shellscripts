#!/bin/bash
USER_ID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT() {
if [ $USER_ID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1
fi
}

validate() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is $R not success.. Check it.$N"
    else
        echo -e "$2 is $G Sucessfull...$N"
    fi
}

CHECK_ROOT

dnf list installed mysql
if [ $? -ne 0 ]; then
    echo "mysql is not installed..going to install it.."
    dnf install mysql -y
    validate $? "Installing mysql" #here also i am calling validaing function again
else
    echo -e "$G Mysql is already installed nothing to do.."
fi