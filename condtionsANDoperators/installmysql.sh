#!/bin/bash
: '
install mysql through shell script
 1. check the user has root access or not
 2. if root access, proceed with the script
 3. otherwise through the error
 4. check already installed or not, if installed tell the user it is already insalled
 5. if not installed, install it
 6. check it is success or not
'

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]; then
    echo "mysql is not installed, going to install it.."
    dnf install mysql -y
    if [ $? -ne 0 ]; then
        echo "mysql installation is not success.. Check it."
        exit 1
    else
        echo "mysql installation is success.."
    fi
else
    echo "mysql is already installed nothing to do.."
fi