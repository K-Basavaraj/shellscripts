#!/bin/bash

# Global variables are accessible throughout the shell session in which they are defined.
# However, these variables are NOT automatically available to subshells (child shells) unless explicitly exported.
# To make a variable accessible in child shells (subshells), it must be explicitly exported using the 'export' command.
#==============================================================================================================================

#  Declare a Variable in the Parent Shell
: '
Here, global_var as variblename is declared, but it is not exported.
This makes it a local variable, meaning it exists only in the current (parent) shell.
'
export global_var="I am global"
echo "Global variable before export: $global_var" #output: Global variable before export: I am global


bash                        # Start a child shell
echo $global_var           # Access the Variable in the Child Shell  Output: Nothing
: '
==> A new shell (child shell) starts. This shell does not inherit local variables from the parent shell
unless they are explicitly exported.
==> Since global_var was not exported in the parent shell, it is not available in the child shell.          
'
exit                        # Exit the Child Shell
: '
You return to the parent shell, where global_var still exists because it was declared there.
'

: '
Note: 
Why Is It Local?
The variable global_var was not exported using the export command.
It exists only in the parent shell, making it a local variable.
'
#=============================================================================================================================
: '
How to Make It Global
To make global_var a global variable (accessible in child shells), you must export it:
'
#export global_var="I am global"
bash                      # Start a child shell
echo $global_var          # Output: I am global


# #Use the printenv or env command to display only environment variables (global variables that have been exported).
# : '
# You can export shell variables to other shells with the export command. This will export 
# the variable to child shells.
# But it will not export to the parent shell (previous screenshot continued)
# '
# # Export the variable to make it an environment variable
# export global_var
# bash -c 'echo "Accessing global_var in a subshell: $global_var"' 

# : '
# Start a new shell (child shell) from the current Bash session:
# type bash
# Now you are in a child shell.

# now Check the Variable in the Child Shell

# echo $ global_var
# Output: Nothing, because the variable global_var was not exported in the parent shell.
#'