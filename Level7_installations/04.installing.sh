#!/bin/bash
USER_ID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

    if [ $USER_ID -ne 0 ]; then
        echo "please run the script with root privilages"
        exit 1
    fi

validate() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 is $R not success.. Check it.$N"
    else
        echo -e "$2 is $G Sucessfull...$N"
    fi
}

: '
# sh installing.sh git mysql postfix nginx  like this way we can pass argumnets.
for packages in $@; do # $@ which is a sepecial varible  refers to all arguments passed to it
    echo $packages
done
'

# sh installing.sh git mysql postfix nginx  like this way we can pass argumnets.

for package in $@; do # $@ which is a sepecial varible  refers to all arguments passed to it
    dnf list installed $package
    if [ $? -ne 0 ]; then
        echo -e "$R $package is not installed..$N  $Y going to install it..$N"
        dnf install $package -y
        validate $? "Installing $package" # here i am calling validate function insted of Nested block in the condition concept
    else
        echo -e "$G $package is already installed nothing to do.."
    fi
done
