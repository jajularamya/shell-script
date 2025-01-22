#!/bin/bash
echo "All variabels passed: $@"
echo "Numbers of variables: $#"
echo "Script name: $0"
echo "Present working directory: $PWD"
echo "Home directory of current user:  $HOME"
echo "Wchich user is running this script: $USER"
echo "Process id of current script: $$"
sleep 60 &
echo "Process id of last command in background: $!"