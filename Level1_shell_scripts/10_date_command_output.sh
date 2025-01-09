#!/bin/bash

#with out declaring varible
date  

# Store current date and time
Custom_date=$(date)

# Override with a custom format
Custom_date=$(date +'%Y-%m-%d')
echo "your custome custome_date: $Custom_date"
