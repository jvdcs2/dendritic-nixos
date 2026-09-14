niri msg pick-color | awk -F': ' '/Hex/ { print $2 }' | tr -d '\n' | wl-copy
