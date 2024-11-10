#!/bin/bash

# Step size for brightness adjustment
step=10  # Adjust by 10% at a time

# Check if brightness direction (up or down) is provided as an argument
if [ "$1" == "up" ]; then
    adjustment=$step
elif [ "$1" == "down" ]; then
    adjustment=-$step
else
    echo "Usage: $0 [up|down]"
    exit 1
fi

# Get the current brightness (assuming 50% as default if undetectable)
current_brightness=$(ddcutil getvcp 10 --brief | awk '{print $4}' | head -n 1)
current_brightness=${current_brightness:-50}

# Calculate new brightness
new_brightness=$(( current_brightness + adjustment ))

# Ensure brightness stays within 0-100% range
if [ "$new_brightness" -gt 100 ]; then
    new_brightness=100
elif [ "$new_brightness" -lt 0 ]; then
    new_brightness=0
fi

# Apply new brightness to all monitors
bus_numbers=$(ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//')
for bus in $bus_numbers; do
    ddcutil --bus=$bus setvcp 10 "$new_brightness"
done

echo "Brightness set to $new_brightness%"

