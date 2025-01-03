#!/bin/bash
: '
$?: This represents the exit status of the last executed command. A 0 means true, and a non-zero value means false.
Each condition is followed by echo $? to print whether the last condition was true (exit status 0) or false (exit status 1)
'

read -p "enter the value of a: " a
read -p "read the value of b: " b

(( $a==$b ))
echo $?

(( $a!=$b ))
echo $?

(( $a>$b))
echo $?

(( $a<$b))
echo $?

(( $a<=$b ))
echo $?

(( $a>=$b ))
echo $?

: '
output: 
enter the value of a: 5
read the value of b: 6
1-> False
0-> True
1
0
0
1
'