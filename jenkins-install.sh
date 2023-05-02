#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F)
LOG="jenkins-install-${DATE}.log"
R="\e[31m"
G="\e[32m"
N="\e[0m"

func_validate(){
if [ $1 -ne 0 ]; then
	echo -e "$2 ... ${R} FAILURE ${N}" 2>&1 | tee -a $LOG
# here 2 is STDERR and 1 is STDOUT
#The tee command, used with a pipe, reads standard input, then writes the output of a program to standard output and simultaneously copies it into the specified file or files.
	exit 1
else
	echo -e "$2 ... ${G} SUCCESS ${N}" 2>&1 | tee -a $LOG
fi
}

if [ $USERID -ne 0 ]; then
	echo -e "${R} You need to be root user to execute this script ${N}"
	exit 1
fi

yum update -y &>>$LOG
# >> is to append the error log

func_validate $? "Updating YUM"

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>$LOG

func_validate $? "Adding Jenkins Repo"

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>>$LOG

func_validate $? "Import Jenkins key"

yum upgrade -y &>>$LOG

func_validate $? "Upgrade YUM"

amazon-linux-extras install java-openjdk11 -y &>>$LOG

func_validate $? "Installing OpenJDK 11"

yum install jenkins -y &>>$LOG

func_validate $? "Installing Jenkins"

systemctl enable jenkins &>>$LOG

func_validate $? "Enable Jenkins"

systemctl start jenkins &>>$LOG

func_validate $? "Starting Jenkins"



