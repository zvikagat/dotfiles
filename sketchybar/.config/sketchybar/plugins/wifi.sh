#!/bin/bash

WIFI_STATUS=$(networksetup -getairportpower en0 | awk '{print $4}')
WIFI_SSID=$(networksetup -getairportnetwork en0 | awk -F': ' '{print $2}')

if [[ "$WIFI_STATUS" == "On" ]]; then
    LABEL="📶 $WIFI_SSID"
else
    LABEL="❌ WiFi Off"
fi

# Update SketchyBar
sketchybar --set wifi label="$LABEL"

# Function to switch WiFi network
switch_wifi() {
    AVAILABLE_SSIDS=$(networksetup -listpreferredwirelessnetworks en0 | tail -n +2) # List saved networks
    SELECTED_SSID=$(osascript -e "choose from list {$(echo "$AVAILABLE_SSIDS" | sed 's/$/", "/' | sed '$s/, ""//')} with prompt \"Select a WiFi network:\"") 

    if [[ "$SELECTED_SSID" != "false" ]]; then
        networksetup -setairportnetwork en0 "$SELECTED_SSID"
        sketchybar --set wifi label="🔄 Connecting..."
        sleep 5
        $0 # Refresh status
    fi
}

# Handle click action
if [[ "$1" == "toggle" ]]; then
    if [[ "$WIFI_STATUS" == "On" ]]; then
        networksetup -setairportpower en0 off
    else
        networksetup -setairportpower en0 on
    fi
    $0 # Refresh after toggling
elif [[ "$1" == "switch" ]]; then
    switch_wifi
fi