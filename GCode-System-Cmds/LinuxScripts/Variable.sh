#!/bin/bash
# this is to give OP something to call
# full paths required
# $OCTOPRINT_GCODESYSTEMCOMMAND_ID="400"
# $OCTOPRINT_GCODESYSTEMCOMMAND_ARGS="File=WhyMe.data Name=my_flag Value=true"
# $OCTOPRINT_GCODESYSTEMCOMMAND_LINE="OCTO400 File=WhyMe.data Name=my_flag Value=true"

# my_string="File=WhyMe.data Name=mine.my_State Value=false"
my_string="$OCTOPRINT_GCODESYSTEMCOMMAND_ARGS"

# Strip each part of the string
# break at 'space'
my_file=${my_string%%' '*}
# delete the part captured
my_newstring=${my_string/$my_file/}
# break that at '='
my_file=${my_file##*'='}
# delete the leading space
my_newstring=${my_newstring/# /}
# rinse and repeat for all
my_name=${my_newstring%%' '*}
my_newstring=${my_newstring/$my_name/}
my_name=${my_name##*'='}
my_newstring=${my_newstring/# /}
#my_value=${my_newstring%%' '*}
my_value=${my_newstring##*'='}

# sed -i 's/true/false/' /home/pi/.octoprint/data/gcode_macro/my_Logic.flag
# {% set mine.my_State = true %}

orig="{%- set $my_name = "
rep="{%- set $my_name = $my_value -%}"

cmd="/usr/bin/sed -i 's/$orig.*/$rep/' /home/pi/.octoprint/data/gcode_macro/$my_file"
# echo "File is: $my_file"
# echo "Name is: $my_name"
# echo "Value is: $my_value"

## /usr/bin/echo "$my_string" >> /home/pi/ShowMe
## /usr/bin/echo "$cmd" >> /home/pi/ShowMe
eval $cmd

exit
