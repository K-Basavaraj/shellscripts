#!/bin/bash

: '
#varibale name and assigned a name to it 
#VAR_NAME=VALUE (no space between name, equal and value)
'
MyVar=555
echo $MyVar

: '
# Notice that double quotes still allow the parsing of variables, whereas single quotes prevent 
# this also gives 555 as output 
# '
MyVar=555
echo "$MyVar"

#here output is $MyVar 
MyVar=555
echo '$MyVar'

: '
Note:
  Use double quotes when you want to include variable values in the output.
  Use single quotes when you want to treat the variable name as a plain string.
'

city=Banglore
echo "I am in $city today."

