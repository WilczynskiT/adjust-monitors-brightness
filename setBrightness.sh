#!/bin/bash

# Step size for brightness adjustment
step=10  # Adjust by 10% at a time
# to checks buses: $(ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//')
monitorBus_1=6 
monitorBus_2=9

if [ "$1" == "up" ]; then
    ddcutil --bus=$monitorBus_1 setvcp 10 + $step
    ddcutil --bus=$monitorBus_2 setvcp 10 + $step
    echo "Brightness set + $step"
elif [ "$1" == "down" ]; then
    ddcutil --bus=$monitorBus_1 setvcp 10 - $step
    ddcutil --bus=$monitorBus_2 setvcp 10 - $step
    echo "Brightness set - $step"
else
    echo "Usage: $0 [up|down]"
    exit 1
fi
