#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #IF USER NOT PROVIDE DAYS , WE TAKE 14DAYS AD DEFAULT

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


USAGE(){
      echo -e "$R USAGE:: $N sh 19-backup.sh <SOUR_DIR> <DEST_DIR> <DAYS(optional)>"
      exit 1
 }

 mkdir -p /home/ec2-user/shellscript-logs

if [ $# -lt 2 ] #$# means no of parameters 
then
  USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
 echo -e "$SOURCE_DIR does not exists... please check"
 exit 1
fi

if [ ! -d $DEST_DIR ]
then
 echo -e "$DEST_DIR does not exists... please check"
 exit 1
 fi

echo "script started excecuting at: $TIMESTAMP" &>>$LOG_FILE_NAME
 
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "files are: $FILES"

if [ -n "$FILES" ] #true if there are files to zip
then
 echo "files are: $FILES"
 ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
 find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
 if [ -f "$ZIP_FILE" ]
 then
  echo -e "successfully created zip file for files older than $DAYS" 
  while read -r filepath
  do  
     echo "deleting file: $filepath" &>>$LOG_FILE_NAME
     rm -rf $filepath
     echo "deleted file: $filepath"
    done <<< $FILES
 else
   echo -e "$R error:: $N failed to create zip file"
   exit 1
   fi
 
 else
  echo "no files are found older than $DAYS"
  fi