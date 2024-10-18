#!/bin/bash

#User Authentication
#Task: Create a simple user authentication script that checks a username and password.

read -p "please enter your username: " Username
read -sp "please enter you password: " password

if [ $Username == "admin" ] && [ $password == "password123" ]; then
    echo "Access granted."
else
    echo "Access denied."
fi
