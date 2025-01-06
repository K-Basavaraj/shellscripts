: '
install git through shell script
 1. check the user has root access or not
 2. if root access, proceed with the script
 3. otherwise through the error
 4. check already installed or not, if installed tell the user it is already insalled
 5. if not installed, install it
 6. check it is success or not
'
: '
Note: 
How to check user has root access or not : using [ id -u ] (If its 0 then having root access)
(If any other number ratherthan 0 then its not have root access)
always Root access having 0  example: [ root@ip-172-31-85-87 ~ ]# id #output uid=0(root) gid=0(root) groups=0(root)
[ ec2-user@ip-172-31-85-87 shellscripts ]$ id #output: uid=1001(ec2-user) gid=1001(ec2-user) groups=1001(ec2-user)
'

#!/bin/bash 

USERID=$(id -u)
dnf list installed git