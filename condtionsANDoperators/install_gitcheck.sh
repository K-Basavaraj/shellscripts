#!/bin/bash
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
KEY-Points
1.How to check user has root access or not : using [ id -u ]
  (If its 0 then having root access)
  (If any other number ratherthan 0 then its not have root access)
Note: always Root access having 0 

2/3)  write condition and, where # sh installmysql.sh 
    ##1st Output:
    # please run the script with root privilages
    # Error: This command has to be run with superuser privileges (under the root user on most systems).

Note: when i ran the script with out sudo its prints the statement but eventhogh
        it get prints next line. which is going to install git But it doesnt install due to we dis not prvided 
        root user at run time. what is the Reason Behind running the script evengthogh it fails?
         example: ls -ltr -->success , 
             lddhj -ltr--> failure 
             ls -l---> success 
         if ran the script it run the script eventhough it gets error. so what we can do 
        ==> ** if you face error, what you do?
	            proceed running the script (or)
	            stop the script execute, clear error and run again we use this 
##2nd output: please run the script with root privilages

4. dnf list installed git to check wether its installed or not? $? to check status of previous command.
'

USERID=$(id -u)
#echo "userID is: $USERID "
#sh installmysql.sh         output: userID is: 1001
#sudo sh installmysql.sh    output: userID is: 0

if [ $USERID -ne 0 ]; then
  echo "please run the script with root privilages" #here clearly we know its failure so
  exit 1                                            #here user given 1 so shell undertand that its a filure. it underdatnd that have to come out of the progrm
fi

dnf list installed git
if [ $? -ne 0 ]; then
  echo "Git is not installed, going to install it.."
  dnf install git -y
  if [ $? -ne 0]; then
    echo "Git installation is not success.. Check it."
    exit 1
  else
    echo "Git installation is Sucessfull.."
  fi
else
  echo "Git is already installed, nothing to do.."
fi
