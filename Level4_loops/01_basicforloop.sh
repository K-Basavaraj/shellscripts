#!/bin/bash
: '
Test Conditions: Use [ ]
Purpose: Tests string, file, or arithmetic conditions.
Operators: Use -eq, -ne, -lt, -le, -gt, -ge for numbers.

Arithmetic Evaluation: Use (( ))
Purpose: Performs arithmetic operations and comparisons.
Operators: Use arithmetic operators like +, -, *, /, %, ==, !=, <, >, <=, >=.
'

#write a script to print  the natural numbers using for loop.
for i in {1..100}; do
    echo $i
done

#Your task is to use for loops to display only odd natural numbers from  1 to 99
for i in {1..100}; do
    if [ $((i % 2)) -ne 0 ]; then # or you can use like this if (( i % 2 != 0))
        echo $i
    fi
done

#Your task is to use for loops to display only even natural numbers from  1 to 99
num=2
for i in {1..100}; do
    if (( i % num == 0 )); then 
        echo -n "$i "
    fi
done

#Print Even Numbers from 1 to 20
for ((i=2; i<=20; i+=2))
do
  echo "Even Number: $i"
done


