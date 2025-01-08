#!/bin/bash

# Define the function
add_numbers() {
    result=$(( $1 + $2 ))
    echo $result
}

# Array of numbers to add
numbers=(3 9 7 5 8)

#A variable total is initialized to store the running total sum of all numbers
total=0

for (( i = 0; i < ${#numbers[@]} - 1; i++ )); do
    sum=$(add_numbers ${numbers[i]} ${numbers[i + 1]})
    echo "Sum of ${numbers[i]} and ${numbers[i + 1]} is: $sum"
    total=$(add_numbers $total $sum)
done

echo "Total sum is: $total"


