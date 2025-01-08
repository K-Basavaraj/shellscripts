#!/bin/bash
#we need use -e when colors are used
R="\e[31m"
G="\e[32m"
N="\e[0m"

USER_ID=$((id - u))

CHECK_ROOT() {
    if [ $USER_ID -ne 0 ]; then
        echo "please run the script with root privilages"
        exit 1
    fi
}

validate() {
    if [ $1 -ne 0 ]; then
        echo "$2 is FAILED.. checkit."
        exit 1
    else
        echo "$2 is SUCESSFULL.."
    fi
}

validate_installation() {
    if [ $1 -ne 0 ]; then
        echo -e "$R $2 is not installed..$N  $Y going to install it..$N"
    else
        echo -e "$G $2 is already installed nothing to do.."
    fi

}


CHECK_ROOT

for package in $@; do
    dnf list installed $package
    validate_installation $? "$package"

    dnf install $package -y
    validate $? "Installing $package"
done


