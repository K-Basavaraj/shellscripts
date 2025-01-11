#!/bin/bash 

# Enable debugging
set -x

echo "Step 1: Listing files in the current directory"
ls

echo "Step 2: Creating a directory"
mkdir test_directory

echo "Step 3: Trying to create the same directory again"
mkdir test_directory  # This will cause an error

# echo "Step 4: This will still run even after the error (no set -e yet)"

# # Exit on error
# set -e

# echo "Step 5: Creating another directory"
# mkdir another_directory

# echo "Step 6: Trying to create the same directory again"
# mkdir another_directory  # Script will stop here due to set -e

# echo "Step 7: This will not be printed if there's an error above."
