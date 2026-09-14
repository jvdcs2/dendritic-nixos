. /etc/profile

while true; do
  temp=$(acpi -t | awk -F', ' '{print $2}' | cut -d' ' -f1 | cut -d'.' -f1)
  printf '{"text":" %s°C"}\n' "$temp"
  sleep 1
done
