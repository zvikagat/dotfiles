#!/bin/bash

# Fetch weather and city data
WEATHER_DATA=$(curl -s "wttr.in/?format=%C+%t+%l") # Condition, Temperature, and Location

# Extract condition, temperature, and location (city name)
CONDITION=$(echo "$WEATHER_DATA" | awk '{print $1}')  # Weather condition
TEMP=$(echo "$WEATHER_DATA" | awk '{print $2}')      # Temperature
CITY=$(echo "$WEATHER_DATA" | awk '{print $3}')      # City name

# Map conditions to icons
declare -A ICON_MAP=(
    ["Clear"]="☀️"
    ["Sunny"]="☀️"
    ["Partly"]="🌤"
    ["Cloudy"]="☁️"
    ["Overcast"]="☁️"
    ["Mist"]="🌫️"
    ["Fog"]="🌫️"
    ["Rain"]="🌧️"
    ["Drizzle"]="🌦"
    ["Thunderstorm"]="⛈️"
    ["Snow"]="❄️"
    ["Hail"]="🌨️"
    ["Sleet"]="🌨️"
)

# Get the corresponding icon (default to 🌍 if unknown)
ICON="${ICON_MAP[$CONDITION]:-🌍}"

# Format the output: "City - ☀️ 27°C"
WEATHER_LABEL="$CITY - $ICON $TEMP"

# Update SketchyBar
sketchybar --set weather label="$WEATHER_LABEL"