#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo "PLease run this script with the root access"
  exit 1
else
  echo " You are a Super user."
fi

for i in $@
do
  echo " package to install: $i"
  dnf list installed $i
done