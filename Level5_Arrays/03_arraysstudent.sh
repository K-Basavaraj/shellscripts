#!/bin/bash

# Tracking Student Grades Note: Associative Array             (similar to a Map)
#You can declare an associative array to store student names and their grades.

#Declare an Associative Array 
declare -A studentGrades

# Add student grades
studentGrades["Ramesh"]=85
studentGrades["Bob"]=92
studentGrades["Charlie"]=78
studentGrades["Diana"]=90

#Access a Value
echo "Bob's grade is: ${studentGrades["Bob"]}" 
echo "Chralie's grade is: ${studentGrades["Charlie"]}"
echo "Ramesh's Grade is: ${studentGrades["Ramesh"]}"
echo "Diana's Grade is: ${studentGrades["Diana"]}"

# Update Diana's grade
studentGrades["Diana"]=95
studentGrades["Ramesh"]=100

# Print all student grades
echo "student final marks after recorrection: "
for grade in "${!studentGrades[@]}"; do  # Iterate through all the keys in the associative array and print each student and their grade
echo "$grade: ${studentGrades[$grade]}"  # Prints each student's name and their final grade
done

: '
Explanation of ${!studentGrades[@]}
${studentGrades[@]} gives you the values of the studentGrades array.
${!studentGrades[@]} gives you the keys of the studentGrades array.
In Bash, the ! is used in this context to refer to the keys of an associative array. Its part of the syntax for referencing 
the indexes or keys when dealing with associative arrays.
'

: '
output: 
Bobs grade is: 92
Chralies grade is: 78
Rameshs Grade is: 85
Dianas Grade is: 90
student final marks after recorrection:
$grade  studentGrades[$grade]
key     values
Diana: 95
Ramesh: 100
Charlie: 78
Bob: 92
'