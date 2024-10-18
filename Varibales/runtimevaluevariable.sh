#!/bin/bash

#write a script that providing a varible values at runtime.
# 1. inside the script
# 2. pass from outside through args
# 3. Enter at runtime

FirstPerson=$1, SecondPerson=$2

echo "$FirstPerson: Hi $SecondPerson, How are you?"
echo "$SecondPerson: Hello $FirstPerson. I am fine. How are you doing?"
echo "$FirstPerson: I am doing good $SecondPerson. What's going on?"
echo "$SecondPerson: I started learning Shell Script $FirstPerson"

#example of command "sh runtimevaluevariable.sh praveen Kumari" 
# we can call it as arguments/args/inputs praveen Kumari