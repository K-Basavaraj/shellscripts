#!/bin/bash
# Array (indexed array)
array_var=(1 2 3 4 5)
echo "Array: ${array_var[@]}" #output: Array: 1 2 3 4 5

# index starts from 0, size is 3
FRUITS=("APPLE" "KIWI" "ORANGE") #Array
echo "i need an: ${FRUITS[0]}"
echo "i have one: ${FRUITS[2]}"
#Note if i give [3] it will print nothing.


# selecting menu script using array and case statemt
echo -e "If you need Dosa then press: 1\nIf you need Idly then press: 2\nIf you need poori then press: 3"
echo -e "If you need light Tea press: 4\nIf you need Hot coffe press: 5\n "
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
    *)
        echo "Invalid selection. Please try again."
        ;;
esac