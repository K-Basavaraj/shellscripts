# The ‘until’ loop is a unique looping mechanism that runs a block of code repeatedly until a specified condition becomes true. 
#It essentially works in the opposite manner of the ‘while’ loop, making it a valuable tool when executing commands as long as a 
#condition remains false.

#!/bin/bash

#!/bin/bash
echo "until loop"
i=10
until [ $i == 1 ]
do
    echo "$i is not equal to 1";
    i=$((i-1))
done
echo "i value is $i"
echo "loop terminated"

: '
output: 
$ sh 03_untillloop.sh
until loop
10 is not equal to 1
9 is not equal to 1
8 is not equal to 1
7 is not equal to 1
6 is not equal to 1
5 is not equal to 1
4 is not equal to 1
3 is not equal to 1
2 is not equal to 1
i value is 1
loop terminated
'