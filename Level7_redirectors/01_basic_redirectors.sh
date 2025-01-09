#!/bin/bash 
: '
> std input 
1--> is sucess 
2--> is failure
&--> for both sucess and failure.
'

mkdir -p /home/ec2-user/test home/ec2-user/dev 
echo "Hello how are you"

ls -l /home/ec2-user/

: '
Here output prints on the termianl.
output: 
[ ec2-user@ip-172-31-80-84 ~/practice/shellscripts/Level7_redirectors ]$ sh 01_basic_redirectors.sh
Hello how are you
total 0
drwxr-xr-x 3 ec2-user ec2-user 26 Jan  9 02:14 practice
drwxr-xr-x 2 ec2-user ec2-user  6 Jan  9 02:21 test
'

ls -l /home/ec2-user/  > output.txt
