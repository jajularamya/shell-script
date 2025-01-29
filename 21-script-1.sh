#!/bin/bash

MSG="SCRIPT1"
GREET="hello from SCRIPT-1"
source ./22-script-2.sh ###this command used to run that script in current script

echo "hello from: $MSG"
echo "A value: $A"
#sh 22-script-2.sh