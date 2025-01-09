#!/bin/bash
: '
Redirecting output:
1 --> Standard output (Success)
2 --> Standard error (Failure)
& --> Both standard output and standard error.
'

# Create directories
mkdir -p /home/ec2-user/dev /home/ec2-user/test

# Create a file
touch /home/ec2-user/output.txt

# Save the output of the `ls` command to the file instead of displaying it in the terminal
ls -l /home/ec2-user 1> /home/ec2-user/output.txt

: '
The output of the `ls` command will be saved in the file `output.txt`.
Output Example:
cat /home/ec2-user/output.txt
total 4
-rw-r--r-- 1 ec2-user ec2-user 123 Jan  9 03:54 details.txt
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 dev
-rw-r--r-- 1 ec2-user ec2-user   0 Jan  9 03:56 output.txt
drwxr-xr-x 3 ec2-user ec2-user  26 Jan  9 03:52 practice
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 test
'

# Using an incorrect command to demonstrate error handling
llls -l /home/ec2-user 1> /home/ec2-user/output.txt
: '
Here, the command is incorrect (`llls` instead of `ls`), so no output is saved to `output.txt`.
The error will print on the terminal instead.
Output Example:
sh script_name.sh
script_name.sh: line 27: llls: command not found
cat /home/ec2-user/output.txt
<empty>
'

# Save only error output to the file
llls -l /home/ec2-user 2> /home/ec2-user/output.txt
: '
Only the error output is saved in the file. The terminal does not display the error.
Output Example:
cat /home/ec2-user/output.txt
script_name.sh: line 39: llls: command not found
'

# Use the correct command, but redirect errors to the file
ls -l /home/ec2-user 2> /home/ec2-user/output.txt
: '
The correct command executes successfully, so the output displays on the terminal.
The file does not store the success output, as only errors are redirected to the file.
cat /home/ec2-user/output.txt
<empty>
'

# Redirect both success and error outputs to the file (overwrite mode)
lls -l /home/ec2-user &> /home/ec2-user/output.txt

# Redirect both success and error outputs to the file (append mode)
ls -l /home/ec2-user &>> /home/ec2-user/output.txt
: '
Both success and error outputs are saved in the file. The second command appends to the file instead of overwriting it.
Output Example:
cat /home/ec2-user/output.txt
script_name.sh: line 53: lls: command not found
total 8
-rw-r--r-- 1 ec2-user ec2-user 123 Jan  9 03:54 details.txt
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 dev
-rw-r--r-- 1 ec2-user ec2-user  57 Jan  9 04:09 output.txt
drwxr-xr-x 3 ec2-user ec2-user  26 Jan  9 03:52 practice
drwxr-xr-x 2 ec2-user ec2-user   6 Jan  9 03:56 test
'