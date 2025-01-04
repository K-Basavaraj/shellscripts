#!/bin/bash

#User Authentication
#Task: Create a simple user authentication script that checks a username and password.

read -p "Enter your username: " Username
read -sp "Enter your password: " password

if [ $Username == "admin" ] && [ $password == "Password@123" ]; then
    echo "access granted"
else
    echo "access denied"
fi
