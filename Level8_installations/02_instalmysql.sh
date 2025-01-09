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

: '
running the script: sudo sh 02_installmysql.sh 
output: 
Error: No matching Packages to list
mysql is not installed going to install..
Last metadata expiration check: 0:29:52 ago on Mon Jan  6 16:46:11 2025...installing..
Complete!
mysql is installed sucessfully..

running the script 2nd time: sudo sh 02_installmysql.sh
output: 
Installed Packages
mysql.x86_64      8.0.36-1.el9_3                                                     @rhel-9-appstream-rhui-rpms
mysql is already installed nothing to do..
'


