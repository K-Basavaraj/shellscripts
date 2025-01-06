#!/bin/bash
# index starts from 0, size is 3

FRUITS=("APPLE" "KIWI" "ORANGE") #Array
echo "i need an: ${FRUITS[0]}"
echo "i have one: ${FRUITS[2]}"
#Note if i give [3] it will print nothing.
: '
output: 
i need an: APPLE
i have one: ORANGE
'
#echo "i dont like ${FRUITS[0,1]}" 
#In Bash, you cannot access multiple array elements directly using a syntax like [1,2] as you might in other programming languages.
#Bash arrays do not support slicing or accessing multiple indices at once in that way. you can achive using loop.

#if you want to access all elements in an array using @
echo "I dont like all these fruits in the list: ${FRUITS[@]}"
# output: I dont like all these fruits in the list: APPLE KIWI ORANGE

#Now i am updating with new fruit insted of KIWI with Banana
# Set the value at index 1
FRUITS[1]="Banana"
echo "I dont like all these fruits in the list: ${FRUITS[@]}"
#output: I dont like all these fruits in the list: APPLE Banana ORANGE


#we can remove the element from an array using unset command 
unset 'FRUITS[0]'
echo "I dont like all these fruits in the list: ${FRUITS[@]}"
#output: I dont like all these fruits in the list: Banana ORANGE

#============================================================================================================================
# selecting menu script using array and case statemt

echo -e "If you need Dosa then press: 1\nIf you need Idly then press: 2\nIf you need poori then press: 3\nIf you need light Tea press: 4\nIf you need Hot coffe press: 5\n"
echo -n "select one of the item in the menu: "
menu=("Dosa" "Idly" "Poori" "Tea" "Coffe")

read select

case $select in
    1)  echo -e "\nYour order is: ${menu[0]} Confirmed! \nThank you BOSS :)"
        ;;
    2)
        echo -e "\nYour order is: ${menu[1]} Confirmed! \nThank you BOSS :)"
        ;;
    3)
        echo -e "\nYour order is: ${menu[2]} Confirmed! \nThank you BOSS :)"
        ;;
    4)
        echo -e "\nYour order is: ${menu[3]} Confirmed! \nThank you BOSS :)"
        ;;
    5)
        echo -e "\nYour order is: ${menu[4]} Confirmed! \nThank you BOSS :)"
        ;;
    6)
        echo "Invalid Iteam. sorry Please try above list in the menu."
        ;;
esac

# Array (indexed array)
array_var=(1 2 3 4 5)
echo "Array: ${array_var[@]}" #output: Array: 1 2 3 4 5