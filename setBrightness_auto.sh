#!/bin/bash

# Step size for brightness adjustment
step=10  # Adjust by 10% at a time

# Check monitors ids
bus_numbers=$(ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//')

# Check if brightness direction (up or down) is provided as an argument for all monitors
if [ "$1" == "up" ]; then
    for bus in $bus_numbers; do
        ddcutil --bus=$bus setvcp 10 + $step
    done
elif [ "$1" == "down" ]; then
    for bus in $bus_numbers; do
        ddcutil --bus=$bus setvcp 10 - $step
    done
else
    echo "Usage: $0 [up|down]"
    exit 1
fi