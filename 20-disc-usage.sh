#!/bin/bash

DISC_USAGE=$(df -hT | grep xfs)
DISC_THRESHOLD=5
while read -r line
do
  USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
  PARTITION=$(echo $line | awk -F " " '{print $NF}')
  #echo "parition: $PARTITION , usage: $USAGE"
  if [ $USAGE -ge $DISC_THRESHOLD ]
  then
   MSG+="high disc message on partition: $PARTITION usage is: $USAGE \n"
  fi 
done <<< $DISC_USAGE

echo -e "message: $MSG"
echo "$MSG" | mutt -s "HIGH DISC USAGE" ramyajajula111@gmail.com