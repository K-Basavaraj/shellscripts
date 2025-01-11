#!/bin/bash
set -e #seting up the automatic exit, ex is for debuging

failure(){
  echo "Failed at: $1 and $2"
}
trap 'failure "${LINENO}" "${BASH_COMMAND}"' ERR #ERR is the error signal

echo "Hello world SUCESS"
echooo "Hello world.. FAILURE"
echo "Hellow world after failure"