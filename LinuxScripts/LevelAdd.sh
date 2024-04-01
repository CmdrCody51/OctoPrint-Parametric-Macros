#!/bin/bash
# this is to give OP something to call
# full paths required
# $OCTOPRINT_GCODESYSTEMCOMMAND_ARGS=
# "Name=my_flag Value=true"

# my_string="Name=mine.my_State Value=false"
my_string="$OCTOPRINT_GCODESYSTEMCOMMAND_ARGS"

# Strip each part of the string
# break at 'space'
# break that at '='
my_file="Level.data"
# rinse and repeat for all
my_name=${my_string%%' '*}
my_newstring=${my_string/$my_name/}
my_name=${my_name##*'='}
my_newstring=${my_newstring/# /}
my_value=${my_newstring##*'='}

orig=" ] -%}"
rep=", ($my_name,$my_value) ] -%}"

cmd="/usr/bin/sed -i 's/$orig/$rep/' /home/pi/.octoprint/data/gcode_macro/$my_file"
# echo "File is: $my_file"
# echo "Name is: $my_name"
# echo "Value is: $my_value"

# /usr/bin/echo "$my_string" >> /home/pi/ShowMe
# /usr/bin/echo "$cmd" >> /home/pi/ShowMe
eval $cmd

exit
