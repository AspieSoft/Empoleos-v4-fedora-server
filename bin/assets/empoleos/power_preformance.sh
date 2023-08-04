#!/bin/bash

# Switch between balanced and preformance mode at this percentage (0-100) (default: 90)
PowerThreshhold=90

# Switch to power-saver mode when below this percentage (0-100) (default: 20)
LowPowerThreshhold=20

while true; do
  powerFile=$(upower -e | grep battery_)
  if [ "$powerFile" = "" -o "$(upower -i "$file" | grep 'time to empty')" = "" ]; then
    powerprofilesctl set balanced # fallback incase preformance mode does not exist
    powerprofilesctl set preformance
  else
    setBalanced="0"
    for file in $powerFile; do
      power=$(upower -i "$file" | grep percentage)
      if [ "${power//[^0-9]/}" -lt "$PowerThreshhold" ]; then
        setBalanced="1"
        if [ "${power//[^0-9]/}" -lt "$LowPowerThreshhold" ]; then
          setBalanced="2"
        fi
        break
      fi
    done

    if [ "$setBalanced" = "2" ]; then
      powerprofilesctl set power-saver
    elif [ "$setBalanced" = "1" ]; then
      powerprofilesctl set balanced
    else
      powerprofilesctl set balanced # fallback incase preformance mode does not exist
      powerprofilesctl set preformance
    fi
  fi

  sleep 60
done
