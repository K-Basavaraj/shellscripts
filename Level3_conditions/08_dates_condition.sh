#!/bin/bash

#1)write a shell script that if its starday or sunday print there is no classes if its other days reatherthan sat or sub
#then print there is a class today.

# use the date command in Linux to get just the day of the week date +%A / %a

Today=$(date +%a)

if [ "$Today" != "sat" ] || [ "$Today" != "sun" ]; then # T F / T T / F T / --> True  if F F--> false
    echo "Today is $Today: you have no class"           #here its true
else
    echo "Today is $Today: you have class"
fi

#2) write same script in different way
if ! [[ "$Today" == "sat" || "$Today" == "sun" ]]; then #same as above
    echo "Today is $Today: you have no class"           #here its true
else
    echo "Today is $Today: you have class"
fi

#3) try in different way F
if [ "$Today" != "Sat" ] && [ "$Today" != "Sun" ]; then #T F/ F T/ F F/ ---> False if T T --> true
    echo "Today is $Today: you have  class"
else
    echo "Today is $Today: you have no class" #conditon fails so false
fi

#4) This is long approch
Day=$(date +%A)
if [[ "$Day" == "Monday" || "$Day" == "Tuesday" || "$Day" == "wednesday" || "$Day" == "Thursday" || "$Day" == "Friday" ]]; then
    echo "Today is $Day: you have a class"
else
    echo "Today is $Day: You have no class"
fi
