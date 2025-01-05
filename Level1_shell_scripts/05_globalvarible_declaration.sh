# #!/bin/bash

# # Global variables are accessible throughout the shell session in which they are defined.
# # However, these variables are NOT automatically available to subshells (child shells) unless explicitly exported.
# # To make a variable accessible in child shells (subshells), it must be explicitly exported using the 'export' command.
# #==============================================================================================================================

# #  Declare a Variable in the Parent Shell
# : '
# Here, global_var as variblename is declared, but it is not exported.
# This makes it a local variable, meaning it exists only in the current (parent) shell.
# '
# global_var="I am global"
# echo "Global variable before export: $global_var" #output: Global variable before export: I am global

# # Start a child shell (no export)
# bash -c 'echo "In child shell, before export: $global_var"'  # Output: Nothing (no export)
# # bash                        # Start a child shell
# # echo $global_var           # Access the Variable in the Child Shell  Output: Nothing
# : '
# ==> A new shell (child shell) starts. This shell does not inherit local variables from the parent shell
# unless they are explicitly exported.
# ==> Since global_var was not exported in the parent shell, it is not available in the child shell.          
# '
# exit                        # Exit the Child Shell
# : '
# You return to the parent shell, where global_var still exists because it was declared there.
# '

# : '
# Note: 
# Why Is It Local?
# The variable global_var was not exported using the export command.
# It exists only in the parent shell, making it a local variable.
# '
# #=============================================================================================================================
# : '
# How to Make It Global
# To make global_var a global variable (accessible in child shells), you must export it:
# '
# export global_var="I am global"
# #bash                      # Start a child shell
# bash -c 'echo "In child shell, after export: $global_var"'
# # echo $global_var          # Output: I am global
# #=============================================================================================================================

var1="I am global"
echo "Global variable before export: $var1" #output: Global variable before export: I am global
bash -c 'echo "In child shell, before export: $var1"' 
: '
Global variable before export: I am global
In child shell, before export:
'
export var1
bash -c 'echo "In child shell, after export: $var1"'
exit