#!/bin/bash


#example1: 
# IFS= IFS,internal field seperatpor, leading/trailing whitespace

# Input string with colons separating fields
DATA="john:admin:42:USA"
IFS=":" read -r name role age country <<< "$DATA"

# Print the individual fields
echo "Name: $name"
echo "Role: $role"
echo "Age: $age"
echo "Country: $country"

: '
IFS=":": This sets the Internal Field Separator (IFS) to a colon (:). 
The read command will now consider each : as a separator between fields.
read -r name role age country: The read command splits the input ($DATA) based on the colon delimiter, 
and assigns each part to the corresponding variable (name, role, age, and country).
<<< "$DATA": The <<< operator redirects the string $DATA to the read command
'