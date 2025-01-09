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
#echo "userID is: $USERID "
#sh installmysql.sh         output: userID is: 1001 if you run this script as normal the uesr id is sum number but
#sudo sh installmysql.sh    output: userID is: 0 If you run this script with sudo <script_name> it will run with root privileges.

if [ $USERID -ne 0 ]; then
    echo "please run the script with root privilages"
    exit 1 #here user given 1 so shell undertand that its a filure. it underdatnd that have to come out of the progrm
fi
#Note: when userid is 1 not equal to 0 so, its true then it gives messege and exit. so, it must be 0 equal to 0 to go to next.
#--> echo $? to check status of previous command which is  success or failure of the previous command if success its 0 if its fail its a 1-127.

dnf list installed git -y   
if [ $? -ne 0 ]; then 
    echo "Git is not installed, going to install it.."
    dnf install git -y
    if [ $? -ne 0 ]; then
        echo "Git installation is not sucess.. checkit."
        exit 1
    else
        echo "Git installation is sucessfull.."
    fi
else
    echo "Git is alrwady installed, nothing to do.."
fi
