#!/bin/bash

USER_ID=$(id -u)

: '
you calso keep this checking root user in a function also 
CHECK_ROOT() {
if [ $USER_ID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1
fi
}

'

if [ $USER_ID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1
fi
# CHECK_ROOT

validate() {
    if [ $1 -ne 0 ]; then
        echo "$2 is not success.. Check it."
    else
        echo "$2 is Sucessfull..."
    fi
}

dnf list installed git
if [ $? -ne 0 ]; then
    echo "Git is not installed.. going to install it.."
    dnf install git -y
    validate $? "Installing Git"  # here i am calling validate function insted of Nested block in the condition concept

else
    echo "Git is already installed nothing to do.."
fi


dnf list installed mysql
if [ $? -ne 0 ]; then
    echo "mysql is not installed..going to install it.."
    dnf install mysql -y
    validate $? "Installing mysql" #here also i am calling validaing function again
else
    echo "Mysql is already installed nothing to do.."
fi
