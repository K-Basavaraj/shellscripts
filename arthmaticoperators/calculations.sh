#!/bin/bash
echo -e "  Please provide only numercal values other wise you will get syntax error\n---------------------------------------------------------------------------\n "
                                                                                     
echo -e "  For addition\n--------------------------------------"

echo -n "Enter the first value: "
read a
echo -n "Enter the second value: "
read b
sum=$((a + b))
echo -e "you addition of two numbers is: $sum \n--------------------------------------\n "

echo -e "  For Substraction\n--------------------------------------" 
echo -n "Enter the first value: "
read a
echo -n "Enter the second value: "
read b
sub=$((a - b))
echo -e "you subsctraction of two numbers is: $sub \n--------------------------------------\n "

echo -e "  For Multiplation\n--------------------------------------"
echo -n "Enter the first value: "
read a
echo -n "Enter the second value: "
read b
mul=$((a * b))
echo -e "you multiplation of two numbers is: $mul \n--------------------------------------\n "

echo -e "  For Division\n--------------------------------------"
echo -n "Enter the first value: "
read a
echo -n "Enter the second value: "
read b
div=$((a / b))
echo -e "you multiplation of two numbers is: $div \n--------------------------------------\n "

echo -e "  For modulus\n--------------------------------------"
echo -n " Enter the First Value: "
read a 
echo -n " Enter the second Value: "
read b
mod=$((a%b))
echo -e "your percantege of given numbers is: $mod \n--------------------------------------\n "