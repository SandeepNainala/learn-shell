USERID=$(id -u)

if [ $USERID -ne 0 ] ; then
  echo "you need to be a root user to execute"
  exit 1
fi

func_validate () {
if [ $1 -ne 0 ] ; then
    echo " $2 ..... failure "
    exit 1
  else
    echo "$2 ...... Success"
    exit 1
  fi

}


yum update -y

func_validate $? "updating yum"

yum install java-1.8.0-openjdk

func_validate $? " install java package "

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

func_validate $? " adding jenkins repo "

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

func_validate $? "upgrading yum"

yum upgrade -y

func_validate $? " installing jenkins "

yum install jenkins -y

func_validate $? " enabling jenkins service "

systemctl enable jenkins

func_validate $? " start jenkins service "

systemctl start jenkins

