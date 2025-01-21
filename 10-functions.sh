#! /bin/bash

USERID=$(id -u)

VALIDATE(){

  if [ $1 -ne 0 ]
  then
    echo "$2 .... FAILURE"
    exit1
  else
    echo "$2 .... SUCCESS"
  fi

}

if [ $USERID -ne 0 ]
then
  echo " Please run this script with the root user"
  exit1  # manually exit if error comes.
else
  echo " You are a Super user"
fi

dnf install mysql -y

VALIDATE $? "Installing MYSQL"

dnf install git -y

VALIDATE $? "Installing GI