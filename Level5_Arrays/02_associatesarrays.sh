#/bin/bash 

# Associative Array (similar to a Map or dictionaries) in Bash are used to store key-value pairs.
declare -A map_var
map_var["name"]="Alice"
map_var["age"]=30
echo "Map: Name=${map_var["name"]}, Age=${map_var["age"]}"

declare -A person
# Add key-value pairs
person["name"]="John"
person["age"]=25
person["city"]="New York"

# Access values using keys
echo "Name: ${person["name"]}"
echo "Age: ${person["age"]}"
echo "City: ${person["city"]}"

: '
output: 
$ sh 02_typesarrays.sh
Map: Name=Alice, Age=30
Name: John
Age: 25
City: New York
'

declare -A fruits

# Add key-value pairs
fruits["apple"]="red"
fruits["banana"]="yellow"
fruits["grape"]="purple"

# Loop through keys
for fruit in "${!fruits[@]}"; do
    echo "$fruit is ${fruits[$fruit]}"
done
: '
Explanation of ${!fruits[@]}
${fruits[@]} gives you the values of the fruits array (i.e., the colors: "red", "yellow", "purple").
${!fruits[@]} gives you the keys of the fruits array (i.e., the fruit names: "apple", "banana", "grape").
In Bash, the ! is used in this context to refer to the keys of an associative array. Its part of the syntax for referencing 
the indexes or keys when dealing with associative arrays.
'

#Checking if a Key Exists To check if a key exists, use [[ -v key ]]:
declare -A capitals

# Add key-value pairs
capitals["USA"]="Washington"
capitals["France"]="Paris"

# Check if a key exists
if [[ -v capitals["USA"] ]]; then
    echo "USA exists in the map."
else
    echo "USA does not exist in the map."
fi

: '
output: 
grape is purple
apple is red
banana is yellow
USA exists in the map.
'