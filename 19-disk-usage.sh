#!/bin/bash

DISK_USAGE=$( df -hT | grep xfs )
DISK_THRESHOLD= 75

while IFS= read -r line
do
  USAGE=$(echo $line | awk -F "" '{print $6F}' | cut -d "%" -f1)
  FOLDER=$(echo $line | awk -F "" '{print $NF}')
  if [ $DISK_USAGE -ge $DISK_THRESHOLD ]
  then
    echo "$FOLDER is more than $DISK_DISK_THRESHOLD, Current Usage: $USAGE"
  fi
done <<< $DISK_USAGE