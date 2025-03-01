#!/bin/bash

# Get weather data (wttr.in or OpenWeather)
LOCATION="Rehovot"  # Change this to your city
WEATHER=$(curl -s "wttr.in/${LOCATION}?format=%c+%t")

# Update SketchyBar
sketchybar --set $NAME label="$WEATHER"