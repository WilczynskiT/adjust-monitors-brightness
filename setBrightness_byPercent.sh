#!/bin/bash

# Check if a brightness level argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <brightness_level>"
    exit 1
fi

brightness_level=$1  # Takes brightness level as an argument

# Detect connected monitors and get their bus numbers
bus_numbers=$(ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//')

# Loop through each detected bus number and set brightness
for bus in $bus_numbers; do
    echo "Setting brightness to $brightness_level on bus $bus"
    ddcutil --bus=$bus setvcp 10 "$brightness_level"
done
