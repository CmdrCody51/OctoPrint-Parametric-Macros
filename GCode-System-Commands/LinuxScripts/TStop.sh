#!/bin/bash
# this is to give OP something to call
# full paths required
# $OCTOPRINT_GCODESYSTEMCOMMAND_ARGS=

file="/home/pi/.octoprint/"$OCTOPRINT_GCODESYSTEMCOMMAND_ARGS

echo -n "Stop: " >> $file
echo $( date +%s ) >> $file

exit
