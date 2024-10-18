#!/bin/bash 

#1) The test command can test whether something is true or false. Let's start by testing whether 
#10 is greater than 55.

test 10 -gt 55 ; 
echo $?  #output: 1 

#2) The test command returns 1 if the test fails. 0 when a test succeeds.
test 56 -gt 55 ; 
echo $?  #output: 0

#3) If you prefer true and false, then write the test like this.
test 56 -gt 55 && echo true || echo false
test 6  -gt 50 && echo true || echo false

#4) The test command can also be written as square brackets, 
[ 56 -gt 55 ] 
echo $?     #output: 0
[ 6 -gt 26 ] && echo true || echo false  #output: false
