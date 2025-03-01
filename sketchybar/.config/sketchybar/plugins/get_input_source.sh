#!/bin/sh

# Script to detect and display different keyboard layout icons in Sketchybar
# Handles English, Greek, Hebrew, and Latin American layouts

# Read the plist data
plist_data=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)
current_input_source=$(echo "$plist_data" | plutil -convert xml1 -o - - | grep -A1 'KeyboardLayout Name' | tail -n1 | cut -d '>' -f2 | cut -d '<' -f1)

# Set appropriate icon based on input source
sketchybar --set input_source label="$current_input_source"
