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
echo "student Grades: "
for a in "${!studentGrades[@]}"; do 
echo "$a: ${studentGrades[$a]}"
done