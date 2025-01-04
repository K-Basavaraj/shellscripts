#!/bin/bash
: '
we will determine the type of triangle using these conditions:

Scalene: A triangle where every side is different in length.
Isosceles: A triangle where 2 sides are equal.
Equilateral: A triangle where all sides are equal.
'

read -p "enter the length of the tringle a: " a
read -p "enter the length of the tringle b: " b
read -p "enter the length of the tringl  c: " c

if [ $a == $b ] && [ $b == $c ] && [ $a == $c ]; then
    echo "IT's A EQUILATERAL triangle where all sides are equal"
elif [ "$a" == "$b" ] || [ "$b" == "$c" ] || [ "$c" == "$a" ]; then
    echo "IT'S A ISOSCELES traingle where 2 sides are equal"
else
    echo "Its a SCALANE traingle where every side is different leagth"
fi