#!/bin/bash 

#Local variables are defined inside a function and can only be accessed within that function, 
myfunction() {
     local myvar=”Hello”
     local name=$1
     echo “$myvar, $name!”
}
myfunction “John”
# output: “”Hello”, “John”!”

#If I try to access the variables outside the function, it prints nothing because they are local. 
echo "outside of the function: $myvar, $name" 
# output: outside of the function: , 

#Note: 
# Local Variables: When you use the 'local' keyword inside a function, the variable is only accessible  
# within the function itself and is not available outside the function after it finishes execution.

#However:
# Capturing the Output: Although the variable is local, you can still capture the output of the function 
#(if the function prints something using echo) and store it in a global variable by using command substitution $(...). 
details=$(myfunction "John")
echo "Result outside function: $details"
#output: Result outside function: “”Hello”, John!”
#========================================================================================================================

#while global variables are defined outside a function that can be accessed and modified by any part of the script.

# Define a function
myfunction() {
    myvar="Hi"         # Modifies the global variable
    name=$1            # Updates the global variable with the function argument
    echo "$myvar, $name!"  # Prints: Hi, John!
}

# Call the function
myfunction "John"

# Access the global variables outside the function
echo "Outside of the function: $myvar, $name"
# Output: Outside of the function: Hi, John

#==========================================================================================================================

: '
Best Practices: if we dont use echo inside function it print empty output. see example down. 
Always Use echo When Output is Needed: This ensures the functions result can be displayed or captured as required. 
'
#If you capture the functions output into a variable, echo defines what gets captured. Without echo, the function will not
 produce any output for capturing:
myfunction() {
    result=$(( $1 + $2 ))  # Performs the calculation
    # No echo here, so nothing is printed or captured
}

sum=$(myfunction 10 20)  # No output to capture
echo "Captured sum: $sum"  # Output: Captured sum: (empty)

: '
Best Practices: Avoid Using echo Unnecessarily: 
If the function doesnt need to return any output, dont use echo. 
For example, functions designed for setting global variables or performing actions without returning a result.
'
# Define a global variable
greeting=""

# Function to set the value of the global variable
set_greeting() {
    greeting="Hello, $1!"  # Modifies the global variable
}
# Call the function to set the greeting
set_greeting "John"

# Access the modified global variable outside the function
echo "Greeting outside the function: $greeting"
# Output: Greeting outside the function: Hello, John!
#=====================================================================================================================