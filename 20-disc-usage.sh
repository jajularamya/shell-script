#!/bin/bash

DISC_USAGE=$(df -hT | grep xfs)
DISC_THRESHOLD=5
while read -r line
do
  USAGE=$(echo $line | awk -F " " '{print $6F}')
  PARTITION=$(echo $line | awk -F " " '{print $NF}')
  echo "parition: $PARTITION , usage: $USAGE"
done <<< $DISC_USAGE