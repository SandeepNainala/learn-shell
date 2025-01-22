#!/bin/bash

COURSE="DEVOPS from current script"

echo "Before calling other script, Course: $COURSE"
echo "Process ID of current shell script: $$"

./16-other-script.sh

echo "After Calling other script, course: $COURSE"
