#!/bin/bash

read -p "Enter the FirstNumber: " Number1
read -p "Enter the SecondNumber: " Number2

if [ $Number1 -gt $Number2 ]; then
    echo "FirstNumber:$Number1 is greter than SecondNumber:$Number2"
elif [ $Number1 -eq $Number2 ]; then
    echo "FirstNumber:$Number1 is equal to SecondNumber:$Number2"
else
    echo "FirstNumber:$Number1 is less than SecondNumber:$Number2"
fi
