#!/bin/bash

credentials() {

    if [[ "$username" == "admin" &&  "$password" == "password123" ]]; then
        echo "access granted"
    else
        echo "access denied"
    fi
}

read -p "please enter your username: " username
read -sp "please enter you password: " password
echo # To move to the next line after password input

credentials "$1" "$2"




