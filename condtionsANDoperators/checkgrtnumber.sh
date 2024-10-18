#!/bin/bash

: ' 
senario
1. get the numbr from userinput
2. check it is greater than 20 or not
3. print number greater than 20, if it is greater than 20
4. otherwise print less than 20
'

read -p "Enter the FirstNumber: " Number1
read -p  "Enter the SecondNumber: " Number2

if [ $Number1 -gt $Number2 ]; then
    echo "Number:$Number1 is greter than $Number2"
else
    echo "Number:$Number1 is less than $Number2"
fi