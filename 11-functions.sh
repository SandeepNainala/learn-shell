#! /bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S )
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)     # here $0 is the script name(11-fucntions.sh) we are deleting .sh using cut command
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

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

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "Installing MYSQL"

dnf install git -y &>>$LOGFILE
VALIDATE $? "Installing GIT"