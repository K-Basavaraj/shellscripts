#!/bin/bash

#for user input topic read the user input using [ "read" ]
#double line comment
: ' 
Write a script that prompts the user to enter a username and a password (with the password hidden), 
and then prints a message confirming that the username and your data is saved. 
'
#!/bin/bash

echo -n "Plase enter your Username: " #here -n is user can enter data in same line not in the next line
read USERNAME  ##takes input into USERNAME variable
echo -n "Please enter your password:"
read -s Password #here -s is hide the user input while giving and takes input into Password variable
echo "Congradulation $USERNAME... your data is saved"

