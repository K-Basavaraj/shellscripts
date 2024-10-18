#!/bin/bash

: '
Scenario:: 
You are writing a shell script to define a configuration setting for a software application. 
You need to define a read-only variable for the application name and attempt to change it.
If the change is attempted, the script should show an error message.
'
readonly APP_Name="MyApplication1"
echo "Application Name: $APP_Name"
APP_Name="NewApp" 
echo "Updated Application Name: $APP_Name"
: '
output:
    Application Name: MyApplication1
    readonly2.sh: line 11: APP_Name: readonly variable
'

