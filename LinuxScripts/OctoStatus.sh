#!/bin/bash

# event names
# PrintStarted
# PrintDone
# PrintCancelled
# PrintFailed

echo "$1" $(date +%Y-%m-%d.%H:%M:%S) >> /home/pi/my_log

if [[ "$1" == "PrintStarted" ]]; then
  touch "/home/pi/NoNoNoNoNo.Yes"
else
  rm "/home/pi/NoNoNoNoNo.Yes"
fi
