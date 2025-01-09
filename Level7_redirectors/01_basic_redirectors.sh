#!/bin/bash 
: '
> std input 
1--> is sucess 
2--> is failure
&--> for both sucess and failure.
'

mkdir -p /home/ec2-user/dev /home/ec2-user/test

touch /home/ec2-user/output.txt

ls -l /home/ec2-user 1> /home/ec2-user/output.txt

: '
Here output of ls command will save on the output.txt insted of terminal
output: 
cat /home/ec2-user/output.txt
total 4
-rw-r--r-- 1 ec2-user ec2-user 123 Jan  9 03:54 details.txt
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 dev
-rw-r--r-- 1 ec2-user ec2-user   0 Jan  9 03:56 output.txt
drwxr-xr-x 3 ec2-user ec2-user  26 Jan  9 03:52 practice
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 test
'

llls -l /home/ec2-user 1> /home/ec2-user/output.txt # here ls command is wrong 