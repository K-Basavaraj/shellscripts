#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo -e "$R please run the script with root privileges$N"
        exit 1
    fi
}

#calling function
CHECK_ROOT

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo "$2 is Failed.. please check it.."
        exit 1
    else
        echo "$2 is SUcess.."
    fi
}

for package in $@; do
    dnf list install $package
    if [ $? -ne 0 ]; then
        echo -e "$R $package is not installed..$N $Y going to install it..$N"
        dnf install $package -y
        VALIDATE $? "$package"
    else
        echo -e "$G $package is already installed nothing to do.."
    fi
done