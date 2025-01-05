#!/bin/bash

# Step size for brightness adjustment
step=10  # Adjust by 10% at a time

# Temporary cache file location
cache_file="/tmp/ddcutil_bus_cache"

# Check if cache file exists and is not empty
if [[ -s "$cache_file" ]]; then
    # Load cached bus numbers
    bus_numbers=$(cat "$cache_file")
else
    # Detect bus numbers and cache them
    bus_numbers=$(ddcutil detect | awk '/I2C bus:/ {print $3}' | sed 's/\/dev\/i2c-//')
    echo "$bus_numbers" > "$cache_file"
fi

# Check if brightness direction (up or down) is provided as an argument for all monitors
if [ "$1" == "up" ]; then
    echo "$bus_numbers" | xargs -I {} -P 0 ddcutil --bus={} setvcp 10 + $step
elif [ "$1" == "down" ]; then
    echo "$bus_numbers" | xargs -I {} -P 0 ddcutil --bus={} setvcp 10 - $step
else
    echo "Usage: $0 [up|down]"
    exit 1
fi
