#!/bin/bash

credentials() {
    if [ $Username == "admin" ] && [ $password == "Password@123" ]; then
        echo "access granted"
    else
        echo "access denied"
    fi
}


read -p "Enter your username: " Username
read -sp "Enter your password: " password

credentials "$1" "$2"