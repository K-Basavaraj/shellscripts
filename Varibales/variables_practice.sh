#!/bin/bash

#1) Use echo to display Hello followed by your username. (use a bash variable!)

username="Basavaraj"
echo "Hello $username"

#2)Create a variable answer with a value of 42
answer=42
echo "your number is $answer"


#3) Destroy your answer variable
unset answer
echo "your number is $answer"


#3)Copy the value of $LANG to $MyLANG
LANG=English
MyLANG=$LANG
echo "you language is: $MyLANG"


: '
use the set command to display a list of environment variables. On Ubuntu and 
Debian systems, the set command will also list shell functions after the shell variables.Use 
set | more to see the variables then
'
#4)List all current shell variables
# set
# set|more on Ubuntu/Debian

: '
You can export shell variables to other shells with the export command. This will export 
the variable to child shells.
But it will not export to the parent shell (previous screenshot continued)
'
#5)List all exported shell variables
# env 
# export
# declare -x

#6) Do the env and set commands display your variable 
# env | more
# set | more

#7) Create two variables, and export one of them.
var1=1; export var2=2

#8) Display the exported variable in an interactive child shell
echo $var2

#9) 9. Create a variable, give it the value 'Dumb', create another variable with value 'do'. Use
#echo and the two variables to echo Dumbledore.

varx=Dumb; vary=do
echo "${varx}le${vary}re."

#10) Find the list of backslash escaped characters in the manual of bash. Add the time to your PS1 prompt.
# PS1='\t \u@\h \W$ '
