#!/bin/bash

# Common path for all GPIO access
BASE_GPIO_PATH=/sys/class/gpio

# Assign names to GPIO pin numbers for each light
FAN=16

# Assign names to states
ON="1"
OFF="0"

# Utility function to export a pin if not already exported
exportPin()
{
  if [ ! -e $BASE_GPIO_PATH/gpio$1 ]; then
    echo "$1" > $BASE_GPIO_PATH/export
  fi
}

# Utility function to set a pin as an output
setOutput()
{
  echo "out" > $BASE_GPIO_PATH/gpio$1/direction
}

# Utility function to set a pin as an input
setInput()
{
  echo "in" > $BASE_GPIO_PATH/gpio$1/direction
}

# Utility function to change state of an output
setOutputState()
{
  echo $2 > $BASE_GPIO_PATH/gpio$1/value
}

# Utility function to change state of an output
getInputState()
{
   cat $BASE_GPIO_PATH/gpio$1/value
}

# Export pins so that we can use them
exportPin $FAN

# Set pins as outputs
setOutput $FAN

setOutputState $FAN $OFF

exit
