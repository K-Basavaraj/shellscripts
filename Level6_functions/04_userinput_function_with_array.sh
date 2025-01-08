#/bin/bash 

# Declare an empty array
numbers=()

#A variable total is initialized to store the running total sum of all numbers
total=0

# Read the desired size of the array
read -p "Please enter the size of the array: " size

# Prompt user to enter numbers
echo "Enter $size numbers for the array:"

# Loop to accept exactly 'size' numbers
for (( i=0; i<size; i++ )); do
    read -p "Enter number $((i+1)): " num
    numbers+=("$num")  # Add the number to the array
done

# Display the final array
echo "You entered: ${numbers[@]}"


add(){
    result=$(( $1 + $2 ))
    echo "$result"
}

for (( i = 0; i < ${#numbers[@]} - 1; i++ )); do
    sum=$(add ${numbers[i]} ${numbers[i + 1]})
    echo "Sum of ${numbers[i]} and ${numbers[i + 1]} is: $sum"
    total=$(add $total $sum)
done

echo "Total sum is: $total"

