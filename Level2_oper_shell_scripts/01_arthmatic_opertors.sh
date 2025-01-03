#!/bin/bash

read -p "Enter the first num: " a
read -p "Enter the second num: " b 

sum=$((a + b))
sub=$((a - b))
mul=$((a * b))
div=$((a / b))
mod=$((a % b))

echo "addition of given two numbers is: $sum"
echo "subsctraction given two numbers is: $sub"
echo "multiplication of two numbers is: $mul"
echo "division of two numbers is: $div"
echo "modulas of given two numbers is: $mod"

: '
output: 
Enter the first num: 5
Enter the second num: 5
addition of given two numbers is: 10
subsctraction given two numbers is: 0
multiplication of two numbers is: 25
division of two numbers is: 1
modulas of given two numbers is: 0
'
#=================================================================================================================

#Increment Operator (++): Unary operator used to increase the value of operand by one.
#Decrement Operator (--): Unary operator used to decrease the value of a operand by one.

read -p "enter the value of c : " c
read -p "enter the value of d : " d

sum=$((c + d))
echo "the sum of two number is: $sum"
((++c))
((--d))
echo "Increment operator when applied on $c results into a :" "${c}"
echo "decrement operator when applied on $d results into a: " "${d}"

: ' 
output:
enter the value of c : 5
enter the value of d : 9
the sum of two number is: 14
Increment operator when applied on 6 results into a : 6
decrement operator when applied on 8 results into a:  8
'
#==========================================================================================================================
