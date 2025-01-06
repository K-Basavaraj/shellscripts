#!/bin/bash

#write a script to print  the natural numbers using while loop.
n=1
while [ $n -le 100 ]; do
    echo -n "$n "
    ((n++))
done
echo -e "\n Here natural numbers end outof the loop..\n"

#write a script to print only even numbers using while loop
a=2
while [ $a -le 100 ]; do
    echo -n "$a "
    ((a += 2))
done
echo -e "\nHere even number end out of the loop..\n" 

#write a script to print only even numbers using while loop
b=1
while [ $b -le 100 ]; do
    echo -n "$b "
    ((b += 2))
done
echo -e "\n Here odd number end out of the loop..\n" 

#print 1st 100 natural numbers in reverse 
n=100
while [ $n -ge 1 ]; do
    echo -n "$n "
    ((n--))
done
echo -e "\n Here natural numbers are in reverse end outof the loop..\n"

#print upto the given range.
z=7
while [ $z -gt 4 ];
do
    echo $z
    ((z--))
done
echo “Out of the loop”

#Break statement in While Loop
i=1
while :
do
    echo $i
    if [ $i -eq 20 ]; then
        echo “This is the end of the loop”
        break #the break statement is used to get the control flow of a script from inside a while loop to break out of the loop without the loop condition evaluating to false.
    fi
    ((i++))
done
# The break only happens when the condition [ $i -eq 20 ] is true.
# Until that condition is true, the loop runs normally.



#continue statemnt in while loop
c=1
while [ $c -lt 30 ];
do
    ((c++))
    if [[ $(( $c % 5 )) -ne 0 ]];
    then
        continue
    fi
    echo $c
done
: '
output: 
5
10
15
20
25
30
'


count=1
while [ $count -le 5 ]; do
    echo "Count is: $count"
    count=$((count + 1))  # Increment count
done