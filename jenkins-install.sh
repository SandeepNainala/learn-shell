USERID=$(id -u)

if [ USERID -ne 0 ] ; then
  echo "you need to be a root user to execute"
  exit 1
fi

yum update -y

if [ $? -ne 0 ] ; then
  echo " Updating yum is a failure "
  exit 1
else
  echo "Updating yum is a Success"
  exit 1
fi

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

if [ $? -ne 0 ] ; then
  echo " adding Jenkins repo is a failure"
  exit1
else
  echo " adding Jenkins repo is a success"
fi

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

 if [ $? -ne 0 ] ; then
   echo " importing jenkins packages is a failure "
   exit 1
else
  echo " importing jenkins packages is a success "
  exit 1
fi

yum upgrade -y

if [ $? -ne 0 ] ; then
  echo " upgrading is a failure "
  exit 1
else
  echo " upgrading is a success "
  exit 1
fi

dnf install java-11-amazon-corretto -y

if [ $? -ne 0 ] ; then
  echo " install Java is a failure "
  exit 1
else
  echo " install java is a success "
fi

yum install jenkins -y

if [ $? -ne 0 ] ; then
  echo " install Jenkins is a failure "
  exit 1
else
  echo " install jenkins is a success "
  exit 1
fi

systemctl enable jenkins

if [ $? -ne 0 ] ; then
  echo " enabling jenkins is a failure "
  exit 1
else
  echo " enabling jenkins is a success "
  exit 1
fi

