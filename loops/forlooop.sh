#!/bin/bash

#basics
for i in 1 2 3 4 5 6 7 8 9 10; do
    echo $i #in a column formate
    #echo -n " $i " #in a row formate
done

#as above one its not a good practice insted in shell
for i in {11..20}; do #which means {start..end}
    echo $i
done

