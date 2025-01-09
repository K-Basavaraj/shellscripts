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
