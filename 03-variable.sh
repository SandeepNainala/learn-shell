a=10
name=DevOps

# Print Variable
echo a = $a
echo name = ${name}

#
#DATE=2023-04-18
DATE=$(date +%F)
echo Today date is ${DATE}

ARTH=$((2-3*4/2))

echo ARTH = ${ARTH}

# Special Variables for Inputs
echo Script Name - $0
echo First Argument - $1
echo Second Argument - $2
echo All Argument - $*
echo No of Arguments - $#

$$ Display process ID
$# Display no. of parameters
$0 Display file name
$n n is a decimal number gives the parameters value passed in command
         line in order
$* Display double quoted parameter (usually all parameters are double
        quoted)
$? Display exit status  of statement. Returns 0 if the statement was
        executed successfully and returns Non-Zero if the statement was not
        executed successfully.