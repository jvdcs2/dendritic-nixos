. /etc/profile

while true; do
  time=$(date '+%a %b %-d %I:%M %p')
  # time=$(date '+%a %b %-d: %I:%M %p')
  calendar=$(cal)
  # Replace newlines from cal with \r so Waybar treats them as line breaks
  calendar_escaped=$(printf '%s' "$calendar" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\r/g')
  printf '{"text":"%s","tooltip":"%s"}\n' "$time" "$calendar_escaped"
  sleep 60
done
