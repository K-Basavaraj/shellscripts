#!/bin/bash

# echo -n "please enter your first number: "
# read a

# echo -n "please enter your second number: "
# read b

# SUM=$((a + b))
# echo -n "your sum of two number is: $SUM"

#now we can reduce the size of code using  by directly assigned to a variable to read command

read -p "enter your first number: " a
read -p "enter your second number: " b
: '
c=$((a+b))  # why here two brackets?
 means -> inside bracket is for addition opertion and the
 -> outer brackets is used in shell script at run time  it will execute it and send the output to the varible.
'
#sum=$(expr $a + $b)
let sum=a+b  #let command to perform arithmetic operations:
echo -n "your sum of two number is: $sum"