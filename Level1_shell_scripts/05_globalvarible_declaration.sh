#!/bin/bash

# Global variables are accessible throughout the shell session in which they are defined.
# However, these variables are NOT automatically available to subshells (child shells) unless explicitly exported.
# To make a variable accessible in child shells (subshells), it must be explicitly exported using the 'export' command.
# ==> What happens without export?: If you start a new shell (a child shell), this variable won’t be accessible to 
#      that shell unless you explicitly export it.
#==============================================================================================================================

#  Declare a Variable in the Parent Shell
var1="I am global"
echo "Global variable before export: $var1" #output: Global variable before export: I am global

# Start a child shell (no export)
bash -c 'echo "In child shell, before export: $var1"' 
: '
Global variable before export: I am global
In child shell, before export:
#Access the Variable in the Child Shell  Output: Nothing
'
# ==> A new shell (child shell) starts. This shell does not inherit local variables from the parent shell
# unless they are explicitly exported.
# ==> Since global_var was not exported in the parent shell, it is not available in the child shell.     
#==> How to Make It Global To make global_var a global variable (accessible in child shells), you must export it:     

export var1
bash -c 'echo "In child shell, after export: $var1"'
exit

# Global variable before export: I am global
# In child shell, before export:
# In child shell, after export: I am global
# "In child shell, after export your able to access the varible in child shell see above output

 
: '
#Note:
1) The script demonstrates how global variables are used in the parent shell, how they behave when starting child shells,
and the importance of exporting variables if you want them to be accessible to subshells.

2)  What is the export Command?
The export command is used to mark variables as environment variables so that they can be accessed by child processes or subshells.
When you define a variable in a shell, it is local to the shell in which it was defined. If you need that variable to be available
in other processes or subshells (which are essentially new instances of the shell), you must export it.
Without export: A variable is only available in the current shell.
With export: The variable is made available to child processes spawned from the current shell.

3) When working in multiple environments (development, staging, production), you may need to use different sets of environment
variables depending on the environment. By exporting variables in the parent shell, you can pass different configurations to child
shells.
'
#================================================================================================================================