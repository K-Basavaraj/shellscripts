!/bin/bash

read -p "enter the value of a: " a
read -p "read the value of b: " b
# Checking if characters are equal
[[ $a == $b ]] && echo "true" || echo "false"

(( $a!=$b )) && echo "true" || echo "false"

(( $a>$b)) && echo "true" || echo "false"

(( $a<$b)) && echo "true" || echo "false"

(( $a<=$b )) && echo "true" || echo "false"

(( $a>=$b )) && echo "true" || echo "false"

:'
output
enter the value of a: 5
read the value of b: 6
false
true
false
true
true
false
'
#=================================================================================================================================

read -p "enter the string1: " c
read -p "enter the string2: " d
# Checking if characters are not equal
[[ ! $c != $d ]] && echo "true" || echo "false"
: '
# output:
enter the string1: ram
enter the string2: ram
true

enter the string1: ramesh
enter the string2: Ramesh
false
'
#===========================================================================================================================

