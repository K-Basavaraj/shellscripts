#!/bin/bash 

# Define a function named 'Greetings'
Greetings(){
    # Print a greeting message with the first argument passed to the function
    echo "Hello, $1!"
}

# Call the function 'Greetings' with the argument 'Raj'
Greetings Raj
#output: Hello, Raj!

Greet(){
    echo "Hello. $1, Your favourite color is $2."
}
Greet Ramesh Blue
#output: Hello. Ramesh, Your favourite color is Blue.

#=================================================================================================================
: '
Function Returning a Value
Functions in shell scripts cant directly return values but can output them using echo and then capture the output

#When you use echo inside a function, the function outputs the value directly to the terminal. However, 
#if you want to store or process that output in your script, capturing it in a variable becomes necessary.
#Otherwise, the output is displayed but not stored for further use.
'
#example1
add(){
    result=$(( $1 + $2 ))
    echo $result
}

add 25 26
#output: 51
# If you simply want to display the result, echo inside the function works fine, and you dont need to capture it.
# But you cannot reuse the result later in the script without capturing it.
#=============================================================================================================================

#example2 Capturing Output: Essential for Reuse
#If you need to use the result elsewhere in your script (e.g., calculations, conditions, logging), you must capture the output.
addition(){
    result=$(( $1 + $2 ))
    echo $result  #inside the addition() function prints the calculated result (10 + 20 = 30) to the standard output (stdout).
    #What happens at this point?The output (30) is "sent" to wherever the function call is used.
}

#Capture the result of the function
# When you call the function inside $(...), like sum=$(addition 10 20), the shell executes the function and
# Takes the output from echo (in this case, 30).Assigns it to the variable sum

sum=$(addition 10 20)  #sum now holds the value 30.
echo "Captured Sum: $sum"  #output: Captured Sum: 30

#If you remove the echo "Captured Sum: $sum" line, the captured output (30) remains stored in the variable sum but won’t be displayed.

# Use the stored value for further calculations
double=$(( sum * 2 )) #30 * 2 = 60
echo "Double of the sum is: $double" #output: Double of the sum is: 60

# Use the stored value for further calculations
sub=$(( sum - $double)) #30-60 = -30
echo "this is sub value: $sub" #output: this is sub value: -30

# Use the captured value in a conditional statement
if (( sum > $sub )); then
    echo "The sum is greater than subvalue."
else
    echo "The sum is less than or equal to subvalue."
fi
#===========================================================================================================================