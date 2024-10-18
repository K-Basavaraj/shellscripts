#!/bin/bash

: '
# Read-only Variables
# Shell provides a way to mark variables as read-only by using the read-only command. 
# After a variable is marked read-only, its value cannot be changed.
# If you want to allow the script to continue despite errors, you can either:
# 1. Remove or modify `set -e`.
# 2. Use a subshell with `|| true` after commands that might fail.
'

# Step 1: Assign "Zara Ali" to the variable NAME
NAME="Zara Ali"   

# Step 2: Mark the variable NAME as read-only
readonly NAME     

# Step 3: Attempt to change NAME to "Qadiri" in a subshell
( NAME="Qadiri" ) || true  # This allows the script to continue even if the assignment fails

# The script continues executing
echo "hello"
