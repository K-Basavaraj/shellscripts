#!/bin/bash


#example 1: 
# Simple read example to get user input
echo "Enter your name:"
read name
echo "Your name is: $name"

: '
output:
Enter your name:
Raj
Your name is: Raj
'

#Example2: Default IFS Example:
: '
What is IFS?
IFS stands for Internal Field Separator. Its a variable that tells the shell how to split input data into separate parts (fields). 
By default, IFS is set to space, tab, and newline.
'
DATA="apple orange banana"
IFS=" "  # Setting space as separator (default IFS is space anyway)
read fruit1 fruit2 fruit3 <<< "$DATA"
echo "$fruit1 $fruit2 $fruit3"          
: '
output: apple orange banana
$DATA is a string of fruits separated by spaces.
IFS=" " tells the shell that spaces are the separator for splitting the input string.
read splits the string into three parts and stores them in fruit1, fruit2, and fruit3.
'


#example3: Using IFS with Colon (:)
DATA="john:admin:42:USA"
IFS=":" read -r name role age country <<< "$DATA"

# Print the individual fields
echo "Name: $name"
echo "Role: $role"
echo "Age: $age"
echo "Country: $country"

: '
When you set IFS=":", it tells the shell to split the string wherever it sees a colon (:).
In this case, IFS=":" makes the colon the delimiter, so the string "john:admin:42:USA" will be split into:
john
admin
42
USA

The read command assigns john to name, admin to role, 42 to age, and USA to country.
'
: '
output: 
Name: john
Role: admin
Age: 42
Country: USA
'

#What is the -r flag with read? The -r flag tells read not to treat special characters like backslashes (\) as escape characters.
##example4: With/without -r Example
DATA="Hello\nWorld"                         
IFS=":" read -r name <<< "$DATA"
echo "Name: $name"
# with out -r output: Name: HellonWorld here string contains \n, without the -r flag, read will interpret \n as an actual newline.
# with -r     output: Name: Hello\nWorld

