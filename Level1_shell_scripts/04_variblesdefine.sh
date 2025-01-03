#!/bin/bash

city=Banglore
echo "I am in $city today." #here output is I am in Banglore today.

: '
Note:
  Use double quotes when you want to include variable values in the output.
  Use single quotes when you want to treat the variable name as a plain string.
'
MyVar=555
echo $MyVar #here output is 555

MyVar=555
echo '$MyVar' #here output is $MyVar 

Var=555
echo "$Var" #here output is 555

varx=Dumb; vary=do
echo "${varx}le${vary}re." #here output is Dumledor
