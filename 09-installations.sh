#! /bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
  echo " Please run this script with the root user"
  exit1  # manually exit if error comes.
else
  echo " You are a Super user"
fi

dnf install mysql -y

if [ $? -ne 0 ]   # #? is a special variable, it refer to the last exit status
then
  echo " Installation of mysql is Failure "
  exit1
else
  echo " Installation of mysql is Success "
fi

dnf install git -y

if [ $? -ne 0 ]
then
  echo " Installation of Git is a Failure"
  exit1
else
  echo " Installation of Git is a success "
fi