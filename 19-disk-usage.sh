#!/bin/bash

DISK_USAGE=$( df -hT | grep xfs )
DISK_THRESHOLD= 75
MESSAGE= ""

while IFS= read -r line
do
  USAGE=$(echo $line | awk -F "" '{print $6F}' | cut -d "%" -f1)
  FOLDER=$(echo $line | awk -F "" '{print $NF}')
  if [ $DISK_USAGE -ge $DISK_THRESHOLD ]
  then
    MESSAGE+= "$FOLDER is more than $DISK_DISK_THRESHOLD, Current Usage: $USAGE"  #we mentioned + to avoid the override for variable value
  fi
done <<< $DISK_USAGE

echo "Message: $MESSAGE"