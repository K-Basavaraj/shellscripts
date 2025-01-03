#!/bin/bash

read -p 'Enter a : ' a
read -p 'Enter b : ' b

bitwiseAND=$(( a&b ))
echo "Bitwise AND of a and b is $bitwiseAND"

bitwiseOR=$(( a|b ))
echo "Bitwise OR of a and b is $bitwiseOR"

bitwiseXOR=$(( a^b ))
echo "Bitwise XOR of a and b is $bitwiseXOR"

bitiwiseComplement=$(( ~b ))
echo "Bitwise Compliment of a is $bitiwiseComplement"

:'
output: 
Enter a : 5
Enter b : 8
Bitwise AND of a and b is 0
Bitwise OR of a and b is 13
Bitwise XOR of a and b is 13
Bitwise Compliment of a is -9
'