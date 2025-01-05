#!/bin/bash

# **Definition of Variables:**
# A variable in shell scripting is a placeholder used to store data, such as text or numbers.
# Variables are created by assigning a value to a name. No special keyword is needed.
# Variables are local to the shell session by default and accessible only within the session where they are created.



CITY=Banglore
echo "I am in $CITY today." #here output is I am in Banglore today.

CITY=Hyderabad
echo "I am in $CITY today." #here output is I am in Hyderabad today.

: '
Note: in the above declared varible override the 1st value CITY set to Bangalore. 
When you reassign it to Hyderabad, the old value (Bangalore) will be lost 
'
#==================================================================================================================
STATE=Andhrapradesh 
echo "I am in $STATE"  #output: I am in Andhrapradesh

# Store the old value in another variable
OLD_STATE=$STATE 

STATE=karnataka
echo "I am in $STATE" #I am in karnataka

echo "I was born in $OLD_STATE, now I live in $STATE." #I was born in Andhrapradesh, now I live in karnataka.
: '
Note: unless explicitly saved elsewhere. above, how to keep the old value before making the reassignment.
we saved the value of andhrapradesh in to new varible. 
'
#======================================================================================================================

# Combining variables
first_name="John"
last_name="Doe"
echo "Full Name: ${first_name} ${last_name}" #here output is Full Name: John Doe

varx=Dumb; vary=do
echo "${varx}le${vary}re." #here output is Dumledor

#====================================================================================================================

: '
Note:
  Use double quotes when you want to include variable values in the output.
  Use single quotes when you want to treat the variable name as a plain string.
'
MyVar=555
echo $MyVar #here output is 555

Var=555
echo "$Var" #here output is 555

MyVar=555
echo '$MyVar' #here output is $MyVar 

#=========================================================================================================================