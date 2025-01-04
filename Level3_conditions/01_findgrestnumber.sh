#!/bin/bash

read -p "enter the value of a: " a
read -p "enter the value of b: " b

if [ $a -gt $b ]; then
    echo "$a is greatest in the given number"
    else
    echo "$b is is greatest in the given number"
fi

: '
output:
enter the value of a: 10
enter the value of b: 50
50 is is greatest in the given number

enter the value of a: 9
enter the value of b: 5
9 is greatest in the given number
'

