#!/bin/bash 

#write a script that providing a varible values at runtime.

First_person=$1, Second_person=$2

echo "$First_person: Hello $Second_person, How are you?" 
echo "$Second_person: Hi $First_person, I am Good!, Thanks for asking. How about you $First_person?" 
echo "$First_person: I am doing good $Second_person. What do you do $Second_person?"
echo "$Second_person: I am a software Engineer. How about you $First_person?" 


#$ sh 03_runRenvvarconv.sh   ramesh suresh at runtime
