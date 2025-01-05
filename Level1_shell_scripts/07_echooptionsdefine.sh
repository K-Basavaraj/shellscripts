#!/bin/bash
: '
The -e option in the echo command in a shell enables the interpretation of escape sequences. 
By default, many shells do not interpret escape sequences in echo, but with -e, it processes them,
allowing you to include special characters in your output.
'

echo "Hello\nWorld" #here output is Hello\nWorld

echo -e "Hello\nWorld" #here out put is Hello nextline it prints World

#======================================================================================================================
Firstperson=Ramesh
SecondPerson=Suresh
echo -e "$SecondPerson: $Firstperson I started learning Shell Script \n"

Manager=Alex
employee=Joe
echo -e "A new Manager with his employee converstion\n----------------------------------------------"
echo -e "Manager: Hi there!, I'm $Manager,the new manager. How's your day going? \n"
echo employee: Hi $Manager, I'm $employee!, It's going well, thanks! Just finishing up a project.

: ' 
here output is 

Suresh: I started learning Shell Script Ramesh

A new Manager with his employee converstion
----------------------------------------------
Manager: Hi there!, I'm Alex,the new manager. How's your day going?

employee: Hi Alex, Im $employee!, Its going well, thanks! Just finishing up a project.
'
#=========================================================================================================================

: '
The -n option in the echo command is used to suppress the trailing newline. By default, 
echo adds a newline character at the end of the output, but using -n prevents this, so the output remains 
on the same line as the prompt or subsequent text.
'
echo -n "Hello"
echo "World"    
#here output is HelloWorld eventhough we defined saparately.

: '
Some shells or implementations of echo may treat -n differently, so for consistent behavior across platforms,
you can use printf instead: same out put will get it.
'
printf "Hello"
printf "World\n"

#==========================================================================================================================

first_name=Raj
last_name=kumar

echo -n "your first name is: $first_name "
echo -n "your last name is: $last_name"

your_name="$first_name $last_name"

echo -e " SO, your full name is: $your_name. Thank you.."
: '
here output is 
your first name is: Rajyour last name is: kumarSO, your full name is: Raj kumar. Thank you..
'

#Done perfect alignment here by using -e and \n it will print to next line.
firstname=Ram
lastname=charan

echo -e -n "your first name is: $firstname\n"
echo -e -n "your last name is: $lastname\n"

yourname="$firstname $lastname"
echo -n "SO, your full name is: $yourname."
echo " Thank you.."
: '
your first name is: Ram
your last name is: charan
SO, your full name is: Ram charan. Thank you..
'
#============================================================================================================================

echo -e "a"
echo -e "b"
echo -e "c\n"
echo -e "d\n"

echo -n "a" 
echo "b" 
echo "c" 
echo -e "d\n"

echo -n "a" 
echo -n "b" 
echo -n "c" 
echo -n "d"

: ' 
output: 
a
b
c

d

ab
c
d

abcd
'
#===========================================================================================================================