#!/bin/bash

USER_ID=$((id -u))

: '
you calso keep this checking root user in a function also 
CHECK_ROOT() {
if [ $USER_ID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1
fi
}
'

validate() {
    if [ $1 -ne 0 ]; then
        echo "$2 is FAILED.. checkit."
        exit 1
    else
        echo "$2 is SUCESSFULL.."
    fi
}

dnf list installed git
validate $? "Listing Git"

if [ $? -ne 0 ]; then
    echo "Git is not installed, going to install it.."
    dnf install git -y
    validate $? "Installing Git"  # here i am calling validate function insted of Nested block in the condition concept
else
    echo "Git is already installed nothing to do.."
fi

dnf list installed mysql
validate $? "Listing mysql"

if [ $? -ne 0 ]; then
    echo "Mysql is not installed, going to install it.."
    dnf install mysql -y
    validate $? "Installing mysql"    # here i am calling validate function insted of Nested block in the condition concept
else
    echo "Mysql is already installed nothing to do.."
fi
